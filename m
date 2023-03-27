Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A06C9D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjC0IQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjC0IQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:16:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C60BB40EA;
        Mon, 27 Mar 2023 01:16:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 096748108;
        Mon, 27 Mar 2023 08:16:50 +0000 (UTC)
Date:   Mon, 27 Mar 2023 11:16:48 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andrew Davis <afd@ti.com>, kernel@pyra-handheld.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        letux-kernel@openphoenux.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap3-gta04: fix compatible record for GTA04
 board
Message-ID: <20230327081648.GF7501@atomide.com>
References: <38b49aad0cf33bb5d6a511edb458139b58e367fd.1676566002.git.hns@goldelico.com>
 <167694504105.814849.13739306703872130380.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167694504105.814849.13739306703872130380.robh@kernel.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rob Herring <robh@kernel.org> [230221 02:04]:
> 
> On Thu, 16 Feb 2023 17:46:43 +0100, H. Nikolaus Schaller wrote:
> > Vendor of the GTA04 boards is and always was
> > Golden Delicious Computers GmbH&Co. KG, Germany
> > and not Texas Instruments.
> > 
> > Maybe, TI was references here because the GTA04 was based on
> > the BeagleBoard design which is designated as "ti,omap3-beagle".
> > 
> > While we are looking at vendors of omap3 based devices, we also
> > add the record for OpenPandora. The DTS files for the pandora
> > device already make use of it.
> > 
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
> >  arch/arm/boot/dts/omap3-gta04.dtsi                     | 3 +--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applying into omap-for-v6.4/dt thanks.

Tony
