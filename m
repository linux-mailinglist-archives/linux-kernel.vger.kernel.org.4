Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22286C813E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjCXPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:32:23 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785011E1FE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:32:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OCMYLV023795;
        Fri, 24 Mar 2023 10:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=OY6gbhc5rqK8NYwaF/FMiViAq5PqtbZQ2uVGYmYXC0I=;
 b=hukVNPJxDWEhPwK5RMrGrnxDcVcMD01NYtmPDO2Tm1dQuHvPKKOmKxUC9+029W/NzHcX
 2fNpBiUSSqWvpbmx/WisDoN7XE0n2fDg6Sp5Wol8ykJGEAaU1DyvzH1rYTGn4VJ7mNgJ
 fXYQBHO2KHAUWw2xTihwNxrVNBaABWW/WF0fcidAkhWsKJFKS9XIGcdqeqSIYyv1iYqn
 IY/9SyyRAjNVPRwJUogpuGUVeuXdWRGHuZjyHV5dum+bHqtlyLLBnHK8Ozpd1yfaX9v/
 l11byvjchL6FKUG4UDShLo7ktPQGCxQyfi7VtfvvM3raMWhai5qU5ZkkeA8aGqrZNS2J nQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pgy30h0qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 10:13:22 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 24 Mar
 2023 10:13:20 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 24 Mar 2023 10:13:20 -0500
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D206511D4;
        Fri, 24 Mar 2023 15:13:19 +0000 (UTC)
Message-ID: <11a0b85f-d705-145d-fc6a-1bcbb78d3686@opensource.cirrus.com>
Date:   Fri, 24 Mar 2023 15:13:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH next] ASoC: cs35l56: Remove redundant return statement in
 cs35l56_spi_probe()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC:     <error27@gmail.com>, James Schulman <james.schulman@cirrus.com>,
        "David Rhodes" <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20230324145535.3951689-1-harshit.m.mogalapalli@oracle.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230324145535.3951689-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ScCh2NKqnHL0z9szIBr078J_Gg_bgyKa
X-Proofpoint-ORIG-GUID: ScCh2NKqnHL0z9szIBr078J_Gg_bgyKa
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 14:55, Harshit Mogalapalli wrote:
> We have unreachable 'return ret' statement in cs35l56_spi_probe(),
> delete it as its dead code..
> 
> This is found by static analysis with smatch.
> 
> Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Only compile tested.
> ---
>   sound/soc/codecs/cs35l56-spi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
> index 80dcf37daae2..4b2084e85f29 100644
> --- a/sound/soc/codecs/cs35l56-spi.c
> +++ b/sound/soc/codecs/cs35l56-spi.c
> @@ -29,7 +29,6 @@ static int cs35l56_spi_probe(struct spi_device *spi)
>   	if (IS_ERR(cs35l56->regmap)) {
>   		ret = PTR_ERR(cs35l56->regmap);
>   		return dev_err_probe(&spi->dev, ret, "Failed to allocate register map\n");
> -		return ret;
>   	}
>   
>   	cs35l56->dev = &spi->dev;
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
