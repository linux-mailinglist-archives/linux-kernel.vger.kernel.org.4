Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7123470F85F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjEXOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjEXOM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:12:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81191119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:12:27 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCLYBD028139;
        Wed, 24 May 2023 09:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=4CRN6cX3nFejeH9of7HvnG8/+qVlZ/0uL+vakv3omEM=;
 b=i7PT2Nr1WPHPUUsNGfdf/tPz5aayfT4/TvV/4MU3rQzRbsTgzZRqCoBMiXxxzzbFsbIi
 ml6UqPD87fwQ0YXBKe9P9bchpbCWxh7Fpo0G4J5I9hvV7oilhY01VhU8+YX9gvjNLsgx
 BrM9xmjlva29K6I70OQ07oPsKXAXS0PpqC9xfvr9nCpBdaA+xRb/DT6z2u3AA+TMelw7
 7MeK4rJL4O8HCZRk0K4DK65hhffwgW7B2UW6LOFVh9dAQWUqhDCaK/JpWH7Qb/u5oWix
 FoB8iQ+WY+HIRsaQmXoOVh+Gu8+N8ZRN1grbx5iHBxQikuqLo6yPuvP7MdU65lq85l2r hQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8gerk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:10:08 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 24 May
 2023 09:10:06 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 09:10:06 -0500
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D708411D4;
        Wed, 24 May 2023 14:10:05 +0000 (UTC)
Message-ID: <19426e6c-d719-b85b-8ef2-f0f3fd3fa12e@opensource.cirrus.com>
Date:   Wed, 24 May 2023 15:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ASoC: cs42l42: Add PLL ratio table values
Content-Language: en-US
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20230524125236.57149-1-vitalyr@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230524125236.57149-1-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hKuRP4Ug16q1rqZKtMu8kii27k9k3AFW
X-Proofpoint-GUID: hKuRP4Ug16q1rqZKtMu8kii27k9k3AFW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 13:52, Vitaly Rodionov wrote:
> Add 4.8Mhz 9.6Mhz and 19.2MHz SCLK values
> for MCLK 12MHz and 12.288MHz requested by Intel.
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
>   sound/soc/codecs/cs42l42.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index e3edaa1a2761..8aa6af21e52c 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -646,12 +646,19 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
>   	{ 3072000,  1, 0x00, 0x3E, 0x800000, 0x03, 0x10, 12000000, 125, 1},
>   	{ 4000000,  1, 0x00, 0x30, 0x800000, 0x03, 0x10, 12000000,  96, 1},
>   	{ 4096000,  1, 0x00, 0x2E, 0xE00000, 0x03, 0x10, 12000000,  94, 1},
> +	{ 4800000,  1, 0x01, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
> +	{ 4800000,  1, 0x01, 0x50, 0x000000, 0x01, 0x10, 12288000,  82, 2},
>   	{ 5644800,  1, 0x01, 0x40, 0x000000, 0x03, 0x10, 11289600, 128, 1},
>   	{ 6000000,  1, 0x01, 0x40, 0x000000, 0x03, 0x10, 12000000, 128, 1},
>   	{ 6144000,  1, 0x01, 0x3E, 0x800000, 0x03, 0x10, 12000000, 125, 1},
> +	{ 6144000,  1, 0x01, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1},
> +	{ 9600000,  1, 0x02, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
> +	{ 9600000,  1, 0x02, 0x50, 0x000000, 0x01, 0x10, 12288000,  82, 2},
>   	{ 11289600, 0, 0, 0, 0, 0, 0, 11289600, 0, 1},
>   	{ 12000000, 0, 0, 0, 0, 0, 0, 12000000, 0, 1},
>   	{ 12288000, 0, 0, 0, 0, 0, 0, 12288000, 0, 1},
> +	{ 19200000, 1, 0x03, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
> +	{ 19200000, 1, 0x03, 0x50, 0x000000, 0x01, 0x10, 12288000,  82, 2},
>   	{ 22579200, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 11289600, 128, 1},
>   	{ 24000000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12000000, 128, 1},
>   	{ 24576000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1}

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
