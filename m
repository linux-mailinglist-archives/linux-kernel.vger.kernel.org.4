Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132D16093B8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJWNpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJWNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:45:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8537197;
        Sun, 23 Oct 2022 06:45:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l32so5064177wms.2;
        Sun, 23 Oct 2022 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epP8M80VvnoS5tqdYkmq04F3KD2QIPCUAZQOWP+SmjE=;
        b=VBDSQpQLjZs994aSc4OML2O5M3KZ0cv7EnUxlVaeGtbYSwLvKfpi2Ov0S6NMlJhjT0
         USOb2kVIPyTjPHo+oCqg2wIZiV5wFrTDW+6dwQFX2KgpA/q8cu5ItbuB8iGOtAGo6/Ye
         6th06X6Y96NLW3qb1bCCioyE1QHS/jzzuyA1YWF9zn+HFtlWU13ZgyG85JGwmZVcqaU3
         z4bXdym2gMMSIhoJ1Mwmd+S4NK2r3hqjAPc9vnLfVIazjEgYOawjGO1uCBSQdhyXF2Oa
         qwmEjRN3y1C7h5Spo6tlb1UW5IlpX/P9BKBASiDbyIBDoqxzmSMEf80DuT25m1uvSLCQ
         ixZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=epP8M80VvnoS5tqdYkmq04F3KD2QIPCUAZQOWP+SmjE=;
        b=T+VyqlaUn8dCCZBWRA+mvHp2g6LpW1EAXIWy8+2qyX7iXB4OQtoOn6cCl2pqT6lhRT
         osmlvSaNn7T7s8EuTVdArKko4o1qArjHr/S2VMtIrxfyzpscBybry3tkyYcNiXHL8AG6
         jMvVVOnmsoPhd0fr+xQbIAPjQcFm/thtZMe6Xg5tQ6Wd9iiLI1CZU3EkeuaGxXpIFQoX
         uUWv100GumOCsu/mf1GlhmOyF505rLg9oAbv1o1CmREqmBtZ6x4jv0wDIiyW/QpbXuEG
         A0P0Huox6rl/3c/TuGs5zJa/A7ANtxiy5LxpgS44u1DegNDZm8pY783ilgUjBZ2HVEiD
         tLRw==
X-Gm-Message-State: ACrzQf3X52+xXwigEcxlFxkZ3JefXY67e0hTlay/OIdxh5sb7mBdYZb8
        FxvpBnPebW4EcWdL+Cd8fcY=
X-Google-Smtp-Source: AMsMyM7ew5rY2o5sFyAigiQLrwo0WFIN3A74MyBDnVGZenApR6lfBR7HI+lQT1jI0KwXoJoCofQupg==
X-Received: by 2002:a05:600c:1e89:b0:3c7:1e:acc2 with SMTP id be9-20020a05600c1e8900b003c7001eacc2mr18329812wmb.44.1666532715862;
        Sun, 23 Oct 2022 06:45:15 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0022afcc11f65sm23645695wru.47.2022.10.23.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:45:15 -0700 (PDT)
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
 <20221022191308.82348-2-aidanmacdonald.0x0@gmail.com>
 <P076KR.VI33CVGCD2OG3@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/9] ASoC: jz4740-i2s: Handle independent FIFO flush
 bits
In-reply-to: <P076KR.VI33CVGCD2OG3@crapouillou.net>
Date:   Sun, 23 Oct 2022 14:45:15 +0100
Message-ID: <C8ST2VJT1fllse8qckGmOAh4wCjnjIkE@localhost>
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
> Le sam. 22 oct. 2022 =C3=A0 20:13:00 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> On the JZ4740, there is a single bit that flushes (empties) both
>> the transmit and receive FIFO. Later SoCs have independent flush
>> bits for each FIFO.
>> Independent FIFOs can be flushed before the snd_soc_dai_active()
>> check because it won't disturb other active streams. This ensures
>> that the FIFO we're about to use is always flushed before starting
>> up. With shared FIFOs we can't do that because if another substream
>> is active, flushing its FIFO would cause underrun errors.
>> This also fixes a bug: since we were only setting the JZ4740's
>> flush bit, which corresponds to the TX FIFO flush bit on other
>> SoCs, other SoCs were not having their RX FIFO flushed at all.
>> Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>
> If you have a Fixes: tag you need to Cc linux-stable as well.
> See "option 1" of
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Then I'll resend with Cc: stable.

