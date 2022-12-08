Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39A64799C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLHXPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLHXPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:15:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521159B28C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:15:06 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c1so4379151lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MLWqHmXw3e31A19JR59i7HY0RQ5DxjozWj3XhLsrl8=;
        b=Rc9ZeeWN3T4pFCyd8oR4JeEfHi+caKb82imwtttTViOt1NE7dQHgPsOR4BDnEG1D1z
         d7IdDrM1gTVuriCshf4VteM1/hJT7noha6pzIQpo+GlqTL6mQ6hDAH35HG2JnKLGO/NG
         egVsBGp9vQxb4M1hFQrvO1KnwFJ1RvfGLNuy4Dgjs4yTvbFRNMzLbmn0n5eCDrkuSkbj
         yRS1YO+3VOYgveiUHmHKV+5qx/TB+iXO3hQd0WjCLGMAUVnS9aChTMyCTE5Rvb1kRHdP
         EUNEM0cecqrdbNhxVx8xkMP6i0U1uLAv6peoDl9dG4P7KVkgIvEE52FBGUHloHPQ6al8
         yYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MLWqHmXw3e31A19JR59i7HY0RQ5DxjozWj3XhLsrl8=;
        b=w623c4Z1bOOtgC2jvifCFFvyzg0zpndy3WBr/kMK8GoMiMzmkjBT1v7CBNsC8ooEOP
         9uHCWHKI4c4yFdg3p3fBRUEGl3U32eDH+q6UdWtgGJdnRtdKDtNihJdGjO9EviQ+HoHO
         WovFOMPnW9KnG9dXKkhhtPjzcM6ypFEV8/HwacVL1JI5sC/XPl8Hy9TTja+JQC408T/4
         AmGaUibt6XN9WCAC4Pj3ujwzPnrVFYBUm0HRoQktl5vMp2fQt/dbj1qrr2N946zT3DjL
         RIqxPOOq278LX4Yp37fnyYlunn2ADCtv+hvH+wPEMrHZAux5AhBJeN8gVdh6ZlHz4tTN
         GnZQ==
X-Gm-Message-State: ANoB5plHUGUE9tIpwiJXgB+UkyM3B3xfeJYsRvcfkC/5yzZv+pnwu8kf
        jzfGPgINWVa/WjkfVacX+54s1g==
X-Google-Smtp-Source: AA0mqf6siW3890I1w3DufKwd9C/HMgXgs7NHanLd8th0sy7Rd98xbdw8OKUW1b7TN1BAj2kJyozw7w==
X-Received: by 2002:a05:6512:e96:b0:4b5:1bbd:3a64 with SMTP id bi22-20020a0565120e9600b004b51bbd3a64mr1192539lfb.21.1670541304622;
        Thu, 08 Dec 2022 15:15:04 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n10-20020ac2490a000000b004b58d457f2dsm1123994lfi.61.2022.12.08.15.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 15:15:04 -0800 (PST)
Message-ID: <40327ddc-dc6e-e803-acb0-310aad63515e@linaro.org>
Date:   Fri, 9 Dec 2022 01:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 04/12] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207220012.16529-1-quic_bjorande@quicinc.com>
 <20221207220012.16529-5-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221207220012.16529-5-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 00:00, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
> Qualcomm SDM845 and SC8280XP platforms.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes since v4:
> - None
> 
>   .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index f2515af8256f..a1dc3a13e1cf 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -21,6 +21,9 @@ properties:
>         - qcom,sc7280-edp
>         - qcom,sc8180x-dp
>         - qcom,sc8180x-edp
> +      - qcom,sc8280xp-dp
> +      - qcom,sc8280xp-edp

This also should be added to the eDP conditional, to allow the aux-bus 
child node (and disallow #sound-dai-cells).

> +      - qcom,sdm845-dp
>         - qcom,sm8350-dp
>   
>     reg:

-- 
With best wishes
Dmitry

