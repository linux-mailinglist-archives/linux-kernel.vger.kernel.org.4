Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB6648407
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLIOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLIOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:44:50 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A1A2B629;
        Fri,  9 Dec 2022 06:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcQbzPvQWIOTGLECBI6q9G07wFiIzXOFLcPVWG8MuxXq7aomHrGmO+mA4LLjqtNfW4dmrafSsHhABpytgQEywiYGc56GNY5/zKztdZ8N/ObQrEm9EABUFa/hG8oUA/S9lB5yIvvlrBCFuwxSg6nnMLhPv58h+2NtVrwnwmPKSwNZ4kaMVOBuVrF376t6+rAtvZlkdPnM0vTd6GdJ3iIR//uEWTVPMZAo7CbrR9HHzfKHmomHQOzq7hd7U+Giqcj1waKcwhozZBCiYMkRD5DW71QALZQzCwWi3IyvUoJq49bo88wluEyFFjzIj8Q9MkvE6NoHqi0YsYpuscJEXz7vLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsWi2rwnxRc3bhqL0wB+hIATSaZErWF5KzkYp/dKD5k=;
 b=mo31QCuimPxjqj3ciirbUcLTUVovaBwNJTUw/72vcbItZLRULmM/yXAlUx6Q9sGy756yS34/O6XlirR11RMM5kQSj5kIGfoa5Q59k8ixM0lE7ydi0ZNE4QmaXTbgpP8LugSdFHdCwUwPTHQryBzPfzn/NAIMTcVyELxgXNExC7qIYYfSeItOhYCXTeMskR9uqS4iHWQeFmdQEx0t1et5GTs3pfG++CGmMRe2WicPD4cJ7Tgmu9X9HIn+V6W/D1xyz7pSxb2p1QW+OI3k1aBKVxSXCSwgNlljhu1DfXUqwEtBaC+vJ79BW7QUWnZqy9INi+0CEfjdx5JR9W1o/sUX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsWi2rwnxRc3bhqL0wB+hIATSaZErWF5KzkYp/dKD5k=;
 b=CFW2o7eXkACjPGILmsMERNBnOby/uNpc2naPbiI9z191NwVMtgTIeBOv9AsZ8EXdaBlzd1bDU/s2S5tdDLE6wVaTdVrA4dTMEOpEje5GekiuPIUWPOHw4ymKf1R8/1hVTyAFCtBzih0cYDKaQT1N/e7yYjBvl8rC45O09u+omU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 14:44:47 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 14:44:46 +0000
