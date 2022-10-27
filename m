Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1842160FFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiJ0SLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiJ0SLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:11:21 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281AE27
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:11:20 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l190so2075344vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghnNel5RKIEKXRcO60Bu3zt02+g/FgjrBbtkb59h7Tg=;
        b=Nl9cV5hYd2NWV2/as5lCXgG/I8Z11C0iPyKcAP0GszGBIl6USl/ycrM5NQHq9QaKsB
         lGnxoZfgdTx+oAjyswEeet279YE8dI0Rr3tICwth/e9xjOpgr2VA8dX0qKPYoeGbiqkh
         SQ3ZDkD8lRd/peA5QVJ0LYpGrxJp/3AcCEsIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghnNel5RKIEKXRcO60Bu3zt02+g/FgjrBbtkb59h7Tg=;
        b=ExDYbf++s00FSCQ8/iarXmuotdQkEVcOkaDVZTU8963bkKq4K9lqQUWyBDuXeIQTBx
         hi6PIsXzzSzJDH64fGh0P1MjX4qlkL9F26yvkSI8xUkVQ2zmzvI8eEn7tbMe7jn9+CGS
         6eSN7PPJs4OZ2P+ArsQy76ZRE5Rue7VuH+NLkNwX8LVdJE62KS8sKqLdYjBiT7TZTBO6
         Kh1wCwtSI4vmj0O4hZVCJRpLUIvpmDB4SsXqpRwXVG/Mv6lw4/F5PQ082M+AlXBCza4X
         LwA53buRsS9T1Rt1MxnFzoNOuO2gZPyQyygzP3OqIbF82Olt+Y95kD76quC4bKsSEl7k
         s0cA==
X-Gm-Message-State: ACrzQf2dxyjWBgn+hxWATFCl5BCol/zLjkUUN+mNl+zjPm/R3oeMDhD/
        ylxOYnwvuzNwIb2YhZcZy7BGi7BVbdJgEDuhHBG1kWYlOsQ=
X-Google-Smtp-Source: AMsMyM74dMH2UoVHwZH6BpexiKJleb8/1mmL7Ju2e0nr7U59fEqEsXTNrYgjaZxot46p9f92JXvR6Ux0CcO4bSM4nxM=
X-Received: by 2002:a05:6102:3ed5:b0:386:91a5:a246 with SMTP id
 n21-20020a0561023ed500b0038691a5a246mr28545900vsv.26.1666894279657; Thu, 27
 Oct 2022 11:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com> <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
 <20221027143627.nbbketezqunkclxh@notapiano> <CAGXv+5Hki=VsvZrtANujFYseBp0Lxj4WVf3nzT7cx1kkMmWPFg@mail.gmail.com>
In-Reply-To: <CAGXv+5Hki=VsvZrtANujFYseBp0Lxj4WVf3nzT7cx1kkMmWPFg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 27 Oct 2022 11:11:08 -0700
Message-ID: <CAGXv+5EZO0+Af-Fmz8JW0SiV+b5He8ZSrinJ3TtaCP0vEoW1Mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Derek Fang <derek.fang@realtek.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:48 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Thu, Oct 27, 2022 at 7:36 AM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Tue, Oct 25, 2022 at 01:12:49PM -0700, Chen-Yu Tsai wrote:
> > > On Mon, Oct 24, 2022 at 3:01 PM N=C3=ADcolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >
> > > > The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> > >
> > > The actual chip also has LDO1_IN (for digital core and charge pump)
> > > and DBVDD (for I/O). However in the Chromebook designs these two
> > > and AVDD are all provided from the same power rail, through separate
> > > filter banks.
> >
> > What about rt5682 (no s), does that chip also have these same supplies?

(Missed this question)

The RT5682 has the same supplies, plus the VBAT one.

ChenYu

> > Also, since you already gave the purpose of these other supplies, could=
 you also
> > tell the purpose of AVDD, MICVDD and (for rt5682) VBAT? That way I coul=
d add
> > some description for them in the binding.
>
> As Mark mentioned in his reply, these are quite standard names.
>
> AVDD is for the analog bits. MICVDD is for the microphone bias.
> VBAT is called battery power in the datasheet. The block diagram
> shows it going through an internal controllable LDO whose output
> then powers MICVDD. This could be used in designs that don't
> include a suitable external supply for MICVDD. If MICVDD is provided,
> then one would turn the internal LDO off.
>
> So either VBAT or MICVDD has to be provided.
>
> ChenYu
>
> > Thanks,
> > N=C3=ADcolas
> >
> > >
> > > Neither does the datasheet specify the ordering of AVDD, DBVDD, and
> > > LDO1_IN for power sequencing, just that three should be toggled toget=
her.
> > >
> > > Should we model these? Or wait until some design actually splits thes=
e?
> > [..]
