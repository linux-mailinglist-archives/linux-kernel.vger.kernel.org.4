Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D99E64C94A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiLNMwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiLNMwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:52:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48DDEA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:52:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j4so10335098lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOzLANzPj3qqEgUCYYhmz4gk7XnLzZTtTOuImpLgf1Q=;
        b=g882j4BHETUyLzMuaQ1dl9SK2tMiL5X1K95rHl30cRk8TwVVTCTGS6Nz5+rBn/6Km4
         S2f3eLMcig+X5LDwTd30zOWTTJ+rnbjB9621TB/ob/OSV/kFk1NvGAhrEUKOHnKlhoB3
         gnNXWmWSv0T1WY48yxj+4QaB3ZcSB3BWp/xTNTZmtTuIBEeolcsuxpMsczbfLBhggSY4
         2lJU9ENlv/n2ZxswSYkkT12k9D52/I1G5n6F7zZf0DNm81YveLzqg3g9CqUKxFCJMKC+
         0t5pQ7shMGAjY9CfT7pTix/tx1wIcJtDzHyDYUywwDC5CGWluaFFkhTwyeSkR87Gk8Cm
         Xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOzLANzPj3qqEgUCYYhmz4gk7XnLzZTtTOuImpLgf1Q=;
        b=zaP2adiHkT8dOWz5AvPaBTF0DRjcXFbiu2DfJ2wdlgg6rwm16GwwPQhDfjjwTI9rNA
         LSnkilC0qp8H9wgvTMV7KnRUOFyJ2CgRhK/yVEUsKPc7SVIh0mfdu8QGY/qyNMCs4mYG
         wApBiywFT7jXvz5vCdqBMgZtl3aWJkoGBE3V3SYuVOWgeeS3os/Ildt3I3Qle1GsqF4U
         HlLQH6NgKgB+LwxRcLDSh4EjdNUet1HA2B1uqTh7ol0dRM17u3gd6pXdG+olms2xcFqd
         ET5zT2bhMya00rWDNWWpVw1Q7BfGBTyOUrSoLErW1dCL0OW0ygMMcIk6PGgA986Lzizt
         MU+w==
X-Gm-Message-State: ANoB5pmPdogNYBcrY5XYmaAfYXUMFtmW6dZa9P3qZ9nIPmhhM7xSI9nb
        Uv6syQ9v74wkVIl5TYj8/rfGlQ==
X-Google-Smtp-Source: AA0mqf4dF4ukgIzu7bnEA0PtZdeNo5htPr4cov7SEOn6tQOU7yoos5cHOcoiiKc7qq/yhV+2jCQ4yw==
X-Received: by 2002:a05:6512:1599:b0:4b6:f119:c820 with SMTP id bp25-20020a056512159900b004b6f119c820mr3177858lfb.40.1671022339165;
        Wed, 14 Dec 2022 04:52:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o11-20020ac25b8b000000b00492b494c4e8sm794858lfn.298.2022.12.14.04.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 04:52:18 -0800 (PST)
Message-ID: <eca6f882-ad01-5b41-bb7e-552193e4a903@linaro.org>
Date:   Wed, 14 Dec 2022 13:52:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and
 qup2_i2c18 nodes
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        quic_shazhuss@quicinc.com
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-4-bmasney@redhat.com>
 <309b3fad-933c-6c45-5cd7-4e082da62c15@linaro.org> <Y5nB1epKN4nbk3ma@x1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y5nB1epKN4nbk3ma@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 13:30, Brian Masney wrote:
> On Tue, Dec 13, 2022 at 03:48:27PM +0100, Konrad Dybcio wrote:
>>> +	qup1_i2c15_default: qup1-i2c15-state {
>>> +		mux-pins {
>>> +			pins = "gpio36", "gpio37";
>>> +			function = "qup15";
>>> +		};
>>> +
>>> +		config-pins {
>>> +			pins = "gpio36", "gpio37";
>>> +			drive-strength = <0x02>;
>>> +			bias-pull-up;
>>> +		};
>>> +	};
>>
>> You can drop mux/config-pins and have the pin properties live directly
>> under the qup1-i2cN-state node.
> 
> Hi Konrad (and Shazad below), 
> 
> I need to enable 5 i2c buses (0, 1, 12, 15, 18) on this board. I tried
> the following combinations with the pin mapping configuration and the
> only one that seems to work reliably for me is what I originally had.
> 
> With the following, only 2 out of the 5 buses are detected. There's no
> i2c mesages in dmesg.
> 
>     i2c0_default: i2c0-default-state {
>         pins = "gpio135", "gpio136";
>         function = "qup15";
>     };
> 
> Next, I added a drive-strength and bias-pull-up. All 5 buses are
> detected. One bus throws read errors when I probe it with i2cdetect, two
> others 'i2cdetect -a -y $BUSNUM' takes ~5 seconds to run, and the
> remaining two are fast.
> 
>     i2c0_default: i2c0-default-state {
>         pins = "gpio135", "gpio136";
>         function = "qup15";
>         drive-strength = <2>;
>         bias-pull-up;
>     };
> 
> This is the style where i2cdetect seems to be happy for all 5 buses and
> is fast:
> 
>     i2c0_default: i2c0-default-state {
>         mux-pins {
>             pins = "gpio135", "gpio136";
>             function = "qup0";
>         };
> 
>         config-pins {
>             pins = "gpio135", "gpio136";
>             drive-strength = <2>;
>             bias-pull-up;
>         };
>     };
> 
> 
> Shazad: 'i2cdetect -a -y $BUSNUM) shows that all 5 buses have the same
> addresses listening. Is that expected? That seems a bit odd to me.
> 
> [root@localhost ~]# i2cdetect -a -y 0
> Warning: Can't use SMBus Quick Write command, will skip some addresses
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                                                 
> 10:                                                 
> 20:                                                 
> 30: -- -- -- -- -- -- -- --                         
> 40:                                                 
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 60:                                                 
> 70:                                                 
> 
> I triple checked that I have the QUP pins defined correctly for the 5
> buses. I checked them against what's in the downstream kernel and I also
> checked them against what's in upstream's
> drivers/pinctrl/qcom/pinctrl-sc8280xp.c. This is the pin mapping that I

What's the base of this kernel? Are you sure you have d21f4b7ffc22?

Best regards,
Krzysztof

