Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10D76B8BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCNH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11F7B136;
        Tue, 14 Mar 2023 00:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD7D7615F1;
        Tue, 14 Mar 2023 07:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C95C433D2;
        Tue, 14 Mar 2023 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678778919;
        bh=4GeQYSSHLSd9LQKfwfmyBcLuTGZ+RhHXCZYk+FRulas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tb/K4ZDsX66Hj8OlwYAejz3v4AegpO49hXYtb60Pgxi9uAbo1HbH/sogCVA64Pg5D
         e1vTZLUzDys2D5nW1twHJknL1G/KGzwPDSrDTIDZEp8gacma40oAwTkPP57WKutly5
         /MD/+fo1e4rxFuGtRFBxjg2BXpCLBXyYxik5/mpw3yKTOwQMvZiaGZEyTg/hntOgwl
         BxRVit5IyTUJ1TNWuy2hoIvn1CMADCWiBgYyBZdzExfRhL1kN+2qcW1q/FXILUtrzY
         JXTXpbW5YqVo3QLslBSDv2OQ8BeZYHqoUa+07ta1Gqi80qsi8bt++/QO1eKeuT4Ltt
         GwWfowmLYM35Q==
Date:   Tue, 14 Mar 2023 15:28:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: Re: [PATCH v1 11/14] arm64: dts: imx8mq-librem5: Remove
 dis_u3_susphy_quirk from usb_dwc3_0
Message-ID: <20230314072832.GC143566@dragon>
References: <20230309204608.237605-1-martin.kepplinger@puri.sm>
 <20230309204608.237605-12-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309204608.237605-12-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 09:46:05PM +0100, Martin Kepplinger wrote:
> From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> 
> This reduces power consumption in system suspend by about 10%.

Is there any other impact than this nice power gain?  Otherwise,
I would wonder why the quirk was enabled in the first place.

Shawn

> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index 0b4b49fa1392a..f557632f574fa 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -1322,7 +1322,6 @@ &usb_dwc3_0 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  	dr_mode = "otg";
> -	snps,dis_u3_susphy_quirk;
>  	usb-role-switch;
>  	status = "okay";
>  
> -- 
> 2.30.2
> 
