Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6771FBB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjFBISn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjFBISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:18:35 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B343196;
        Fri,  2 Jun 2023 01:18:32 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 798CD20395;
        Fri,  2 Jun 2023 10:18:29 +0200 (CEST)
Date:   Fri, 2 Jun 2023 10:18:25 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
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
Message-ID: <ZHml0ZEC9ZvxHXr9@francesco-nb.int.toradex.com>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-2-francesco@dolcini.it>
 <20230602072045.GO14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602072045.GO14287@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:20:45AM +0300, Tony Lindgren wrote:
> Hi,
> 
> * Francesco Dolcini <francesco@dolcini.it> [230601 13:15]:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> > nonwifi and wifi variants and the carrier boards (Dahlia,
> > Verdin Development Board and Yavia) they may be mated in.
> 
> Looks like you have wifi on sdio, there should be no need for separate
> compatible properties. The sdio wifi will try to probe and will just bail
> out if no wifi is populated.
> 
> If however the non-wifi variants are recycling the sdio pins for something
> else, then it's it's a different story. In that case you want either
> seprate compatible properties, or want to use dts fragments possibly.

This is exactly the case, the wifi/non-wifi variant are re-using pins.

I provided a more verbose explanation on that on a previous discussion
https://lore.kernel.org/all/ZG5jYV%2FNfGJvYkma@francesco-nb.int.toradex.com/

Francesco

