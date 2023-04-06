Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D46D9FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbjDFScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbjDFSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:32:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BCAA26C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:32:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t14so41605230ljd.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680805960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb7AHlVzzDMUYgUKWXYiRLmXkdswaw+n2t+bRcy2/rg=;
        b=fqjOEAr1lUjhphcKWwklh6oWc9fP/hWg8Lzk+AugAVD+xDpjzY5VsPsm3zYdiH2MJo
         vyadlXylXGaG3UTtmIZQTqUGYTE8ztTvH3Sm0cXNfS2To3y4smrm8ckbXyFAXcWrAqsd
         ZzlvY2aO7qiHwAeelLI2LC786Cgs1rs3Q4fRhUc+kdsWu3ql15huNeTmAWMd4NNcOAoz
         BGxUE+Ig/l6IA0Ij7MpUfE9UW8EaP8YTBXJuXltMrdbcx1YJMgSlu37JXH6TgoN0cPp7
         FSvNLMqsW3i6UXzb5soW1A17XkQFnMgNlr4LdHsCkyg63D5lXZu3WQS4h7fXOsPN+dcL
         12bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb7AHlVzzDMUYgUKWXYiRLmXkdswaw+n2t+bRcy2/rg=;
        b=m1ELgOW83lP4r41IQ3Nb+ZAXsXXyhTfLvrBixixG684DMPIOruRYMrjSwsuS0fRlgf
         iu4VS1APxrdJmSxPWtma9fRNDDK1KrkuWtc/lsPHjMb0wzumBjB2Uo7leakz1xbeVZtQ
         u4rbeA3JvaAKg3OCR/g6RYrSYpjP9W1ZJ+Mi0Yd0U9LRMC42IrYtfndTaP9pqolmbBB4
         3frrRsrhEureY8QaGC5uQYY76v/K7C1FboWgoWDJUs0RTGGC0XEHYBY+Jcunu+SyVqpN
         bZaaDnt4y4PnR3TO+6CzijiVSJsa9nAQOstpTyoE3WQzkE0+3P2pZ0tnbrA9r984vlBy
         WI2Q==
X-Gm-Message-State: AAQBX9cax9sPifL6qVTxU0+37Fe1xV9XUF1KHrnJM3lARGQhx7O/fdOz
        QeyarkUYYsiRz40y9kn6pCKRXg==
X-Google-Smtp-Source: AKy350bBUgim2iNgD2sYabdzyBZz7uqHM8WGfuNvgZIC5MmNx80787Am4O9xaU3OYx332Z41SAoMCQ==
X-Received: by 2002:a2e:7814:0:b0:29d:ce75:5d06 with SMTP id t20-20020a2e7814000000b0029dce755d06mr3227238ljc.32.1680805960605;
        Thu, 06 Apr 2023 11:32:40 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id n9-20020a2e8789000000b00295a21c7954sm383798lji.50.2023.04.06.11.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:32:40 -0700 (PDT)
Message-ID: <bceb91fa-c94b-a0bf-a612-19fc5778810e@linaro.org>
Date:   Thu, 6 Apr 2023 20:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6115p-j606f: Enable ATH10K WiFi
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
 <20230406-topic-lenovo_features-v1-4-c73a5180e48e@linaro.org>
 <7476b5ba-426c-3701-c4aa-d3e2db3de112@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <7476b5ba-426c-3701-c4aa-d3e2db3de112@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 19:51, Dmitry Baryshkov wrote:
> On 06/04/2023 18:25, Konrad Dybcio wrote:
>> Enable the onboard QCA Wi-Fi. HW identifiers for reference:
>> qmi chip_id 0x320 chip_family 0x4001 board_id 0xff soc_id 0x400e0000
>>
>> Firmware sources:
>> /vendor/firmware_mnt/image/wlanmdsp.bin -> qcom/.../wlanmdsp.mbn
>> /vendor/firmware_mnt/image/bdwlan.bXX [1] -> [2] -> ath10k/.../board-2.bin
>> [3] -> ath10k/.../firmware-5.bin
>>
>> Not sure where 3 comes from on the device itself, gotta investigate that..
>>
>> According to [4], it's called WCN3990_STRAIT.
>>
>> [1] XX = board_id printed when the file is missing or by your downstream
>> kernel firmware loader in the dmesg; if XX=ff, use bdwlan.bin
> 
> Since the board_id is 0xff, please add qcom,ath10k-calibration-variant
Do I make up a name, or is there some convention?

I see Johan used "LE_X13S" in commit 2702f54f400ad3979632cdb76553772414f4c5e3.
Should I go with "LE_P11"?

> 
> Ideally, could you please send the bdwlan to ath10k for inclusion, see https://wireless.wiki.kernel.org/en/users/drivers/ath10k/boardfiles .
The legal situation is ambiguous at best :/

Konrad
> 
>>
>> [2] https://github.com/jhugo/linux/blob/5.5rc2_wifi/README
>> [3] https://github.com/kvalo/ath10k-firmware/blob/master/WCN3990/hw1.0/HL3.1/WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1/firmware-5.bin
>> [4] https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn/-/blob/LA.VENDOR.1.0.r1-20700-WAIPIO.QSSI13.0/hif/src/hif_hw_version.h#L55
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> index 2aac25171dec..4ba8e59a27d8 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> @@ -315,6 +315,14 @@ &usb_hsphy {
>>       status = "okay";
>>   };
>>   +&wifi {
>> +    vdd-0.8-cx-mx-supply = <&pm6125_l8>;
>> +    vdd-1.8-xo-supply = <&pm6125_l16>;
>> +    vdd-1.3-rfa-supply = <&pm6125_l17>;
>> +    vdd-3.3-ch0-supply = <&pm6125_l23>;
>> +    status = "okay";
>> +};
>> +
>>   &xo_board {
>>       clock-frequency = <19200000>;
>>   };
>>
> 
