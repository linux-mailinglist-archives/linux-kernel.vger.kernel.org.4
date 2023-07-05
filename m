Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD4747FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjGEI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGEI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:29:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291421712
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:29:03 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qGxsc-0007l4-BO; Wed, 05 Jul 2023 10:28:54 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qGxsb-00081q-S6; Wed, 05 Jul 2023 10:28:53 +0200
Date:   Wed, 5 Jul 2023 10:28:53 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, marex@denx.de,
        frieder.schrempf@kontron.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: fix DEBIX binding
Message-ID: <20230705082853.26kfb7thnxkb5tz4@pengutronix.de>
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
 <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 23-07-05, Krzysztof Kozlowski wrote:
> On 04/07/2023 20:41, Marco Felsch wrote:
> > The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> > corresponding bindings by adding an own entry for it.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 15d4110840654..d9e763ef932e5 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -1019,8 +1019,6 @@ properties:
> >                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
> >                - fsl,imx8mp-evk            # i.MX8MP EVK Board
> >                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
> > -              - polyhex,imx8mp-debix      # Polyhex Debix boards
> > -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
> >                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
> >                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
> >                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
> > @@ -1054,6 +1052,13 @@ properties:
> >            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
> >            - const: fsl,imx8mp
> >  
> > +      - description: Polyhex DEBIX i.MX8MP based SBCs
> > +        items:
> > +          - enum:
> > +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
> > +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
> 
> Same comments as for patch #2. I think this should be rather deprecated
> - not a good pattern.

How can we deprecate a binding?

Regards,
  Marco
