Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BAD6EFDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbjDZXUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjDZXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:20:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13EE35B6;
        Wed, 26 Apr 2023 16:20:33 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 160856602E0E;
        Thu, 27 Apr 2023 00:20:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682551232;
        bh=Dey1VOUTEwTL6Sl2f26EKC7VLJF2yfDPr0/B4iTsk+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiwtnYoGHuqxptvgNLvgHXQx445i09BhdsipGOGAjX/cWTRLSZ07A50kQaD32jsmt
         msu/BY7f+3YxnAZxl4RxDwuLDuAMEvHMjZ7u3bpHu03O0S+F2oCNcxqSesXBnG/eM5
         Yg3oYKYH136JURJs6iMuHlPiYZDp7NAw0HAZMLPHlE/U/S0bUl3JBBRkNNyJtGshqI
         Tsaczz57ydyC+9E4wNae3hnurW9cuBGsztaJUy6/4ZtoSGAtCCBgcgLtoidf84cMiX
         GlRDDiqzqAAS+mzssxQkdeo8xkhV+iuGhSpRQvsdvc7cL8GDJn85Z3ecfJEzET0LdY
         RqT/xvZVLPjbw==
Date:   Wed, 26 Apr 2023 19:20:25 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
Message-ID: <28e50e45-53cf-4a34-a81c-10f1faab2d4e@notapiano>
References: <20230307163413.143334-1-bchihi@baylibre.com>
 <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
 <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
 <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
 <fab67eef-4dc9-420d-b127-aedc6f54cad0@notapiano>
 <CAGXv+5E0rzByZBn91d60MQ7P0=GbAQUH=PK9EYDu3Upr33td6A@mail.gmail.com>
 <CAGuA+oo0w8n9zEKdd1UfYx+F08wK4CcUGqRbBi4C-xNYp+vtDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGuA+oo0w8n9zEKdd1UfYx+F08wK4CcUGqRbBi4C-xNYp+vtDA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:28:39PM +0200, Balsam CHIHI wrote:
> On Tue, Apr 25, 2023 at 12:00 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > On Tue, Apr 25, 2023 at 6:21 AM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > On Tue, Mar 28, 2023 at 02:20:24AM +0200, Balsam CHIHI wrote:
> > > > On Sat, Mar 25, 2023 at 5:33 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> > > > >
> > > > > On Wed, Mar 22, 2023 at 8:48 PM Balsam CHIHI <bchihi@baylibre.com> wrote:
[..]
> > > >
> > > > Hi Chen-Yu Tsai,
> > > >
> > > > Thank you very much for helping me testing this suggestion.
> > > >
> > > > Indeed, calibration data is stored differently in the mt8192 compared to mt8195.
> > > > So, the mt8192's support will be delayed for now, to allow further debugging.
> > > >
> > > > In the mean time, we will only continue to upstream the remaining
> > > > mt8195's source code, so it will get full LVTS support.
> > > > A new series will be submitted soon.
> > >
> > > Hi Balsam,
> > >
> > > like Chen-Yu mentioned, the calibration data is stored with 4 byte alignment for
> > > MT8192, but the data that is split between non-contiguous bytes is for the
> > > thermal controllers (called Resistor-Capacitor Calibration downstream) not the
> > > sensors. The controller calibration isn't currently handled in this driver (and
> > > downstream it also isn't used, since a current value is read from the controller
> > > instead), so we can just ignore those.
> > >
> > > The patch below adjusts the addresseses for the sensors and gives me reasonable
> > > reads, so the machine no longer reboots. Can you integrate it into your series?
> >
> > Not sure what I got wrong, but on my machine the VPU0 and VPU1 zone interrupts
> > are still tripping excessively. The readings seem normal though. Specifically,
> > it's bits 16 and 17 that are tripping.
> >
> 
> Hi Chen-Yu,
> 
> Thank you for testing!
> 
> As the readings are normal that proves that calibration data offsets
> are correct.
> would you like that I send the v2 of series to add mt8192 support?
> Then we could deal with the interrupts later in a separate fix,
> because the interrupt code in common for both SoC (mt8192 and mt8195)?
> 
> Does Nícolas also have tripping interrupts?
> On my side, I've got no interrupts tripping on mt8195.
> 
> Any other suggestions (a question for everyone)?

Hi,

sorry for the delay.

Indeed the interrupts are constantly tripping on mt8192 here as well.

I do not see the same bits as Chen-Yu mentioned however, I see

LVTS_MONINTSTS = 0x08070000

which corresponds to

	Hot threshold on sense point 3
	high to normal offset on sense point 2
	high offset on sense point 2
	low offset on sense point 2

and it's the same on all controllers and domains here, which is weird. I noticed
we have offset interrupts enabled even though we don't configure the values for
those, but even after disabling them and clearing the status register, the
interrupts keep triggering and the status is the same, so for some reason
LVTS_MONINT doesn't seem to be honored.

I also tried using the filtered mode instead of immediate for the sensors, and
that together with disabling the extra interrupts, got me a zeroed
LVTS_MONINTSTS. However no interrupts seem to be triggered at all (nor
LVTS_MONINTSTS updated) when the temperature goes over the configured one in
LVTS_HTHRE.

I tried the driver on mt8195 (Tomato chromebook) as well, and it has the same
LVTS_MONINTSTS = 0x08070000
even though the interrupts aren't being triggered, but in fact I don't see them
triggering over the threshold either, so I suspect the irq number might be
incorrectly described in the DT there.

Do either of you have it working correctly on mt8195?

Anyway, I'll keep digging and reply here when I find a solution.

Thanks,
Nícolas
