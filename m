Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C5462A433
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiKOVe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiKOVex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:34:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14465D67;
        Tue, 15 Nov 2022 13:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSsjCkJ1L+Q5ouhl/qvtiZto23iOpJsXjpL+FJDMvQiBvObHCJ9HHmAj7d7UuUgDcdvu+Dv5x3L2aBPJNqY2hGRtW1fFbL9w5gXeC9hAVek505sVQZGZK7pTKEMSKTUqtv6QMuhVHQcWXBGIEk1GvjLlp9g7w6da2l8kt4m51hf4R0BjG6CBJrHMQToLiTzAh/FXQE4qfxCKr46kc/kF21EvEP+//OhpKAh0Ysusm006/StAZqUZiUyePgAD62x2b4leNFYgc/wWNPYR04k4ePeufKollyOXumEyWrrFgFsONlg4UGzwpV8nUEGYRDhp6irlHvEk+g0HsOq4ZeSfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fnHl3bQRA9DzsSBuESUSQZXXueSOEf7/r53BVzWUkE=;
 b=Q+Ap3Jt8W9sFLlskf6K5DXxjHgu9Ovrduqh8rq4UaL8lzBen8fwE9VLlpQeAloxsY+BKwyJ1sp48lmIQ4v82HuCUGTedYfAj8WrmxHMtxuGQ9DJbPBouwMMPrNvWN1do0xgc44cb9AH7wMIpqQFFGQGZdQ4ndjIesxbl09Wxc0kWHBOQRKeHv/NSdQEmHPVE22qdxtrSYp3NIANRq6mFCMVo7cAc5NwQIZ2wT1sZa3BzMQb8EpUz058W7rsnHn27qjBvOElrNXi+dqNopkcs6chRbYEuHwdfgRXej2xlSe+oj3/IV7IkY2hHC2kguyG/dkMaphY1Zo33rji7GcYkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fnHl3bQRA9DzsSBuESUSQZXXueSOEf7/r53BVzWUkE=;
 b=xhBpm8Re4pOqoC8tjgsslR4rmzJai3C8vTwCeJ+1A5mUS34n6XDNc2xUfq/u9f8/FVR5UTylNoHi+VJomf9zmX8dzxgrYY0tTKkH7mY2qxhTj8cCShcx+2ad/42CYszsmLxa2rShKwDKU8DUDS5Ai7xMB6a68hzbfhfdLQLj1Ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 21:34:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 21:34:47 +0000
