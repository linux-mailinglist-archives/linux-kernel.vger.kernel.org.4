Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC660FF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiJ0Rsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiJ0Rsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:48:39 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFD159A17
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:48:38 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id t85so1192210vkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KCnP92hVg2b4OPU8MtnSYIJzA7N3h0NpJJjHHoL8P8=;
        b=F2omDsoPpXXQur7mSB0dnyaFLhNZV4z5D7DchgCW6Bha04vnZBiTMnkZ0HojExFiPS
         KdBMG91XUVNUEYIc8uUkbTBBivETBLA08Oj1gsphbMKBc12iKgM/ePnqZYxnOBw1Gl5D
         jYiWDihIbAWf/Epw952HJ2d3CWz00/Qtm9/8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KCnP92hVg2b4OPU8MtnSYIJzA7N3h0NpJJjHHoL8P8=;
        b=zTJXNYlZWro3t04qzSMf6vlp2FzPvPWUacCPEGfAnXXx0ptqJkirP96cWOM3/29fWG
         /axryHydv4tO0R2YpNdHT+pjWkOIC6q9CgeCEiLyT2YaoEu+KE1XrNMwDma4fxn+eAHV
         Q7aWlilK8z+hpCtOMQsILIASxQf2ubUn8LaaHxO3wlKmRouJHycUpR+dvKXaR9SSRuH5
         w654X7SiVVGyIDOzGMikTwqOWgC/lEOsSFUSObOyMNXvRbQ0RPrhSuRUPi4XRA80IdI3
         3a9uCjVyXHzvs2sA5ZzWj3wJmBudlsY+A13EVZJeLV7RVQEqjDDQfaOvpr9LKG5zUOjL
         dPpw==
X-Gm-Message-State: ACrzQf12ZMsuvNJeaNBvWkOBses+ljV9wBKPRx+zX7Rmw6ZmvGLmQC1Z
        cF4J9EN4SQWp1I4KUJhkIbFVO28wgdlj8nklf6VnEQ==
X-Google-Smtp-Source: AMsMyM6fdbfm1xIT3CDDeYdHZqjTpKCb0UWp+jaha25OIvK5KR4BPj1fdpFAXxmgHFlAMdNMl+znMaqyHInybaIOGMg=
X-Received: by 2002:a1f:9116:0:b0:3a2:362b:fea9 with SMTP id
 t22-20020a1f9116000000b003a2362bfea9mr26689153vkd.11.1666892917792; Thu, 27
 Oct 2022 10:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com> <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
 <20221027143627.nbbketezqunkclxh@notapiano>
In-Reply-To: <20221027143627.nbbketezqunkclxh@notapiano>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 27 Oct 2022 10:48:26 -0700
Message-ID: <CAGXv+5Hki=VsvZrtANujFYseBp0Lxj4WVf3nzT7cx1kkMmWPFg@mail.gmail.com>
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

On Thu, Oct 27, 2022 at 7:36 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Oct 25, 2022 at 01:12:49PM -0700, Chen-Yu Tsai wrote:
> > On Mon, Oct 24, 2022 at 3:01 PM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> >
> > The actual chip also has LDO1_IN (for digital core and charge pump)
> > and DBVDD (for I/O). However in the Chromebook designs these two
> > and AVDD are all provided from the same power rail, through separate
> > filter banks.
>
> What about rt5682 (no s), does that chip also have these same supplies?
>
> Also, since you already gave the purpose of these other supplies, could y=
ou also
> tell the purpose of AVDD, MICVDD and (for rt5682) VBAT? That way I could =
add
> some description for them in the binding.

As Mark mentioned in his reply, these are quite standard names.

AVDD is for the analog bits. MICVDD is for the microphone bias.
VBAT is called battery power in the datasheet. The block diagram
shows it going through an internal controllable LDO whose output
then powers MICVDD. This could be used in designs that don't
include a suitable external supply for MICVDD. If MICVDD is provided,
then one would turn the internal LDO off.

So either VBAT or MICVDD has to be provided.

ChenYu

> Thanks,
> N=C3=ADcolas
>
> >
> > Neither does the datasheet specify the ordering of AVDD, DBVDD, and
> > LDO1_IN for power sequencing, just that three should be toggled togethe=
r.
> >
> > Should we model these? Or wait until some design actually splits these?
> [..]
