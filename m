Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5880679314
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjAXI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjAXI1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:27:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74BD768F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:27:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so488566wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l32ibYG6p5bDrGsHgZxAaD4UChPnplKR4dXx/jYKRDA=;
        b=JKNqKuqs+62LV2uGr0H76AeKHaofNBUD3PD06z8T8M+IGrZpO97cTq/Sl1NUFaz+PD
         ki9FBk2C52GVGSlVVsImhjy+JOl2tkWYHuk0F9VeHN9+hqhv7qq16tjAmZMfzYawXWMF
         8N0Xwa9HRXS2UcF3yYEwNj1W9SnijTva0mZ1YTetaomk7o6lg3zmaJWQpSNkh0JZW6eN
         A5NxR0lY0bxfPyYvofnXfTk0AE4UQRT700951Mc/ZCoSB7m4W3So4PHGl88saJWEs2L4
         C48h+JK/Rg8f6jeQwzuAdmlEbM0b+4FKpzSgNqUy1kfoVjTEdDLyK2gdV2jo1NGLiY3t
         JTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l32ibYG6p5bDrGsHgZxAaD4UChPnplKR4dXx/jYKRDA=;
        b=Rt/x818rHpBSZ2CqASZi6Avbnmc+BgiU8M3lyc+0v0rkJkm27U4rbpO/KEwIoux6Bb
         F0td8eHc59rG07Iw9ie3OUTZevyTO9NJF8InIjqyi/oB5Mmy2S62OMOMmxL9yKLYuIhq
         Wqw8QykWxs5/J+TkLzwyOxJbt5AkhGSO/PP20XotZGdVcdJ2gzQJx0RldWDMtT6vGqLE
         uSjyu1SY5hZcDTG1/gOQz6dCF+B23DjeZxBgZh2W9ifjwMOy+M2ITb4BPZ/iyOmwt43i
         6yQXppYXQ65//suUusKBViWvJeVSnhODZJ+fSnuunfqxG55jLDAD2nr8OMA6KS3f0+j1
         qJNA==
X-Gm-Message-State: AFqh2ko1mXo+aZAd4XqE2IkLTPChg85jXynfLV5iI404kjaVT9RSvTlC
        jfUkP64jzF4GB79A3fVN8UuN3g==
X-Google-Smtp-Source: AMrXdXs8UXA8beQuN+9MpImN9RApvtnwpwlKVPL40j/+G59nG/CBvkp1LiNKNiClcIddqubyyyEagg==
X-Received: by 2002:a05:600c:3d06:b0:3da:f945:2354 with SMTP id bh6-20020a05600c3d0600b003daf9452354mr27219855wmb.41.1674548831234;
        Tue, 24 Jan 2023 00:27:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ebd2:15b:f444:7985? ([2a01:e0a:982:cbb0:ebd2:15b:f444:7985])
        by smtp.gmail.com with ESMTPSA id l18-20020adff492000000b00241d21d4652sm1308969wro.21.2023.01.24.00.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:27:10 -0800 (PST)
Message-ID: <2e86f4a5-3612-590b-2845-629a667d926b@linaro.org>
Date:   Tue, 24 Jan 2023 09:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Fix DSIn PHY compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230123200552.553181-1-konrad.dybcio@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230123200552.553181-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 21:05, Konrad Dybcio wrote:
> Use the correct compatible so that the driver can probe properly.
> 
> Fixes: a6dd1206e45a ("arm64: dts: qcom: sm8450: add display hardware devices")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index d66dcd8fe61f..8d85a3139849 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2873,7 +2873,7 @@ opp-358000000 {
>   			};
>   
>   			mdss_dsi0_phy: phy@ae94400 {
> -				compatible = "qcom,dsi-phy-5nm-8450";
> +				compatible = "qcom,sm8450-dsi-phy-5nm";
>   				reg = <0 0x0ae94400 0 0x200>,
>   				      <0 0x0ae94600 0 0x280>,
>   				      <0 0x0ae94900 0 0x260>;
> @@ -2946,7 +2946,7 @@ mdss_dsi1_out: endpoint {
>   			};
>   
>   			mdss_dsi1_phy: phy@ae96400 {
> -				compatible = "qcom,dsi-phy-5nm-8450";
> +				compatible = "qcom,sm8450-dsi-phy-5nm";
>   				reg = <0 0x0ae96400 0 0x200>,
>   				      <0 0x0ae96600 0 0x280>,
>   				      <0 0x0ae96900 0 0x260>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
