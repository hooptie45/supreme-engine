import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { SupremeEngineStack } from '../lib/supreme-engine-stack';

const app = new cdk.App();
new SupremeEngineStack(app, 'SupremeEngineStack', {});
