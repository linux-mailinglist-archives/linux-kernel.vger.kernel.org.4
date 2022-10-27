Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CE610175
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiJ0TU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiJ0TUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:20:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5795D8B6;
        Thu, 27 Oct 2022 12:20:23 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBDB56602901;
        Thu, 27 Oct 2022 20:20:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666898421;
        bh=9dJxbXEMErZ8t4h221dFyy5GrBkDKxqglNeRuSY+Z/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FypfZf5gz1/t1Dy1SoKKAZSlLago1tiIZqAALtt3IgovT3zAVCXjfcOmrNqwIS1aP
         Gaa/GAv1u3u2e2bPzAlZYiPMhF8eFmio8m/O5y6aNlvPparNWktBtZNcL/avsAa+am
         aJpCspM6ZVSGJqRL7wk8jPiFH50wPWVWXaLPIggshnXGzN9og4wpWZq6tvu5MzElaN
         OIdPdzsCKlpGgdQ55qs6Zkm5iG1XHQ2V/yA8DUDfXKOlKhFolaL23es4vcsjnDIohg
         cw8JZnCYN81y2EmbyGeS6DqxuQFTKExsI85c21xzDBRfLhVK30cEDqXBiF2hKuhAR8
         T6ojLQorHHHbg==
Date:   Thu, 27 Oct 2022 15:20:15 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Derek Fang <derek.fang@realtek.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <20221027192015.qbmf4bwwok63wytz@notapiano>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
 <20221027143627.nbbketezqunkclxh@notapiano>
 <CAGXv+5Hki=VsvZrtANujFYseBp0Lxj4WVf3nzT7cx1kkMmWPFg@mail.gmail.com>
 <CAGXv+5EZO0+Af-Fmz8JW0SiV+b5He8ZSrinJ3TtaCP0vEoW1Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EZO0+Af-Fmz8JW0SiV+b5He8ZSrinJ3TtaCP0vEoW1Mg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:11:08AM -0700, Chen-Yu Tsai wrote:
> On Thu, Oct 27, 2022 at 10:48 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > On Thu, Oct 27, 2022 at 7:36 AM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > On Tue, Oct 25, 2022 at 01:12:49PM -0700, Chen-Yu Tsai wrote:
> > > > On Mon, Oct 24, 2022 at 3:01 PM Nícolas F. R. A. Prado
> > > > <nfraprado@collabora.com> wrote:
> > > > >
> > > > > The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> > > >
> > > > The actual chip also has LDO1_IN (for digital core and charge pump)
> > > > and DBVDD (for I/O). However in the Chromebook designs these two
> > > > and AVDD are all provided from the same power rail, through separate
> > > > filter banks.
> > >
> > > What about rt5682 (no s), does that chip also have these same supplies?
> 
> (Missed this question)
> 
> The RT5682 has the same supplies, plus the VBAT one.
> 
> ChenYu
> 
> > > Also, since you already gave the purpose of these other supplies, could you also
> > > tell the purpose of AVDD, MICVDD and (for rt5682) VBAT? That way I could add
> > > some description for them in the binding.
> >
> > As Mark mentioned in his reply, these are quite standard names.
> >
> > AVDD is for the analog bits. MICVDD is for the microphone bias.
> > VBAT is called battery power in the datasheet. The block diagram
> > shows it going through an internal controllable LDO whose output
> > then powers MICVDD. This could be used in designs that don't
> > include a suitable external supply for MICVDD. If MICVDD is provided,
> > then one would turn the internal LDO off.
> >
> > So either VBAT or MICVDD has to be provided.

So if I get this right we should be making the following supplies required:
AVDD
VBAT or MICVDD (on rt5682s there's no VBAT so just MICVDD)

And for LDO1_ON and DBVDD what would be the best way to model? Should we make
them required in the binding as well and add them pointing to the same regulator
from AVDD in the chromebook DT or just leave them as optional?

Thanks,
Nícolas

> >
> > ChenYu
> >
> > > Thanks,
> > > Nícolas
> > >
> > > >
> > > > Neither does the datasheet specify the ordering of AVDD, DBVDD, and
> > > > LDO1_IN for power sequencing, just that three should be toggled together.
> > > >
> > > > Should we model these? Or wait until some design actually splits these?
> > > [..]
