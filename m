Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB80734199
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbjFQOP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjFQOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:15:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EFA1BD1;
        Sat, 17 Jun 2023 07:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687011310; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UiLias+d1CKFQudf7HvmdiB29NDf1GbdStqyFgAEf9oSLAD6lAyDREP0Kpb1+3bp6R
    trlYmzzi36/KUZud0raGEuvD9sOjcB8YoUFoOMQNUz6AX4N+9baxPMAHIgSXpn0Pib8q
    H+HCmNK8UPB5boLYYSFbNs7GvtzMqk3YXXjcedankQGMtnFv6/REGgfZtNQ7Rcr1FaAd
    hOM8rTJAvk4QsUZNWax4ce6//4Usg/sb9akXihNgrNQtXDpH/yEGBXchaOT3Prt8E0Tv
    2iLdBCh9ehNzmrcNnIgqPOlECKrUv8uOEQfuHCLkwM3V/OXEo4dejQ+FIMfcb7F80wGy
    iDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687011310;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y0b7he3HXOLqe7VbS+H+PIvkibqHGVaV+hOty/itXJY=;
    b=i7oyBJptOC72RfTg787sy7RLdtClSB6CdRArbk7C1JTDlnC39FPFbOpPILa2qZ42h3
    49lOGT1PD7H8iXW7K34FAqnreLNJkXhDL9pdkDrylIV1/x6/TJJaDFOUQcrE82tONKZY
    Ybd+mfTeKD93ooLL1p95FNUJk/vAQtJbm8NRXI2//KL0OvJGuSB24GLH0SfTrpzDgqkb
    dqhDuH+sJvB/JoGMX6QiuBEDcDhdugu6uU40lE6quzY39z9jqTy3vQqcO5OUXUo9Wfk7
    ReSxrPOLp8J9yxSGm3NJVuKq3Ra1tqNZ/Qair/9lgGv3pPqHfx5fZCYL7GnQ9+VsSCeJ
    hbcw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687011310;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y0b7he3HXOLqe7VbS+H+PIvkibqHGVaV+hOty/itXJY=;
    b=Mw3xpHOgdAXOTj3RbzSJdMwNiE5Emj10hxklRy++KFFnWaooYHeArdxBn4il3PioRP
    rPn7snv7U1pYiCLhnYhNIIZG97rgI7tGmFJuvaiBw/7xvQUewA6sUM2vYdKQ0/Fx3V2V
    J/uXEZY0qt++ZGpMDM4hmctGmyysLuWSAeraUhJDJ67R7l7oDkCApwpZd0/vS7OrM2Rn
    anFDo/YbG2SPTZhgJ5JsXAlhNqj4GGcbpu1EdUAmLnJxvOxGstNpC7GreJhsGNrFx+EA
    WthgnnB676j/yUiToRg6S1etVr1zzxKtzWcCnqI5k57LjYKOnZEIeBvu8aGegrzzkLzJ
    e6pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687011310;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y0b7he3HXOLqe7VbS+H+PIvkibqHGVaV+hOty/itXJY=;
    b=DksqII6+OZ1i49BQBKI11R4ZINk9g3AHXe1YsF7OgSDZccsyASYrWFFnUDfoXf4d9R
    LJN/H6EVDwTXI8p3eKCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+pvh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5HEF98GB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 17 Jun 2023 16:15:09 +0200 (CEST)
Date:   Sat, 17 Jun 2023 16:15:03 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RESEND] arm64: dts: qcom: msm8916-samsung-serranove: Add
 RT5033 PMIC with charger
Message-ID: <ZI2_565RFDtR3Sa-@gerhold.net>
References: <20230617002934.39408-1-jahau.ref@rocketmail.com>
 <20230617002934.39408-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617002934.39408-1-jahau@rocketmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 02:29:34AM +0200, Jakob Hauser wrote:
> For the regulators, apply the same settings as in the downstream
> devicetree [1], including the "regulator-always-on" for the SAFE_LDO.
> For the voltage of SAFE_LDO, however, there is only one voltage of 4.9 V
> available in the mainline driver [2][3].
> 
> The values of the battery data evolve from following sources:
> - precharge current: 450 mA corresponds to the default value of the chip. It
>   doesn't get changed by the downstream Android driver. Therefore let's stick
>   to this value.
> - constant charge current: The 1000 mA are taken from the downstream devicetree
>   of the serranove battery. It's not easy to spot. The value is in the line
>   "input_current_limit" [4]. The rows are according to the power supply type,
>   the 4th value stands for "main supply" [5]. That's the value used by the
>   Android driver when a charging cable is plugged into the device.
> - charge termination current: In the downstream devicetree of the battery
>   that's the line "full_check_current_1st", which contains the 150 mA [6].
> - precharge voltage: This one doesn't get set in the downstream Android driver.
>   The chip's default is 2.8 V. That seemed too low to have a notable effect of
>   handling the battery gentle. The chosen value of 3.5 V is a bit arbitrary
>   and possibly rather high. As the device is already several years old and
>   therefore most batteries too, a value on the safe side seems reasonable.
> - constant charge voltage: The value of 4.35 V is set in the line
>   "chg_float_voltage" of the downstream battery devicetree [7].
> 
> The "connector" sub-node in the extcon node, the "battery" node in the
> general section and the line "power-supplies" in the fuel-gauge node result
> from the way of implementation documented in the dt-bindings of
> rt5033-charger [8] and mfd rt5033 [9].
> 
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-eur-r03.dtsi#L135-L181
> [2] https://github.com/torvalds/linux/blob/v6.3/include/linux/mfd/rt5033-private.h#L211-L212
> [3] https://github.com/torvalds/linux/blob/v6.3/drivers/regulator/rt5033-regulator.c#L83
> [4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L100
> [5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/include/linux/power_supply.h#L173-L177
> [6] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L102
> [7] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L95
> [8] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml?h=next-20230616
> [9] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml?h=next-20230616
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> The patch is based on linux-next "next-20230616".
> 
> The driver rt5033-charger was just recently added to linux-next.
> 
> RESEND because I used an outdated e-mail address of Bjorn before.
> 
>  .../dts/qcom/msm8916-samsung-serranove.dts    | 67 ++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> index 15dc246e84e2..2114d26548db 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> [...]
> @@ -261,6 +278,46 @@ touchscreen@20 {
>  	};
>  };
>  
> +&blsp_i2c6 {
> +	status = "okay";
> +
> +	pmic@34 {
> +		compatible = "richtek,rt5033";
> +		reg = <0x34>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_default>;
> +
> +		regulators {
> +			safe_ldo_reg: SAFE_LDO {
> +				regulator-name = "SAFE_LDO";
> +				regulator-min-microvolt = <4900000>;
> +				regulator-max-microvolt = <4900000>;
> +				regulator-always-on;
> +			};
> +			ldo_reg: LDO {
> +				regulator-name = "LDO";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +			buck_reg: BUCK {
> +				regulator-name = "BUCK";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +			};

The "regulator-name"s here don't really seem useful, since they're just
the same as the ones already declared in the driver. Can you drop them?
Alternatively you could assign more useful board-specific names, such as
the CAM_SENSOR_A2.8V that was used downstream.

Also, I think it would be slightly clearer to prefix the regulator
labels (safe_ldo_reg, ldo_reg etc) with rt5033_. Perhaps
"rt5033_ldo_reg" or "rt5033_reg_ldo"?

Thanks,
Stephan
