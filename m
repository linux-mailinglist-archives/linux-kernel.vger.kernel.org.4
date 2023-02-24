Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E166A2366
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBXVGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBXVGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:06:33 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249C6DDB7;
        Fri, 24 Feb 2023 13:06:28 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pVfGp-0002JD-34;
        Fri, 24 Feb 2023 22:06:24 +0100
Date:   Fri, 24 Feb 2023 21:06:17 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH RFC 1/4] dt-bindings: clock: rename mt7986-clk.h to
 mediatek,mt7986-clk.h
Message-ID: <Y/kmj36e4jSfLdVN@makrotopia.org>
References: <cover.1677089171.git.daniel@makrotopia.org>
 <15d718a2d696d29b48668b9ab5531369c537a1e6.1677089171.git.daniel@makrotopia.org>
 <ace28a97-b43e-4b24-52d0-93bc21263aff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace28a97-b43e-4b24-52d0-93bc21263aff@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 11:18:37AM +0100, Krzysztof Kozlowski wrote:
> On 22/02/2023 19:09, Daniel Golle wrote:
> > Rename dt-bindings header file mt7986-clk.h to mediatek,mt7986-clk.h,
> > propagate this change also to mt7986a.dtsi which is the only user.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt7986a.dtsi                       | 2 +-
> >  drivers/clk/mediatek/clk-mt7986-infracfg.c                      | 2 +-
> >  drivers/clk/mediatek/clk-mt7986-topckgen.c                      | 2 +-
> >  .../dt-bindings/clock/{mt7986-clk.h => mediatek,mt7986-clk.h}   | 0
> 
> You cannot have bindings and DTS and drivers mixed together. Which
> points to fact - you cannot make such change... Also your commit msg
> does not justify "why" you are doing it.

The reason is simply consistency with most other SoCs.

So to make such a change possible, I should do it in three steps, right?
Step 1: dt-bindings: copy mt7986-clk.h to mediatek,mt7986-clk.h
Step 2: changes in drivers
Step 3: dt-bindings: remove mt7986-clk.h

Would this change be acceptable if carried out in 3 commits?
And using the same strategy also the other changes suggested in the
series?

Thank you!

Best regards

Daniel
