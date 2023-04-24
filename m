Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306976ED7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDXWYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjDXWYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:24:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0FAD15;
        Mon, 24 Apr 2023 15:24:09 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-74dd7f52f18so1440544885a.0;
        Mon, 24 Apr 2023 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682375046; x=1684967046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29IkbevyZ1JNfaYOQPn+HUpDLJ8b+PXRIDIYtEtvSPw=;
        b=IenoMxH48zII5fB58Gv60rUYDA9EtMMTbp/ZPDsVe6TBLDWwJpDQNL0U/+HtpDrCsX
         fYcOvs90TmBzvujQKZgX1eQmTxHrD8IQ8eq3PJOqaDLWqpZdTwfMfBvVmqcqO28ToIw7
         /P7xxKrOhgtS2jNLZBQf3OSYmuIwjEkZ1S/W3qfD2WGO2+JW+Io3zDwpMSpXDXbRTpHh
         uitadTIFC1oliUm/1Zh59RVMfDNq9tD4dKeTBpg9+/lExxyEH32RZcEQz0uV3npjXStN
         Fms3lNhl1J8Rm6im79IxUzwKmWZ7e0Mj4EIC16F0L0FGCYsa066ivIKjU382HCqCopQ+
         ujLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682375046; x=1684967046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29IkbevyZ1JNfaYOQPn+HUpDLJ8b+PXRIDIYtEtvSPw=;
        b=lWo6nHAEfIOipfehf51FecZAfITaBM+vqDI9AxHUmuzcndFEglOb0AJ8Uhr1I/52hR
         Eet8hpcwTmTbLeaR2m9B6S6b1kRCuRuwTZHnJu9Cvrq0El6o4LCxTuaBDTVJTfLWlAz8
         hrWOclISrYufvtlI9zBC65yS5zL7kNwChco2caNqY/avRXu8qICtfDzU+aTftUA8+ved
         ZVseMEawpFJHLFG2OrysugFRGA4gDF5MtaUjnHcE+ycSC9Lqa3U15Qwj6ZsCqMdHyrqU
         wIFwqbGUpvR1grvAafJQHw975KIW7+XqBLKNh+8tWn/9Je+CwNfUrKrJCz2Xm3se0ZG2
         Difw==
X-Gm-Message-State: AAQBX9evpql8NFCSW+pZM1zNy3cCMQ9Ff+kjz1SpUOhdIf7WIIklykZl
        0C1ZdtxDgMQ2/xVNoZ18G33sixilGgh6Cu5xiZ8=
X-Google-Smtp-Source: AKy350ZaN4hyLvIPAT5s597oFwGJxWUglXzPuWB3KyxTTdt5lEGprQ4ln3wBEVVlH0j6U9Xj73/XDG6Es3m1QFoaTr0=
X-Received: by 2002:a05:6214:5195:b0:5ef:512d:2d47 with SMTP id
 kl21-20020a056214519500b005ef512d2d47mr22906279qvb.19.1682375046222; Mon, 24
 Apr 2023 15:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Tue, 25 Apr 2023 00:23:54 +0200
Message-ID: <CA+_ehUw3eAEHRsi1ATSKeK4jtX+EoVSwUodNL3bcpTJaX-r9cA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno mar 25 apr 2023 alle ore 00:10 Rob Herring
<robh+dt@kernel.org> ha scritto:
>
> On Tue, Mar 29, 2022 at 8:27=E2=80=AFAM Ansuel Smith <ansuelsmth@gmail.co=
m> wrote:
> >
> > On Tue, Mar 29, 2022 at 03:20:18PM +0200, Krzysztof Kozlowski wrote:
> > > On 28/03/2022 02:09, Ansuel Smith wrote:
> > > > Hi,
> > > > as the title say, the intention of this ""series"" is to finally ca=
tegorize
> > > > the ARM dts directory in subdirectory for each oem.
> > > >
> > > > The main reason for this is that it became unpractical to handle 26=
00
> > > > dts files and try to even understand/edit/check the situation for a
> > > > specific target.
> > > >
> > > > In arm64 we already have this kind of separation and I honestly thi=
nk
> > > > that this was never proposed for ARM due to the fact that there are
> > > > 2600+ files to sort and the fact that it will be a mess to merge th=
is
> > > > entirely but IMHO with a little bit of effort we can finally solve =
this
> > > > problem and have a well organized directory just like arm64.
> > > >
> > > > Some prerequisite on how this work was done:
> > > > - This comes entirely from a python script created by me for the ta=
sk.
> > > >   linked here [1]
> > > > - I had to manually categorize all the different arch in the makefi=
le
> > > >   based on the oem. I searched every arch on the internet trying to
> > > >   understand the correct oem. I hope they are correct but I would l=
ove
> > > >   some comments about them.
> > > > - This current ""series"" is all squashed in one big commit to bett=
er
> > > >   receive comments for this. The final version ideally would have a=
ll
> > > >   changes in separate commits. The script can already do this, it's=
 just
