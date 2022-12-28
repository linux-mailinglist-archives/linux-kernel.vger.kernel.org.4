Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7565725B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiL1DdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiL1DdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:33:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A39E00A;
        Tue, 27 Dec 2022 19:33:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD060B8109D;
        Wed, 28 Dec 2022 03:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A14C433EF;
        Wed, 28 Dec 2022 03:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672198382;
        bh=OxYFzOxUddD53IoxgH6JG051kpj+BcBJ+9Mpo8HDiak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEXlyD5g+mFtRA2cM1mdUHTGTEgazk6SERcHP3xA5YWEAE4iHaRaIEW5oX//3dDgv
         bOgpnNWzebrP6OETwArgTHByz+xXgrqEJ0/sfobogNufdBeOLQ+ukUK5TYYmaO35DC
         r5EUFupMsrvNyPAx6xKyl8Gx1MvJoemmoTAQODy9J70F+hu0dNbLzL03JNsPGpBCIk
         6pvP6/EnJMdGEpOCWu8k8RJf2ENL/BLREDHOPLhGNS0CMryeJnZ5hH9umOIAGI5Ayp
         V+Nsh5J065k7gLpBaaPaopDKNEMZ61Xw6HHe/T3TIxK/vQlUbWlYXb48PSgv++c7yr
         62a/rwQKmyjNA==
Date:   Tue, 27 Dec 2022 21:32:59 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     swboyd@chromium.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mka@chromium.org, Yunlong Jia <ecs.beijing2022@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sc7180: Add pazquel360
 touschreen
Message-ID: <20221228033259.vdajrkgxl5sy2ete@builder.lan>
References: <20221209171240.1614904-1-dianders@chromium.org>
 <20221209091234.v3.4.Id132522bda31fd97684cb076a44a0907cd28097d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209091234.v3.4.Id132522bda31fd97684cb076a44a0907cd28097d@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 09:12:40AM -0800, Douglas Anderson wrote:
> The touchscreen was supposed to have been added when pazquel360 first
> was added upstream but was missed. Add it now.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v3:
> - Removed hid-descr-addr
> 
>  .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> index 5702325d0c7b..ff9dd6857f8b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> @@ -14,6 +14,25 @@ &alc5682 {
>  	realtek,dmic-clk-rate-hz = <2048000>;
>  };
>  
> +ap_ts_pen_1v8: &i2c4 {
> +	status = "okay";

I'm told that we want status to be the last property, so I moved it
one step down as I applied the patch.

Thanks,
Bjorn

> +	clock-frequency = <400000>;
> +
> +	ap_ts: touchscreen@10 {
> +		compatible = "elan,ekth3915", "elan,ekth3500";
> +		reg = <0x10>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +
> +		vcc33-supply = <&pp3300_ts>;
> +		vccio-supply = <&pp1800_l10a>;
> +		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
>  &keyboard_controller {
>  	function-row-physmap = <
>  		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog
> 
