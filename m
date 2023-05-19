Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9876F70A351
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjESX0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjESX0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:26:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8461BD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:26:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2451b3f1so14659941fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684538763; x=1687130763;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/ov4pxRxJ4QbWDTCVaG66K0GULJXTSbVWYDGbvGsAg=;
        b=LaNjTC+Q05a85D6fFDrs/2WUzSWkuXLN8bDf+Oo/tuTyIsyQ6jT18e6TspMLyUQHTz
         7uG/c0Jz/FbkcPTG333CXHYFChwg5NT7+iTPE1vdPfn9Z1hPyYOqnSPDVCT/UKjkidVl
         +nTAcA6Z7iT6K9/C7NzJt/FEo9QEom/L5fufdg7pm8NH7T5IXAEvoiHucoOo6annnfO+
         iLUeS9ZTUGXbplF1QWKXWeeMH1VoKpCk/HX7HrCXA75aDCb7Cuar2eJG0X7uLHZUR4Y8
         c1yEtaMm27smg50Z+9WHv0/w14i6/6q7nwhUEn2NUkdzX+TYDRgVJjKed1iCb1kc3yAa
         Jpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684538763; x=1687130763;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ov4pxRxJ4QbWDTCVaG66K0GULJXTSbVWYDGbvGsAg=;
        b=Ucvl6Lp0kYA4/DFUU0qW90ev+ABGm6UgBAcAJ8q/TiEsZSiA+3Q1jS1PGMIYNtfcRz
         kemOr9J7Vy19j2vIIMkTDT7xcipMtEKlYvO2hRyB13oyzQ5oL48tQc3bwKAEV5/w1oYo
         qJu1xXrU6l971VmwcjjjyKPPXfUqqp+PoCYgJY08Z1Sen7MbHaV0zFQqvqgaQpESWjDW
         ZaZ+O9B8aVD3oTL8J4Autm7IKcYDGgZoi2Oi5DqQ2kIA2gsZ2RGS0EiscGWb7rgAzxu7
         6SMbUjPp+reQPWr3NGaqYfi7o7rWaiuWr4p5QgRY7zseDCptgKczUtIyCxAoK52nIvnl
         uBkg==
X-Gm-Message-State: AC+VfDxx7mmnLsDSEWvNBsFS5dGb+rum7kOjAxBiUxAeLehK3KHDfPQB
        UeXTOn2d20907YuJLBkje4CRww==
X-Google-Smtp-Source: ACHHUZ7MUsWEpeOvAxt1rHg7+tOa8LG9RqkRNYz0NMQx202TWnGM+PPBcxspaw8ho1OQkL/00/ISxw==
X-Received: by 2002:a2e:3809:0:b0:2ac:8efb:fc02 with SMTP id f9-20020a2e3809000000b002ac8efbfc02mr1350663lja.4.1684538762886;
        Fri, 19 May 2023 16:26:02 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id i2-20020a2e8642000000b002ac7a25c001sm42601ljj.24.2023.05.19.16.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 16:26:02 -0700 (PDT)
Message-ID: <d52036e2-2156-f00c-6b60-e0d942857d98@linaro.org>
Date:   Sat, 20 May 2023 01:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] ARM: dts: qcom: msm8226: Add IMEM node
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
 <20230519210903.117030-5-matti.lehtimaki@gmail.com>
 <7d8ff3f4-fa9f-109e-b255-329803532e9f@linaro.org>
In-Reply-To: <7d8ff3f4-fa9f-109e-b255-329803532e9f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.05.2023 01:25, Konrad Dybcio wrote:
> 
> 
> On 19.05.2023 23:09, Matti Lehtimäki wrote:
>> This is used for example for reboot-mode which enables userspace to
>> signal the bootloader to go into the bootloader or recovery mode.
>>
>> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Actually, please undisable it. It's always on the SoC and requires
no additional resources.

Konrad
> 
> Konrad
>>  arch/arm/boot/dts/qcom-msm8226.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
>> index 006263373348..3628e48c1ec1 100644
>> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
>> @@ -646,6 +646,18 @@ smd-edge {
>>  				label = "lpass";
>>  			};
>>  		};
>> +
>> +		imem: sram@fe805000 {
>> +			compatible = "qcom,msm8226-imem", "syscon", "simple-mfd";
>> +			reg = <0xfe805000 0x1000>;
>> +
>> +			status = "disabled";
>> +
>> +			reboot-mode {
>> +				compatible = "syscon-reboot-mode";
>> +				offset = <0x65c>;
>> +			};
>> +		};
>>  	};
>>  
>>  	timer {
