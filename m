Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419C608E22
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJVPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJVPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:43:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EE922C45F;
        Sat, 22 Oct 2022 08:43:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e20-20020a05600c449400b003cce0107a6fso224333wmo.0;
        Sat, 22 Oct 2022 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9r+aFR8+2XwprKP6aUwtuqR0EdoHS149XwjTsHXczI=;
        b=Atb6QXoy2zOIgecKnjLHwUEN2heu9wkTpFNqI8supYptdMcuxInUr5HAJsJM80Tj9o
         VkZR8XeUlyty0Zml/N24OsUr9roqXdpVPeAcHpUNC9RYC92hHPDmKq0O27MhYDy3Bi+o
         TlHP7GqbwSeFqznULI4mlMmDBnBSCjeMRUnIYWf0VSVRDHQJ8MIquwCbNmskwbwRm1P8
         8chIjVgV5rcEdeTMXwXLkkQsFYeOgSl1G+7xDn/uY5/NfdaD+fZdUDqe/0O7NuhcCp0k
         aYJtHUDUxVSOWklZXvD7n9IdCWnp/9NF9Y/2A1zMHxGSjBiNxcF99n8Lk4qjf+kVgq9O
         XO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J9r+aFR8+2XwprKP6aUwtuqR0EdoHS149XwjTsHXczI=;
        b=QKQIw5F6QGRjXEwNzNFAH2IhLTJaSvxTGFoakvxAOKRaXQsPA75HMsbjvDuRnizpRi
         RPczy0YU0nVR6lVb0/X17fvkaEx3pXW4NkcqghCZI1trGCbqfR+ogXHuN+eSj/+RrP+U
         hj20EQIjZ9J4EDK02NlQsyjjXbAAgu06WHUdvEYz9vBTax5b0TbBYq5/scqIlXoTXUY9
         ueg+Dc9YH8xBPvRtNThPI2rJwETGrNO6TmXcDuESVxOxaUsvRiWuOY+zDmuJnHsh0ngQ
         qJKoHCsxUg3cOo+83WE58sRVKOLicvdHKm+0W0qfScqkyYJ6ZWkHKVEafP7+50YBouHf
         9DrA==
X-Gm-Message-State: ACrzQf1ljg6R1prQ4yWpYyVKivnuZMcrJWEajYA4ymuumKC2J2AIouVu
        3yS2c4cjfPegdvMh8qVjoUE=
X-Google-Smtp-Source: AMsMyM4wj9mhNf9PgnbhTN3dPvQmxmMTj72Z5wjcRTJ2hsR5qKS78V2WVXT1/5o5i4agdnM9lTTQVw==
X-Received: by 2002:a05:600c:4588:b0:3c6:f645:dad0 with SMTP id r8-20020a05600c458800b003c6f645dad0mr17700663wmo.114.1666453392376;
        Sat, 22 Oct 2022 08:43:12 -0700 (PDT)
Received: from localhost (94.197.3.61.threembb.co.uk. [94.197.3.61])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c2d0300b003a2f2bb72d5sm3403926wmf.45.2022.10.22.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 08:43:11 -0700 (PDT)
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-2-aidanmacdonald.0x0@gmail.com>
 <UXHBFR.6W2XPUNX040K1@crapouillou.net>
 <KM3aQuHkqtNZOgfaFAVA54klqcIZBA4X@localhost>
 <Q58DFR.835FR3DH8BFV@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] ASoC: jz4740-i2s: Handle independent FIFO
 flush bits
In-reply-to: <Q58DFR.835FR3DH8BFV@crapouillou.net>
Date:   Sat, 22 Oct 2022 16:43:07 +0100
Message-ID: <xDY1t3w8XLey5GcrHHg3gEH9kOIC7xq6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le mer., juil. 20 2022 at 15:43:06 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> Paul Cercueil <paul@crapouillou.net> writes:
>>
>> According to the JZ4740 programming manual JZ_AIC_CTRL_FLUSH flushes
>> both FIFOs, so it's not equivalent JZ4760_AIC_CTRL_TFLUSH. I don't
>> think it's a good idea to confuse the two, or we'd need comments to
>> explain why JZ4740 uses TFLUSH but not RFLUSH.
>
> "shared_fifo_flush" is pretty much self-explanatory though. It then becom=
es
> obvious looking at the code that when this flag is set, TFLUSH flushes bo=
th
> FIFOs.
>
> If you prefer... you can #define JZ_AIC_CTRL_FLUSH JZ_AIC_CTRL_TFLUSH. I =
don't
> like the JZ4760 prefix, this is in no way specific to the JZ4760.
>

Makes sense, I'll stick with TFLUSH / RFLUSH only.

>>
>>>>  +
>>>>   #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
>>>>   #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
>>>>  @@ -90,6 +93,8 @@ enum jz47xx_i2s_version {
>>>>   struct i2s_soc_info {
>>>>   	enum jz47xx_i2s_version version;
>>>>   	struct snd_soc_dai_driver *dai;
>>>>  +
>>>>  +	bool shared_fifo_flush;
>>>>   };
>>>>   struct jz4740_i2s {
>>>>  @@ -124,12 +129,33 @@ static int jz4740_i2s_startup(struct
>>>> snd_pcm_substream
>>>>  *substream,
>>>>   	uint32_t conf, ctrl;
>>>>   	int ret;
>>>>  +	/*
>>>>  +	 * When we can flush FIFOs independently, only flush the
>>>>  +	 * FIFO that is starting up.
>>>>  +	 */
>>>>  +	if (!i2s->soc_info->shared_fifo_flush) {
>>>>  +		ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>>>>  +
>>>>  +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>>>>  +			ctrl |=3D JZ4760_AIC_CTRL_TFLUSH;
>>>>  +		else
>>>>  +			ctrl |=3D JZ4760_AIC_CTRL_RFLUSH;
>>>>  +
>>>>  +		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>>>>  +	}
>>>  Wouldn't it be simpler to do one single if/else? And hy is one checked
>>> before
>>>  the (snd_soc_dai_active(dai)) check, and the other is checked after?
>> snd_soc_dai_active() is essentially checking if there's an active
>> substream. Eg. if no streams are open and you start playback, then
>> the DAI will be inactive. If you then start capture while playback is
>> running, the DAI is already active.
>> With a shared flush bit we can only flush if there are no other active
>> substreams (because we don't want to disturb the active stream by
>> flushing the FIFO) so it goes after the snd_soc_dai_active() check.
>> When the FIFOs can be separately flushed, flushing can be done before
>> the check because it won't disturb any active substream.
>
> Ok. It makes sense then. Please add some info about this in the commit me=
ssage,
> because it really wasn't obvious to me.

It wasn't that obvious to me either :)

I've added code comments too since it seems likely to trip people up
if you're only taking a casual glance.

> You should maybe factorize the read-modify-write into its own function. I=
 know
> this gets eventually modified by [03/11], but this [01/11] is a bugfix so=
 it
> will be applied to older kernels, and I'd rather not have duplicated code
> there.
>
> Cheers,
> -Paul

And I've factored out the r-m-w helper as requested.

Regards,
Aidan
