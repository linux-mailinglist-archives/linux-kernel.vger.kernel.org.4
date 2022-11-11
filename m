Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3762562F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiKKJGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiKKJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:05:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68951122;
        Fri, 11 Nov 2022 01:05:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j15so5637932wrq.3;
        Fri, 11 Nov 2022 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QviO7g0X9TaU2BPfKXn+/uDSwn9+ZcxkSHMkagSvBQ=;
        b=XH7/0SMYFxcygZBP/lXF+7e071JADn9twF2Wzsu12Te92AbupuMte1rSifd+asp7zY
         m7ZZ2eKEOK8HhQYGiAIqYQXpyRljjlMXVfstuvWKERhG3gJnDgdSPB0K8JXrnxD7Kk+2
         0uvQRV5C4MFPOSgA3jhqSBPaS6l98ohw1nHuLHRipMSzEGVI1B4c58RM9TlM7AoMx4k3
         ZXbg1AUUduuFtWLNmWmPNDUVr4kUejMwnwFQbbRq05nZf+zu49I/dY+T8ZITK51DPGYk
         f2IFeKYc/YOR4Q7vTpztl13WvEtiOCY5uInpO9olCCpTD7yIboP4gupAqNBm1IvPUfbk
         lxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QviO7g0X9TaU2BPfKXn+/uDSwn9+ZcxkSHMkagSvBQ=;
        b=J0FT3CbVSjIkDQGtskRBtJiRgvlFHSYy/SQ2G5D4uMKJCOawgCdA4q0cVqBoqXP2jL
         hT8C6XUu3hH1tFt3Jtvj8xw1th5ys1uMePUkZJTtfxqbRuMHZ15At1AKiZmDrFeZFa04
         5IsgBNLEVV6Sgkr0mcHN42vC4XmudVJ0xtQ6MkWOUOAoUpNyCKhbdVJkyOgGiHT+7nsm
         z4dt2PDDDPN8JXlFJSshISGJaLDVDQYSh905OVh5BWoo3zl4R1vLPnj1T0hrUIWyiQv3
         XYJxkg/IroJAmCr7Wvqno65flGBJbNvH9QYiUR2XeUipJE34bXoGzPoCWhIV/DVXJAjH
         gL2Q==
X-Gm-Message-State: ANoB5pnE8rYmy9BUth+/O8JLMV2klXUv4qeD/y9nYKCJQOcZ0FtEExV+
        qQf9nT59pAksfidypXLVadc=
X-Google-Smtp-Source: AA0mqf63UJilBtZakUaPTB0dgbaIiRLdllAsQExluAwwAkE1d1Fc1dH/wnYZ/0v9nOHk7xNr/uBT4g==
X-Received: by 2002:a5d:4841:0:b0:22e:38b:95ff with SMTP id n1-20020a5d4841000000b0022e038b95ffmr610851wrs.202.1668157540379;
        Fri, 11 Nov 2022 01:05:40 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p25-20020a05600c1d9900b003c64c186206sm2203693wms.16.2022.11.11.01.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 01:05:38 -0800 (PST)
Message-ID: <a9273083-eb34-6415-132a-621ec7703d92@gmail.com>
Date:   Fri, 11 Nov 2022 10:05:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v3 01/11] arm64: dts: mt7986: harmonize device node order
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-2-linux@fw-web.de>
 <d38f8b81-b62e-18c5-1bd3-d1bc1f2b98d9@gmail.com>
In-Reply-To: <d38f8b81-b62e-18c5-1bd3-d1bc1f2b98d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 09:55, Matthias Brugger wrote:
> 
> 
> On 06/11/2022 09:50, Frank Wunderlich wrote:
>> From: Sam Shih <sam.shih@mediatek.com>
>>
>> This arrange device tree nodes in alphabetical order.
>>
>> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Applied, thanks!
> 

I realized that
wed_pcie: wed-pcie@10003000
is'nt ordered correctly. Please send a follow-up patch to fix that.

Regards,
Matthias

