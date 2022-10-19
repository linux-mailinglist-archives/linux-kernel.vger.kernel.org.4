Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB277603A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJSHQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJSHQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:16:37 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E81054C;
        Wed, 19 Oct 2022 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=5UtqZavdKpTg1FruydvA10Sn7lC8SdZCH7ZT7Um1HY0=; b=CVe1tmmxyiuv2se9MJNcky/8sZ
        aMQilixXg7sg+p8wxP8AFDAcgQjMs1RHlUCzHCH1/fguhTEngFJXBmcjHcPhpiYVAqhfnBga92abV
        khjwxXZpM9/V0JZK3YTFqpmCJhETlF14QYECPq4+BVEsMVkf9Ny3tv/gV40YZirmKYHD6sb1f7wz8
        XGQFAsvcKsTOjG1jIGQ5x3V88LE2+V3cLuByzSnC4hdmbyeOxN+/CQojMjTGXjLav6299SO1pPxXh
        /VZfQvZwkFVxaS/Lp2+OPkJoW6M5CKs21YfphE3lQlB/1cgvqqGOhf5yLKpbyshC7duTU+XUQ3XgN
        EWCQgYVQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1ol3JZ-000Fv7-RH; Wed, 19 Oct 2022 09:16:33 +0200
Received: from [2001:a61:2a91:5601:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ol3JZ-0009TQ-Fo; Wed, 19 Oct 2022 09:16:33 +0200
Message-ID: <fbdd3785-af5b-66de-f882-a008c87642dd@metafoo.de>
Date:   Wed, 19 Oct 2022 09:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH][next] ASoC: codecs: jz4725b: Fix spelling mistake "Sourc"
 -> "Source"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019071508.1003680-1-colin.i.king@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20221019071508.1003680-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26693/Tue Oct 18 10:02:42 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 09:15, Colin Ian King wrote:
> There is a spelling mistake in codec routing description. Fix it.
There is also "Routee" in the same string
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   sound/soc/codecs/jz4725b.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
> index 685ba1d3a644..64b14b1c74b9 100644
> --- a/sound/soc/codecs/jz4725b.c
> +++ b/sound/soc/codecs/jz4725b.c
> @@ -359,7 +359,7 @@ static const struct snd_soc_dapm_route jz4725b_codec_dapm_routes[] = {
>   
>   	{"Mixer to ADC", NULL, "Mixer"},
>   	{"ADC Source Capture Route", "Mixer", "Mixer to ADC"},
> -	{"ADC Sourc Capture Routee", "Line In", "Line In"},
> +	{"ADC Source Capture Routee", "Line In", "Line In"},
>   	{"ADC Source Capture Route", "Mic 1", "Mic 1"},
>   	{"ADC Source Capture Route", "Mic 2", "Mic 2"},
>   	{"ADC", NULL, "ADC Source Capture Route"},


