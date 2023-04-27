Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D36F021F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbjD0HtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbjD0HtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:49:03 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BFD1DD;
        Thu, 27 Apr 2023 00:48:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AA15480A4;
        Thu, 27 Apr 2023 07:48:46 +0000 (UTC)
Date:   Thu, 27 Apr 2023 10:48:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        linux-realtek-soc@lists.infradead.org
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <20230427074845.GG14287@atomide.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <1cfc224b-f8b0-3143-42d2-188b56368c61@gmail.com>
 <CAMuHMdU91NtZeFKe6mB3B48TNb64wfPu77xRbOEVX4tV65e38w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU91NtZeFKe6mB3B48TNb64wfPu77xRbOEVX4tV65e38w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [230427 07:47]:
> On Thu, Apr 27, 2023 at 9:37 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > On 25/04/2023 17:57, Rob Herring wrote:
> > > On Tue, Apr 25, 2023 at 2:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> On Tue, Apr 25, 2023 at 12:16 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >>> I have a script[1] that does the conversion written the last time this
> > >>> came up. Just have to agree on directory names. I think the easiest
> > >>> would be for Arnd/Olof to run it at the end of a merge window before
> > >>> rc1.
> > >>
> > >> "emev2" and "sh7" are missing for renesas.
> > >
> > > No doubt it's been bitrotting (or I may have missed some).
> > >
> > >> Does your script also cater for .dts files not matching any pattern,
> > >> but including a .dtsi file that does match a pattern?
> > >
> > > I assume I built everything after moving, but maybe not...
> > >
> > > That's all just "details". First, we need agreement on a) moving
> > > things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> > > been stuck on a) for being 'too much churn'.
> > >
> >
> > I think it makes sense to move them and probably the best way to do so is, as
> > you proposed: that Arnd or Olof run the script to move them just before -rc1
> 
> FTR, no objections from my side.

Sounds good to me.

Regards,

Tony
