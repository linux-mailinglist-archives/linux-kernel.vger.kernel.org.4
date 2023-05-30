Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B04716A35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjE3Q6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjE3Q6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:58:17 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028179D;
        Tue, 30 May 2023 09:58:14 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id DD99D207A3;
        Tue, 30 May 2023 18:58:12 +0200 (CEST)
Date:   Tue, 30 May 2023 18:58:11 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Message-ID: <ZHYrIwfzLyYC+2Cb@francesco-nb.int.toradex.com>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-2-francesco@dolcini.it>
 <20230530121231.fnfqhkfliysrv2pr@engross>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530121231.fnfqhkfliysrv2pr@engross>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 07:12:31AM -0500, Nishanth Menon wrote:
> On 16:36-20230524, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> > nonwifi and wifi variants and the carrier boards (Dahlia,
> > Verdin Development Board and Yavia) they may be mated in.
> > 
> > Link: https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-am62/
> > Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  .../devicetree/bindings/arm/ti/k3.yaml        | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > index e1183f90bb06..e3aee191d403 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -33,6 +33,26 @@ properties:
> >                - ti,am62-lp-sk
> >            - const: ti,am625
> >  
> > +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards
> > +        items:
> > +          - enum:
> > +              - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
> > +              - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
> > +              - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia
> 
> Does'nt one of these indicate the rest?

Strictly speaking it does.

However it's convenient to have a tuple with more generic compatible
afterward.

I tried to explain some of the reasoning for that on this email [1].

More in general this tuple of compatible is matching how the actual system
is layered (SoC -> base SoM -> SoM variant -> carrier board) that is
also reflected on the dtsi include hierarchy.

FWIW, this is the standard approach you can see on fsl.yaml, where such
kind of modular system are pretty much standard.

[1] https://lore.kernel.org/all/ZG5jYV%2FNfGJvYkma@francesco-nb.int.toradex.com/

Francesco

