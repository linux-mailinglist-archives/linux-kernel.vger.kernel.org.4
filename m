Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7621645815
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLGKkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGKkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:40:33 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043101A9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:40:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVfYXAoLMDMRIzJMSc3hJOE3N2Kkw6RYtrCn5uJYwrAutrHQhIETC9qSAZptbDXxSZnAdqpvG9yq2TkCylCiiN3FPOx+zagKCnJBlmoMvE6rU7yI94kn4bxdHtTzXtpD/6pZHwtXaTIHuvZ5HSIGpyNusbhZffqIP01q3qBvYljCperGIziR/witxL6FE1kVIhQYk+MMVrSlCdSsU/f5wR9/85eT85I+U6RBlFWX14w13/toDAPbgHveKIjgxp7IgT7oggRsx5Q+Oy5T0nMRDCJBK2hBUJcn07DcKDMvizjLNXCYxEZvqyJyUhVxwT/XtL/WfkQpikz1aLu/kIPn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp5z5ZMrqw/X2qTPKPNMmYGTmeK78RKGE4hLAx50FiA=;
 b=gfY9dMaCmWeVHDX58WutT2UQ+L2cOJuX2W+Dpz+OyPu9YqOltpAF3jzVLuYwX4/r1wNQrUCUFNpn4r5pCoAWsU85JKIrUiWGmHz2mwv50MALj1638YQ2vM6zbhHqTiBr2EXNnwaF2O4hajom6dg9ponXYoKQJ29q53EU+qVeeOdrys/pjkhq7rPdKIwxkEcfPwqzBiPK2lLiQLxleqGUY/4F69C+TNnMH3nY4cC5PHm0131nfhopvzRvnwk052A6DQKSErnAPWltKy+XLh8tDMiIwb+Fi7p/JD+Ht1WXV9T1qMJoRfJ1HDFIBFPc9MMmNq/hppOtlr/UnzjxHb64JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp5z5ZMrqw/X2qTPKPNMmYGTmeK78RKGE4hLAx50FiA=;
 b=a0//R6hQzEnOAf3r11m3f5dzJNwrU4ZmC6l7hiJ3Q+79n1afNZQxgAEe9gJR/9iAGgl8tsUEUw8t0s1IeT3+UbqFGR4NsDn9nsB6A9gxlxcoy87sOG0neau/vaoOlx+nt+22UYKlR2lF0olfJheuIIw4FHYaU8YpctdjqFVvDgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 10:40:28 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 10:40:28 +0000
Message-ID: <a1304dbd-2287-b4d1-6e20-da55387202ac@amd.com>
Date:   Wed, 7 Dec 2022 11:40:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] virtio_pmem: populate numa information
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Michael Sammler <sammler@google.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mina Almasry <almasrymina@google.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Sammler <mich.sammler@gmail.com>,
        virtualization@lists.linux-foundation.org
