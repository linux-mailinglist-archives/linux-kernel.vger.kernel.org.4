Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB526240B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiKJLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiKJLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:07:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB6727CEE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:07:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bj12so3951631ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQX9GTmrLZBtKec2fbKivH9CTf4ja7pEoVT//UJEx5U=;
        b=Npy4C2HhwXmt9y3B4wwziVQWyD88DQs8jr/dCNkgMQUFlBu76zaZ7gf+PVrZFet/eH
         nPwDAJGvrxMmqxn6QIts4AVvZpWiGNt6zldTYdA1Wdr6cqpE/Fcjg1XwaxlygdPztqOl
         5rSZJBXeMYftVOGj/hqRls9rYmFMx8NsIB2xjiyb1byUDvrvWfqT2Xh3J16iUUowlhqz
         lkjN2ETLI5D2Y+4d73Kl4V4W3xrrY0/0SH8gYmF45TSlZss6zQLRS0gjPh2OfVUaiXdI
         0ggUtKr7NOSykrMKf3WVw8iG/jTvUyftDF6CDVEcbihOj/soHuOhfGOzeCM4x3Dai7pj
         Ri2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MQX9GTmrLZBtKec2fbKivH9CTf4ja7pEoVT//UJEx5U=;
        b=gDefdSOGKVYTYiXa9QvsjNaOjDuk3QL8fECfFB0ViMR/NcmQeCtiw/NmsvRf5Oa6ry
         lM5jQ3rFUtcj4AD98izjUNCuo2ABMez5ss4K8pWqsJ4b3kSc4dWWSkJlZ11V4tAogmxw
         xhLW9vuB/ZtCxs3V1J6HpugSu9WQFMF9bqMqfmLzO9LOT9S29X2HeQWwG8zzuUURg/ic
         VoEHePITt1PkVanLdsQRtVfrafi142na8MPuzrhw4ITaFRTl7+77ZU4EHFqOTkCZ1gTb
         0hqtOmOH5cCdK61B2U1YNrtOrIfjaCLYgKw5WJpHEsYP++oSasK1/BI0Se9S68CJHDvt
         E7Kw==
X-Gm-Message-State: ACrzQf1Q9bRgVmeD+tAWIBhtVnaPBUBYT15bRnngQayDjoYVS6ELZRV5
        1k7phmDHhKkE0VzHZeDXx2yetQ==
X-Google-Smtp-Source: AMsMyM5cpNFu8N/NqiPC7wjqt7C3v4tSHMovTtvT4mU+AT8hBQ9Su0twzukgaQ64uLuZTP9W8obE2A==
X-Received: by 2002:a17:907:b07:b0:7a8:beb3:aa2a with SMTP id h7-20020a1709070b0700b007a8beb3aa2amr59181987ejl.459.1668078427399;
        Thu, 10 Nov 2022 03:07:07 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ez9-20020a056402450900b00463c475684csm2068245edb.73.2022.11.10.03.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 03:07:07 -0800 (PST)
Message-ID: <e1e8c273-cb40-504d-d8de-ae8a894f5d0e@linaro.org>
Date:   Thu, 10 Nov 2022 12:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc8280xp-crd: rename backlight and
 misc regulators
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-4-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221110103558.12690-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2022 11:35, Johan Hovold wrote:
> Rename the backlight and misc regulators according to the net names.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>   arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index a2027f1d1d04..0801bd8c44fb 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -37,7 +37,7 @@ chosen {
>   	vreg_edp_bl: regulator-edp-bl {
>   		compatible = "regulator-fixed";
>   
> -		regulator-name = "VREG_EDP_BL";
> +		regulator-name = "VBL9";
>   		regulator-min-microvolt = <3600000>;
>   		regulator-max-microvolt = <3600000>;
>   
> @@ -53,7 +53,7 @@ vreg_edp_bl: regulator-edp-bl {
>   	vreg_misc_3p3: regulator-misc-3p3 {
>   		compatible = "regulator-fixed";
>   
> -		regulator-name = "VREG_MISC_3P3";
> +		regulator-name = "VCC3B";
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
>   
