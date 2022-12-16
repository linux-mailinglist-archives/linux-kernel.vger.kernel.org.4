Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0D64EFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiLPQzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiLPQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:55:40 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F08FF2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:55:38 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-40b40ff39f1so40818257b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSh2mHS3a/WVKWmgpBdkSxEC5BZvHlzqieLbmOlJd+Y=;
        b=jPIEGmH8jpNZDIgiwhpHedHCuvgD/xiLEsQj7JjOYWxHvRcT5bFDWmAZGlGulCZ7Yf
         yLX5VhQl1TxisuUXdhJZJUywsPwDnFgfRErlWrg4RoZZg4oDqiWRF6n1UhrrTKefItXX
         FNz52MXjhlFczjR7lctHlYMMXFczCLhXmg0tA+h061lH31MHeoBZV8HxM5WIb4IhdIAz
         qhV7PuTAkHyUFHaD/qXJB0AHZi/v02lNtUnZ/j1+u6JdU9tmkLdfFpXagOv8DVrpj39s
         e0XkIx0NlryEqokhmpl0cZMxa/lKL/HU/63HHE9YpsizvCQmWoMOkEjZlOK/HPweMFu2
         m5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSh2mHS3a/WVKWmgpBdkSxEC5BZvHlzqieLbmOlJd+Y=;
        b=SCQYmWeKnLSJDR5K+xPlmDyb6c5F6klLMzL02O+cAmc2qBTYBN41LdGQ8A0xhc+FHp
         rT+HZHptbNtq2DDCm4RyqnFW7KZtu2QKQFjsi9xuSmCHb84zIFAL3u30CCznWzk0EB3+
         8/CWL2XNmrFAhKX2I0kGl6YeC9ukwB8Ia5BiAE9RonqXwB0G4d+MlBndoP4je7LD+iKz
         vHNgWY7xuxp1wjNSZ7TYsZzVPOGSotq5ZZVGdjLMWzt5HT1R1jNqr2fk+7g/Hvw4aydF
         4viJqCcu3Ggr28ZL1g/A6NLYgC6SDzQCN5qg/YDOteIUlF3Zj4AfhU3DlIheMEtwLpPX
         wEaA==
X-Gm-Message-State: ANoB5pmrcSa7fYc4p6wxqQ5pZINxVw0hGdr35X348B3pu+raENsOFMd6
        gw2KEKRIH3nYbBXDg/CXrJ/r85Jsy2b+fM2gAkEMVQ==
X-Google-Smtp-Source: AA0mqf4p4beqjNrpgW68N/JzW8JqSmKkOyTxSo9B+R/HRFFITRAUI6xDN7EmgwOD/ufKLHLpGNkd2mS0tcHcTGmjuX0=
X-Received: by 2002:a81:9945:0:b0:370:4fa5:7077 with SMTP id
 q66-20020a819945000000b003704fa57077mr11009315ywg.360.1671209737775; Fri, 16
 Dec 2022 08:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com> <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com>
In-Reply-To: <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 17 Dec 2022 00:55:26 +0800
Message-ID: <CALprXBYy9_ax8-xfh0paB59Pn=TB7yVLwtY8vnT_-y5vWd867w@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre

On Sat, Dec 17, 2022 at 12:03 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:

> On 12/16/22 09:49, Ajye Huang wrote:
> > This patch adds the driver data for two nau8318 speaker amplifiers on
> > SSP1 and nau8825 on SSP0 for ADL platform.
>
> So here you are making reference to two amplifiers...
>
> > +static struct snd_soc_dai_link_component nau8318_components[] = {
> > +     {
> > +             .name = "NVTN2012:00",
> > +             .dai_name = "nau8315-hifi",
> > +     }
> > +};
>
> but here there's only one? I was expecting something like what we've
> used for Maxim amplifiers with a codec configuration and dailink
> components that list the two amplifiers.
>
> static struct snd_soc_codec_conf max_98373_codec_conf[] = {
>         {
>                 .dlc = COMP_CODEC_CONF(MAX_98373_DEV0_NAME),
>                 .name_prefix = "Right",
>         },
>         {
>                 .dlc = COMP_CODEC_CONF(MAX_98373_DEV1_NAME),
>                 .name_prefix = "Left",
>         },
> };
>
> struct snd_soc_dai_link_component max_98373_components[] = {
>         {  /* For Right */
>                 .name = MAX_98373_DEV0_NAME,
>                 .dai_name = MAX_98373_CODEC_DAI,
>         },
>         {  /* For Left */
>                 .name = MAX_98373_DEV1_NAME,
>                 .dai_name = MAX_98373_CODEC_DAI,
>         },
> };
>
> Or is this a commit message problem and there's really only one amplifier?

Really , it has two speakers.  The nau8318 is an auto mode Amplifier
chip, similar to the max98360a amp chip.
EX: Sof_maxim_common.c (sound\soc\intel\boards):
static struct snd_soc_dai_link_component max_98360a_components[] = {
    {
        .name = MAX_98360A_DEV0_NAME,
        .dai_name = MAX_98357A_CODEC_DAI,
    }
};
It is not an i2c interface,  from the nau8318 data sheet, there are
five pins used mainly. one for enable, others for I2S.
EN-- enable pin
FSR-- Frame Sync, Right
FSL--  Frame Sync, Left
BCLK--  bit clock
DACIN-- Input i2s data

The FSR and FSL pins are for Left and Right channels used.
thanks
