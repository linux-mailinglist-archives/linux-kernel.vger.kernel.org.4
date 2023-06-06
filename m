Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1C723D46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjFFJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbjFFJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:26:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1456E7E;
        Tue,  6 Jun 2023 02:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNC69U8ccM8Es2tP2QU2t8cm5aYhOQD6w/qHer4zNRu82+gEI198YMFRjEyLcPO3Ex9ckLJZsbqKxS896LiU2wVQfJUBIdmOh548dITRbvy0ldGPDwYxHZPO6z87/lLBKGjrs8g3t4iMKu8qBO24EYn0kduxCP0P4tOj7Z1PALLgdT410b0kdSukLCMZyn4SunDVzHfoRtt/SzYicoQlj1jLOt+NeOMcsIOF3KSuBeoN8GuupJUITodgZvJQSV8jggjf968Sa5YqiLGfwH/k6vjUWocCceQtB3qaQWVhNSWmrH3n/k8inajFS641nJXIdmowkxZGd8ScOwlRQSzMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c7uf8gj0Xo1ZKpBo32cpR6kfyCJxKJ3nw3nNsQFPzs=;
 b=NZK2ot991MrIN01+g5htzmuhRMAgric83qAh64IhWvNXw4+2tfj5KKpb63GyI++xmbbPdmZGA1fy662rAHWctTyoOtBFLK7LypUPWAONpeWS21MoN0FVwSDvbSeGntjWOfNqIHktfwcd+X3gms8c1i1g9Fv6ZTnbXmfIaNYp9/6m7nCLs24EHvuAGXEiBkJrC94J/ubbJLhqt4QehKJUQVhzMncIYM+ZYbqr5+h4PRfCLqJbzYFJwmkhDs908kGo/bxQQBKS1FH/lfpr5x+TeBLxyxgZ8NxsxzwYaub1wf0owJNqgLfsf8MMYKTvJ9OELTCab70stijcykJdV5TTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c7uf8gj0Xo1ZKpBo32cpR6kfyCJxKJ3nw3nNsQFPzs=;
 b=ASe2HaHwsMQMyB9InkblXXAoFtXMpusxvqg3nknEbIMPHso+EItaLg359CmwrNvE4Cwijj+nfnqIlXje0GerKeI6gRcEkyqtpEtg7qVKrJfjdR3K9NK5N+7x7XVV+dguadGc8QcrWYWxf2zC9kDnUf4lJpCP0QFwPnr3nMj0xQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:26:34 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:26:33 +0000