>> ---
>> i modified sams patch
>>
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20220427124741.18245-2-sam.shih@mediatek.com/
>>
>> by moving pio-node up instead of moving uarts down to ensure alphabetical
>> order for switch-/wifi-node.
>>
>> And moved uart0 and wifi in mt7986b-rfb too.
>> ---
>>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 94 ++++++++++----------
>>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 22 ++---
>>   2 files changed, 58 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts 
>> b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>> index afe37b702eef..6189436fe31d 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
>> @@ -54,6 +54,53 @@ switch: switch@0 {
>>       };
>>   };
>> +&pio {
>> +    uart1_pins: uart1-pins {
>> +        mux {
>> +            function = "uart";
>> +            groups = "uart1";
>> +        };
>> +    };
>> +
>> +    uart2_pins: uart2-pins {
>> +        mux {
>> +            function = "uart";
>> +            groups = "uart2";
>> +        };
>> +    };
>> +
>> +    wf_2g_5g_pins: wf-2g-5g-pins {
>> +        mux {
>> +            function = "wifi";
>> +            groups = "wf_2g", "wf_5g";
>> +        };
>> +        conf {
>> +            pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
>> +                   "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
>> +                   "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
>> +                   "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
>> +                   "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
>> +                   "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
>> +                   "WF1_TOP_CLK", "WF1_TOP_DATA";
>> +            drive-strength = <4>;
>> +        };
>> +    };
>> +
>> +    wf_dbdc_pins: wf-dbdc-pins {
>> +        mux {
>> +            function = "wifi";
>> +            groups = "wf_dbdc";
>> +        };
>> +        conf {
>> +            pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
>> +                   "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
>> +                   "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
>> +                   "WF0_TOP_CLK", "WF0_TOP_DATA";
>> +            drive-strength = <4>;
>> +        };
>> +    };
>> +};
>> +
>>   &switch {
>>       ports {
>>           #address-cells = <1>;
>> @@ -121,50 +168,3 @@ &wifi {
>>       pinctrl-0 = <&wf_2g_5g_pins>;
>>       pinctrl-1 = <&wf_dbdc_pins>;
>>   };
>> -
>> -&pio {
>> -    uart1_pins: uart1-pins {
>> -        mux {
>> -            function = "uart";
>> -            groups = "uart1";
>> -        };
>> -    };
>> -
>> -    uart2_pins: uart2-pins {
>> -        mux {
>> -            function = "uart";
>> -            groups = "uart2";
>> -        };
>> -    };
>> -
>> -    wf_2g_5g_pins: wf-2g-5g-pins {
>> -        mux {
>> -            function = "wifi";
>> -            groups = "wf_2g", "wf_5g";
>> -        };
>> -        conf {
>> -            pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
>> -                   "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
>> -                   "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
>> -                   "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
>> -                   "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
>> -                   "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
>> -                   "WF1_TOP_CLK", "WF1_TOP_DATA";
>> -            drive-strength = <4>;
>> -        };
>> -    };
>> -
>> -    wf_dbdc_pins: wf-dbdc-pins {
>> -        mux {
>> -            function = "wifi";
>> -            groups = "wf_dbdc";
>> -        };
>> -        conf {
>> -            pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
>> -                   "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
>> -                   "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
>> -                   "WF0_TOP_CLK", "WF0_TOP_DATA";
>> -            drive-strength = <4>;
>> -        };
>> -    };
>> -};
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts 
>> b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
>> index 3443013b5971..7459ddb6b6f0 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
>> @@ -25,10 +25,6 @@ memory@40000000 {
>>       };
>>   };
>> -&uart0 {
>> -    status = "okay";
>> -};
>> -
>>   &eth {
>>       status = "okay";
>> @@ -99,13 +95,6 @@ fixed-link {
>>       };
>>   };
>> -&wifi {
>> -    status = "okay";
>> -    pinctrl-names = "default", "dbdc";
>> -    pinctrl-0 = <&wf_2g_5g_pins>;
>> -    pinctrl-1 = <&wf_dbdc_pins>;
>> -};
>> -
>>   &pio {
>>       wf_2g_5g_pins: wf-2g-5g-pins {
>>           mux {
>> @@ -138,3 +127,14 @@ conf {
>>           };
>>       };
>>   };
>> +
>> +&uart0 {
>> +    status = "okay";
>> +};
>> +
>> +&wifi {
>> +    status = "okay";
>> +    pinctrl-names = "default", "dbdc";
>> +    pinctrl-0 = <&wf_2g_5g_pins>;
>> +    pinctrl-1 = <&wf_dbdc_pins>;
>> +};
