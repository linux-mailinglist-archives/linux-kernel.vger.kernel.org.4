Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403E16D77E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjDEJPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDEJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5702D7D;
        Wed,  5 Apr 2023 02:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C56B9638E4;
        Wed,  5 Apr 2023 09:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB1C433D2;
        Wed,  5 Apr 2023 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680686111;
        bh=1WC5vJKuvluemVN0pPhdXxQ0pptk2co2rAHuQbcKB5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npzp0IapxWh2AC21LFOQLZpCmgK2L4U/NaHNpP/Fy9po3DwbKKR6LWB2do4soCC8v
         c3Zpxfvm1cBBonKB/NJ09lRt2BGDnXn+WbsQMGgt2mnuxX7YEBqDXO31TWbAMi68eS
         8T3LUQTHxM1Pa2qAbbGeDzZxQoR1istR9JHBv1qcAGire8SdiYZu8NUYyZ6tVJvZch
         Knd4e8KH3pBvnT3FtwWuGT3jBr9pfDBZouF+wDBl/GlN2eb+/crxCZI0oCBJWN9v3W
         xBa98ADF9Alsi+f9SqJ7q9ww6zqZpg1S72CiTtGgasVhWxm2V9CgAqD74gEpm3vMUL
         ZylnA/wFEkQgQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjzEz-00020g-0w; Wed, 05 Apr 2023 11:15:41 +0200
Date:   Wed, 5 Apr 2023 11:15:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <ZC08PfY+TN3+lBT4@hovoldconsulting.com>
References: <cover.1680682939.git.quic_varada@quicinc.com>
 <aaf44ceccef9c7b20a08b8c9fa534f99468f8856.1680682939.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf44ceccef9c7b20a08b8c9fa534f99468f8856.1680682939.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 02:26:42PM +0530, Varadarajan Narayanan wrote:
> Add USB phy and controller related nodes
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v6:
> 	- Introduce fixed regulators for the phy
> 	- Resolved all 'make dtbs_check' messages
 

> +		usb_0_qmpphy: phy@7d000 {
> +			compatible = "qcom,ipq9574-qmp-usb3-phy";
> +			reg = <0x0007d000 0xa00>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB0_AUX_CLK>,
> +				 <&xo_board_clk>,
> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				 <&gcc GCC_USB0_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "com_aux",

Looks like you just ignored my comment that you need to rename this
clock (and update the binding). :(

	https://lore.kernel.org/lkml/ZCaznloORtzgioOP@hovoldconsulting.com/

> +				      "pipe";
> +
> +			resets = <&gcc GCC_USB0_PHY_BCR>,
> +				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
> +			reset-names = "phy",
> +				      "phy_phy";
> +
> +			vdda-pll-supply = <&reg_usb_1p8>;
> +			vdda-phy-supply = <&reg_usb_0p925>;
> +
> +			status = "disabled";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "usb0_pipe_clk";
> +		};A

Johan