Message-ID: <0cc62a35-8dcc-01ad-8db1-e9a1ee2f4e4b@amd.com>
Date:   Tue, 6 Jun 2023 11:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] clocksource/drivers/timer-cadence-ttc: fix a signedness
 bug in probe()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <ZH7rMgjh+z3TUKGu@moroto>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <ZH7rMgjh+z3TUKGu@moroto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 16714a47-ef89-4d8b-8238-08db66701df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tabtqP2BubUnxnhGKVxZlpBQS6FQZ3Ke05SpaZgLO4BC9kRaVrnbrmoZbMGWlmMWNeEGteSd5EVJvzt5Ux6VSBOsCGmm0BCkIg9oiAtxzEDhvqdGug0sw9QcyXixHi5P/aTyDf30DA5IAYoV6/krvxgNe6oOVC7p39S/YBYGFQDYTbdw+gplAWsIeaVXl4m6LZFJB1LLaYfBwbOS9+4ZBQItARVYXIRlpiv7ZwQIQ6O+ZEErAbQ5ciqnZTDTyuFdkESi5yLrmv5avf2c57SJxM0SZYl6l/YIhjWmnI5okZUqDYjgis5QaHJPRYfzilRBlqNr9AwPmjgc36KDw9dfGFZSvxhovRoIYXYyAr73rQ/2+js53WMT/bQM3ipjBf9FopWKsn6kh1dYTr5t1LIOA3xTnYQMM/EK1VJbUgoy4CBLk+LpaeCnihSOsebvZdq4EO1DiFTmaHtpwcacBchJkdv9vixF+Sxk4xkm9/Zv/Sf6VCusM8PDo9cpo7xnXfy4g66q9Xu1FRsxs3tzchH/fcTA0xfP3cpfPdQ9x4HUVe0om/p/Ogy/uguZgFO07qV51/qnwfa6stA6OpJvAsK0mbGB1xHrZxCGBE+MefBkoR1sA9IUtp4NjiY6wMtyS1a81k4C1oGMpjVmyDs1Yh8Ndl4NncZPJOqjhxwjiyjN7JO6DgNusu9tBQ+s2H/Don53P0rHQAIxeSI7H9+vLgN/xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(31696002)(4326008)(66946007)(66476007)(38100700002)(6666004)(6916009)(54906003)(66556008)(6486002)(478600001)(186003)(2906002)(36756003)(4744005)(2616005)(8676002)(8936002)(41300700001)(5660300002)(316002)(86362001)(44832011)(31686004)(26005)(6506007)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzNXYjhlTkMrZ3JrSnQ0NzFxei9Kc05sby9sYmh1U2VnQjJUeGp6clVnS0Jo?=
 =?utf-8?B?bTNleURjcmtKbHljQk1JeWxITyt3eld3RW1DdC9NbmplVTl4SmQyYVpOclZP?=
 =?utf-8?B?OW1ra1QxaVg0VndnV1NBSWVOcVB5aE9NVUczZ1V5VXM0UjNGK1BJVEpRQmdX?=
 =?utf-8?B?bkc4R0tHZGppVllORkRra291RjE3Y3RzT1JJdkNINGIvWlk0OGZSM3U1Q1A3?=
 =?utf-8?B?ZXFXSkI5V2srVVh2WU0rRWZ3eUJzR0VjMDQ4TUZ0N2FTWFhDM3B3RFA5bnUx?=
 =?utf-8?B?Mnc1SUxCZFhXOEwwR0h4cytwR29zekZRWlludjR0ZStZYlVYZzZDWm1NWHl4?=
 =?utf-8?B?ZmJUK281MGJMeGpabVBUUjFnTkZOZEhKN3NmeXhSMXdrT3N6K0V4SEM1SWVL?=
 =?utf-8?B?QmNGb1I1STBxa2NLNDQ4T0QwM2RqQnVrS3hEYXU2Z1pFV1FkKy9xT2RWdWlO?=
 =?utf-8?B?UStTZkY1YStBNjU3TTRUa2dqNTBWMWdCT2dMbDVBNVJVOXE2Vk84cmp3ZWRu?=
 =?utf-8?B?NWJjSmFWSWI0RHlyWW14WkkyY21CTFZreHdKeDM3N285MDBPSXFBenBGdnEv?=
 =?utf-8?B?TDFIZjk5bEh4Q2dycGZNemNkNHFLVU9TYUg5NG5YL1g3WHpvN2RBT094RkVh?=
 =?utf-8?B?c3Q1Z04vV1lIVzN5eHdkK3ArVzkwdWgwTHo4dkk0aHBpL0h2M2lpTjFPbGpi?=
 =?utf-8?B?RlEzV3BkTWp1ZS91dXpJaGQ2ZXRsaXVQY1JTSVhRclo4dktqclFGejZ0cU9o?=
 =?utf-8?B?UTJPYU9nb081RklBcU9TY3liTE1CVnB4ZXNhU2dzRVIyb3U5WFhpaGJoMFBN?=
 =?utf-8?B?S0ZQdXBWYlVQU0N5Rm1ETDE0ck80TDZUN3czMzJCOUhkSkcxQmlXeHlQY1cy?=
 =?utf-8?B?Yy9NUS9OVzFkR20zdVZZam5qR3lYdkdUUHV5Z1loRytISm5NVTRRLzlKV01O?=
 =?utf-8?B?M0NsYkowVjU5Ymw3OEpXZmF5TEdhejF3Z0NnN3FUeS9wYWpDbzc1MHhiNU8z?=
 =?utf-8?B?bXJyZEVnZXlGMUxRL1lNTnlnL29TN254cDhlY0FTVy9CdHlFTHJpUmlDNTVK?=
 =?utf-8?B?SlFsdWhrN3ZMOUErUnJtV3VXRDRwL2g0bnRjcENBVFIxdm8xdHE1UWhzQmtW?=
 =?utf-8?B?dGpQOHZmb2xDemNrY21xSmtwR0ZKY01abWR5TnFHQ2VQOGhGa3dsLzJIdjRp?=
 =?utf-8?B?MGpHeFd6ZTdCMWF1c1VpRGQvNmQ5dE5jdGtoS2ZRTm9VQ3laT0FJTzlLREJB?=
 =?utf-8?B?WHJCS3NXd1ZoOTVWbVl6UVpFOGV4TjdUaGFxOEdRRXVIUjljNzdYZ01UTFQr?=
 =?utf-8?B?b1hZc1A3enR2R1ErN2V1ZDM1emNlR2lPL24rN3l1cTdCZjV4RVZTR2pXRElV?=
 =?utf-8?B?bXMwWEIxQzBiNEZrRHlmZ1pqZCtnbVZOM3BNMmhLaGhVcEtKMndmaEdkNU1t?=
 =?utf-8?B?L2JuOE9tTzRVd2xFTmJnTXpDcEJYOVhCeHRBUGxEa21adlhqMDd2NUcxYkhp?=
 =?utf-8?B?RGxWVXVRV29ZVFpta2Y2WGl6c01ON01NSjk5d0ZLNkNRYkhOOERjd1Jhdm02?=
 =?utf-8?B?eVZCZUJBekZ2NUdXWFk2N2pWZFZQVGRNcVRNTXE1VS8xbUZUMEVPS3FhK2h1?=
 =?utf-8?B?NU9ZTFNXMmJJR2U2Ullza0RRd0pSaXM0NExZR2hxQUpxdU9PS0t3Y1NCOGhu?=
 =?utf-8?B?NUhUM0dIWEUvTVR5TlQ3ZmFQbnZ4dHRYd1JCcHNkNUl1VGYrbU4yWDljN2Rj?=
 =?utf-8?B?RVo1THJzaHBEaC9VdEg3MlNZNzh1a2RLSE9xQVlZWEdBTGJMRVQ2bjcwSWhB?=
 =?utf-8?B?QTk0ZWg3R2txNDVzbVFvTlpVUnoyYW1OY1Y0V1BZYmhraG50UUI2am5zS0Z6?=
 =?utf-8?B?Y040TGV5V1cvTkRMT1g5aWZFcGt2VnR5T0c2SWRVdk1TTlNkUnpQaDA2cmh5?=
 =?utf-8?B?UU5saFVDWmRBQjFibS9rYUc1VWRXay9ROUZON2krRzM5ZmMycUs1a0dkRE9G?=
 =?utf-8?B?aTBEZHoyNjNRdlVrSHE0TUgzWUhwaUp2clFIbDg1Q0R5RmhOcjZFcW00MUht?=
 =?utf-8?B?VFVvMC9majludjRKS1dyYnlUaU1id0E4WjNXMElRYitVT2ZIYUgvazlGZFNo?=
 =?utf-8?Q?vyNqLk+o7cMiGc0awmtBDhCda?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16714a47-ef89-4d8b-8238-08db66701df5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:26:33.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6ULrNtsZSth52E75LqhsHnF+8OsTNI8N71d2g7QawsbtqhqzFEqUm4wamALu4L6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/23 10:15, Dan Carpenter wrote:
> Make the "irq" variable signed so the error handling can work.

urq_of_parse_and_map returns unsigned type.

include/linux/of_irq.h:118:extern unsigned int irq_of_parse_and_map(struct 
device_node *node, int index);

instead of this condition should be fixed to

         irq = irq_of_parse_and_map(timer, 1);
         if (!irq) {
		...

> 
> Fixes: e932900a3279 ("arm: zynq: Use standard timer binding")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  From static analysis.  Untested.  Presumably if probe fails the system
> is unbootable so I didn't bother looking at the resource leaks.

In the way how systems with TTC are used today that's correct assumption.

But just to be accurate system can also have different timers which could be 
used instead.

Thanks,
Michal
