Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1D637A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKXNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKXNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:54:28 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F92E0DC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:54:27 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id j196so1901846ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d19VZe73RsPQWbRMrRH216S4FHkhXapc6P3i52jmtAc=;
        b=iHQdDPV0ac4BN0lr3UIcdo0l9o8IvC/T2aKWTM3N//are1c4pniWRMI9Wq7uw6zp35
         irIz6Dzc+GGvWaUfq63UjjORdGQMOPbPvKsIBzQXhokJiz7rA9TLFYovwQh2ZvYN6cFz
         7wYilt3BDqwAQn0wfaBdOGxLeI1vYWC/g8awjJgO1jaHNVtaZ9iiUNL8GHloaCxl7EMO
         zAu9uDM0LZfTkBSoKPOiI+tzfrH77UwF0n8b2JYeupK3X/ULL7TkvPtylxXSuaj8Zq5S
         bLlFJaQoXVctBwxN5UcG1t/Pnjtyj5GUv7fj8Z11a2xiM1qhukgu2smV3qeOQEWbw5QS
         ltLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d19VZe73RsPQWbRMrRH216S4FHkhXapc6P3i52jmtAc=;
        b=4ROpMzs/hzmYNpYS5m8rMl3HN4beGaR/1rQLE4A1/DmLPHb1CrhYRfBDyfH3YX/QUm
         lc4fCXvQICEnYBJtWFbFhhNbZLWjc3Fx3tDkIJsMFgfbnRsaH6RDVNpz/4JtP1RMwcfe
         wXlE4i/guOcgpkX69HC/5GTZOIgf3qpn7pQPXhCcLf//jd1T4lXd8EOH5h231e6i8kfu
         HbqpI9lDGLE2sALKqyEBYxT4aYzC3BEQcYvq5mbGQMhhzJUuG2dNwqcpXX8s4utiBkJx
         FMcIQZWdn6iCk3pu8wg8CXqP1HBxFjJVaNIeBugcl1SfR8L+znyGHmr2FCmWE94QvWBZ
         1Btg==
X-Gm-Message-State: ANoB5pnToMGEGdSqhO17/iVSj0jxJqIThp0YLtV1tlvoq2FJMRRDfU5I
        0bIfhVmg29rjmCrGoq00dTjGTm3e2vEQkz58C5k=
X-Google-Smtp-Source: AA0mqf5IrmZnahNNIPS3/hpEG3PMIsp17Y7diXsqE373VqHNhMRguSHtQK56lGixA59/Fp9Gj76W5OPPLgNBPQ+WnpI=
X-Received: by 2002:a05:6902:192:b0:6ef:3e1d:9054 with SMTP id
 t18-20020a056902019200b006ef3e1d9054mr9549191ybh.48.1669298066226; Thu, 24
 Nov 2022 05:54:26 -0800 (PST)
MIME-Version: 1.0
References: <CABDcavYdsk-O4x3oPX4i4+T5wsoZV26_kpEq6JvpD8A_cAGHxg@mail.gmail.com>
 <20221124111336.GE105268@ediswmail.ad.cirrus.com>
In-Reply-To: <20221124111336.GE105268@ediswmail.ad.cirrus.com>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Thu, 24 Nov 2022 14:54:15 +0100
Message-ID: <CABDcavbRryENG58LO7+gbJeKbBBPP1uG1Xc00yXUBNzspWpWoA@mail.gmail.com>
Subject: Re: SOC_DOUBLE_R_SX_TLV controls broken in cs24l51 driver
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Tan_Nay=C4=B1r?= <tannayir@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 24 nov 2022 a las 12:13, Charles Keepax
(<ckeepax@opensource.cirrus.com>) escribi=C3=B3:
>
> On Thu, Nov 24, 2022 at 10:57:34AM +0100, Guillermo Rodriguez Garcia wrot=
e:
> > Hi all,
> >
> > I am using a dev board with a Cirrus Logic cs24l51 codec.
> >
> > This used to work fine prior to kernel version 5.x, however after 5.x
> > it is not possible to set certain values for ALSA controls from
> > userspace.
> >
> > I believe this is related to the input validation that is mentioned in
> > this thread: https://lore.kernel.org/all/Yph8C3bRxcr6ogW7@sirena.org.uk=
/T/,
> > and possibly in this commit: 4f1e50d6a9cf9c1b8c859d449b5031cacfa8404e
> > ("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()")
> >
> > For the cs24l51, all the controls that fail are using the
> > SOC_DOUBLE_R_SX_TLV macro.
> >
> > I have traced this to the checks in snd_soc_put_volsw_sx, specifically
> > the (val > max - min) check:
> >
>
> Can you try these two patches:
>
> https://lore.kernel.org/all/165236477046.1016627.15470197691244479154.b4-=
ty@kernel.org/

Thanks.
In my tests, these patches seem to fix the problem for some values,
but not for all of them:

$ amixer cset name=3D'Analog Playback Volume' '208','208'
numid=3D3,iface=3DMIXER,name=3D'Analog Playback Volume'
  ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D228,step=3D0
  : values=3D208,208
  | dBscale-min=3D-102.00dB,step=3D0.50dB,mute=3D0

$ amixer cset name=3D'Analog Playback Volume' '180','180'
amixer: Control default element write error: Invalid argument

Looking at the code I'd say that patch 1/2 is correct however I have
doubts about patch 2/2:

        val_mask =3D mask << rshift;
        val2 =3D (ucontrol->value.integer.value[1] + min) & mask;
+
+       if (mc->platform_max && val2 > mc->platform_max)
+           return -EINVAL;
+       if (val2 > max)
+           return -EINVAL;
+
        val2 =3D val2 << rshift;

        err =3D snd_soc_component_update_bits(component, reg2, val_mask,

The checks for max and platform_max are done on val2, but val2 is
already the result of adding the minimum value ('min') and applying
the mask.
Shouldn't the checks be done on ucontrol->value.integer.value[1] instead?

Thanks,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
