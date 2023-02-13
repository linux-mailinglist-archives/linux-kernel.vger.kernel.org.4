Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1BD694607
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBMMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBMMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:39:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94B91BE2;
        Mon, 13 Feb 2023 04:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C18CB811B1;
        Mon, 13 Feb 2023 12:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE98C433D2;
        Mon, 13 Feb 2023 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676291944;
        bh=epz9p7oE3Yaw0AKI3I7gdt9KCzgEQvhn444XGIHRtuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjKebC9ToVjErn3KdrjkHdz/8PQarmJMlYCSR7KURgEESMnOB56e627CagWQoqm5/
         j7EoqapGGT9ciuECShtxAXe8Bg3QcUcIhz4IEZJeTujYHadGbFZ6xEIAATVDz7EvjZ
         blWmNjlx1Z9SDIsJ1X4j1BECg0q4hWy0XyvVax9G+UmrEe7D+LtSwifJ7tJGzEiYPX
         LApRvwPGf4uMD0gCNs5kKay8NcEcWRSK4UlzgT7jNGHu3BUtdHvcpQk2iFnnTYUwzh
         //lugEgN4FxmFjVRLhFUpkDZB70Rh9lOKE2aIocT0e5LWrc6auTFjtrGgHBt9NsBf/
         a3zkp7upRjUQw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pRY7e-0002cC-VN; Mon, 13 Feb 2023 13:39:55 +0100
Date:   Mon, 13 Feb 2023 13:39:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce
 pmic_glink
Message-ID: <Y+ovmtdRU83A+M5W@hovoldconsulting.com>
References: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
 <20230209011325.2603663-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209011325.2603663-3-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:13:23PM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SC8280XP CRD control over battery management and its two USB Type-C
> port using pmic_glink and two GPIO-based SBU muxes.
> 
> Enable the two DisplayPort instances, GPIO SBU mux instance and
> pmic_glink with the two connectors on the CRD.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Fixed style and property sort issues
> - Moved dwc3/port to sc8280xp.dtsi, override remote-endpoint here
> - Added pinconf properties to SBU control pins
> 
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 200 +++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    |   9 +
>  2 files changed, 207 insertions(+), 2 deletions(-)

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index fcd393444f47..0495361fc0fd 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3040,6 +3040,11 @@ usb_0_dwc3: usb@a600000 {
>  				iommus = <&apps_smmu 0x820 0x0>;
>  				phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				port {
> +					usb_0_role_switch: endpoint {
> +					};
> +				};
>  			};
>  		};
>  
> @@ -3095,6 +3100,10 @@ usb_1_dwc3: usb@a800000 {
>  				iommus = <&apps_smmu 0x860 0x0>;
>  				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";

Nit: Add a newline before the child node here.

> +				port {
> +					usb_1_role_switch: endpoint {
> +					};
> +				};
>  			};
>  		};

Johan