Message-ID: <5705b4a6-6fb6-56b0-473d-05ae3a926518@amd.com>
Date:   Tue, 15 Nov 2022 15:34:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 00/13] Support for AMD QoS new features
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <f69a6454-a8c0-8ce1-0356-cde0d8b89c2a@amd.com>
 <90a66b72-368a-7199-0d6c-f876cd1ca63f@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <90a66b72-368a-7199-0d6c-f876cd1ca63f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:610:11a::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 562fb183-f7b9-4d8b-8bcf-08dac75137e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovnOf4rkwPk5yUdf066ZIDno1hdS7w54cVqHL165/JE4M2O87ru9erDVIjsqS65Yh6agmUCNMGT16cQipu4UHvdYinbxTIlqjW3zF5DIm4kfMqOoSsaYqC1+9a6HkK3+SWOyuJMCLhiw8M767Dw+d7cdrDpDLmPMBhcnMCakkLJNt4EC3TSa00AAGBv+Y0MCnJb9hwg+m2zWrRvpBVR/Yl0nGicGw/EjqurACNK7IVLeSqeEpBwcviNGu4p0ZlRuQUkrKkTcbwIWl7+L5iERqj60gti/sT775kygSlteCptiV4/k1HCSS8fFBDgCQ8KG+5sTOFVAx9dUQi3fpD/qjp3cSTK0W6+nK6kN2W6f+EwXhEJkJOZb5kVMNeYNV+JSM3rQkOZvtHxeztjx0NnESWS1gOtBxFZFAAq10xSvJFKMP3J8Ua2AndDzA11iRCtCUyRLVRCvDmHUt+jVcrMyk0FvW+DRVr+BenHvZW0kMlNeC4sHw37rLYGdfJEoSClxF3nkjzbxPOO44F8rDrQvbjiVV9disiqqCpZEcNUbpKr4Ixpeyymfibpn1rKHVrHlfqWGEMbfi2laNKLh/seM6palK7UUZHqpKDVrAS4uIcg5NsTZzQ9Y0ToRpH3anb6Si5pI5q2q+XfYKsBagubIP8c63VTTk2P+2ed0fHLAXD+Kk62y0wZ3QS0fI6Y7rb1euRKuUV+UKnFMPU7iQ3rAlj4WXbJBEIyjsorWarGy8UORLm9WS4Lra95RUVfMd+y394nJnuNH5KrlbrIuqVEnl8NlvJCn1XeECiVEx5nzDCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(478600001)(86362001)(6486002)(38100700002)(6666004)(31696002)(31686004)(2616005)(186003)(26005)(6512007)(6506007)(5660300002)(7416002)(36756003)(3450700001)(53546011)(316002)(41300700001)(4744005)(8936002)(4326008)(66946007)(66556008)(8676002)(66476007)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnljL2czZHVBZ1BSdGtkdGhmMW9IUU9DYUN0QlkybkR3Tmhock0zK0o2bkRU?=
 =?utf-8?B?MGVZbjhFcWVwTkc5K0VhMW5meFY5bzlnTmtjRzJyVTlZRUtubmdTQllpNUV1?=
 =?utf-8?B?QVJJUm5rejJhRUpqd2owS3JBQkFkcU5OZzIwb0kzK21SVTRnV2ZkVi9EbDI3?=
 =?utf-8?B?OUtYNVYvSjZTWkR1TWY3K29lYitJRDI1L0VoVGhFZmJuNkZEZ3NQRm1LTDR1?=
 =?utf-8?B?ZzAxS1BYVmZYOXBKbHBXUVZJRGdrY2QxbXZpdDlkRFF1cXZSM2UvdCsvamR6?=
 =?utf-8?B?eTdtNklpRVp4eU1XbUVxQlgzSkxONDYxeVgwT28rZlpTSGZ4aGhyV0xvUVhz?=
 =?utf-8?B?Wlo2QUJUUWlVU0JuNXVjd0h2MHVtN2x1OE9CSDg5UUI2eXlQajNDdVAwNkhx?=
 =?utf-8?B?MEFXYmpFMHNLZ3RKUWV6WlVjd0ozcmJYd1RaczY5Skh3MktPQzl0SHo2N1FR?=
 =?utf-8?B?ZnBtalp0QXIvT3R3QmJJbERkMURxKzN1N1FhdE9TTzdYTHNSUWhLdzd5V2JT?=
 =?utf-8?B?bjYrY3Nub0gxZFU5Q2cwK245S0lTTUNGN0Vpa0JYS1p1cWVkaE42Umh3Z09o?=
 =?utf-8?B?L1UyOFk3QVFZVDRBbzNpNHhKNDBXQU9zN1BqSXJlOFNQVWxOVm9qS09LOFRS?=
 =?utf-8?B?S0M4Z0toZEJDUVVOWUpudktQelFzV2xTM3hjSDZwRkgwSVFLZHY2a3NOSFZt?=
 =?utf-8?B?YnRvbVc2OGJGbUdOVk01TmY5TzkvOGQzcmxjdVJVZ2kxa2xhaHVvczdzWUhL?=
 =?utf-8?B?WUprb1JtNm0wa3Q1UEsvOStveEtpS21qaFV5TjZWRzFEV004UjRLUVJsL0w1?=
 =?utf-8?B?bTZ2b1JMWUZ6VU1OK3QzeTVEdGtKYmx6QlA4K3gzZThJSElYYzE5b0VqYlF0?=
 =?utf-8?B?ZGVWeXhtenErUi82QXJ0WCtPWUdFbklkQjVqVHdpSk1aRmNIRnc0MEdQNVhG?=
 =?utf-8?B?ZE1UeUpTOFR3Q213eGR1by9jVE1QZ0I0YXVrWTRkMVNjV1Z2UHdSMEF6VDJn?=
 =?utf-8?B?a250Mjd4VkRiaHBvTGhUb1hNS0MxcDhaR2NERm5FNE1NV2ZSR2JXTnBrR242?=
 =?utf-8?B?T0FBRUljMTMyTHZ1TklOVm5IeHNuZWZ0M21hZ2x5cXhOZ2l5WmVZY1psQUhk?=
 =?utf-8?B?WFRPbzlFVGcvQ2JlYm1oNldjd2VHMnAzTXQ4RWw5UGJiTHhDajQ3SVg0bkE1?=
 =?utf-8?B?Z2Q3djBLY2MwWHQ1aC9VY3Z4TFEzRkhWM3o0Zy92T1UrcjZKZkREMkV6bjlr?=
 =?utf-8?B?RGx0M3lCMG9WQzJwaWQrRjNRMG9mT2QyL2hnYkpRMzJhd0dscDltaE40Y29S?=
 =?utf-8?B?clltZFRBaU4ySGE5Q3VaQnp5SGt1S053Y1BHT3gzbWIrbWJJTXdMbjJmc0NY?=
 =?utf-8?B?a29xOEg1c0VHUmxUQWVBQWU1N2lhTzFhK3pZdnpCMEJjcFltSTlxenZXRHBT?=
 =?utf-8?B?d24veFNNem9KWkd0UTBJUUp2S1h2OWtVM0kvVURHM2l5TkpiMFR1a21wTmtO?=
 =?utf-8?B?TVhyc3VKM0lzYU8zUFhnRHM5SFJjM3JaNG9VNml6RG4vUVdxakNKRUpkd3FB?=
 =?utf-8?B?bmtveEN6Qm9RcmpBM1lMZDlDczdLcHh1R2wrWno1UUhLWGw0aUd2M3ZTbXdE?=
 =?utf-8?B?R0hxdE5xS3ZDckhyb0dqZFhoL0ZSU3hpMEV0SE5pdG5GV1greHN1VDhQdmJH?=
 =?utf-8?B?dkEvSVdOUVJNUlB2L3lmT2hzUzlwTlhhRzlnTFpiNmxFMmIrVmhDb3U2R0U0?=
 =?utf-8?B?VTUwc2I5Rkt3bXRiQk8wSU8xTEFpTzJKT0tuTjdQYlBZOWc0SVhhcTBGT2Fa?=
 =?utf-8?B?QVkrSkR2TmZIcFdjT3pFMit6ZHVwSksxVHFkTVNHTCtwQVpoMVB0TmppcHYr?=
 =?utf-8?B?MVRQaXRpQkNsSFdCZ2JSd1BOOVhKNWE1RWRRUXpqOTV6emk4RVZWaW1VUTRj?=
 =?utf-8?B?SVNmTkdQY1hOK3VnOTRxb1FQNWJFanFTdk05Mk5oVGhIUGpxUitMTzRiQzk0?=
 =?utf-8?B?MGhBK3lidkx0VWJYL0hEUENXT2ovZXFpcEVlQkdHR2xMK1NZZnBQOXBrRkVZ?=
 =?utf-8?B?WGJIdEhpTVo4RmpmSk90dGZ2UktmR0dGdDI4UXd3eFJUUGRkdWF2UHBSUjFs?=
 =?utf-8?Q?1cCm9NThTJhiJmQsKMQotIqUV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562fb183-f7b9-4d8b-8bcf-08dac75137e1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 21:34:47.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: te9sE0WfKR8B44WmI06p9QGRrSOKSQQQwWtwJ7FHAVRT9GzEdqrK6Jgw5Vd7qFu2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 11/15/22 15:07, Reinette Chatre wrote:
> Hi Babu,
>
> On 11/15/2022 12:50 PM, Moger, Babu wrote:
>> Hi Reinette and Others,
>>
>> I was planning to refresh the series later this week. I have one comment
>> from Peter Newman.  Let me know if you have any comments.
>>
> I am behind on resctrl work and have not had a chance to look
> at this series yet.

Sure. Thanks for the update. I will wait.

Thanks

Babu


