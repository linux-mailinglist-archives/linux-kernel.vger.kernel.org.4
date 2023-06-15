Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4122D731EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjFOR01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjFOR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:26:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50476270C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:26:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so10441350e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686849976; x=1689441976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OD9CfNGG0ljVkHjUXzx71k7VdGMyNrkhpyVNqChErc=;
        b=h1U7GUovXKBg8zOEwjAYNdcM+iamFEnF2AyGLYAtv4n1zNv+cXvGW4SnGRRNtqB5Dd
         Mzpx/Z5vt/uZMY9kzIpw4tAAjqv3yDu7ohjM5GPCBy6Bn0BCJmgB4ytYJW9GxzZajY9t
         +6kzNwwnYWMbOo1fkF3HDFp/e+s21JbsafUQ1uBkIkT6LBc9ZCqNHax6mAwtlba0WANj
         CepmoZvfbLDiPiDRm3AhY/iZkpGSrDx3QInDHk3e2U0CCJc72ryVN7mjoNPde3aKTIQi
         j9BpvivNlZ52lnTTWCsQ/MHiCBVsdUFBe3SJLJeCrhi168MnZAaFhQJLGQniG/tYye44
         SZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686849976; x=1689441976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OD9CfNGG0ljVkHjUXzx71k7VdGMyNrkhpyVNqChErc=;
        b=cjxWo5MB1BUdcfqzIqn8l8286tp2t/Hg7rYldq2X7ejiyANIzzQBDL0lN5pqS7wztn
         XEliu8/gQi+8bTha0gMakGLi64UtsjaTv3DenTAILtpPoZfrc3gz1HitIrCXSxBWHXzt
         MaiDCjqFbBcXbxe1JvNjS0rrnEG5EOUcmUA5V/26taARO0qAgNW1jjk0tydl96n2u6Ck
         j1e/jfuw0YUoQBALEP31ma2cARsdCaqmko3fyUt6xOQ1tbfNlq98IdzXKhsIMgHA4Ibi
         bBIXFsOEtFRN4cWrQvlmfSc8B6u5wRwuiOXgCi9HpIqNMNvU7pnyB+NukseQxcy9gtJS
         uMvg==
X-Gm-Message-State: AC+VfDxX7elGwmIIF+z6uKJpLwvPquGeOOtaXuAIjIYLGuDZM3xGHJSG
        vUMJ7n8Gz0AILhiR4pHKre10hA==
X-Google-Smtp-Source: ACHHUZ6FWxB2G5sI0gRE4Ywc1DSB6zpSrGXY6CITo1W5RCOByENa7dVFWNEcmGMX7f/bgXCe2Er8nw==
X-Received: by 2002:a05:6512:54e:b0:4f7:69c8:44ff with SMTP id h14-20020a056512054e00b004f769c844ffmr3217394lfl.2.1686849976301;
        Thu, 15 Jun 2023 10:26:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f3b4d17114sm2645328lfn.144.2023.06.15.10.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 10:26:15 -0700 (PDT)
Message-ID: <5377c938-10df-20ce-2bdb-dad41e472041@linaro.org>
Date:   Thu, 15 Jun 2023 19:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-db845c: Mark cont splash
 memory region as reserved
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230615142711.2994811-1-amit.pundir@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230615142711.2994811-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2023 16:27, Amit Pundir wrote:
> Adding a reserved memory region for the framebuffer memory
> (the splash memory region set up by the bootloader).
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> v2: Updated commit message.
> 
> There was some dicussion on v1 but it didn't go anywhere,
> https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u.
> The general consensus is that this memory should be freed and be
> made resuable but that (releasing this piece of memory) has been
> tried before and it is not trivial to return the reserved memory
> node to the system RAM pool in this case.
> 
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index e14fe9bbb386..10a06ee8e262 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -101,6 +101,14 @@ hdmi_con: endpoint {
>  		};
>  	};
>  
> +	reserved-memory {
> +		/* Cont splash region set up by the bootloader */
> +		cont_splash_mem: framebuffer@9d400000 {
> +			reg = <0x0 0x9d400000 0x0 0x2400000>;
> +			no-map;
> +		};
> +	};
&mdss {
	memory-region = <&cont_splash_mem>;
};

?

Konrad
> +
>  	lt9611_1v8: lt9611-vdd18-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "LT9611_1V8";
