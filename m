Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893D86A7ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCBJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCBJxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:53:01 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518D3C3A;
        Thu,  2 Mar 2023 01:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX4FO2z7eqTImC6DY1jxGg2fsmzC8g4cJm0mCR3XATeUFQLhEHcBUSAiVooqPweOfq04CgtcGYSgzb+KkjoycJjNtKyiK1URW++7/mHdOHpYUgDWg0zpyYVa3vX+Vlpq8e03FNbxxC99LMzMthoPIjF+qXKqplIQbBdKp38ShEsH4IwQYWNYzDUgSQZdErQcvxAnFUjcw/kjm5C4hcG2SXodHQXAOqmFaxnj6xxBprs6T8vyX9TGgM/BZ6s98c3zhfRidxr1lRh434UBokhmzGxD8M/siygd1A3gg7U05CTf2Mjmo2YprFELyVESiRHb/o+HfUXC43vo8LpfscBG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6wwmI7XU/u72f0RhZcJpQMKYINHkN4riuzoZNKkVtI=;
 b=CSPqV3zZAYGknkIx0SkKFrvA09eTtpv8dfqQ2PgnmVSuOmz5g512OKXYA/wWVNKyQzNfG702whVkhNRtD7/wiaMtgxRaW0e8NBliPbXo17rFuRFE0rc7DsFrrZ8qMcvVn6ODJO5qsTfORhnVBOAGBCaLwTCcs3j6Gvo5fVcybenMwdO3ol07VbN6pbHcNOS9lZUUdVyc6pgcyNDNt9iA6BkQ2OIEFtqfMO9JUo+TUa/7X1o9GRbtecrnIc+E0fnjpd//7E4GHd3SYmDea1rwYbO29fUVQTl0+vwGppTDm5yyCmuh1nfW6Ok7G29kwCtYmDZJ8axJJaDGZHba32pk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6wwmI7XU/u72f0RhZcJpQMKYINHkN4riuzoZNKkVtI=;
 b=ZKloaofZCPlBeU/yk/Y6YUu6hqK8QW8BT4XAdYd5bu+mVT2zJQlOrPd4gPgq7U1aNNif2Xv5c2veOHuOSwr6Qz6yxaeAj1K4lA8dKBdUwZ8wO5EVw3AKB+KM4gAuec7ZHYnlI2wGYYuPLtOWaT5lKTYLevyIlcgAOwlhNnmvee8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:52:56 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::8e85:409:6bbd:aa9f]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::8e85:409:6bbd:aa9f%6]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 09:52:56 +0000
