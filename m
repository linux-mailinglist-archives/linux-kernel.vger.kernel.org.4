Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1362B61A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKPJKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiKPJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:10:34 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA3384;
        Wed, 16 Nov 2022 01:10:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id BB80DDFE60;
        Wed, 16 Nov 2022 01:10:32 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vwPmCZ4RRr4h; Wed, 16 Nov 2022 01:10:31 -0800 (PST)
Message-ID: <a1e854995fbeaf49e6cbdc8020574ac991da2b25.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1668589831; bh=I1CW3yeKCOsz2l81RMgsbGEjAHtcj+ErrbCvsdHHU54=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=roFt/u8MbYMccm6i8kirKiRPUqvwDxdsPC+Bx2vawtupBQppC4LUwDv63A6KnDyVB
         szHOnTaeW9uSlLg6+zr79OJXoEx0GsagbKolgi/3iWqKW0wUz5vvrvEy4fqeZ5Nz/Q
         9puD60PAdsBfqyxFWf16y1jMxT/NSzpSxzb+TCrUOcY4lXIvmWXO185N7du3ut4UxH
         v2HPUaItuuPMad5KDMt7Hufg01LUJRnFnUOHfXfbi/MsQ2AOqnCyIInPX+z1r+RoRb
         Jm1fwOQhabL082GcAp54ICoA/yHNXXz5cUK8swynsOD4ZXML5YlhWHMx8uEextwQgf
         pwCKejJ1xO+fA==
Subject: Re: [PATCH] arm64: dts: imx8mq: fix dtschema warning for imx7-csi
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        dev@lynxeye.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Nov 2022 10:10:25 +0100
In-Reply-To: <20220909083940.1554887-1-martin.kepplinger@puri.sm>
References: <20220909083940.1554887-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 09.09.2022 um 10:39 +0200 schrieb Martin Kepplinger:
> According to dtschema for the csi bridge, compatible is an enum and
> only one must be used. Fixing this removes the following warning:
> 
> compatible: 'oneOf' conditional failed, one must be fixed
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index e9f0cdd10ab62..a348169c40f15 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1184,7 +1184,7 @@ csi1_mipi_ep: endpoint {
>                         };
>  
>                         csi1: csi@30a90000 {
> -                               compatible = "fsl,imx8mq-csi",
> "fsl,imx7-csi";
> +                               compatible = "fsl,imx8mq-csi";
>                                 reg = <0x30a90000 0x10000>;
>                                 interrupts = <GIC_SPI 42
> IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&clk IMX8MQ_CLK_CSI1_ROOT>;
> @@ -1236,7 +1236,7 @@ csi2_mipi_ep: endpoint {
>                         };
>  
>                         csi2: csi@30b80000 {
> -                               compatible = "fsl,imx8mq-csi",
> "fsl,imx7-csi";
> +                               compatible = "fsl,imx8mq-csi";
>                                 reg = <0x30b80000 0x10000>;
>                                 interrupts = <GIC_SPI 43
> IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&clk IMX8MQ_CLK_CSI2_ROOT>;

hi Shawn and all interested in DTC warnings,

does this look ok to you? it should still apply. thank you,

                       martin


