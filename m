Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0859F6F6526
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEDGh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEDGhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:37:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D3212F
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:37:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f139de8cefso7256685e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683182271; x=1685774271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cV8SP0+conCgx/kMvroC2TvkC/2RNEpRSHVn27JyaQ=;
        b=yX/SCba83ivAxFAZ8MnyrgBx4MI4DBaQZihlnd7jDunSUKbokGB9CJ4RAE80GcJXC3
         ALsl/72RTOxmA9XLvJNo9VYxjgT29+sDRxOJ9f2iWVyaPOKGn2bIpf5MwTB1O5Dbmc7+
         KoDswCoFDMgBUmBv1SWZJl8OGVEOpFu6M0xTu20a1yR7NwoIrsULFMRpICAS9VxbI56e
         OW+m0n6fxcI3lKQ4v8fTKoEgGSyRRlpHXzpXrq58F6wxPScBSg3JbBq4ZjSPecP92t8+
         JnEQsW25Q+YNi2Go6a7IjULFCW29zSpY/iTJS3vUzrg8RT4bl4XK/6UPyywahHX44N6E
         QjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683182272; x=1685774272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cV8SP0+conCgx/kMvroC2TvkC/2RNEpRSHVn27JyaQ=;
        b=AgMtckBZVLKoxa25XXE4zHIFXihNYNID8c8vaBbWZz4kF5/dO9VLldK0QekjvvQTVE
         QYyAXMmaOYVqN/l0MSXsYY2KiarM6LY9EE30VSfSe3N11o1R6XXziSv85Q7F7msm0tru
         2fKTOHP3X7lwkshhLcaqOLAlKjeA1eN2/+ciStJqp4ePS7VI9XI9Qn+6vYKSo9AfPELe
         /AWJBo+nz8ASC3H5MHaUv5THoLqyLNveUe07z9OI2wdRvKyvhXsv9KRevbe4UNhCaBUU
         l6YGjsCkx+5vgUsheg9ZvdhQmNBcsRxc9DULVT8cN2aJNgNdeCd15HeMMBcDtE7Iees7
         Ku+Q==
X-Gm-Message-State: AC+VfDxpR1k87UITYBRMuFFOkwjMsfqH0ON7zwJ3v8WhmZnfGm3u87tR
        FTON6QKm9dGAZpTBLQXgESy/pA==
X-Google-Smtp-Source: ACHHUZ7kkw0BxUkuVNZ7g+5icqsDpZOtvyVf5kIlR56RmZTwZalTK7LSACtrs4sppfaClARaY2bm5Q==
X-Received: by 2002:a05:6512:24e:b0:4ee:fdd8:a536 with SMTP id b14-20020a056512024e00b004eefdd8a536mr1225936lfo.8.1683182271668;
        Wed, 03 May 2023 23:37:51 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id k26-20020ac2457a000000b004f11eb32f20sm2145325lfm.13.2023.05.03.23.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:37:51 -0700 (PDT)
Message-ID: <ce92c0b0-adb1-ffe0-e812-6b4532209c81@linaro.org>
Date:   Thu, 4 May 2023 08:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 8/9] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-9-quic_kriskura@quicinc.com>
 <8c8a7c25-9eae-7ded-61ce-2ce22b7b76dc@linaro.org>
 <c2a747d4-57d3-61e9-69db-c94ccc6fd5cf@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c2a747d4-57d3-61e9-69db-c94ccc6fd5cf@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.05.2023 05:55, Krishna Kurapati PSSNV wrote:
> 
> 
> On 5/2/2023 4:36 PM, Konrad Dybcio wrote:
>>
>>
>> On 1.05.2023 16:34, Krishna Kurapati wrote:
>>> Enable tertiary controller for SA8295P (based on SC8280XP).
>>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 47 ++++++++++++++++++++++++
>>>   1 file changed, 47 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> index fd253942e5e5..7e6061c43835 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> @@ -584,6 +584,19 @@ &usb_1_qmpphy {
>>>       status = "okay";
>>>   };
>>>   +&usb_2 {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&usb2_en_state>,
>>> +            <&usb3_en_state>,
>>> +            <&usb4_en_state>,
>>> +            <&usb5_en_state>;
>> This is misaligned. Also, please do property-n before property-names.
>>
>>> +    status = "okay";
>>> +};
>>> +
>>> +&usb_2_dwc3 {
>>> +    dr_mode = "host";
>>> +};
>>> +
>>>   &usb_2_hsphy0 {
>>>       vdda-pll-supply = <&vreg_l5a>;
>>>       vdda18-supply = <&vreg_l7g>;
>>> @@ -729,3 +742,37 @@ wake-n-pins {
>>>           };
>>>       };
>>>   };
>>> +
>>> +&pmm8540c_gpios {
>>> +    usb2_en_state: usb2-en-state {
>>> +        pins = "gpio9";
>>> +        function = "normal";
>>> +        output-high;
>>> +        power-source = <0>;
>> No drive-strength values?
>>
>> Konrad
> 
> Hi Konrad,
> 
>  TBH, I didn't add the drive strength values as things worked out of the box with the current changes (may be the default value of drive strength is sufficient for us).
> 
> Let me know if it is mandatory, I will add it up in the next version.
It's not, but it helps eliminate one more potential inconsistency

Konrad
> 
> Regards,
> Krishna,
> 
>>> +    };
>>> +};
>>> +
>>> +&pmm8540e_gpios {
>>> +    usb3_en_state: usb3-en-state {
>>> +        pins = "gpio5";
>>> +        function = "normal";
>>> +        output-high;
>>> +        power-source = <0>;
>>> +    };
>>> +};
>>> +
>>> +&pmm8540g_gpios {
>>> +    usb4_en_state: usb4-en-state {
>>> +        pins = "gpio5";
>>> +        function = "normal";
>>> +        output-high;
>>> +        power-source = <0>;
>>> +    };
>>> +
>>> +    usb5_en_state: usb5-en-state {
>>> +        pins = "gpio9";
>>> +        function = "normal";
>>> +        output-high;
>>> +        power-source = <0>;
>>> +    };
>>> +};