References: <20221115214036.1571015-1-sammler@google.com>
 <CAFPP518x6cg97tK_Gm-qqj9htoydsBtYm5jbG_KivK5rfLcHtA@mail.gmail.com>
 <3f7821a0-7139-7a97-ab24-dfca02811fc0@amd.com>
 <20221207053242-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221207053242-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::23) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2d40d1-44b7-4c3f-090f-08dad83f74f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbHViMgII6Fm/pVCvjwk+2F3kChoKHA8Y5CBzkNr2yVdEl9JZAlsjsvyCyofxdQqNfBr8J/z9xkLWXBnDXqFcofQv0gw6j5Wxf3dIoiWhqsaROumXQ4StSz6HkrBAr1BfqrH2kEa+ErS7V6zCNdnwEVi9pOoQX9FXdXplj5m2c8PQGLMytgSHutRrTUSb98z2tD924V392naKUQflFUdhDUYlNmNu+56DoTcy7a/gFNHr3XIWRkwP96cpGd9O0q4K90iRXutQ+8zxvvyc3348RlL6twsfr1UT/1jYc3fb3zgWiCKgmQG0G6XdC6W/XUqsy+UtgmdG+GEjjFsS7GsBcQGz7gGYWUD0JhjQ1/++QUIcKWEImZV8Ui0kDTfHnYH4PllSDLSDVWGNx6f5gnTGZFRbq1cjvQBEd8YFGSVDIhS323M1RsIO7TaAW56hoIPJdSjDODsdLOU3VMIvocPTK+2PrxBQ8gUmzugDVoTM3iFoL5wY07io7cs9UD8T0VZVqVFGIirjHrJSJe+OkKeHCk+ajRDdEBAlAu0ilvNF2PHYjbIiIBxy3guBMMEqFbxvGIh4/fK+S+3omJiei0hMCK65zFszj9Nd0PMnjww3PayvAdYqKfqSIz72qu/+LRtKCKQN8sdfd+cU6EEoUZzWZq629SPH+fWQROC4AULzqmOw8sDRuoLM7l4bMDR7c2jtjWK3g+sIIOGSUQiEmGaB3JXkJA/39QhVEWveElJQAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(36756003)(31686004)(4326008)(38100700002)(7416002)(41300700001)(8936002)(2906002)(478600001)(83380400001)(86362001)(31696002)(558084003)(54906003)(6486002)(66556008)(66476007)(6916009)(2616005)(66946007)(5660300002)(316002)(6666004)(26005)(186003)(8676002)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NSVHVUNGV2Y05HR3l2VGY2NE5hSEVRZlREUG5rUGl6akluMjlXQlBpdXlL?=
 =?utf-8?B?OTQ1MFltd1ZSZTVwYTVVYkRBbDVwWm9mUVBiV3JRQWg0UzI5TFk5aEx6Qk05?=
 =?utf-8?B?OXdVNUs0am5tcGo3eUdhckR0em9IMFh2bGlRZFJwZ291Q29Ed2NuQWJGUnRZ?=
 =?utf-8?B?ZTFrKytZdWRBaXNuUjJKeWQ0clh1SE1XUEZCeWFlZEZQc1NxSzhKd2NRNHdk?=
 =?utf-8?B?dW8rS3lxTDFXOXdXcEpvcXdhREJMTWNwVzVNUHR0a2orVlZPZHN3SVlqOUFp?=
 =?utf-8?B?dFl3NHZtRU0veVhNTkl2Y3YxV0UyaFJIaDB1cXZzOTEzeE5rU1BocFVkS3dJ?=
 =?utf-8?B?K0xQQXhqeVJ4N2dZNTlEQnByTGVINDBQcVBGYUNsQyt2bFN5MWE1ZC9oWlgv?=
 =?utf-8?B?bTlwMmk2TXZKQ0RIT3J6TGl4RkhOYi9scmhaNHA0SXB4Q0U1OGNrbzRleWQ2?=
 =?utf-8?B?MnFtZ0dieEpES0VEZDNmMTBCeGUwNlJvZExxZEg4b1FKWGEwcXhVMEVrdjNF?=
 =?utf-8?B?ekxlOUtFSG1jK2lJR0VjRW90WExjTU1POGxiN2s1aHplZW9ZNTdtbDIwWjJq?=
 =?utf-8?B?aWxScXIzNDQwK2M1UDllb1h2Q0VoTWJ3b0lob1l5MHZaS3l3NWpRT1BmdzF5?=
 =?utf-8?B?d1VJaTRTVG1pS241Rzh2aEV5SzI5UFhCVjdjaldNR2ZyT29BUkU0RGk2VjQx?=
 =?utf-8?B?T3EvNk45L1pybGcvdGV4TTZabU1hbnBjeDVkNEFmR0xZczkyNFBaNzdLcVo1?=
 =?utf-8?B?aGRDY05wcVRCeC9ibjE0cCtSMWF2TWl2dm5iNno3WXVDamFKYnpDbWhRL1Fs?=
 =?utf-8?B?MkI3WVNzTzBrUHgxRFYwQk9COGVvTFNIU3dWVlB2aG1sSEJ4eG0xUGlySUR0?=
 =?utf-8?B?QnFIYUp3Y2RMSkpjdUM4eGprMnd0cUtZRG5RSjUvcTRPekhXSjJDcjRxR1Iz?=
 =?utf-8?B?K2tkRzdBMzlGTThHMEpYeTlEZmxwdHUrVHIwdS9melhMaHoxY2hKb2YzSFJ2?=
 =?utf-8?B?MHdaT2g3cWFTUzFScDlTaFVUcnhXK3VGcklibWtOMFMrc2FjL0ZaT2MzQmY1?=
 =?utf-8?B?dXIzc0lyZ1B0Z3NPZXZHWDJQQzhza3JPTlFYajkxWGxyK1BlWTdPWHhlQjNo?=
 =?utf-8?B?cE9KSWtGNHNJMHFLc1M3ckxNU05vVW4xNld1Q2xMdXBNTTViUGpaQnF1Z3Jr?=
 =?utf-8?B?cXNMdkJ5TFNDVGxXdDZJRnU5V013WnpZTWowaU0xekF5MUdPanN6UitoM3M0?=
 =?utf-8?B?aW1KMTJJZ1hzREliYUduc1RnTWpRQy9aVmZjUzdNZmxwRnFTZmRISGtLWjFr?=
 =?utf-8?B?VEZLK05uRjlyWUdqZDhYZmh2QXo5amM4U3N4cFpDaERzcklZN3NReW1vVmlQ?=
 =?utf-8?B?eWdLMzJCWUVKUHJwaTlaWEpQamhhSC96cEJ2anJNckhzdGhuNUJqOE13Umlh?=
 =?utf-8?B?WGNNWGwrMkJxSXo5anRmS3dvbGYvY1hYcEx6TTRuekFJN1ZiYk9yaXBCTkE5?=
 =?utf-8?B?YVoyUmJNL3FTSnFiRXY3WEVTSEtOazZJNERpTmVwSVVlV0VLckRvTWRPZ2hF?=
 =?utf-8?B?dmdJcHBUZEdBOUhFZ0MrUkRwd3NNcXl2d1RiQnp4YmZDWXlKVkRKSVdNWGNt?=
 =?utf-8?B?OUhKeGZZV3BqcTJWa2k2cUlkSkw5RnRPOGg4NkdSTjB0UHB1eklkenJGQjBr?=
 =?utf-8?B?Uk1qdVh6TkdsZnF1a3lKVytIbFZmTGJwRTlzcGhOZFVjdXQySVlGZDl4MkNw?=
 =?utf-8?B?eE5pM1ZMd3NkU0V0NEpsTEFDZk9wZkZaL0VsZ2RTeHphSDVVR1FscmJYV09T?=
 =?utf-8?B?dHUzNHpYVmYzWHFFeElLVGE3YUNCWWhPSVRMdGVyNGdFYTBaU1F1MFp6cnV1?=
 =?utf-8?B?ZUN0dDB4WVdUV1RiakR0dWpOUG5hSVVoS1Z4MkVxN2JLSWZKd3FWM0FNYkdo?=
 =?utf-8?B?UkY2Q2kyOGUxL3FXSWl1QmNlZGM1UlFkbVJpUXVENVNCMlRta0luL28xbHhx?=
 =?utf-8?B?QVpnbS9KSjltVGdIRHh0UzA0dkZ4Q056a0lOTG9IcmNOZllGTFdTTmNWSC85?=
 =?utf-8?B?M2FyWDVUL3NzQkhSeXZQMlVtVEhYMWZxWjRzeWZMMHFiczFCV1QvRWdDbFZP?=
 =?utf-8?Q?x6T8P8NUcmxiUXfhdxYkWC/DL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2d40d1-44b7-4c3f-090f-08dad83f74f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:40:28.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ode6ukAZVZwYcpLVbbj+EOJN3d/JhHqggWuHE+xi0cuBVu76yM/Wt1f0p5ceTnb8gPYpcUsNr1qu3x3zT0p+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I'll take a look. Generally if you want my attention you
> should CC me on the patch.

Sorry for that! Did not notice the entire Cc list earlier.

Best regards,
Pankaj

