Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DD6EE534
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjDYQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjDYQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:02:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EC0CC1F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:02:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f3df30043so942850966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1682438551; x=1685030551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U1FebJ48rmYLrZgvW/d5KNeRthnVpxmVYJl0x+IboA=;
        b=SZpt8wqa8NJlghs5ohxeUYKrUK3e5qaBbISMNAUU7pnC3iaMHqd7nqyEcNT+BDOyBt
         1geT8uih1tSgnaWI28XbTpctzi18GqGLhVVqfrw751+OPckIolkRoZAgSZS96kR7DD9h
         JPqfzqBviknKwU3i8KOHJ0aGr66a5uH4g29EcqI/t9sklKcLTsJrwZkpcjd0D3OfIy+N
         4wwhDd6diQsPzabc1fAOf4hJnMh9qPSva95M5IhHyXlOEyfUNXZv6ZXr09smgdmzEzVk
         9sDyiECHmJyBnTMRmU9JiyvPcuThz6RVaDNvTJEFK3H5woJQDUKIjv5f9veNBLGMPkQT
         zuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682438551; x=1685030551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5U1FebJ48rmYLrZgvW/d5KNeRthnVpxmVYJl0x+IboA=;
        b=IEb7K2M74icazlNyGVaVfzSCYZQTj3+kp8N6lxF5/4JJ3xHlfseDtO3zkPPhBrcF30
         4gcHtdahWd17zuSFqUYERSYmkeN2SDIG+UsOnseiJqjm8TehG7UgnKqx13FOozDz5tQu
         oLUDy18sgKolP1JxkFIfctPeqLOKgXg5Df0uHKHlFPmf8xBTuRx58zb7du/3mKgcSZ1s
         ZgN7BeDMVgny40TrE8NKm6qnSehN8T2CxcCIkWAkO8JcgGF3pHnsgz5t4iWOckaVlOjD
         AhGueoZNBEBzwcFawGA2fs7kZaR+JMY1q0bLrI83MV1S9RpNuU6leoW7yqRSx3WI8qR3
         vIMA==
X-Gm-Message-State: AAQBX9egNAWHJUAAGgGyWeFhGfT5r3KnHTulBza8GcBkX+tc0Bqw897v
        /i29Dwntf2L1laWXTBNIARYIHNkdQXibEpEtvsJKkw==
X-Google-Smtp-Source: AKy350ZyQQXlExOYMD/D3YT7w+OnXYHx8fNk7AhdjTIc0H2Av/6728FCr95KZnQpnj//tjszaXVJ90/Hm4NZ1m7PoVw=
X-Received: by 2002:a17:906:6009:b0:94d:69e0:6098 with SMTP id
 o9-20020a170906600900b0094d69e06098mr15526256ejj.45.1682438551364; Tue, 25
 Apr 2023 09:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230414140203.707729-1-pan@semihalf.com> <20230414140203.707729-6-pan@semihalf.com>
 <cb35f3f2-4dc9-4d56-96bd-bcffb33b7aaf@sirena.org.uk>
In-Reply-To: <cb35f3f2-4dc9-4d56-96bd-bcffb33b7aaf@sirena.org.uk>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Tue, 25 Apr 2023 18:02:20 +0200
Message-ID: <CAF9_jYSMieE=GP3T-gsXe+SDjuWKGVy9LjhMHKB9_hW7czuZmg@mail.gmail.com>
Subject: Re: [PATCH 5/9] ASoC: ssm2602: Add workaround for playback with
 external MCLK
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 7:35=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Apr 14, 2023 at 04:01:59PM +0200, Pawe=C5=82 Anikiel wrote:
>
> > Apply a workaround for what seems to be a hardware quirk: when using
> > an external MCLK signal, powering on Output and DAC for the first time
> > produces output distortions unless they're powered together with whole
> > chip power.
>
> This doesn't seem coherent, these are multiple register writes so
> clearly can't be done at the same moment as initial power on.  Clearly
> there's some other constraint here.

The "at the same time" part is done by writing multiple bits at once
to SSM2602_PWR. But before that, SSM2602_ACTIVE has to be set, and
then the chip is reset (SSM2602_RESET) to power everything down again.

>
> > The workaround powers them on in probe for the first time, as doing it
> > later may be impossible (e.g. when starting playback while recording,
> > whole chip power will already be on).
>
> It doesn't do that, it powers them on at component probe.

Yes, I meant component probe.

>
> > Here are some sequences run at the very start before a sw reset (and
> > later using one of the NOT OK sequences from above):
> >
> >   ssmset 0x09 0x01 # core
> >   ssmset 0x06 0x07 # chip, out, dac
> >   OK
>
> I can't tell what any of this is trying to say, especially given all the
> magic numbers, and obviously no actual use of the driver should be
> writing directly to the register map.

These are shell commands run from userspace (with no ssm2602 driver
present in the kernel). ssmset is a wrapper for the i2cset command:
ssmset() {
        i2cset -y 0 0x1a $(($1*2)) $2
}
I definitely should have made that more clear.

Do you think these logs are worth adding? If so, I'll improve the
explanation what these mean.

>
> > +     /* Workaround for what seems to be a hardware quirk: when using a=
n
> > +      * external MCLK signal, powering on Output and DAC for the first
> > +      * time produces output distortions unless they're powered togeth=
er
> > +      * with whole chip power. We power them here for the first time,
> > +      * as doing it later may be impossible (e.g. when starting playba=
ck
> > +      * while recording, whole chip power will already be on)
> > +      */
> > +     regmap_write(ssm2602->regmap, SSM2602_ACTIVE, 0x01);
> > +     regmap_write(ssm2602->regmap, SSM2602_PWR,    0x07);
> > +     regmap_write(ssm2602->regmap, SSM2602_RESET,  0x00);
> > +
>
> The rest of the driver uses symbolic names for register values, this
> code should too.

Ok, I'll correct that.

>
> This also seems buggy in that it writes non-default values to the
> hardware then does a reset, meaning that the cache and hardware values
> will be out of sync, and since it only happens on probe there will be an
> issue after suspend if power is removed.  It looks like this would be
> most comfortably implemented as a register patch applied as soon as the
> regmap is instantiated.  See regmap_register_patch().

I haven't considered that. I will look at regmap_register_patch() and
try to use it.

Regards,
Pawe=C5=82
