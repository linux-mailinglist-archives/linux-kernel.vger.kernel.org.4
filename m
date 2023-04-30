Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58B06F286F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjD3KN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 06:13:57 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4FF1995;
        Sun, 30 Apr 2023 03:13:56 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id D03E91F8F7;
        Sun, 30 Apr 2023 12:13:54 +0200 (CEST)
Date:   Sun, 30 Apr 2023 12:13:50 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "festevam@denx.de" <festevam@denx.de>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "max.krummenacher@toradex.com" <max.krummenacher@toradex.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "denys.drozdov@toradex.com" <denys.drozdov@toradex.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yaml: Add an entry in imx8mm boards for Emtop SOM-IMX8MM
Message-ID: <ZE4/XmIq+KNDTsIt@francesco-nb.int.toradex.com>
References: <BM1PR01MB4899FB61CCDE89E83F0F4D979A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BM1PR01MB4899FB61CCDE89E83F0F4D979A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 02:07:51PM +0000, Himanshu Bhavani wrote:
> >From 8756e66b7fba0a5063c6011983eb876456504ede Mon Sep 17 00:00:00 2001
> From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> Date: Sat, 29 Apr 2023 19:32:27 +0530
> Subject: [PATCH] Add an entry in imx8mm boards for Emtop SOM-IMX8MM
These looks just broken

> Added an entry to the list of imx8mm boards denoting the Emtop SOM-IMX8MM
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 442ce8f4d675..61f3beabb1d0 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -902,6 +902,7 @@ properties:
>                - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi / BT Modules
>                - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
>                - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
> +              - fsl,imx8mm-emtop          # i.MX8MM Emtop SOM
Wrong vendor? fsl is freescale AKA nxp, and this board is supposed to be
emtop.

Francesco

