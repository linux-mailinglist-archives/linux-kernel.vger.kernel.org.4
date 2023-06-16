Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217797336F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343695AbjFPQ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjFPQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:59:13 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4F24213;
        Fri, 16 Jun 2023 09:57:32 -0700 (PDT)
Received: from p5dcc3b18.dip0.t-ipconnect.de ([93.204.59.24] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qAClO-0003Fy-5M; Fri, 16 Jun 2023 18:57:30 +0200
Date:   Fri, 16 Jun 2023 18:57:28 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Josua Mayer <josua@solid-run.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add SolidRun LX2162A SoM &
 Clearfog Board
Message-ID: <20230616185728.7f0de1a3@aktux>
In-Reply-To: <5139b72e-cccb-43b3-ba37-35f0011e4a2b@solid-run.com>
References: <20230616110610.32173-1-josua@solid-run.com>
        <20230616110610.32173-3-josua@solid-run.com>
        <a9098664-ac16-eddb-3e2d-78eb08ac973f@linaro.org>
        <5139b72e-cccb-43b3-ba37-35f0011e4a2b@solid-run.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 16:32:01 +0300
Josua Mayer <josua@solid-run.com> wrote:

> HI Krzysztof,
> 
> Am 16.06.23 um 14:36 schrieb Krzysztof Kozlowski:
> > On 16/06/2023 13:06, Josua Mayer wrote:  
> >> Add DT compatible for SolidRun LX2162A SoM and Clearfog board.
> >>
> >> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >> ---
> >>   Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> >> index 15d411084065..438a4ece8157 100644
> >> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >> @@ -1373,9 +1373,11 @@ properties:
> >>         - description: SolidRun LX2160A based Boards
> >>           items:
> >>             - enum:
> >> +              - solidrun,clearfog
> >>                 - solidrun,clearfog-cx
> >>                 - solidrun,honeycomb
> >>             - const: solidrun,lx2160a-cex7
> >> +          - const: solidrun,lx2162a-som
> >>             - const: fsl,lx2160a  
> > You change existing entries, breaking boards and changing the meaning,
> > without any explanation in commit msg. That's not how it is done. Please
> > provide rationale in commit msg.  
> 
> I'm sorry. Given your comment I think I did not understand how these 
> entries are supposed to work.
> So perhaps you can provide some guidance based on my explanation?:
> 

it breaks:
arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dts
compatible = "solidrun,clearfog-cx",
                "solidrun,lx2160a-cex7", "fsl,lx2160a";

now you would require:
compatible = "solidrun,clearfog-cx",
                "solidrun,lx2160a-cex7", "solidrun,lx2162a-som", "fsl,lx2160a"

which is probably not what you want.

Regards,
Andreas
