Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12447157F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjE3IGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjE3IGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:06:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2090.outbound.protection.outlook.com [40.107.7.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F5124
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOjD0b83kfOE7qEPGxFyUewjyqHd1loYQhxkTVGR5k7Zx0oB4fMcBMB9nEd68MjMBpOKT0Q4r2wnR43hbMNTWVwsetqTTkcBwYBPowQ/g7M5dWbQsjrGo9k09fwP+aX2Im2vMsVMJ9iUot09SiMa0HEMUINcnlFd7eY7W51P5LJH5lXYf3OzvNUmC4BOjRBGJy4+O1R4B7CxOXgFmViUw/tTkXPWA8k3cCkc5c66DiWazwWf2fbYncXH7myGh3i5f7A6d6h9ZNivreWguIED4JjNv+bRtFuvoq6M1BE641L4yEFHGPdFewAZWkdfNDok/fIS6cdaEp7vTDGyDwIKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXC+JABUxMhcpraCX6s/4IZ71wQ6isYayBWUiK42lPo=;
 b=IV3ezrcVowBiwR7Q37V/5cC7jwP/UgiE6dHjKZ+ly1TFrV91EhSGtlXMYCXBArpVzq6j5jcdFWiMTQeTUVvVvDZJmrt7I9jQitDEqnk8J/3ENEYAgusRSFVITmdyV1QHXWxd3208AUwe+nD9p+T4+WifiqIhzxGxN8Hxf6htQdDEXgNbmJREJwSql2KTbcc6PsWU8wRmvcSb0Nr2neNBTWMQZY8khdl5JUU/I3AFeiSWJx1Moh9aTfhzwks6KWOOMWkuMFMoeUt+LcCPyNIv4iNVpXI5l7mwrmG0OrN/pSo4fjp2/FQqRd3na1PCDMtt7/rvHRa90ukdfbZ3BIbdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXC+JABUxMhcpraCX6s/4IZ71wQ6isYayBWUiK42lPo=;
 b=d569e3rX/eeeTab1c5OFTNrp68xyLzQot6T1lE8g0BS94Ai6QoTOT2zfOz5wMAtu4DXEyR+bu0zrwDs6swkJ8aewVaVkvWxJGCLRcc50No9+73aSqaADEaSaolyDW1ScM7YI+pT+pyfIpcl5BGPldjVQSNr+tBmFq8O0Y8XZk3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:06:16 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:06:16 +0000
Message-ID: <04a3e224-3f06-47e9-54ca-44a0c4d5759c@prevas.dk>
Date:   Tue, 30 May 2023 10:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 1/2] soc: imx: Correct i.MX8MP soc device
Content-Language: en-US, da
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230529033710.4098568-1-peng.fan@oss.nxp.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230529033710.4098568-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0124.eurprd05.prod.outlook.com
 (2603:10a6:207:2::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: a723d543-ef6a-4fa8-2272-08db60e4be4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19AlUCo92FojnqAwGJFV+O5CN1FsVot6+rcfAeaa0U3xH0RvBAZ0d56n4cLNOApjMkdnWC0nKH43DCTZVQLycvsqJIvHXcNcQtjh5zEa9hIAzXN3d4YFFFRWh0Et50YHTKR3AlsP8WARhI7tpTs9JxM0R7juna1OLazdQGPvHnmINwpyU+ljlJHdjQpcVeoN34QCQQOEkYtEYMCG93DaBqplCXFzuDe8SkBUe9Et0IBYpDkAr7tjxuh2dlX3gYgHFD9mAot4BxYiUo+e+LFrio6qt1eabt9crRQL6YITl5BpyehBou4KMGdDnU2Vu202OOnFVoRRvb+QahouyVPAIh72fZs4vR4zbDK/pBrsSIGxjntoQuds8C879QvFJcIrUthch+oPkpVy4puGX7hSTieLr7yJWlZGPYSCXUJP9UeLgAGZ9wSnY4crmJi8GfpeLPAwm4t+fec1WLtmJeKrr1C7ZJXutMZP/jNHCbLbgpOG7g0oAQCSUuVmRmk6egIkzvKGxYziOhEftYF1Utk/RuLjIv67HJK6YoxdiIGAdujp3MK8E3rRb0NbKTmMw+OlXhMWZaY1plaOoDdDUz2BvXPjCwDpDSOYdJZKGbHfS2MzTkx/XUm0nEAmsJs9EZy4gy7RDYo1T7BzZv2qHiwyXYvubgd5dVkqR+E51tDryDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(451199021)(966005)(186003)(2616005)(38100700002)(38350700002)(41300700001)(31686004)(83380400001)(6506007)(6512007)(26005)(6486002)(6666004)(52116002)(478600001)(4326008)(66556008)(66476007)(66946007)(316002)(5660300002)(8676002)(8936002)(8976002)(44832011)(2906002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVBWlZLSkZINXBXdmN0WmFZMlkrT1hISmttQ2JGMWxZOVRzSk9sZXZMcE5H?=
 =?utf-8?B?YmV1c2dicGdESHZ1eUJ0RXVhT3A4NURWMm9vUWl1Z2ljUmRzejNhVEY0b29h?=
 =?utf-8?B?WXZoSllTS0hzS0VaalVLWTVPUXZQV2VxZTh0eURXcGR3UmxNUWN6bTFETFpr?=
 =?utf-8?B?Q0wzQUZJVkx3alhNb1lBQ0RjSTAvZmhvSnhNVEJ1bzVwWkFvL0VUTFM0U2w5?=
 =?utf-8?B?ZENDTTNidDFDbW9tWDBPd2FTRkVJdE1WN2pQTUlDN09pd2FBQStIR3F3d3RK?=
 =?utf-8?B?UTBpZVpJUXZ6WnR5SzNmZ3NUL0NUVVJPV1F4Vnd6VUZZVTRWcHR1QjZDK1hZ?=
 =?utf-8?B?bUluQkpnak1xUmM1NmpQcUFCM1QvbDhKdEdvSmYxUlEwdmRBbmJHNklJWHFj?=
 =?utf-8?B?NlhRUDBzVGdNRzczUFV5WmZpTTlrTEdEVW9ucS9jOXpGZlFlSkpFcENJRkto?=
 =?utf-8?B?R2NjanU4MWQzMWluMU9qbEhSWTVuaEJTSnFaYmtQY2VJenZWRTNHL3RvNGlh?=
 =?utf-8?B?Qk1scEFNOUhIS09YWmJ6cGVNMHBwK2UydklmM3FiU2xBZExPVm5xTmZOTWdn?=
 =?utf-8?B?WG96Q2YzamU5VWZZQzU1V0VkbnZBRWx5NHpEQmRkNVc4NEFPbi9rVDhxRWNJ?=
 =?utf-8?B?WTVlRGsxblN4M1JyaVJ3SGs3Y1FnVFZRQVY1bVZNczVlQmdxWGRhc1Bwbm1n?=
 =?utf-8?B?bHo4RXlrZ1RlZ2RGU0VreUVCd1NYWmREZXJacGZPU2Nmc3I0eVBQTmJ3cFUx?=
 =?utf-8?B?K1dQVENEcE5lVjJqSmlhanpCNzdNYmhqRWloK1FPVGhzK2duR3ZVaE0yRDF5?=
 =?utf-8?B?ckRZSm5GUnIvZnhyTmhtaGFHWTZPaVh2TjdIM1UzbHREVGFoaWx3c2dWOU9Z?=
 =?utf-8?B?U0k4emZsa2Q5T0hJUGNLU0tUcVVkdWRXMXp6elVaZmg1YkRrd3JWZCtJdExS?=
 =?utf-8?B?YXozWVpjWkkwMTIxY3UraDhkZXFjR3h2SGVSOE5zbEhMVnZua0ppc3o1UkJM?=
 =?utf-8?B?eUxyWmI3Tmk0eUExV0lHNTZ0TVFkSDVQeDdSQ3hnSk9yMUtCWmhYRExJaFNF?=
 =?utf-8?B?blVTZy9BNjVKSUF2TmJhT1IrclduQ1RjWk9ad0JEaWM4Z0VHWDJKOGZSc3Jt?=
 =?utf-8?B?M2pjWU9GcFBlSnNTcldSNWYxdmNEWjdYTVJtUGVOdExHSFVHUVBHMWc3bDA0?=
 =?utf-8?B?cE9DVjlQelNERmZ1MnM3ZmVFeWFSSVdUWnhrb0lrbVN3MElpb1JVS3N5OWhZ?=
 =?utf-8?B?SHREQ1hxTFJLZW16cXVqWklNMGYvZlFZZWZUSVQrZjNkN1VRSkhmSWJFbHNR?=
 =?utf-8?B?bmNPV1IybG9nbG5hZGgzRVR0ZzIreTFYblRSNi9PK0o4M2lEclpYZ0V6ZWlt?=
 =?utf-8?B?dlBJZkRXOXdxSHBNdERKSnBuS05HeDkvOW1LQkxpeHR6VGNxVW9vWXRMU1Nq?=
 =?utf-8?B?eVlWYS9XWXZoMHJRUjd5ZkgveW5yd1RZWjlUWXVqVVYyQkZnb0pNMGRiM3py?=
 =?utf-8?B?VmZVZGJ0WmpmdmJ4S2RiMFpHUlN0N0d1ak5mZTh1VGVQYzBiZmo5RHMxVk9s?=
 =?utf-8?B?Z1NrNXNaQXhBOFJmUG5DTERYMGVuN3lzdnEvTHNRQmtVZnJYekFsWnp0c29R?=
 =?utf-8?B?K0swUDdYdWVpUFpvS1RnMGFzV2lRV2N6WllCNkVDM3lSUXVocUJ3SndBMjlR?=
 =?utf-8?B?NThhc0FDTkFUZTZ5SWU5cWNDSCt2c05HSnFmTGxXcS9EcEM5OTdFaENMMXBP?=
 =?utf-8?B?MlB1dS9GNiszekhGUGtxMWhjUW5JRWJ0cVh2dE5IT3Bua1lFRHFaZnlmUkxk?=
 =?utf-8?B?RmlLTWl1b3d6eVZlYUJ4Q3hkUE5uWE9PSE5UeFZaQmRUdU0yUFBzVHRHWXk0?=
 =?utf-8?B?ZllCVCtUcCtvaXc2REtpMk1nTzNpL0xaaDVhQUljdy9TT0xidTNKWXkrTzVj?=
 =?utf-8?B?Y1ZzK2VRcmVhMmdjbHJCZ3U5bXJZRk9sUCtLOHhoWHY0ZGZxZmhEUkJZOUxm?=
 =?utf-8?B?SEFic2hWVFlBdktXUEx6L0RGbGtHUUh1cWF1MDZqd3B3RVVJS1RmY284Vlp5?=
 =?utf-8?B?eENHeXg3OGozaXVIUVFLZzI3djQrcWlWeFI0WEJqSVU5N3IwQmVUelJNMmd0?=
 =?utf-8?B?Q1JBOWVqT2ZORkpDQ1duVThHWmxRWmZYMTVMbXBYelVvRTBnSlBWTU1ZYWNN?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a723d543-ef6a-4fa8-2272-08db60e4be4b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:06:16.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPYRHDIeKA0+bMMnzKiMEi1KaOmVxdaEIBtEKkL+FeUI/4BB8CVcmhYMGZ0wHbN436fJChjEQTrh7W0hbw8Gn04ND60puHgcH7NhXdlxh28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6996
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 05.37, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP UID is actually 128bits and partitioned into two parts, with 1st
> 64bits at 0x410 and 0x420, with 2nd 64bits at 0xE00 and 0xE10.
> 
> So introduce soc_uid_h for the higher 64bits

Interestingly, reaching out to our NXP sales rep asking for
clarification resulted in:

  On i.MX 8MP Unique ID is 64 bits. Please see here:


https://github.com/nxp-imx/uboot-imx/blob/lf_v2022.04/arch/arm/mach-imx/imx8m/soc.c#L752

So could you guys (and here I'm referring to everybody with an @nxp.com
email) internally _please_ talk to each other and figure out what's what.

And, again assuming that the UID is really 128 bits, nobody has yet
answered why the upper 64 bits are not locked down, nor what would/could
happen if the end user/customer modifies those bits.

> Fixes: 18f662a73862 ("soc: imx: Add i.MX8MP SoC driver support")
> Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

That's true.

> Closes: https://lore.kernel.org/all/fe5e2b36-6a8e-656c-a4a6-13a47f4871af@prevas.dk/

Not at all. We (anybody outside nxp.com, and from what I can tell,
probably quite a few people inside) still lack a complete explanation
for this whole mess - why does the RM say one thing, which gets repeated
by NXP TechSupport in a community forum, while a sales representative
asserts that the current code (in both mainline and downstream linux and
u-boot) is correct, and now you claim that in fact the current code is
not correct.

Rasmus

