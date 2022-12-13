Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52C64BD73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiLMTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiLMTlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:41:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7E220DF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:41:50 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so6718465lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4w/i4s+wbfLDhbCXcN4sZLbigXk4yPqeCVMd1UYoC8=;
        b=l1YgaJSR8zIKABctWDgqJrEKQZhIUg0X37tyK3QIJaz+b3FXUdFXm22/k7AztMAHA8
         QwWzTiLxTYSUl5iipZKzKT25YykhW+VgDcKbPMRnx3zf8yxhT6S6l6GnOxB23SuufyGw
         b4xN4lw37GHjsiaa5pP0YUBJPDSRbXSvB5VSvnxQkFYqbfzKWFCf1WXMF7xumT2o8izp
         VbiHttXIa45hmECJ7di7lYOWrIGT5wXlrB3n/SXCtjadQ+jAhx5hW4zjib/FupJIJEIu
         IgS4YHRs2sP19rsbFc4+a1DyMDpHVX/rWCciD6c++MzFND+Fxebj1dbDYB9N+NmckSeB
         g03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4w/i4s+wbfLDhbCXcN4sZLbigXk4yPqeCVMd1UYoC8=;
        b=htxI349Fbhbopfx0ySelL9lqijJx/Yl7boAi08QHGjwlw8vUmV8J6rldCTbQd08aWy
         BOFIIny0p/v75Y6QU4WPq2yg+4m6gfnqa7a17wvzZui6vIejLvjd1+ECtvWU5PoZbHCN
         +xhQT4UR2t8iRcys1XE45mywwZ9eC77h85s2EwCoaGlve+yiouVr6PkKu4/vDimkiz2K
         FL9qinXtbLJoShs25sSvcKhkv2r8y92uf/EHQ1pdvUDiJFbqCKS7H8nMpczNeV9TJclO
         ca2JxupRq5IDAO+LGvB++e1v9Z0W08j/V6eZOo7e8EoIIqLbgnR1zAYW8/15TKSo5gfS
         Ittw==
X-Gm-Message-State: ANoB5pn1mlKpH6ZpmuzL9ffcgdYsh8vcMaXwqvrK/4ErOFK4Pro+rkZo
        jx3cDZLZGtiOdnxEnsSZ8TPHmg==
X-Google-Smtp-Source: AA0mqf5uXazyz4GJOBpdYgRVrYmk+mlHPYvjMiThTKK+ghEcoTdhkkdD33yw33KWvWvI3cRqSbehug==
X-Received: by 2002:a05:6512:b10:b0:4a6:c596:6ff7 with SMTP id w16-20020a0565120b1000b004a6c5966ff7mr7009187lfu.2.1670960508591;
        Tue, 13 Dec 2022 11:41:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p8-20020ac24ec8000000b004b4e4671212sm481348lfr.232.2022.12.13.11.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 11:41:48 -0800 (PST)
Message-ID: <612c1019-11c0-38b6-e1d5-1a52f1456989@linaro.org>
Date:   Tue, 13 Dec 2022 20:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] dt-bindings: remoteproc: qcom: sc7180: Update
 memory-region requirements
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, robin.murphy@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-3-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213140724.8612-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 15:07, Sibi Sankar wrote:
> Update the bindings to reflect the addition of the new modem metadata
> carveout reference to the memory-region property.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml    | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> index e4a7da8020f4..b1402bef0ebe 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> @@ -95,6 +95,7 @@ properties:
>      items:
>        - description: MBA reserved region
>        - description: modem reserved region
> +      - description: metadata reserved region

Which makes the third item now required, also for all out of tree DTS
and other users of the bindings. Please write a bit more in commit msg
why this is necessary (e.g. was it broken before?). I assume the driver
does not break the ABI?

Best regards,
Krzysztof

