Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB57C6EF06B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbjDZIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbjDZIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:46:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A449EDA;
        Wed, 26 Apr 2023 01:46:53 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 813D166032A7;
        Wed, 26 Apr 2023 09:46:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682498812;
        bh=MIvypk/ABXRS6CkQmUf5Gqt/bwzeB1sNeZv/ERfJSDU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ALh0W156IH1Nx33oly0SGgoCItZYpLTyGen+40TGR2AL+WKyNGa7tuWkft6Wmzbg+
         X9VRSMsRc1u7z2xGEFL8cRQeHfq33j6l1LK3WatZ71b4vtmZyhnYUTIUtsb0YgtFG1
         5Q2/w6wiqZtB7q2p58mdWekJqBruEBiA0o0710VpP7wyHyPgKKUY/kAXxxfAN9qYvv
         hHdap9S0gBEU8rtNr9cl0eNM1ti3BkrtC2CS5wqvfNfSsitXffHa6Qjj4PILsWkwwn
         J0FW8hW/9jgXUw5HVNnCXsVKPLPSsExCF7/UYmw4f5HkdzkJp65kpzIvL7CoYhxOQo
         vrptfWDWLfmHg==
Message-ID: <f7a2c3f7-5a25-07ed-0c77-e87e40a7d88a@collabora.com>
Date:   Wed, 26 Apr 2023 10:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: cherry: Configure eDP and
 internal display
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
 <20230424112523.1436926-4-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EHAGMYE7Z-n6Wtss-sXXa0Rvv=jkse2sqyTOtGYpqR-A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EHAGMYE7Z-n6Wtss-sXXa0Rvv=jkse2sqyTOtGYpqR-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/04/23 10:24, Chen-Yu Tsai ha scritto:
> On Mon, Apr 24, 2023 at 7:25 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add the required nodes to enable the DisplayPort interface, connected
>> to the Embedded DisplayPort port, where we have an internal display.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 32 +++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> index 4229f4f7dc2f..adbda4dccdd5 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> @@ -47,6 +47,18 @@ memory@40000000 {
>>                  reg = <0 0x40000000 0 0x80000000>;
>>          };
>>
>> +       pp3300_disp_x: regulator-pp3300-disp-x {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "pp3300_disp_x";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               enable-active-high;
>> +               gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&panel_fixed_pins>;
>> +               regulator-always-on;
> 
> I think you missed my comment on v1 about this regulator's supplier and
> enable delay.
> 

Sorry, it wasn't my intention to ignore that. Will check that out and
push a v3 asap.

> ChenYu
> 
>> +       };
>> +
>>          /* system wide LDO 3.3V power rail */
>>          pp3300_z5: regulator-pp3300-ldo-z5 {
>>                  compatible = "regulator-fixed";
>> @@ -288,6 +300,20 @@ port@1 {
>>                          reg = <1>;
>>                          edp_out: endpoint {
>>                                  data-lanes = <0 1 2 3>;
>> +                               remote-endpoint = <&panel_in>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       aux-bus {
>> +               panel {
>> +                       compatible = "edp-panel";
>> +                       power-supply = <&pp3300_disp_x>;
>> +                       backlight = <&backlight_lcd0>;
>> +                       port {
>> +                               panel_in: endpoint {
>> +                                       remote-endpoint = <&edp_out>;
>> +                               };
>>                          };
>>                  };
>>          };
>> @@ -927,6 +953,12 @@ pins-cs {
>>                  };
>>          };
>>
>> +       panel_fixed_pins: panel-pwr-default-pins {
>> +               pins-vreg-en {
>> +                       pinmux = <PINMUX_GPIO55__FUNC_GPIO55>;
>> +               };
>> +       };
>> +
>>          pio_default: pio-default-pins {
>>                  pins-wifi-enable {
>>                          pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
>> --
>> 2.40.0
>>
>>

