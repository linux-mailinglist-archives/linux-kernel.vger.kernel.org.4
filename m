Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1166861DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBAIlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjBAIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:41:40 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1360C8A;
        Wed,  1 Feb 2023 00:41:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqfru936AN33yhQUegxvYqd0MlSI0SuJWtcTYi8myCgs48wjO/2+8oTtH3STbargNinyvZOzXjNluNyNGhCgZ1idN2EY+RaGPHm2w5ye/0ZWorha4P+eED2dsV9Qb6okSMfcTgXWNXl/AMDh0XZAU+BovIvk2jx0I9U0eBUJVe5DSMiRGYrKBsxtzIyz58JmYaFq7jKU2JK9pUMsOevjvlJZlSXkem95lVk9iE9+3rzouF/nYBMR0d1mABjvUxXrJpWYLIbKanoPrmeutGHwq7haKnC3LB3Z335YQa42LlIBDAtyVbuSWD3VdIaqLeFPAVuZS+u7CX+sRV5hGjV4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxfyGVHaxg6QtbRsrBEg0EL95DEQg4p1DJnJN7JgoJk=;
 b=C9fP5XH/tdaZr/2MEh2Iq6dC51aNL2wZaIY2ub5XHIZlXpEjtvvWAqzevhNg+ZYtme7V94Fn68RQ5vO7WuMK1uj7CIUYy0gUjdBUKGfchMLHOeQeiT0iUTqH0DepNATTcEGHgNpiTW8YVKz0nRJ7Hfrj4KMUIhZX6Hh6XJRxpkn+rTgyJSJem50XJ5UFKuRY9XYHNQymDPt0fTJXc+4OH4/rh36OrQV/RaZouGqUzpT/iAJwagrkj+tPKXbq/W3gH7HL3nblj3gVH29+IgOYQSBbT2R98kvLdXHEdhVW2ONaqkzJJEcqfysEDhu3tU4sZXHPkZ+Clx+QDDmtsSVFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxfyGVHaxg6QtbRsrBEg0EL95DEQg4p1DJnJN7JgoJk=;
 b=N3UqOfUVfRhmNhTFwkPswjk/ek8XCVI0Uq/jvnI3OyIFzIp8zvSmWTkE6SVJEKAP8ppfFGO02GkTBZ5nN4t9eqErLrK8J0e1bPXK9cDssf7cLbfHN/LAQHSCiAS5LPT0IUnZBNfIAdNn6DE5RskjHVFoeIRSp1Eqy3bVyi8gYvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by DB9PR04MB9449.eurprd04.prod.outlook.com (2603:10a6:10:36a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 08:41:36 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 08:41:36 +0000
Message-ID: <30b1aa51-2fac-16b8-8fba-e82a88e3219d@nxp.com>
Date:   Wed, 1 Feb 2023 10:41:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
To:     Peng Fan <peng.fan@oss.nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230131170436.31280-1-iuliana.prodan@oss.nxp.com>
 <abd74bb6-9131-3769-513f-954234981403@oss.nxp.com>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <abd74bb6-9131-3769-513f-954234981403@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::10) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|DB9PR04MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 64189862-a671-449c-c12a-08db043020b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Aj3MCpgihb70OUjbMRTy/xJFRkNLefP/mpLvhZ0ScYEYO/nka8blbVzR0V8TWJ/qCmPI0cilf3c66bzAkXctVHMSb/NN3z7TrQ1s2Kykild+jCGCJpEsKE1hJpsMXu1V7drqHXIckM0ERvB1X0kP9H+dsO/I3iZC508N0wAiYhhkWYtdwaB/7eXcp3+YZ7eBK236BYCkKmHiZod4+GhAITBMZmx9ZZWEhQ+UpYBNAkZygXHg2os8xvqvmUTFw0cdvbeRSKi/hQYwQ7/akRFMLEWXewiZA6b9TA9xxrXcVD6Jk3nrpaLkhCvU5h9po+68wdfhc3raCdMRMYLkg4RiW2koLF/3gZyX09Fw88Jo73MvLioi02gsrVZqpnhPBZeIK0RRKqZrmu4Hw/JND7D9kPqAZw4Mlqfv86/zHuNUK/8UPIJeCmF8rkCV+DvZenVGLehB3XrSCqW3mwAvajBShfaTP31ZL4PYd03Rrziu1CDTEsCvzLVSSm/6LpmsNW7Fi07GBjcxuNPbIY/0ozp8TjYGXSe0WduBfJ6utmR2Fx6GfOpAuVsvtCg+dmKGzWB12fwwPsqEZTCzUCjxJwz3YLmdxvdO+QnTt0SC1P9d6ivpO7/1ra0CtChtMSjJnrAyhrMYSl9jnZSFoSj9SF1rAIzor8U3UrNmYHyjsGYgK8rLyHd/HI+LOJbM+1oWq7w93g0dIjQmimxwksNlsXzIMBDRfz1HBzU8NBpgLhUVi1NmoVkCIPSKiV2iGCnx+Yr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(31686004)(2906002)(86362001)(921005)(4744005)(44832011)(83380400001)(8936002)(41300700001)(31696002)(6512007)(54906003)(36756003)(478600001)(26005)(6666004)(186003)(55236004)(53546011)(5660300002)(66899018)(6506007)(110136005)(66476007)(6486002)(2616005)(4326008)(66946007)(66556008)(8676002)(38100700002)(316002)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmEyblNWeUcyQ2FFOHBCRkY3RWR1WVltekZ5UmFVb2lqNmc3K3BOeWRRSkJM?=
 =?utf-8?B?STR1V3V5dE8yYUgyZGZEc2Q5L2tPT1NubFZmbndsVml1WjYyOFVtaEpaaTFi?=
 =?utf-8?B?bXRlVUMzemM1RGFJS1lXZVo0VXhDSDErU3duRERPQ3JaV3RLTytHclh2MHZD?=
 =?utf-8?B?WVJRL0NWTzNGTHlOdGs1NFZOVGRZSHRQa3Z1eHFLR1VITU4zRTcwZHNxTnVX?=
 =?utf-8?B?UnBIUFBJMVQydkhaRSsvWGNya0tsWTJ1aVREZ1kxZEp5d0RBTkxCM2pXNWQr?=
 =?utf-8?B?ZGNiSEMwU0UvZ2FHcnRpWjRCSE5zdFVNUHFqbHpXSkdQa2hQRnFrMWV0VE1N?=
 =?utf-8?B?YlZ4dktOc0FyeWNBa25sbkttcHJwZlkxQllFTVo1NTF3UzExVmFqNXJvczd5?=
 =?utf-8?B?Q3dYNWsrOFNCM0JOOUlRM3J3bUxmQmdZeWZqVVZ1eUFiS0I1YkpOOGFoRU1s?=
 =?utf-8?B?eDI5L2M4QTIxMjltWHhhK3JVQ2FralI5RHRwbWlaQmpGQW9BdDJudmZaY0xB?=
 =?utf-8?B?N1dmQTM5RDZvbEJjejBNK091UHNManhCSHVWWE0valE1L2hjTlo3SDlHUnVV?=
 =?utf-8?B?QXV4Z1NIcENOUlNYMVN1c1Zxc0xzR1B6Z21Qcy95bEwwUGNRK2JBbnQ3YS94?=
 =?utf-8?B?WENGMVBtVHlpNXVFZUhKUFVIdURGeXY5VHRFcDNNNWYxVWlzTm94NlpBUE9m?=
 =?utf-8?B?M1hqQkFJaFBpRG5Eem5teHNkaEtpcVRNc1BocW93KytMZzkvNXNKQ1c4bFdi?=
 =?utf-8?B?bXZlZmFISXM1aXoxcW01WUJkd1dFTkdmVjY3L2lJVzlnbkszVmlhVnArdGlP?=
 =?utf-8?B?MGpUUE1uUWZQT2ZXVXhWdjE2N3dzQWRNQzhkaE4rY3cvbU95cUZnMGxRUjU5?=
 =?utf-8?B?amRpQ09PL1NLWGR4UTdWWGUzOXIrOGhGMVk3eExYZlJvMGZESjlvRG16R2JN?=
 =?utf-8?B?cll5L00xVnFHSngyMzh5bnc1MG1Ub0lDQkR1d1VvMlk3QjZZUS8zc3RqVkxt?=
 =?utf-8?B?NG9jNjQwWVpUNVdJeUp6bmF5SFlsdU0xWkdhMS82cDhPNHdGeVk4eHVLa3Iy?=
 =?utf-8?B?Qjk1dFVUY2ZQUUlRTWN0a0N0ZVlBTW9VSmJWWVE1MUZLZm9NbnVHSFRtckE2?=
 =?utf-8?B?QzR2SEJnWFdEcHI1a3FaMWFWSDAxK1dCTW9sVmREZFpWdzNMd2tWUlRaRi8w?=
 =?utf-8?B?NVIwNkJsc1BPSHJyTVJCaUpQNWFwelFlUUU2QzE2UW1YRENTT25mQWtETlh1?=
 =?utf-8?B?SVg3VTBtN2FjcXF6UTE5cVNhZmI4ZnFGNUpuMGdPc0Q3S1JwOVBWWmJnRE13?=
 =?utf-8?B?bm5wWWRVY1dXdm1nTFdmNVlYdEM5V3FTSHVFWXFRQ200d2hBdnVPbXI4YjJD?=
 =?utf-8?B?REFLUWV2YkFCbnY5d01FbWVoeGhNKy9BaDArWDh2WHB2RmgyWkxJR20rOGF2?=
 =?utf-8?B?WW14STlDRzNLWW5FcHQvMHNLelpjZDVhYzMxWm5wZzRNMFpMZ21NY0NSUWNa?=
 =?utf-8?B?THgvOG5QYXh4ajl5cmNpUlhhNGloMFhqRW9LOGNvLzJ0bHBaSkQ2VjlQMjhP?=
 =?utf-8?B?eFlQUVhhaDF6Uyt6MUVCRjgzYkRVY0NOTTQ2akZvSy9lWWxIQUdKY25pK2th?=
 =?utf-8?B?Qmxpa3NLRy9iMk5WeUJlYjB1RHo0ZCtaM1pIYml0dG1xOFI2ZzEzSlpLdE9m?=
 =?utf-8?B?SzJERXZyQnE0N1RCd0RuMHNrMm4zSk9kTHFoTGJac3Q0Tml3MlptRlo1d1Fx?=
 =?utf-8?B?cmV6cUhsczcyVkpaeURvS2Q2aW9EZHR2REVZcFBaZWZQSHVSYkxabk1uV3Ax?=
 =?utf-8?B?L0s1VUZmdVhXMXowQmhkN2IvWXVIdVJJU29kSnRwSVFaYkgxTTRaVFNUTDVl?=
 =?utf-8?B?VHJCNWhmajNTMENKS1laVjBQc1Z2WHVCMlZpdGRQM3I4YmJ1Y2Z2aGI0eU1K?=
 =?utf-8?B?THMvQkU0YmU0SjFCTW5VT2pZcDFOa283cjZ6b2NEcVZaTnhOZ0lieWNuOVNu?=
 =?utf-8?B?d2FrTUFjR3NsdFlWYkkvUllWTHd1cmt0OFFSanN1K21EamJ2cURxbmtBei9p?=
 =?utf-8?B?NDJQZFdIOFRUNSs5Q2pUa1Y0a2dQZEdlSVhRSlNZbEhoeXhoWlZ2Q05ldFAx?=
 =?utf-8?B?MU1VNUN0Ylg4SEVDSjdsUDBGellLQllhZXlsL0llQ0pJZmdLVjQ1OEpLZDY1?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64189862-a671-449c-c12a-08db043020b6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 08:41:35.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SiwY3+LAkEvrQoOBRjiQdIRhlZIpi00TRjhgJp+y3h5nWp+BMRa7wh9ONx78tFzsH9fOLBsc331mkNN+xt9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9449
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 2/1/2023 2:27 AM, Peng Fan wrote:
>
>
> On 2/1/2023 1:04 AM, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> The IRAM is part of the HiFi DSP.
>> According to hardware specification only 32-bits write are allowed
>> otherwise we get a Kernel panic.
>>
>> Therefore add a custom memory copy and memset functions to deal with
>> the above restriction.
>
> Which platform has this limitation? This driver has been landed for
> quite some time, is there any specific condition to trigger the issue?
>
> Regards,
> Peng.
>
Any platform with HiFi DSP.

As I explained in the previous version, until now, it was used in a 
limited scenario and the firmware was correctly built to respect the 
write restriction - having the IRAM sections size a multiple of 4bytes.

Now, I was trying a simple hello_world sample from Zephyr, compiled with 
GCC and I crashed the Kernel trying to load it on the hifi4 DSP.

Thanks,

Iulia

