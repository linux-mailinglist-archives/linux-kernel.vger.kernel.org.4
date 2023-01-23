Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F16678022
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjAWPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjAWPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:41:21 -0500
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 07:41:19 PST
Received: from out-67.mta0.migadu.com (out-67.mta0.migadu.com [IPv6:2001:41d0:1004:224b::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD52A152
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:41:19 -0800 (PST)
Date:   Mon, 23 Jan 2023 16:34:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1674488070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qa6ykdif3qPx60n5o/W3CrQiW/SVFhDTfRQq7YvN39Q=;
        b=I+1YPVl4ZXJkYR/A6IFAO9yGwLw1SDhN+vVTnMO0fqh2CvgQvL+P6biJdtUl4c6rbmBCiH
        UqCbPteCoOoWpyjL8Cmj1+gcPTJBZ1AJFkEGRlAAF8s+nQj95HdCNtFD2oWB1dhT/lkuc8
        Y6oO+AfVsJtk9cSFqRroX1U7Q487LP0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Subject: Re: [RFT 05/11] ARM: dts: exynos: add ports in HDMI bridge in
 Exynos4412 Midas
Message-ID: <Y86pA6xo9EttJJ6g@L14.lan>
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
 <20230120155404.323386-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120155404.323386-6-krzysztof.kozlowski@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see you have already merged this, but FWIW HDMI works as well as
before on exynos4412-i9300, so:

Tested-by: Henrik Grimler <henrik@grimler.se>

Longer explanation: HDMI output only works on i9300 if MHL cable is
attached before device boots, so probably bootloader sets up some
settings that the sii9234 driver does not handle (correctly) if cable
is hot plugged.

Best regards,
Henrik Grimler

On Fri, Jan 20, 2023 at 04:53:58PM +0100, Krzysztof Kozlowski wrote:
> The SII9234 HDMI bridge expects ports property:
> 
>   exynos4412-i9305.dtb: hdmi-bridge@39: 'ports' is a required property
>   exynos4412-i9305.dtb: hdmi-bridge@39: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index 8e1c19a8ad06..a626d33d1330 100644
> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> @@ -273,9 +273,16 @@ sii9234: hdmi-bridge@39 {
>  			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
>  			reg = <0x39>;
>  
> -			port {
> -				mhl_to_hdmi: endpoint {
> -					remote-endpoint = <&hdmi_to_mhl>;
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					mhl_to_hdmi: endpoint {
> +						remote-endpoint = <&hdmi_to_mhl>;
> +					};
>  				};
>  			};
>  		};
> -- 
> 2.34.1
> 
