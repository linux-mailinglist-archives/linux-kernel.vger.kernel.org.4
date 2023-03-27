Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0D6CA82E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjC0OtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjC0OtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:49:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C4E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:49:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so37293132edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679928550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVHxlnW6dANW4bLJRZbyNubcNIn9eicFT4GW59KFMWo=;
        b=ZUc8vRqWh6v/KqWmwKnujcqsPGQN3AW1a+uNsjsdxxanX7O7AMqYHKSAyA8x334HOH
         buEyjMByhK//Rdsdo8FjuDhiLgMiDmOc8AI4AlbC65I401Ijb5C5thKepIZZWihZbAU5
         aQbZX/lFNdpFzM3+aMJdnfHqAYgrAgyh145V8iWmJLj/0YUkx7Hq9ZU2UqQn7kIxWiKt
         WTXAQdfBCanT9GjmOFEpZ/MClBMDf6IeK7M15IN4LaVIhFsdNe93YqkRT67jsYYZ4I6q
         C6jInxjEdOj5O5d5pP0t0nhgmFN7O/kbge/JDT7slKDx0t2HD1nuUWRDJcICajEU98ON
         Gm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679928550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVHxlnW6dANW4bLJRZbyNubcNIn9eicFT4GW59KFMWo=;
        b=dRrX8CWrPAx1RUH95N2ZKxxzyxH1lATcIp/lWor8Gh8fBwPRZhNcXssejGtRqbd+nS
         lduNfpvmWskWI/Ln+GvLD1OjWwHqhfa48roT+EOXxWdJ3N7FL8NcLpuqJESeRNDRugzy
         bIqnp0qADt1WfBCYl+mMq+kloWzOQk40u9V2fWRRylBN+fXEA/ovzcIeUwCpeji4cE9i
         GVIEnx8H6405iEsJK2wkvgM15is6pNmN8M1swRIDW7mZknb8emO1+W4/HMcRlk8zeevE
         +qDLFOlapJkd7LaZNaMe5R11uQKxrIrXGIVrws2GzqGNUepIKIvLDg0Otj/mkwhuzwUA
         IQEg==
X-Gm-Message-State: AAQBX9e8B5AJiL52DR1eJdwyO5zUFJagGA1qvwckYF9OhLHDGeCGr5SQ
        4dO/lCrQbz7GB0ueEgWdVARvMQkiCqYNHIOrICkdAZA4
X-Google-Smtp-Source: AKy350bLAuhq1B5VAnk84Reany6FBtJSeXd0DNWssq5L/sg2ql7zOJLzmZgRzAgmBOidC0R3bHa0gzzxXlGQc4Lojys=
X-Received: by 2002:a17:907:80a:b0:8af:43c6:10c0 with SMTP id
 wv10-20020a170907080a00b008af43c610c0mr7494741ejb.1.1679928549993; Mon, 27
 Mar 2023 07:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230325083643.7575-1-clamor95@gmail.com> <20230325083643.7575-2-clamor95@gmail.com>
 <20230327083208.GQ68926@ediswmail.ad.cirrus.com> <CAPVz0n1AaTzdwmfkxaUX5peAiQ2K73aoqKfLUy1jwEE6__uG2w@mail.gmail.com>
 <20230327101429.GT68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230327101429.GT68926@ediswmail.ad.cirrus.com>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Mon, 27 Mar 2023 17:48:58 +0300
Message-ID: <CAPVz0n1fOB8W43B+jfFWB_8HfBzVtn7pm_NcD-GOocaqt1MN_A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ASoC: wm8903: implement DMIC support
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 27 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 13:14 Char=
les Keepax <ckeepax@opensource.cirrus.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Mar 27, 2023 at 11:37:05AM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 27 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 11:32 =
Charles Keepax <ckeepax@opensource.cirrus.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sat, Mar 25, 2023 at 10:36:43AM +0200, Svyatoslav Ryhel wrote:
> > > > Add DMIC input and routing.
> > > >
> > > > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF300T
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  sound/soc/codecs/wm8903.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> > > > index 41346e5ec5ad..9c2f0aadcff3 100644
> > > > --- a/sound/soc/codecs/wm8903.c
> > > > +++ b/sound/soc/codecs/wm8903.c
> > > > @@ -9,7 +9,6 @@
> > > >   *
> > > >   * TODO:
> > > >   *  - TDM mode configuration.
> > > > - *  - Digital microphone support.
> > > >   */
> > > >
> > > >  #include <linux/module.h>
> > > > @@ -816,6 +815,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
> > > >  SND_SOC_DAPM_INPUT("IN2R"),
> > > >  SND_SOC_DAPM_INPUT("IN3L"),
> > > >  SND_SOC_DAPM_INPUT("IN3R"),
> > > > +SND_SOC_DAPM_INPUT("DMIC"),
> > > >  SND_SOC_DAPM_INPUT("DMICDAT"),
> > >
> > > There is already a datapath for the DMIC here, DMICDAT. Are you
> > > sure you don't just need to set the "Left/Right ADC Input" muxes
> > > correctly through the ALSA controls?
> > >
> >
> > I will check once more, but so far I was not able to set the mic to
> > work with DMICDAT. Only with this patch.
> >
>
> The two should be basically equivalent when the controls are set
> right, your patch has:
>
> DMIC -> ADCL
>
> The current code has
>
> DMIC -> Left ADC Input -> ADCL
>
> The only difference is that Left ADC Input sets the ADC_DIG_MIC
> bit, but the datasheet clearly indicates that should be
> necessary for digital mics to work. Does your system definitely
> have DMICs? Without that bit set the decimator should still be
> connected to the analogue front end.
>

You are correct, this patch is not needed. It appears that the
issue was not in routing but in wm8903 gpio configuration.

DMICDAT works as intended.

> Thanks,
> Charles