Message-ID: <24f4ab71-a873-7e29-e7f6-84b82796fe2e@amd.com>
Date:   Fri, 9 Dec 2022 20:14:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] amd_pstate: Add guided autonomous mode support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Huang Rui <ray.huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
References: <20221207154648.233759-1-wyes.karny@amd.com>
 <CAJZ5v0gy+sZJp_SD2zF-n-zD=hCL4jXd+=cMuOujQqZOUUCHMQ@mail.gmail.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <CAJZ5v0gy+sZJp_SD2zF-n-zD=hCL4jXd+=cMuOujQqZOUUCHMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::27) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fe047a-919a-4e24-b7ac-08dad9f3ea7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: az37ELeAdB3siDtuDUWx8A6oA1wr/MW/1O7evpIQ4JnJMJ6LsyGl8DrhPxJAv428ljC4WnEDvJgCFIAPDZqj5fmV0wSRDqiyM81hZ1WbanUYOQPzsg2E78pvGqWkEGcWkbKrtKxfx8zwFp+eCdM2mGg/E+s6PAInedQgIt7wxYaHCxY4Svo6GfKPQHebuxX/1/mc77ZXl6X/SrsKeJTWimLVNLjLtLAnTYtxzSVQcD8o8M+cmxUUvRiSummPXgb6K/ElZPAI2uRrhP+2zGek4G7MMzANFDU33woXI+cG3CNZzWt+YEtjDWYTKBA43+zGmJZB+2rziP/c40DkCsynMl1QJeCUStp3Gj4lT3Wzvtvraf4Q15X29RvErgT9h3YiOVdW31oBGS4BZzvqq0sDR6sIFsJ4+GMOuXCdLoFeI1qc22OCpE9I0LwYPbxRZsXMSv+1LidNHl1x3TOc5yRH+BtA00+NVpqvgE3f99Z59j7AQoBak8h3HdNfSTBPPfjE/HFyJURvyMMwPMBocLvgZJnH6rf+S8mPr9pCVZLqmbDxPyoK9Nvg+EogDN35D7f6XZIi/R+b/Kr3LcvWA5GLfgvoOA8UVuXc1YjYWA3YpiR1spny7KIVlsMkvK4k6K5bFJJbZWqSLa2ZVzwVjK+6n8/KQ+843U11U9kSjRrprJW2KCdROXIN9cwscQEWbIEQ7rCrLvtC6XTgp5GnS/4wev4+eCsp5N9gIj1pkzih2Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199015)(478600001)(44832011)(31696002)(4744005)(316002)(66946007)(8936002)(41300700001)(36756003)(186003)(66476007)(66556008)(8676002)(6506007)(5660300002)(4326008)(2906002)(6486002)(86362001)(83380400001)(54906003)(6916009)(38100700002)(66899015)(31686004)(53546011)(6512007)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNoanVUcEpJZDlmR2JhRS9wQld6QnhweGdhYzhtcXRzTmRoR0MvL1lMSHNL?=
 =?utf-8?B?QTRhYkVGVUR1Z2QwR1lvZXRBQTJSaXZIeDErTWRsaGgveHFsUStSMVQzMm9k?=
 =?utf-8?B?TjF6UU1QUHhuZVFFekRPWE5rUEtobDIyMHRVd1UwY0FiYmNZb25PVytDODBG?=
 =?utf-8?B?NnVaU0kvVmZ5RGRVSWpCUy9IWXNWMXJnaFpJbjFTYlUxYThTWnJBa3hGcC94?=
 =?utf-8?B?cStObjBUSGxMU0p6RmlLbnFSWkdJOFI3WmFxY2ZEN3VGSmZYNnRRckNoVXgv?=
 =?utf-8?B?dUpGcXZ0OGljU2xKOERXdkZRd1Y2bldaVTdNQ2VQbDl2QlJjTEFmem9QMG4w?=
 =?utf-8?B?ZFFzSUpkYkRvT3FpcUw1Rk1LRGI2eUpkdGVEOG52Rmt0SFZESXhBOWg4dEFI?=
 =?utf-8?B?SGhwZnZPUzZudXAyeHNoTVY3QXIzZ1Z5M1BGNjlHZVFCS2xvNFhqamlMZE1D?=
 =?utf-8?B?Wnp6d1R5Sk5jZVFnSWpjV3ljVThnYnY5cTBlZDk3SGc5OEhwQWdqeFdBYXQy?=
 =?utf-8?B?Zk1PMklocVh3c3U4V3h0c3Q4a0ZoSmN3S2VvdGtnSEU0d01WNEtacXFqTE9n?=
 =?utf-8?B?dG5yNjZoTEc1NGVXbnNuVjBiNytIQ25iY2ZYRFkxQjhzOWRPdjZXQkVnU2VG?=
 =?utf-8?B?L3B1VHBHK0h0S2xlbGh3dHZVLys1U1Z3dTRvN2N6QUtMMTFHaTBMUkMzcXZa?=
 =?utf-8?B?NzBrOEZmZFB2VnU0d1JzbXd1TERPU2lnVGw3RjE3NEtpb0c2YUgzMEtTNWdR?=
 =?utf-8?B?end5RUwvYU5oTVY4MktLVEloRGlET2dQT0NCNk41VExmY0VSYXZzT3kxNkZO?=
 =?utf-8?B?RlhxRG5OMlJIcGhEWTFtOERMN0lwOFFzTWZwdW41Y0dVcFJZendkWG5NMEN2?=
 =?utf-8?B?Z2l1elc5UWNlTDV4OHkzZERCRm5sNjB0Z0VMYTcrdFFZazJ2SFh5TXJSU0dH?=
 =?utf-8?B?VTE3SmxaR29TSEsrb0x3bDFoMXhDbCs0aTMvNnNvNTE0K2pMQzhDWGhTWDBk?=
 =?utf-8?B?TXJlYVhMRGpiTTdaSTlVUTBVMXZUckNJWXZoN2puamhOZFZXZUxFcVFWZXJ4?=
 =?utf-8?B?SlVwOTBpUHl1bHpFUC8xNlV0MUNkSU8vbnhwYjIveEQ3cXowa0E1bnRHYzdC?=
 =?utf-8?B?bW5QcUYxTVlVSEtKSWRGU1J4aFN2RUNtQ0E1SG5qdkkrYncrZDR2TkZqMWM3?=
 =?utf-8?B?YTFkT2I2ZXcwZEp2N3pjODlCbVRqVDdyQ1ZROHRJaWl1Qkx0L3gxeVFyQlJu?=
 =?utf-8?B?UDhBWm10NHZ0RktIaTN1TjYrMlVoN2lHaTE1TXlHRjJJbmdjZkFGdmdyYllp?=
 =?utf-8?B?cll2V0hxNDVzbU5BbWozWVdkeTFMZENPMHdrSDM4a0ovMHIwS2FOYlpzUzNX?=
 =?utf-8?B?UWFwL3RENjFESjk4UjBZSnphdldheEJmTzVGNGZOZFZYZHJMRSt3N1VKZ1lF?=
 =?utf-8?B?YW1sOWYwNHIwYVEvRFlsTncrYzFSZ09qc0JKSEYrMnEyTzI1eXVwa3I2bmVv?=
 =?utf-8?B?OHptRW5xSzhnQkEwSDd2M2pqT1B3bzlXd3VHVU9GaWN1TmwzYTJCYlRoUnpW?=
 =?utf-8?B?TkRadkpHdWNLOEZ6SnBlYnVVdkpmeStncDVXSVBReDd1anBGNnhReUptdDRv?=
 =?utf-8?B?S0w0d2hNWXlQZ2dwd3JWVWFzR3crM2xYanNjT1NKMkRZNjZObjJSeTJnS3Rs?=
 =?utf-8?B?NHFEL3lBR2JlZktLV1l5cHg0ckluSVpMZDZGYmVmU0lSRGpOQnJNWkU5cUp5?=
 =?utf-8?B?aUY2OVJRa3ZTM25rdng0ZmRlRm0zQTg0ZDVBc20zbEVIVVFwamkzeWFUTUV2?=
 =?utf-8?B?ZE1ncmNwR3Y5TlZzL0tCSUpEOVdnK3hjWm5YL1JQdWEvdGI2MGQ3ZVlBREdX?=
 =?utf-8?B?SkZIU3VoWFdXaUdmQlN1ZkxjSWdVVC9FK3pzRWpBT0x1WlI2MFFaTWJPaUN5?=
 =?utf-8?B?eTlaRWZnMm5SYXk0bFlrOElXa0NBVEtRTkZNbEQ1WWlqWmdTaFZvQ0czaWh1?=
 =?utf-8?B?Sko5d0RSOTVnU016N0VBemNjaFN5dDZicjhRZCtocGhUSXpSR2piNmJiT1BF?=
 =?utf-8?B?NlJxUmlKVVZ0MXY3NmZhdjQ1N0FiMzN0WHd0ZnVpa2ZERHpackdOcitYMGVS?=
 =?utf-8?B?SHEwSTNialhOaEdSS1F4aDcxbHgxVDMvM3ZCWnJkVDlxNHRmL0czWmhkSkth?=
 =?utf-8?Q?8GCuVoVys6LjMh1DpY71J8NEOj39CDsiOc658xYFYVRf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fe047a-919a-4e24-b7ac-08dad9f3ea7e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 14:44:46.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVaCXXkn8M90yngTsimt0QNGgJmhdBbaCGlAY/8A9DCpbrAQqxscfu27ESwYMsQF6bKGfUFwEYCYhmHZytcQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 12/8/2022 5:18 PM, Rafael J. Wysocki wrote:
> Well, can you guys please agree on priorities?  Like which one is more
> important and so it should go in first?
> 
> At this point I'm not sure what the ordering assumptions with respect
> to the EPP series are.

I am working with Perry on this and we will post a new patchset.
Meanwhile, any review comments on this patchset is welcome.

> 
> Also this submission is late for 6.2, so I will only regard it as 6.3
> material on the condition the above gets clarified.  In the meantime,
> please address review comments and consider resending after 6.2-rc1 is
> out.
Sure, Thanks!

-- 
Thanks & Regards,
Wyes