> > > >   commented.
> > > >
> > > > Here is a list of some discoveries while doing all the sorting.
> > > > These are totally additional reason why we need this.
> > > >
> > > > While creating the script I discovered some funny things:
> > > > - We have orphan dts! There are dts that are never compiled and are
> > > >   there just for reference. We would never have noticed this withou=
t this
> > > >   change and probably nobody noticed it. They are currently all lis=
ted
> > > >   in the python script.
> > > > - We have dtsi shared across different oem. My current solution for=
 them
> > > >   is: NOT SORT THEM and leave them in the generic directory and cre=
ate a
> > > >   link in each oem dts that points to these dtsi. This is to try in
> > > >   every way possible to skip any additional changes to the dts.
> > > >   Current dtsi that suffers from this are only 3. (listed in the sc=
ript)
> > > > - arm64 dts and dtsi reference ARM dts. Obviously this change would=
 cause
> > > >   broken include for these special dtsi. The script creates a depen=
dency
> > > >   table of the entire arm64 directory and fix every broken dependen=
cy
> > > >   (hoping they all use a sane include logic... regex is used to par=
se
> > > >   all the different dependency)
> > > >
> > > > So in short the script does the following steps:
> > > > 1. Enumerate all the action to do... (dts to move, scan dependency =
for
> > > >    the dts...)
> > > > 2. Generate the arm64 dependency
> > > > 3. Creates the Makefile
> > > > 4. Generate the Makefiles for the current oem
> > > > 5. Move all the related dts and dtsi for the current oem
> > > > 6. Check broken dependency and fix them by editing the dts and writ=
ing
> > > >    the correct include (or fix any symbolic link)
> > > >
> > > > This is an output that describes all the things done by the script =
[2]
> > > >
> > > > I really hope I didn't commit any logic mistake in the script but m=
ost
> > > > of the work should be done.
> > > >
> > >
> > > +Cc Arnd and Olof,
> > >
> > > Ansuel,
> > > Thanks for you patch. Please cc the SoC maintainers in such submissio=
ns.
> > > It seems that you got some quite nice discussion, but still the core
> > > folks are not Cced, so no one would be able to take your patch...
> > >
> >
> > I had some problem with gmail and sending mail too much users. I put Ro=
b
> > and You and all the various list to try to workaround the "gmail spam
> > protection"
> >
> > > I am pretty sure we were discussing such split idea in the past and i=
t
> > > did not get traction, but I cannot recall the exact discussion.
> > >
> >
> > I think the main issue here is how to handle bot and how problematic is
> > to merge this. As written in the cover letter the final version of this
> > should be a big series of 50+ patch with every commit specific to each
> > oem. In theory we should be able to merge the different oem separately
> > and try to at least start the categorization.
> > Another idea I got to at least have a "migration path" is to convert
> > every dts in the dts/ directory to a symbolic link that target the dts
> > in the correct oem. But I assume that would fix only part of the proble=
m
> > and git am will still be problematic.
>
> I have a script[1] that does the conversion written the last time this
> came up. Just have to agree on directory names. I think the easiest
> would be for Arnd/Olof to run it at the end of a merge window before
> rc1.
>
> I'm very much in favor of this happening especially before *any*
> overlays are added to add to the mess (it's probably already
> happened).
>
> Rob
>
> [1] https://lore.kernel.org/all/20181204183649.GA5716@bogus/

Hi Rob,
thanks for recovering this. I remember also providing a script.

Anyway considering the amount of stuff to move, I feel like some
OEM might be problematic to move due to rebase and merging problems.

We should consider accepting moving only some and keep other
in the unsorted path. And move them at the first time possible with
the help of the maintainers.

One main blocker of this is some qcom dts that are linked to arm64
directory, so for some dts special care is needed.
