Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044776DA83C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 06:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjDGEUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 00:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjDGEUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 00:20:45 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DF16E82;
        Thu,  6 Apr 2023 21:20:43 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 30FD841352;
        Fri,  7 Apr 2023 09:20:40 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680841241; bh=ndOEKu6fIuDczEykR/dREXWWtJRtRlhJOZHnem7ucUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q11RIdziu0Is1lgJVSaou+GdEVQLYgzdGpOEd6FVY4+njvUc9u3xPpZXy/cf031Ap
         BI0iJ7/EYDja+4M/SuevQJRTq0I6VjCuyyggPOjtxjlpEK+Qc5KL4cZh740AnIgmLs
         VMpd3wqXd4SRfY8ea026Va9xZO0xN8nlTEBNZT77NzOXT7XARShqlsNHSW0qPJXjti
         9a/TAK4Xhq0LdmkR/aKcDoq4Ii7n5u7sDAB0K4tbN3u/TWWPbuBNM2NIXkeLXHyA5H
         jqAYtOVVl70ByY3M/E6FhjTnsHA0K2rlhpL3R1AZyGx0B8Z3N1jM253NlJH/v6Whz4
         qE1AN1vMg5ZQg==
MIME-Version: 1.0
Date:   Fri, 07 Apr 2023 09:20:40 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: Add Acer Aspire 1
In-Reply-To: <2edbb19a-aa0f-4ad7-2c83-e10f949b9d5c@linaro.org>
References: <20230406150633.83351-1-nikita@trvn.ru>
 <20230406150633.83351-5-nikita@trvn.ru>
 <2edbb19a-aa0f-4ad7-2c83-e10f949b9d5c@linaro.org>
Message-ID: <7c29b035be9653d6b1a1a4e3c31b107c@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 07.04.2023 00:34:
> On 6.04.2023 17:06, Nikita Travkin wrote:
>> Acer Aspire 1 is a WoA laptop based on Snapdragon 7c gen1 platform.
>>
>> The laptop design is similar to trogdor in the choice of primary
>> components but the specifics on usage of those differ slightly.
>>
>> Add the devicetree for the laptop with support for most of the
>> hardware present.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>> Changed in v2:
>>  - Various styling, ordering and node naming issues fixed. (Krzysztof)
>>
>> Changed in v3:
>>  - Kepp camcc on, wakeup on touchpad, minor style issues. (Konrad)
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>  .../boot/dts/qcom/sc7180-acer-aspire1.dts     | 859 ++++++++++++++++++
>>  2 files changed, 860 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index f6ff4024a60e..f0d92c47bc7f 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-acer-aspire1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>> new file mode 100644
>> index 000000000000..b4161f1f21a7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>> @@ -0,0 +1,859 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +
>> +#include "sc7180.dtsi"
>> +
>> +#include "pm6150.dtsi"
>> +#include "pm6150l.dtsi"
>> +
>> +/delete-node/ &tz_mem;
>> +/delete-node/ &ipa_fw_mem;
>> +
>> +/ {
>> +	model = "Acer Aspire 1";
>> +	compatible = "acer,aspire1", "qcom,sc7180";
>> +	chassis-type = "laptop";
>> +
>> +	aliases {
>> +		bluetooth0 = &bluetooth;
>> +		hsuart0 = &uart3;
>> +		serial0 = &uart8;
>> +		wifi0 = &wifi;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	reserved-memory {
>> +		zap_mem: zap-shader@80840000 {
>> +			reg = <0 0x80840000 0 0x2000>;
> Please use 0x0 consistently as you did below.
> 

Will do.

>> +			no-map;
>> +		};
>> +
>> +		venus_mem: venus@85b00000 {
>> +			reg = <0 0x85b00000 0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		mpss_mem: mpss@86000000 {
>> +			reg = <0x0 0x86000000 0x0 0x2000000>;
>> +			no-map;
>> +		};
>> +
>> +		adsp_mem: adsp@8e400000 {
>> +			reg = <0x0 0x8e400000 0x0 0x2800000>;
>> +			no-map;
>> +		};
>> +
>> +		wlan_mem: wlan@93900000 {
>> +			reg = <0x0 0x93900000 0x0 0x200000>;
>> +			no-map;
>> +		};
>> +	};
>> +
> 
> [...]
> 
>> +	sdc1_default: sdc1-default-state {
>> +		clk-pins {
>> +			pins = "sdc1_clk";
>> +			bias-disable;
>> +			drive-strength = <16>;
> drive-strength
> bias-
> 
> Just like you have in all other nodes, please.
> 

Will look through and fix.

Thanks for the review!

Nikita

> With that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>> +		};
>> +
>> +		cmd-pins {
>> +			pins = "sdc1_cmd";
>> +			bias-pull-up;
>> +			drive-strength = <16>;
>> +		};
>> +
>> +		data-pins {
>> +			pins = "sdc1_data";
>> +			bias-pull-up;
>> +			drive-strength = <16>;
>> +		};
>> +
>> +		rclk-pins {
>> +			pins = "sdc1_rclk";
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +	sdc1_sleep: sdc1-sleep-state {
>> +		clk-pins {
>> +			pins = "sdc1_clk";
>> +			bias-disable;
>> +			drive-strength = <2>;
>> +		};
>> +
>> +		cmd-pins {
>> +			pins = "sdc1_cmd";
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +
>> +		data-pins {
>> +			pins = "sdc1_data";
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +
>> +		rclk-pins {
>> +			pins = "sdc1_rclk";
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +	ter_mi2s_active: ter-mi2s-active-state {
>> +		pins = "gpio63", "gpio64", "gpio65";
>> +		function = "mi2s_2";
>> +	};
>> +};