Message-ID: <37ad1463-c12c-f148-4fe3-07dab52e8e1b@nxp.com>
Date:   Thu, 2 Mar 2023 11:52:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230221170356.27923-1-iuliana.prodan@oss.nxp.com>
 <20230301184916.GA1326133@p14s> <20230301185606.GB1326133@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230301185606.GB1326133@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:205:1::14) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|PAXPR04MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: e886a66b-055a-410a-fd18-08db1b03e5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6s7ehyiOCCo/3ViXo2goOj5K2yV0LJWbQKUfOGJrtnh+yk1oxFffbx2yN2S8UKgRgw9RZfTTcRkR1/lLVBgxFlnoy+GA3bZWKEPaqT+fZ4HPMubV/yHmfUnIi2+JjtqvFgOxasDblW1ffRnYELTHcwrq+5E9UmQubQshGYh5Wi77Wg0SxChSnkE9JYkUgWSNVSHWTRYJEFSOn5ohngZmXf/2h03yr+sl3lyYs8BRkXRZITJxlH1hee0UD4sJpLfyTDmNM5nWRFh2XOAJs3v7WbDQchXcLInirPIgEVO17MfbgvqcO5q0TJ8Koij7FtcAsc9haqwAc11gE/sv9WbfML5z7HeoQbdKKATnfJ1RF/EPyzr2xadijeNb8RvZd30X+c6R+VqxFKtCTSpWi1SRscjmsT7e+ww2ciZ/sd3hO7NfGaPTzRp8THtEAaAdAAaQxfY+1wbZjeoHzjtpzwey4ZeQharbyAFwj+X/1HhmoFDBRwk6cFBPGLdqWuLbkcBPXptxeyh7MYHbx9F1nzCHDQ54NVcuEqjMadYM61cLg1WA+6L8nAKHHJb344n/QtKE1rcafozHhtehMRDTe4hKFz2ytfPF4zfRnvr2dkL/69SVyTPwh2DksGf81HO7+i7Fyxs8gPSaxL0M8BFlQwll4KwC8tabGcNe8CnpQi3rMIlAyo06ICNb+oSGeUZpvd1dk5lGN1WsBtzljUgcou/u2cGLl00ca89AYgKBHmX2zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199018)(31686004)(86362001)(31696002)(2616005)(110136005)(5660300002)(8936002)(83380400001)(54906003)(41300700001)(44832011)(66899018)(186003)(4326008)(66946007)(6506007)(6512007)(66476007)(66556008)(8676002)(26005)(478600001)(316002)(6486002)(55236004)(53546011)(36756003)(2906002)(6666004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0JaRDZQNE5rUGlEclExVHZHMzRlZ084SU1NOGo5WXNhb0F0L2Ywc2s4eVA5?=
 =?utf-8?B?NHM3VG9SeVpxTjRpekhGT0pBZWVLUThjS2hwVWZ3ZUlzUUdIbGFDUEtHNWV0?=
 =?utf-8?B?Z3k0R0dlUkxPZnRjaHg1RUhHYWRsYzkxUzJRcjIwTVc1Vk9lOGsxQUp1d2wy?=
 =?utf-8?B?RUYxVWRCd1FONTI0M1BjZkkwUHdVMm5leVVvb0VmbE0zR3JEakNHRDhNWTBG?=
 =?utf-8?B?b2lFeFZwd3ByeEhvbUhCZGZyaXZueDdiRGhvTGluQ21XMGlRZ3R3bTJETXpi?=
 =?utf-8?B?bnBXbXdSckNqblRlRUkyZXRRbklYb2RqNzZTMGUreDBlRjdSM1NvSUZ6ZU5z?=
 =?utf-8?B?M1pZMldOV281WWVpQnZmWUlYQ3pYR0Y5MURHcHY2aFlnSitLWnNrQnB2WGNz?=
 =?utf-8?B?YzRJdlBqaWNQdnhoSWRIaVNNdDdCajFjVTNlQy9BSFMwcExCWCtvczhxTHBZ?=
 =?utf-8?B?SU5OKzJ0Q25FeFMyaEllV2xmcDNtNnl0b2p0cktSYlE2d2tkcTNOa1dLSFhE?=
 =?utf-8?B?RDhxc1dCNGZkczFjZTFZanBVR0Jyc3Y5Mi92SCtwUitHaks1YkN1S0hkblk1?=
 =?utf-8?B?Vm1mOWRpaGxRTnNCTk1XUEducFplSWFuWGVUem5QVVUwcSs3em8zcHlqQnBj?=
 =?utf-8?B?UFQrSlcvK0ZWVHdhV3gzemQveDRoM3RBdE1yUUdjZ3pSSHNuWnJSWWphQW9S?=
 =?utf-8?B?cEtQUkIyMXYxWmVBRjRBS2pLQjZtcFdweTMzRVdXcCtrQXBDUy94d21NTWhS?=
 =?utf-8?B?R0tTUGtuV2QrMHJUY0o5NUgwbXRIazR2L1pmelVwK0U4YjQ4ZDVPbUdHUkJr?=
 =?utf-8?B?SFJPSGhPN0U0NzZnY1UzZTJGN2RvMkhOSGZHNGF1b2toQStpTm9HdzJVMU1W?=
 =?utf-8?B?MU5ybnVndmJhZ2tUVWpVNDVwU2VaYko3bjAzVlBXTElia0NNTDQyNTRsM21j?=
 =?utf-8?B?YXFRNGhlbGgrQi9yQjI1Z1ZkU0J3UFVYZ0FFd0JuR3A4eGxwK2dZa2d1UmJa?=
 =?utf-8?B?S0Jya2NDWVlRL3NHVmZhcXRSd0krWm9RblJsK2pGc2JOYVI1ZmROTXVzQU9O?=
 =?utf-8?B?N1ZtalQ2YUxESmxDTUFBZnNLTUNEVHpXQ2hGcDJ5SEVrd0xVL1BNU1VTemhH?=
 =?utf-8?B?dVZDSTJqdEhyZTc0SU1uSjY3M2Jlb3M0ZFZuakp0UklyMDcxTjVCUlQzV2k0?=
 =?utf-8?B?QXp5WGxramEzNys3WUdhTmczcGYya0ZDZWhxelpSck10QjVybFZNRUQ1MUov?=
 =?utf-8?B?K2FTNVpKdXhGbm42WkdXUEZGVGxOUk1PQkJ0NTZDTFlOVUV1cjZaL29lcEls?=
 =?utf-8?B?SFdkWkgvODdSNFRvdlluR0hvV3ZHU2Rpelo4bkx6akw4eWVIeVQrNnVtckhk?=
 =?utf-8?B?Y0dyb3dOS295Q2ExaE9MSllGSmhVemdjTXFnT2VDRlo1cDhOSmh2Tis1WG5B?=
 =?utf-8?B?NHpjVno5R3IvTTRQZmVCMUxwY1ZYeXNRcXFFTDZFUVkrd01UMml6VlZMc3N4?=
 =?utf-8?B?NEg5VzlkN0dNemZ5SFhSa2lrOEZoME13YnJDNFpUQ0o2QkdGSTZMT1lEOXI3?=
 =?utf-8?B?MnVhSnVwY3k1OUNCMDg1c2RLeStzY2JuUGNhWG9JMldIdkFkb0RKYVhXdGor?=
 =?utf-8?B?TDhEN1dwS3dpUGRzdUY3SmdwcmRvSE4vTkhlWXB2NUQwOUtZSCs5M2h1NHl2?=
 =?utf-8?B?N0Z2VlZtVGx5TXpVQzRvUkN3cDRNWUlSUmhKN3dwVDduODlDQzNaZEYwL21i?=
 =?utf-8?B?Q2hIbWhQUXVCaWpwVFAyT3ZIdXVHbFdLdnhiSjV4ZW5oZERvdUo0VzgzNzNK?=
 =?utf-8?B?TjNEOEtORU41OEpaNHluZU5hUDdNNGNSZWVuSnNEZkRUWnF0TWpwa1JoN3JR?=
 =?utf-8?B?VjBSOTFVVmpHOC9CR1BRK3Z4UVIzQ0dWaUpaUE9zWE0rZWQ3VGZscjEwdFha?=
 =?utf-8?B?dEFMUTNKRGJMblQyTkJIcGtRTVp1d01Da1U5WFpxTWRZWEZtSlR1NXBiMkU3?=
 =?utf-8?B?UmpVaWMyOGd2NTBlTFlRTlcrZnl5T1B0US9scDYxTlpCVkIwbTBGZWZ1eU56?=
 =?utf-8?B?UkVNdTZXNkwzaWs1elVDMnd4QS9pUEM1TEdNOTE4ZWo2RlIvWVA5TzIzVUU2?=
 =?utf-8?B?R2N3bnVoeHBpemtpTUNPUHRpenBqVzhwZ3d0djQyeWc0ck5HSFNnT2F3V3JL?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e886a66b-055a-410a-fd18-08db1b03e5c7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:52:55.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjAKUTSQu5JoKQ2vxaDoYO3UMgPMGAOu5wNUQaCa+hXTbAic6f/uSgeyEMw+9dJGbZxCekBII8CDQHd4rJBAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9060
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 3/1/2023 8:56 PM, Mathieu Poirier wrote:
> On Wed, Mar 01, 2023 at 11:49:16AM -0700, Mathieu Poirier wrote:
>> Hi Iuliana,
>>
>> On Tue, Feb 21, 2023 at 07:03:56PM +0200, Iuliana Prodan (OSS) wrote:
>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>
>>> The IRAM is part of the HiFi DSP.
>>> According to hardware specification only 32-bits write are allowed
>>> otherwise we get a Kernel panic.
>>>
>>> Therefore add a custom memory copy and memset functions to deal with
>>> the above restriction.
>>>
>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>> ---
>>> Changes since v4
>>> - use GENMASK;
>>> - s/ioread32/readl;
>>> - s/iowrite32/writel;
>>> - use for loop with writel instead of __iowrite32_copy;
>>> - update multi-line comment format.
>>>
>> This looks good now.  I will queue this on March 13th when 6.3-rc2 is out.
>>
> And out of curiosity, are the remote processors handled by imx_rproc.c also have
> the same 32-bit write constraints?  If so, it would be nice to have a patch that
> fixes that as well.  In such a case, imx_dsp_rproc_memcpy() and
> imx_dsp_rproc_memset() should be renamed to something more generic and re-used
> in imx_rproc.c.

None that I know of.

But, this restriction applies to any core who's writing to IRAM.
When one is writing from anywhere else in the system to IRAM, this is a 
PIF write.
And the inbound PIF writes are 32-bits at a time.

Thanks,

Iulia

