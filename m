Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8959F721D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjFEEs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjFEEsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:48:21 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C73E3;
        Sun,  4 Jun 2023 21:48:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E2A4F80C1;
        Mon,  5 Jun 2023 04:48:17 +0000 (UTC)
Date:   Mon, 5 Jun 2023 07:48:16 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Message-ID: <20230605044816.GU14287@atomide.com>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-2-francesco@dolcini.it>
 <20230602072045.GO14287@atomide.com>
 <ZHml0ZEC9ZvxHXr9@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHml0ZEC9ZvxHXr9@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Francesco Dolcini <francesco@dolcini.it> [230602 08:18]:
> On Fri, Jun 02, 2023 at 10:20:45AM +0300, Tony Lindgren wrote:
> > Hi,
> > 
> > * Francesco Dolcini <francesco@dolcini.it> [230601 13:15]:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> > > nonwifi and wifi variants and the carrier boards (Dahlia,
> > > Verdin Development Board and Yavia) they may be mated in.
> > 
> > Looks like you have wifi on sdio, there should be no need for separate
> > compatible properties. The sdio wifi will try to probe and will just bail
> > out if no wifi is populated.
> > 
> > If however the non-wifi variants are recycling the sdio pins for something
> > else, then it's it's a different story. In that case you want either
> > seprate compatible properties, or want to use dts fragments possibly.
> 
> This is exactly the case, the wifi/non-wifi variant are re-using pins.
> 
> I provided a more verbose explanation on that on a previous discussion
> https://lore.kernel.org/all/ZG5jYV%2FNfGJvYkma@francesco-nb.int.toradex.com/

Ok thanks for the information.

Regards,

Tony
