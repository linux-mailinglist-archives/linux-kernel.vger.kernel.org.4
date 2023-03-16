Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F166BC666
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCPG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCPG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:59:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A22CFD2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:59:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so3561587edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678949947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgDKGokQR+4JPSgN0QqCTweCwRsx4eTE4MHO9hOb9T0=;
        b=WKjcew4l/h348OTCKt6zEsmhdyILWxegry52zwbTUXK5+ORd93qwQJYlaWWBcYu0nF
         H+xPjC1V3S64zgWDnfPWvxaQUA8pXwZz+Ugu253yLvKXWbw6zcXBbFEKpm8oUlkfJcez
         qO1wVd5iPhyw9I3FrEfhFr9jrgG9vrjK8D3NjCMrvjjN57ok0Kuj39CzaPVXwR5XhcXF
         WEz+DRS4WZ5XA4QfGTsI9ctDUPRhbcO+a8ec25xVp6BeQq0xVzUVJzZG3W5qa2QFFmVM
         x6c72mP0BIuyVDCpOjzZdfdXk+G56D1J59tSFObLmfchCM/GU11Clr7QGYm3dRRX0c4M
         agXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678949947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgDKGokQR+4JPSgN0QqCTweCwRsx4eTE4MHO9hOb9T0=;
        b=ZGT8cQIgscXklhxDz1sxfdNqcsw5QUPOC9ZqCrKvM7W15hekLwhPPqO89slEDQn1v5
         j/VoA5KUrluHoDYF73BBBasLP22Gf1chNBFnU7oPXXiD8poOk4mClOnOSVFL3dBTnj1D
         VLOtknY2Qx0UkIk9lKmowJlSStLFBR/DFYRCGRdYaI1Py09dqE6RmOfC5naM5i02owVR
         eD2tSwxXPikMyqWj7+LkJEs5zd+M3W3YDzw/io5FNbUTJYcXOuCZXGljv8PNXq4m8FvS
         natPMadZ9Rml2/mwvd6Urrkg0K2errmd/YUFaZ+t/lNcwTtMsmEFG8YPTxHd8tVR3nUg
         1qlA==
X-Gm-Message-State: AO0yUKV5efNek85nVCy3QBvy3jXWZeqx3QJLz5KjbOyZo9DnD2OKagZt
        6Wm7LNp42Z0Epq4mf5POGvMA2Yg4/0I09K2jUoLxCW+26mk=
X-Google-Smtp-Source: AK7set/hRGu/gvEAQOZy55e95HFYusYBm+MYWsGO+1P/oimOY18G0R+Vs517oYPB5xrG+vDfgyyAyuLM0FDlExZIfig=
X-Received: by 2002:a17:906:1dcc:b0:8b2:23fb:dfd8 with SMTP id
 v12-20020a1709061dcc00b008b223fbdfd8mr4667764ejh.12.1678949947098; Wed, 15
 Mar 2023 23:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230314153409.1805280-1-daniel.baluta@oss.nxp.com>
 <6d9d09aa-d83e-e811-1d43-34780ea05d4d@linux.intel.com> <CAEnQRZAj-FW-fCWsyupUDAH4Z2kTf0RL1acivyDHszMuU-75pg@mail.gmail.com>
 <5e26ef3e-1319-25cd-f7d5-245eaea66769@linux.intel.com>
In-Reply-To: <5e26ef3e-1319-25cd-f7d5-245eaea66769@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 16 Mar 2023 08:58:55 +0200
Message-ID: <CAEnQRZCtmXdFqrsUEaDMG49=ZreFE2oBowjP1M4pywrQP4PA2A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-compress: Inherit atomicity from DAI link for
 Compress FE
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com
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

On Tue, Mar 14, 2023 at 6:52=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 3/14/23 11:37, Daniel Baluta wrote:
> > On Tue, Mar 14, 2023 at 6:14=E2=80=AFPM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 3/14/23 10:34, Daniel Baluta wrote:
> >>> From: Daniel Baluta <daniel.baluta@nxp.com>
> >>>
> >>> After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
> >>> that of the FE") BE and FE atomicity must match.
> >>>
> >>> In the case of Compress PCM there is a mismatch in atomicity between =
FE
> >>> and BE and we get errors like this:
> >>>
> >>> [   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but B=
E
> >>> is nonatomic, invalid configuration
> >>
> >> Not clear on the 'FE is atomic' in the case of a compressed stream,
> >> which has to be handled with some sort of IPC, i.e. be nonatomic.
> >>
> >
> > 'FE is atomic' in this message is printed because this is the default v=
alue
> > of nonatomic field when PCM struct associated for a Compress PCM
> > struct is allocated.
> >
> > No one changes 'nonatomic' field for Compress FE until my current patch=
.
> >
> >> Also not sure why the FE is not set as nonatomic by the SOF parts?
> >> If it's needed for PCM, why wouldn't it be needed for compressed data?
> >
> > FE is not touched for SOF parts. Only BE is set to nonatomic by SOF.
>
> Where do you see the BE being changed by SOF?
>
> >
> > See: sound/soc/topology.c
> >
> > =C2=BB       /* Set nonatomic property for FE dai links as their trigge=
r
> > action involves IPC's */
> > =C2=BB       if (!link->no_pcm) {
> > =C2=BB       =C2=BB       link->nonatomic =3D true;
> > =C2=BB       =C2=BB       return 0;
> > =C2=BB       }
>
> that's a FE property, not BE.

You are right.

>
> > FE for PCM is modified by sound/soc/soc-pcm.c
> >
> > int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> > =C2=BB       pcm->nonatomic =3D rtd->dai_link->nonatomic;
> >
> > So, I guess people assumed that is enough to use RTD dai link to set
> > pcm->noatomic field
> > and didn't look at it in SOF.
>
> Ah yes, now I see your point now. You still had a logical inversion
> above but you're correct here.
>
> > When FE for Compress PCM is created, we don't use soc_new_pcm but inste=
ad
> > we use snd_pcm_new_internal which doesn't inherit the nonatomic field
> > of the rtd->dai_link
> > as Normal PCM does inside soc_pcm_new.
> >
> > So, my patch makes sure we inherit the nonatomic field from
> > rtd->dai_link also for Compress PCM
> > similar with what already happens for Normal PCM.
> >
> > tl;dr: when creating a Normal PCM pcm->nonatomic is inherited from RTD
> > DAI link. when creating a
> > Compress PCM pcm->nonatomic field is not set. This patch makes sure
> > that for Compres PCM
> > we also inherit nonatomic from RTD DAI link.
>
> That makes sense. It's quite likely that the compress PCM should be
> nonatomic by default, not sure how it can work otherwise.

To sum up:

- we need to merge current patch  because Compress PCM needs to
inherit the atomicity from FE DAI

Because SOF FE DAI links are made to be nonatomic:

sound/soc/sof/topology.c
=C2=BB       /* Set nonatomic property for FE dai links as their trigger
action involves IPC's */
=C2=BB       if (!link->no_pcm) {
=C2=BB       =C2=BB       link->nonatomic =3D true;
=C2=BB       =C2=BB       return 0;
=C2=BB       }

and with my patch:

sound/soc/soc-compress.c

+               /* inherit atomicity from DAI link */
+               be_pcm->nonatomic =3D rtd->dai_link->nonatomic;
+
                rtd->pcm =3D be_pcm;

... then Compres PCM will be nonatomic.

Side note: I think be_pcm from the patch above should be called fe_pcm
instead. But that's a story for another patch.

thanks,
Daniel.
