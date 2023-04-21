Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707BE6EAC37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjDUOBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjDUOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:01:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A2E55;
        Fri, 21 Apr 2023 07:01:28 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54ED26603276;
        Fri, 21 Apr 2023 15:01:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682085687;
        bh=1vgwclP5B6vfVz7wXujyKjNoyVDTIACdOwUdXtZG1fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMON1N7KEo0dGRHeB/EiSYBZlhMPw0PYScmX0/QFGDPPFm+oWqrpAvR76ZxglqN+o
         NwyR7DrKTqyh2Wi++ziTgeKQX9wIcPovn7nnYxELH5D03DoKmCwinXpQmF5WmROY46
         wmw3xa7D4gf/HrbOiRWLyWOeobTzGJh0HrxLgNlVdDSB9zujcekTqpnP6VEjhSrYrW
         InfVmI/WgAuTgxPK4CnBkfecqVfYte4BGNHUL3w2Is9yenf0BlvKqPtloyYfYEibza
         uDZFA4GYDnAZjXmytM9CTjKWdwjXV62zGhbcQPDwRGWff6RtgzZUEj1kmlR9uvgT7Z
         OxKbvf+8rfYVg==
Date:   Fri, 21 Apr 2023 10:01:22 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192-asurada-hayato: Enable
 Bluetooth
Message-ID: <872e8b77-c1ea-410a-b978-dd8f49f9904b@notapiano>
References: <20230421110327.2395804-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421110327.2395804-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 07:03:27PM +0800, Chen-Yu Tsai wrote:
> Hayato's Realtek WiFi/BT module has it's Bluetooth function wired to
> UART1.
> 
> Add and enable the relevant device nodes for it.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> index 43a823990a92..6a7d7870525b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> @@ -40,9 +40,89 @@ CROS_STD_MAIN_KEYMAP
>  	>;
>  };
>  
> +&pio {
> +	bt_pins: bt-pins {
> +		bt_kill: pins-bt-kill {

Drop this label and for the other pinconfigs below as they'll never be
referenced.

> +			pinmux = <PINMUX_GPIO144__FUNC_GPIO144>; /* BT_KILL_L */

I'd also drop this and the other comments, as they're already documented in the
gpio-line-names property.

> +			output-low;
> +		};
> +
> +		bt_wake: pins-bt-wake {
> +			pinmux = <PINMUX_GPIO22__FUNC_GPIO22>;  /* bt to wake ap */
> +			bias-pull-up;
> +		};
> +
> +		ap_wake_bt: pins-ap-wake-bt {
> +			pinmux = <PINMUX_GPIO168__FUNC_GPIO168>; /* AP_WAKE_BT_H */
> +			output-low;
> +		};
> +	};
> +
> +	uart1_pins: uart1-pins {
> +		pins-rx {
> +			pinmux = <PINMUX_GPIO94__FUNC_URXD1>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-tx {
> +			pinmux = <PINMUX_GPIO95__FUNC_UTXD1>;
> +		};
> +
> +		pins-cts {
> +			pinmux = <PINMUX_GPIO166__FUNC_UCTS1>;
> +			input-enable;
> +		};
> +
> +		pins-rts {
> +			pinmux = <PINMUX_GPIO167__FUNC_URTS1>;
> +			output-enable;

Looks like the dt-binding doesn't currently support output-enable, but the
driver does, so please just add a patch with

          output-enable: true
	
on mediatek,mt8192-pinctrl.yaml

> +		};
> +	};
> +
> +	uart1_pins_sleep: uart1-pins-sleep {

"-pins" needs to come last in the name otherwise the dt-binding will complain.

> +		pins-rx {
> +			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +		pins-tx {
> +			pinmux = <PINMUX_GPIO95__FUNC_UTXD1>;
> +		};
> +		pins-cts {
> +			pinmux = <PINMUX_GPIO166__FUNC_UCTS1>;
> +			input-enable;
> +		};
> +		pins-rts {
> +			pinmux = <PINMUX_GPIO167__FUNC_URTS1>;
> +			output-enable;
> +		};
> +	};
> +};
> +
>  &touchscreen {
>  	compatible = "hid-over-i2c";
>  	post-power-on-delay-ms = <10>;
>  	hid-descr-addr = <0x0001>;
>  	vdd-supply = <&pp3300_u>;
>  };
> +
> +&uart1 {
> +	status = "okay";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-1 = <&uart1_pins_sleep>;
> +	/delete-property/ interrupts;
> +	interrupts-extended = <&gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&pio 94 IRQ_TYPE_EDGE_FALLING>;
> +
> +	bluetooth: bluetooth {

I'd also drop this label and only introduce it if/when needed.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> +		compatible = "realtek,rtl8822cs-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_pins>;
> +
> +		enable-gpios = <&pio 144 GPIO_ACTIVE_HIGH>;
> +		device-wake-gpios = <&pio 168 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&pio 22 GPIO_ACTIVE_LOW>;
> +	};
> +};
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
