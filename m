Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE26629AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiKONo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiKONo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:44:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FE2099B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:44:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l12so24466704lfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdaHmrZopow0cZrS7QRhB/XmFkl/A5fmUKYPPGyHrPQ=;
        b=ycizX72uD0PnQmkCOgJqAakMV2BZT7P/463tJ48Di3wgsFQuRWUW5BbRx5OScawtiB
         RIqqRnnWzGAdh7G81shiXKHpxIwOspFS8e6VJSVJFu7FALGX2tT7HADcaoCwHYMa1Xt5
         a8cPAQTbMJyeKfZFl8zdn9LV+ch5IZMEBgPeiGzVceiKzscwkdDkYr9sb2pY0+W0doyB
         5X4JA2EaOjA9vhFQfUqL6UB+rKaPY+R0//XOmJjKyI8c+mYexXEcIWr6G1oA7V5ao27h
         L4W38YOvFj5a7m7/KMZl53EwN6USaEN1Lk1YNj/H7IwbzKOqi3cbXA1a5HEGFeeY+DQ9
         sKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rdaHmrZopow0cZrS7QRhB/XmFkl/A5fmUKYPPGyHrPQ=;
        b=2MpxI9IVlVGZNxVyCI2gpTnRrvynBpJ/Xj+YZNRiBm6ia+Bypo90Y7OkY3SSW/0F2U
         z8dymA1sILiZXnv3aVedVv2+d5OT2FZr1ni6R6UZ4NG/Pqu5IZHQ5V5W9iMli3fPjTnx
         idnHUOd3KknJduG8N/PH8HueRywXsZEDM/zhpEoxu4DGXVZIM1tGX+7p1Yj8zRLPgL+s
         qgjg8T9SE6EhvzVcOBhAIZo1u870EdWAuPSNC/5IfDAzCdiAkRvjGkB2gQtXhpZQ/8Yo
         wcWx4wyL49Ydphdt43mydGiSHWZokJm2fUNmiLe/Yt5NjO8Xu3UX/PwTZGavEwlYIvJi
         D5yw==
X-Gm-Message-State: ANoB5pm7xO0GlsVgfwEaPLi5aNy+J/50HedR67qyCypTMWmOxIhY/HLf
        hN0vzE/CA8scNFVum1ArilMQ5w==
X-Google-Smtp-Source: AA0mqf7gFOTN3V/Hzzq2wgjXL7xVmz53u/5hppb8CWem6NjgH646duFocYVW9tk/Vyy7OF99ZPKYjw==
X-Received: by 2002:ac2:41d4:0:b0:4a2:4d53:8294 with SMTP id d20-20020ac241d4000000b004a24d538294mr5110012lfi.263.1668519862567;
        Tue, 15 Nov 2022 05:44:22 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id s13-20020ac25c4d000000b004a91d1b3070sm2207716lfp.308.2022.11.15.05.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:44:22 -0800 (PST)
Message-ID: <c4db1802-9aac-7fd6-605d-cac4b62b25d9@linaro.org>
Date:   Tue, 15 Nov 2022 14:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 08/12] arm64: dts: qcom: sm8350: Remove mmxc
 power-domain-name
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        quic_khsieh@quicinc.com, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
References: <20221115133105.980877-1-robert.foss@linaro.org>
 <20221115133105.980877-9-robert.foss@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221115133105.980877-9-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2022 14:31, Robert Foss wrote:
> The mmxc power-domain-name is not required, and is not
> used by either earlier or later SoC versions (sm8250 / sm8450).
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index cbd48f248df4..805d53d91952 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -2558,7 +2558,6 @@ dispcc: clock-controller@af00000 {
>   			#power-domain-cells = <1>;
>   
>   			power-domains = <&rpmhpd SM8350_MMCX>;
> -			power-domain-names = "mmcx";
>   		};
>   
>   		adsp: remoteproc@17300000 {
