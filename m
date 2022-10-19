Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C616B6046D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiJSNVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJSNVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:21:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7CB1DB270;
        Wed, 19 Oct 2022 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666169132; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2irzQRisuQph0qVQTfrw1gD3XTb5c+6xxeX7I05Lbx8=;
        b=jjeeum7SZmGwGhPrFwc9Kx571MNPHFw077WifZSIV7ABbqICZWqAwwtr6XpAciPJ8c8G/Y
        GMY+yWVDuu2ZD1dAMi5x/N5nNYJP3Cnz672CN98++xJOEFmmDWtKoHAPCr4z19courTJ1a
        uY61NBBpDo+2oB8Eydhc5FPKee34LiE=
Date:   Wed, 19 Oct 2022 09:45:23 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH][next][V2] ASoC: codecs: jz4725b: Fix spelling mistake
 "Sourc" -> "Source", "Routee" -> "Route"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <NBSZJR.DRWYIWVJJ4H42@crapouillou.net>
In-Reply-To: <20221019071639.1003730-1-colin.i.king@gmail.com>
References: <20221019071639.1003730-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Le mer., oct. 19 2022 at 08:16:39 +0100, Colin Ian King=20
<colin.i.king@gmail.com> a =E9crit :
> There are two spelling mistakes in codec routing description. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> V2: Fix "Routee" -> "Route" too
> ---
>  sound/soc/codecs/jz4725b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
> index 685ba1d3a644..64b14b1c74b9 100644
> --- a/sound/soc/codecs/jz4725b.c
> +++ b/sound/soc/codecs/jz4725b.c
> @@ -359,7 +359,7 @@ static const struct snd_soc_dapm_route=20
> jz4725b_codec_dapm_routes[] =3D {
>=20
>  	{"Mixer to ADC", NULL, "Mixer"},
>  	{"ADC Source Capture Route", "Mixer", "Mixer to ADC"},
> -	{"ADC Sourc Capture Routee", "Line In", "Line In"},
> +	{"ADC Source Capture Route", "Line In", "Line In"},
>  	{"ADC Source Capture Route", "Mic 1", "Mic 1"},
>  	{"ADC Source Capture Route", "Mic 2", "Mic 2"},
>  	{"ADC", NULL, "ADC Source Capture Route"},
> --
> 2.37.3
>=20


