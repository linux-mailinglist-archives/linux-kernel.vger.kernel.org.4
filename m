Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EECB71456A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjE2HZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjE2HZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:25:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD247AF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:25:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fd3a658eeso426078166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685345139; x=1687937139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKRg7l5upkPsHIbZGSw6Q8T2a/KMJm+ptNrO6T1korM=;
        b=P/iSYFpQmgEljYGK2XHIQlE5MqGp/QLon7aRZTfpzPWXUEusqmS6BApSim4mj9x/D5
         /93UGSQD5xtqefIXombswSsHyQ0W8CSIXotboM6ZBjl4+yzw+1os8u05fsG5cfZCi3li
         1ygO3ysknEbwRLDUQLwIcar7XMX9nV3bWyD6TDPpwDyFtPy+lvJzPvhF8HNp/UBILU/o
         8keIrXXXOxNsb0/18B87quiSqb2Phqy5MHvfj9jY30rHP2e4v+cEVgApXOeBsQWxqJYs
         l+sQwrzPPssAkdh/xWmlPAppqVW9yQFOUo4zM2HtFD3mZvfux1+i1qi22kQjhVkguHaE
         Bl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685345139; x=1687937139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKRg7l5upkPsHIbZGSw6Q8T2a/KMJm+ptNrO6T1korM=;
        b=hRUbq6C21hT5Cl8dTNGHCVNhlcL/mMh6KpKISIno5PzndkDb7maLh1NUrqJkIacLSx
         b9qLN+iVMtIB9eIVedpNr/ETk428Blw1kmzNVZo4WJCYc0RLH4oAzUuggcehakF9wyna
         kBimFaaa9qihO8L5mulXgaWehvrzg368HQDtQR9ht2JHmH7WG4ZNU1D8+qg38K0RBGo4
         EofVhZIJsvHgQF8PYN0ImR0S0uFtVgpPiFNxpPrT9pw9vRjUsa6BJq3MrHRg5NR9+Qkx
         8cSTR0jxWoUyKXl8tkY00f65rmF82igTWFZZFzTke0AhDLG4VHAKoitB6KUnoaoYitSk
         hSFA==
X-Gm-Message-State: AC+VfDz/TKE+NnVPu/A3YO4sgGek4cTqNgd8eKQQCqux0h0KBvYomJh8
        naSINyLJdVAeTXkORfKUjDp3vHCmK6JamFKERMg=
X-Google-Smtp-Source: ACHHUZ5o0wacQ702LrQubMWpOhTJauZeqW+GMEsMsxGDKb9Shv3EqNUyOU1XwX5LqkT2fpMFJ+G7vKhrUy0+dhXHY3I=
X-Received: by 2002:a17:907:7243:b0:94c:ea3b:27a with SMTP id
 ds3-20020a170907724300b0094cea3b027amr9760839ejc.16.1685345138979; Mon, 29
 May 2023 00:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230525122837.649627-1-daniel.baluta@oss.nxp.com>
 <69c2b7cd-f211-47ef-b42a-609ee792de11@sirena.org.uk> <CAEnQRZAseAmOHLBsBQuW+SqEFbT-pbrjpUiPhSuv8Ww2VoJf_w@mail.gmail.com>
 <9484d916-2983-40a3-bad9-b2125e48e2b6@sirena.org.uk>
In-Reply-To: <9484d916-2983-40a3-bad9-b2125e48e2b6@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 May 2023 10:25:26 +0300
Message-ID: <CAEnQRZA+dXPN6xeV1SZk6YbaZSqTxoP7AJ9mqko98Jj25cs0Kg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: SOF: imx: Add OF machine descriptors for i.MX platforms
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 6:32=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, May 25, 2023 at 09:35:40PM +0300, Daniel Baluta wrote:
> > On Thu, May 25, 2023 at 8:07=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > > +     {
> > > > +             .compatible =3D "fsl,imx8qm",
> > > > +             .drv_name =3D "asoc-simple-card",
> > > > +             .sof_tplg_filename =3D "sof-imx8.tplg",
> > > > +     },
>
> > > It seems a bit sad to be adding simple-card rather than audio-graph-c=
ard
> > > at this point - is there some great reason for this?
>
> > This is what we used so far and it works pretty well for us.
>
> > Is there a plan to deprecate simple-card? And switch to audio-graph-car=
d?
>
> > We could have a look at this if this is the correct direction.
>
> It's already deprecated, and audio-graph-card (really you want to use
> the audio-graph-card2 binding) is much more featureful so will cover
> more machines.  If you're doing something new then it's best to use
> audio-graph-card for future proofing, simple-card is a bit too simple
> and inflexible.

Ok! Thanks for clarifications! Will use audio-graph-card!
