Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95BB6B099E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCHNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCHNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:43:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC69898CC;
        Wed,  8 Mar 2023 05:42:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7002DB81CC0;
        Wed,  8 Mar 2023 13:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B87FC4339B;
        Wed,  8 Mar 2023 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678282935;
        bh=YW+SZDRVXklCngw+7708VvFnfwV2mw5HHBrr6iHIZtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3yvoyvi4uAYB5K4AyE6S1fEmLVPM0XKZHidQLpGT2LYPEqQ2JZmpYAE8eDUshAlQ
         bcud82pWGNVDAhcLzqsA4m+LpktawJycbe6sYG2TV6gbx75gfyhEiGn1QBaouIzt0k
         SScNezEWmdsMjQrruWSEts4A7TV5qa0lV6sQN2tkDwcdZx+t48ZsQaUtrz2qPoJfVm
         GPLg/oyqbSnQ2YTZok9YY2gMsp07ncHPrLpc2A+AAKv9HIezA6m9ZaX+jm+JJDPys3
         AGGkOZ8dYrv4l0Cnkxvfk7Wr3hrcWWrUi4BAvjuZUzDedQyiLTiT9tJPKQcBmGxVcm
         surebN+LfQ1dQ==
Date:   Wed, 8 Mar 2023 13:42:08 +0000
From:   Lee Jones <lee@kernel.org>
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     ChiaEn Wu <chiaen_wu@richtek.com>, corbet@lwn.net, pavel@ucw.cz,
        matthias.bgg@gmail.com, andriy.shevchenko@linux.intel.com,
        jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v17 RESEND 3/3] docs: leds: Add MT6370 RGB LED pattern
 document
Message-ID: <20230308134208.GK9667@google.com>
References: <cover.1677150607.git.chiaen_wu@richtek.com>
 <c6487954daff5e514023056ad7de1d0ddee674a8.1677150607.git.chiaen_wu@richtek.com>
 <20230305101824.GE2574592@google.com>
 <20230307040804.GA15766@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307040804.GA15766@linuxcarl2.richtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, ChiYuan Huang wrote:

> Hi, Lee:
>
>     Some question about the comment.
> On Sun, Mar 05, 2023 at 10:18:24AM +0000, Lee Jones wrote:
> > On Thu, 23 Feb 2023, ChiaEn Wu wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Document the MT6370 RGB LED pattern trigger.
> > >
> > > This simply describe how the pattern works, each timing period, and the
> > > pattern diagram for MT6370 RGB LED.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > > ---
> > >  Documentation/leds/leds-mt6370-rgb.rst | 64 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >  create mode 100644 Documentation/leds/leds-mt6370-rgb.rst
> > >
> > > diff --git a/Documentation/leds/leds-mt6370-rgb.rst b/Documentation/leds/leds-mt6370-rgb.rst
> > > new file mode 100644
> > > index 00000000..d1b2e4f
> > > --- /dev/null
> > > +++ b/Documentation/leds/leds-mt6370-rgb.rst
> > > @@ -0,0 +1,64 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=========================================
> > > +Kernel driver for Mediatek MT6370 RGB LED
> >
> > Are you describing the device or the kernel driver?
> >
> But referring to others, it seems each one also write this as 'Kernel driver'.
> Sorry, I cannot catch the point. Did you mean to modify this description as
> 'The device for MT6370 RGB LED'?

Just because it's been done before, doesn't make it right.

IMHO, this document should describe the device, not the driver.

--
Lee Jones [李琼斯]