> Also, a cover letter with a description of the changes is good, but you s=
hould
> still add a changelog per patch (below the --- line so that it doesn't en=
d up
> in the commit message). That makes it much easier to review.

Thank you, I'll keep that in mind next time.

> With the Cc line added:
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>
> Cheers,
> -Paul
>
>> ---
>>  sound/soc/jz4740/jz4740-i2s.c | 39 ++++++++++++++++++++++++++++++-----
>>  1 file changed, 34 insertions(+), 5 deletions(-)
>> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s=
.c
>> index c4c1e89b47c1..83cb81999c6f 100644
>> --- a/sound/soc/jz4740/jz4740-i2s.c
>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>> @@ -55,7 +55,8 @@
>>  #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
>>  #define JZ_AIC_CTRL_SWITCH_ENDIANNESS BIT(10)
>>  #define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED BIT(9)
>> -#define JZ_AIC_CTRL_FLUSH		BIT(8)
>> +#define JZ_AIC_CTRL_TFLUSH		BIT(8)
>> +#define JZ_AIC_CTRL_RFLUSH		BIT(7)
>>  #define JZ_AIC_CTRL_ENABLE_ROR_INT BIT(6)
>>  #define JZ_AIC_CTRL_ENABLE_TUR_INT BIT(5)
>>  #define JZ_AIC_CTRL_ENABLE_RFS_INT BIT(4)
>> @@ -90,6 +91,8 @@ enum jz47xx_i2s_version {
>>  struct i2s_soc_info {
>>  	enum jz47xx_i2s_version version;
>>  	struct snd_soc_dai_driver *dai;
>> +
>> +	bool shared_fifo_flush;
>>  };
>>  struct jz4740_i2s {
>> @@ -116,19 +119,44 @@ static inline void jz4740_i2s_write(const struct
>> jz4740_i2s *i2s,
>>  	writel(value, i2s->base + reg);
>>  }
>> +static inline void jz4740_i2s_set_bits(const struct jz4740_i2s *i2s,
>> +	unsigned int reg, uint32_t bits)
>> +{
>> +	uint32_t value =3D jz4740_i2s_read(i2s, reg);
>> +	value |=3D bits;
>> +	jz4740_i2s_write(i2s, reg, value);
>> +}
>> +
>>  static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
>>  	struct snd_soc_dai *dai)
>>  {
>>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
>> -	uint32_t conf, ctrl;
>> +	uint32_t conf;
>>  	int ret;
>> +	/*
>> +	 * When we can flush FIFOs independently, only flush the FIFO
>> +	 * that is starting up. We can do this when the DAI is active
>> +	 * because it does not disturb other active substreams.
>> +	 */
>> +	if (!i2s->soc_info->shared_fifo_flush) {
>> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>> +			jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
>> +		else
>> +			jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_RFLUSH);
>> +	}
>> +
>>  	if (snd_soc_dai_active(dai))
>>  		return 0;
>> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>> -	ctrl |=3D JZ_AIC_CTRL_FLUSH;
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>> +	/*
>> +	 * When there is a shared flush bit for both FIFOs, the TFLUSH
>> +	 * bit flushes both FIFOs. Flushing while the DAI is active would
>> +	 * cause FIFO underruns in other active substreams so we have to
>> +	 * guard this behind the snd_soc_dai_active() check.
>> +	 */
>> +	if (i2s->soc_info->shared_fifo_flush)
>> +		jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
>>  	ret =3D clk_prepare_enable(i2s->clk_i2s);
>>  	if (ret)
>> @@ -443,6 +471,7 @@ static struct snd_soc_dai_driver jz4740_i2s_dai =3D {
>>  static const struct i2s_soc_info jz4740_i2s_soc_info =3D {
>>  	.version =3D JZ_I2S_JZ4740,
>>  	.dai =3D &jz4740_i2s_dai,
>> +	.shared_fifo_flush =3D true,
>>  };
>>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
>> --
>> 2.38.1
>>
