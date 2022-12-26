Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F56562A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiLZMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZMqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:46:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F53C47;
        Mon, 26 Dec 2022 04:46:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i15so15418689edf.2;
        Mon, 26 Dec 2022 04:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsGoM9wrfrqSxjOB2TLHCV3vyYhdzPB5JRtWli8vvl0=;
        b=Q7K8OSd0+78QglTAYccZl3uIyE2NNuMF2wQ3hih1MHzEXNHMd9EOMv1iqFOq4OyJ8K
         MocTlZzejtOrtkurO23Bbxsih7K47QO95NPC0xxVMcJhcdFYvCaHPN9f62h12jmwUVHX
         5wbI+nd5vHIY+5GXOnUYqhCAwjBRJRUTDy3ywbqwexyE/TqcDUOUKzzED6Cn6O7KPTDi
         TZrKE1KIFgX1cnPkAhAz9lZqQvBT9myWDwk8hU/6JBl9HSn72FRtO5Zj+t+NUCHk3Qzv
         25LNw2gR6MVFTSI5MtTZznP53R2Ns333nVPpOeC/14pLI2Q4wha2Rha5GY1OWc1NyZQ9
         BFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsGoM9wrfrqSxjOB2TLHCV3vyYhdzPB5JRtWli8vvl0=;
        b=EnAG0P0U12fN4alqv5UpLmyEm5crbdxR3PkgMRL5goA99nLZtUa0uYTaz3OdtXY9/A
         WrlMdI6fJ9fsHCj/7QJ2r9WoR2HI3xokKj4thfrU4U7cxXaUziZLW7EIwdQYzEOIuybr
         ec0BhJPYwrw6ZDwp45YmyGx3syqWFEJ7LyzJZ3+utdHeYN7LuUycSdH49ovXp5sMyC9u
         kXjBb5syYqTspoAslnLWPwcCH3HBZTd3Z44jvMmxaUocCDtlmaBeyTyQ1MlPr5RTiQn5
         co1UylhfGiqgQTowi74SqtSjXAo93KG8NK+XHxrUvZREnttrr33xENFyUr/hQmKiAHMQ
         NY6g==
X-Gm-Message-State: AFqh2koV26QapQ5s+VURsZZaEr/e+c2Z1kzVb5HtqwiVhuL93kQayYbz
        Y3ZSTN+/i9/wylvfsXSz78g=
X-Google-Smtp-Source: AMrXdXtGQSNPam2o2K74D5fk+LjhpiGxspOsh6elxwY/2wQp/CsNRlRfHEswUYk8escDVHiRVGSvlg==
X-Received: by 2002:a05:6402:1486:b0:482:ab74:6432 with SMTP id e6-20020a056402148600b00482ab746432mr7735255edv.20.1672058789915;
        Mon, 26 Dec 2022 04:46:29 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id dm4-20020a05640222c400b004677b1b1a70sm4598433edb.61.2022.12.26.04.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 04:46:29 -0800 (PST)
Message-ID: <d0eafc59-6718-f904-132a-1a6dbd083878@gmail.com>
Date:   Mon, 26 Dec 2022 13:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv2 linux-next 4/4] ARM: dts: rockchip: rv1126: Enable
 Ethernet for Neu2-IO
To:     Anand Moon <anand@edgeble.ai>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221226063625.1913-1-anand@edgeble.ai>
 <20221226063625.1913-4-anand@edgeble.ai>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20221226063625.1913-4-anand@edgeble.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/26/22 07:36, Anand Moon wrote:
> Rockchip RV1126 has GMAC 10/100/1000M ethernet controller.
> Enable ethernet node on Neu2-IO board.
> 
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> ---
> drop SoB of Jagan Teki
> ---
>  arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts | 37 ++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> index dded0a12f0cd..bd592026eae6 100644
> --- a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> +++ b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> @@ -22,6 +22,43 @@ chosen {
>  	};
>  };
>  
> +&gmac {
> +	clock_in_out = "input";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmiim1_pins &clk_out_ethernetm1_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&phy>;

> +	assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
> +			<&cru CLK_GMAC_ETHERNET_OUT>;

align

> +	assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>, <&cru RGMII_MODE_CLK>;
> +	assigned-clock-rates = <125000000>, <0>, <25000000>;
> +	phy-supply = <&vcc_3v3>;
> +	tx_delay = <0x2a>;
> +	rx_delay = <0x1a>;
> +	status = "okay";
> +};
> +
> +&mdio {

> +	phy: phy@0 {

use ethernet-phy

no '#phy-cells' here

> +		compatible = "ethernet-phy-id001c.c916",
> +			       "ethernet-phy-ieee802.3-c22";

align

> +		reg = <0x0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&eth_phy_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pinctrl {

> +	ethernet {

Maybe use a node name more in line with where it is used.

> +		eth_phy_rst: eth-phy-rst {
> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
>  &sdmmc {
>  	bus-width = <4>;
>  	cap-mmc-highspeed;
