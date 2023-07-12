Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCF750962
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjGLNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjGLNQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:16:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38141999
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:15:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so9577021fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689167757; x=1691759757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dn4rYyKdwTQMplFvM1YHg3Gp1VPxwOyOuPdjDZ4oTQs=;
        b=MjXeUH9brINWRIL75SFSSvwFmVJG2jUS3gyV+2SmtbAKX/SQCvWGhRcT87fnTJmuiE
         yMG3yUecRAAinZBdsfwGWunFL90IVP7OCaKSigAJzC66J5dq7lKbBHSjx0ts327vTI79
         R6FrVsk6YWv4AUH45Vs+/hBbxAW4p9zlnVgkrsZCdNnZ2D2Rx4CM/y6xd3AyNpSg2Ghk
         ViLO6OpihgDYF0R6FVEYVrhdXeOw0bOWgdZlkK+WA7ZX8c5gpscpLSWQhMOtt1yEaBUA
         PfmaYmejlQt3Bhy0/On7Mv5QoUuB82vM32cdVkduN+DbKN3fPzntcD8r3hBE8SqLn4vS
         Z4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167757; x=1691759757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dn4rYyKdwTQMplFvM1YHg3Gp1VPxwOyOuPdjDZ4oTQs=;
        b=NWAF66yHfWSbJSLD62grxU8gtK3gwNMaVNeugXlYwcsmcC2xy1RAKxYqSaDGeB1JrQ
         RMHlRRd1yJLSGJ7kRI0mOAPXWn4rZ9Qp8X6+Otl4WHGpFAqhXQIUByjRMQPWQ1CoIEr0
         K1B8eejeNXVrxnf9QLAST9UI38fAwY0qYBUFanUCFHxoG62gmfDDzMwgKq6o8/EavCeK
         k1PlB0CUxk2+tXaKdI5fvnePPkbAqnFw9Rb4swKFlqJZDzVai0T9C5eHjmNfRFzNM3C3
         CzeRYS+8RvkCY19HevXlc0LQ3vfxj4q7lQfEKRuIFtlptqS2WpGQiHNjX8VSpz/QPiug
         jgyA==
X-Gm-Message-State: ABy/qLZIpbaB5Mwz64MeOsrTFDpGP2UC7tHm86oXVx8A/Z2Xr1/c4QW3
        lBU4SyH5ZuoTcwHajA9ANjBGlg==
X-Google-Smtp-Source: APBJJlF3SgFBdLW73ntgGd2gci24bmcZ/SHaaJOixefWrDQ+G8QUUfyYVuY0X5Z36wtyT5cVzOllFQ==
X-Received: by 2002:a2e:7d14:0:b0:2b6:d0fa:7023 with SMTP id y20-20020a2e7d14000000b002b6d0fa7023mr792416ljc.24.1689167757034;
        Wed, 12 Jul 2023 06:15:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p9-20020a2e8049000000b002b6ebc61e85sm962698ljg.54.2023.07.12.06.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 06:15:56 -0700 (PDT)
Message-ID: <3b677200-a201-680b-391f-fbf73064496a@linaro.org>
Date:   Wed, 12 Jul 2023 16:15:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: qcom,sdm845-mdss: add
 memory-region property
Content-Language: en-GB
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230712130215.666924-1-amit.pundir@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712130215.666924-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 16:02, Amit Pundir wrote:
> Add and document the reserved memory region property
> in the qcom,sdm845-mdss schema.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>   .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml    | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> index 6ecb00920d7f..3ea1dbd7e317 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> @@ -39,6 +39,11 @@ properties:
>     interconnect-names:
>       maxItems: 2
>   
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Phandle to a node describing a reserved memory region.
> +

Please add it to mdss-common.yaml instead

>   patternProperties:
>     "^display-controller@[0-9a-f]+$":
>       type: object

-- 
With best wishes
Dmitry

