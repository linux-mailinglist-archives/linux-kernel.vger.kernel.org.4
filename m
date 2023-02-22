Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307169EFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjBVH4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjBVH4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:56:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774DD36FF2;
        Tue, 21 Feb 2023 23:56:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s26so26789248edw.11;
        Tue, 21 Feb 2023 23:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgFg4u82TvD5fQ/qkOIk8bqnfcsUdnb5ri794YsSIUk=;
        b=We04ug736s7NZz1w+LsI1A/zzq9lsygNQuEg8sDER1ENddmP57YgH0DhF73Y+JWZxv
         /tQkKOc1NJciSK2RTuI9V9ykmKhcLNUXLPp/odXiLkvoEmpFg1DYZ6WAbYX1lMB+Vf0J
         HcdpcRJElLHrax2orAiwALCfMsmsxddxsg5PxDti9agbKf9O3aUf+DX3mnCPOx2VQdwU
         rrC7HM5M6bmAn942zaRhuBMnqlQfiDp1aEDZDCT2xhX3XyxQwrWeoVwvSeeVGPaFnIEx
         trrHweLwcgvBvDHgxmGZBfzpruBbrGfw59+rgvrHdp6HzT4NvbsiB7MDDLsQZdulvBF5
         gAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgFg4u82TvD5fQ/qkOIk8bqnfcsUdnb5ri794YsSIUk=;
        b=7oIPLip7ZcX/4QkDw68r9j3XQIdi16zzvSOfZakZTAjDWG4lX6V15ZeYEARtYTlEzD
         9PLIckzJiyBOT4K7gKYK8gBrhTxM1Cht9c4Ozyy2NtS/im3GKdjc4uamonPxDmyO0APi
         KgiW7G6hCaWxi+QrLUjBs+j4fd22AUmZp4LjHymjWO1YLw0YP/CfNBzw7ZIGPfQd2s1D
         gGsqHETwZxtcfm4nJY+CzLkHaLOPynCvEn5P2FIdeS84xrsWpW1wJQds4/dQwwMDO8v0
         oUUxyfLB553kQ+uWFrGcS/vLUUQZpgQgNxSimBpEH9Wb+DN3mmWlV9/Q6T8Z4F3zCxC7
         C+5Q==
X-Gm-Message-State: AO0yUKVX2OgblWmiw4jdMKuiIEAvXrKh1Axov0AAzMQ8gD1ZNBtSyEvN
        OGJoh2cOMqK1XLPhhpqUWu4XQc0AXnf5nfeVN38=
X-Google-Smtp-Source: AK7set86EqLJbVtLPn+eFpQhyilCpoGiEYS+jNbNtWWgWpm5ic8N1YNya+4HDkYqa1aZTpjG14F9tumdchiAIzrcXZo=
X-Received: by 2002:a50:9f08:0:b0:4ab:4b85:a6a8 with SMTP id
 b8-20020a509f08000000b004ab4b85a6a8mr3408901edf.4.1677052563525; Tue, 21 Feb
 2023 23:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20230221183211.21964-1-clamor95@gmail.com> <20230221183211.21964-5-clamor95@gmail.com>
 <Y/UcXNueAmrrhWG0@kadam>
In-Reply-To: <Y/UcXNueAmrrhWG0@kadam>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 22 Feb 2023 09:55:52 +0200
Message-ID: <CAPVz0n01YWQ6FY9RDsa1rw_36n=NKpRLokFiVTxLsMDpQEd4YA@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] ASoC: tegra: Support RT5631 by machine driver
To:     Dan Carpenter <error27@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

=D0=B2=D1=82, 21 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 21:32 Dan Carpente=
r <error27@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 21, 2023 at 08:32:05PM +0200, Svyatoslav Ryhel wrote:
> > diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/teg=
ra_asoc_machine.c
> > index 78faa8bcae27..607800ec07a6 100644
> > --- a/sound/soc/tegra/tegra_asoc_machine.c
> > +++ b/sound/soc/tegra/tegra_asoc_machine.c
> > @@ -51,6 +51,17 @@ static struct snd_soc_jack_gpio tegra_machine_headse=
t_jack_gpio =3D {
> >  };
> >
> >  /* Mic Jack */
>
> This comment doesn't make sense now.  It was never super useful, though.
> Just delete it.

It does. Headset is Mic Jack + Headphones combined. headset_check function
performs check for a Mic Jack component in plugged Jack 3.5

> > +static int headset_check(void *data)
> > +{
> > +     struct tegra_machine *machine =3D (struct tegra_machine *)data;
> > +
> > +     /* Detect mic insertion only if 3.5 jack is in */
> > +     if (gpiod_get_value_cansleep(machine->gpiod_hp_det) &&
> > +         gpiod_get_value_cansleep(machine->gpiod_mic_det))
> > +             return SND_JACK_MICROPHONE;
> > +
> > +     return 0;
> > +}
> >
> >  static struct snd_soc_jack tegra_machine_mic_jack;
> >
> > @@ -183,8 +194,15 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_run=
time *rtd)
>
> regards,
> dan carpenter
