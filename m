Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB277184EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbjEaO1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjEaO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:27:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEAE1B7
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:26:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3a873476bso6648633e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685543203; x=1688135203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsb/Lkvit7E6o25rklytBN+4+1hIjsLT4kpV/+YNtPI=;
        b=s5VJQSDMVf1ZO7LSn6Qz8ogWZMVgFKLHWGk5Ta/NYNJuEAmViSvBAw2cNM+FoqKHzu
         rt2AsxhMJEHCEM1ycEb9dm5lSnn/F8cQNrgQysTAyKtaTNjANRmjDbcTxEBJTRSmcXo4
         PY2D8Lw4YPtigFF4peLh5Ih2rK/SbYWEOodnDVCzSkbvlxARLxewCjXii/eapKmFyYRc
         PjAmyypkxgf7retomJFTRxAU3KsNu8b+ijtrJqw5pHlecNoYn2hLI2+T5tj/GOFQlTTc
         z7KiW4ud2tTmt/0iS4zIffQQHvy2lfKVHM0R0NMviBVb0V9dd9Qsc3N+vV0u+u/oYSk+
         V/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543203; x=1688135203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsb/Lkvit7E6o25rklytBN+4+1hIjsLT4kpV/+YNtPI=;
        b=EbbWkeDyr6pNE4orsLxCpddWsmPiGo5HjRE/p56jcdijMHlJnotfDh7kO0QHF6BlJl
         NcT7S1WOW0qaOdjR8jzoyeFPeQRypmSsJPvE10LI8SRguHw+y/qN0yAilSNJ7ToZOLcb
         ozVE2OE1LRxrdsm0+r7YzWy/6N13kNntXB43cbArGcymLI6Pu1/DZ8SgTmhgkL0N7c7T
         oUL8jGz8JC2k/pIX2G0JtT1wDm2HZUVDZDYgw0elGRxWKt3Sj+r46hoo4z4b362pcyNX
         5qTY2uE8xCxKK3BPN3SXWl2KHgrxYKJQ1DGEDSPGR/8zog5UGFK4ES4fuLzlXFnjkpes
         SlJA==
X-Gm-Message-State: AC+VfDxFrd4Y7kv419Z7H2w6aRRckg9d7tGrTQo+wqnJLO0EZBuyiNWL
        H7kJhTpNHa2bW6qXGu/nUOG/0ni7mWM6b7yw4/g=
X-Google-Smtp-Source: ACHHUZ6oAHKtG4Gtml+ABdtf9CkPpqdfRliFW4OeYR4pkE2wnfjiDAC/126mi+a6wiyp1UEy4wYyIA==
X-Received: by 2002:ac2:518c:0:b0:4f3:baf9:8f8e with SMTP id u12-20020ac2518c000000b004f3baf98f8emr2961540lfi.4.1685543202973;
        Wed, 31 May 2023 07:26:42 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b004edc55d3900sm743380lft.0.2023.05.31.07.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:26:42 -0700 (PDT)
Message-ID: <b6015e94-47f1-aaa3-ad42-9ee8f78daeec@linaro.org>
Date:   Wed, 31 May 2023 16:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: pmk8550: always enable RTC PMIC
 device
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org>
 <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-3-a3b890604c49@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-3-a3b890604c49@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.05.2023 14:22, Neil Armstrong wrote:
> There's no reason to keep the RTC disabled, it has been tested
> and is functional on the SM8550 QRD and MTP boards.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pmk8550.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
> index 8c897d4fee29..c7ac9b2eaacf 100644
> --- a/arch/arm64/boot/dts/qcom/pmk8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
> @@ -49,7 +49,6 @@ pmk8550_rtc: rtc@6100 {
>  			reg = <0x6100>, <0x6200>;
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
> -			status = "disabled";
>  		};
>  
>  		pmk8550_sdam_2: nvram@7100 {
> 
