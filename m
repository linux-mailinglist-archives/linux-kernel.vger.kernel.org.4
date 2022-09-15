Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFABA5B9D80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiIOOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiIOOkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:40:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6F1AF28
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:38:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e16so31204244wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6mZeceF7rfeZc7wJjrZqqoRnOO4JaL00mHNu2FRG14A=;
        b=vygv4IzQcLnnr7H8d8pLsom5/lZ9uzs+1LXwo7J04btfubOfqRNSKwnMvkrcnpjTii
         Weei4djnAVZ754kl7b6ogCd3lOAvaNmLBL8g5rdpzf657zQPdkx9nZf46TtmyQtVtBkD
         2gEwpMQvMAU5C0bq16V+gE2WzYzlAd4CnBNCP+uDXghtF9Tc24zxOgp/QquUfkMcfNJH
         kdy0ZYIcOPFkXhT4ehRR89DR6fzFeXHg80hNsLguczOUNrxV+qWkwOCNEe3IGiI3u6Ih
         p4r1KXU/PPLtEsYD5+3eIJEAIVjFC/KDV95eHQaBOjievWoNFP/7sDRhvQMoXNIpOL1r
         +FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6mZeceF7rfeZc7wJjrZqqoRnOO4JaL00mHNu2FRG14A=;
        b=yuTG1vUWvDFvIcHT8rZxuWa3AI2i45aONDzRpW8W/JsCTbcj4r4bYPl4f66YVmK+zV
         YQrQ+g7xq5kgRY3sen/R8Q2YiOWCJwuVgybdJ4RAxcoj4rxlPd0Ije9BxLyy0nv4MrZG
         /vQpUN2ANyrLXyElG1Nhsl9aZkPzuvBqRwWazrf3wRIwPMnMlxUYNHFKAXS4znEjsXEO
         ZGH+Vo0Q8YqxVhuBDHd30ewQO1PBbTKC0HdldaoXfNAUfYP7olwCYovMuG7lAZg+/JkY
         yPZXdfCNvZmf5p3Z0hQxak3T7GiTcz1R9NedofdvV3bpZ1HtdnocSkSqGhotxVpVMa7Z
         vlmQ==
X-Gm-Message-State: ACgBeo3LRjlgx5XU4PLdCHaa/68s2RyeV3ziVTuabU6jU274viJuyipY
        gP889yTp1ruNCuYS7wrkr2+IeQ==
X-Google-Smtp-Source: AA6agR4moNalga88Hitwb5FNf96LKA4F6ZPVlakO5ZVEyEVtBOcJf4hHJ/dslkC/QAR93cJHIAXdWQ==
X-Received: by 2002:adf:db44:0:b0:22a:56eb:927f with SMTP id f4-20020adfdb44000000b0022a56eb927fmr15358975wrj.627.1663252678566;
        Thu, 15 Sep 2022 07:37:58 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.72])
        by smtp.gmail.com with ESMTPSA id q123-20020a1c4381000000b003a84375d0d1sm3060464wma.44.2022.09.15.07.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 07:37:57 -0700 (PDT)
Message-ID: <aa728ce9-8d70-a497-8062-1320a583f28c@linaro.org>
Date:   Thu, 15 Sep 2022 15:37:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 9/9] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
 <20220910143213.477261-10-iskren.chernev@gmail.com>
 <20220913213007.gdk27nxjzmagbdzn@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913213007.gdk27nxjzmagbdzn@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 22:30, Bjorn Andersson wrote:
> On Sat, Sep 10, 2022 at 05:32:13PM +0300, Iskren Chernev wrote:
>> Add initial support for OnePlus Nord N100, based on SM4250. Currently
>> working:
>> - boots
>> - usb
>> - buildin flash storage (UFS)
>> - SD card reader
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 241 ++++++++++++++++++
>>  2 files changed, 242 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index f4126f7e7640..5d2570b600e0 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -137,6 +137,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> new file mode 100644
>> index 000000000000..b9094f1efca0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> @@ -0,0 +1,241 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
> 
> Would it be possible for you to dual license this?
> 
>> +/*
>> + * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm4250.dtsi"
>> +
>> +/ {
>> +	model = "OnePlus Nord N100";
>> +	compatible = "oneplus,billie2", "qcom,sm4250";
>> +
>> +	/* required for bootloader to select correct board */
>> +	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
>> +	qcom,board-id = <0x1000b 0x00>;
>> +
>> +	aliases {
>> +	};
>> +
>> +	chosen {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		stdout-path = "framebuffer0";
>> +
>> +		framebuffer0: framebuffer@9d400000 {
>> +			compatible = "simple-framebuffer";
>> +			reg = <0 0x5c000000 0 (1600 * 720 * 4)>;
>> +			width = <720>;
>> +			height = <1600>;
>> +			stride = <(720 * 4)>;
>> +			format = "a8r8g8b8";
>> +		};
>> +	};
>> +};
>> +
>> +&xo_board {
>> +	clock-frequency = <19200000>;
>> +};
>> +
>> +&sleep_clk {
>> +	clock-frequency = <32764>;
>> +};
>> +
>> +&reserved_memory {
> 
> As the number of nodes grow it would be nice if these were sorted
> alphabetically.
> 
>> +	bootloader_log_mem: memory@5fff7000 {
>> +		reg = <0x00 0x5fff7000 0x00 0x8000>;
>> +		no-map;
>> +	};
>> +
>> +	ramoops@cbe00000 {
>> +		compatible = "ramoops";
>> +		reg = <0x0 0xcbe00000 0x0 0x400000>;
>> +		record-size = <0x40000>;
>> +		pmsg-size = <0x200000>;
>> +		console-size = <0x40000>;
>> +		ftrace-size = <0x40000>;
>> +	};
>> +
>> +	param_mem: memory@cc200000 {
>> +		reg = <0x00 0xcc200000 0x00 0x100000>;
>> +		no-map;
>> +	};
>> +
>> +	mtp_mem: memory@cc300000 {
>> +		reg = <0x00 0xcc300000 0x00 0xb00000>;
>> +		no-map;
>> +	};
>> +};
>> +
>> +&usb3 {
>> +	status = "okay";
>> +};
> [..]
>> +&rpm_requests {
>> +	regulators-0 {
> 
> Is there a reason why you don't call this node pm6125-regulators ?

It's the follow up of:
https://lore.kernel.org/all/20220901093243.134288-1-krzysztof.kozlowski@linaro.org/

Node names should be rather generic, so just regulators.


Best regards,
Krzysztof
