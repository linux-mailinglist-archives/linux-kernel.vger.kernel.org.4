Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C16ADA0F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCGJRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCGJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:17:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92876A1D5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:17:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ay14so45821204edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678180626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFABy9U7esu++afwwpsJQiDnIZRoaCQ7T2FtObsP3io=;
        b=M9FcPcGCviYeDHBK3iUL8M9xZII/LkzvDQWrPLfi7uuNQkf6x6Y6ofBP4fGdNCgIA4
         ikkicI1LPvFBXsllIRa7ewtEZjZHtv/phVduUl7oBPegVP4QP1UJQgLjd7/QOsICnUMF
         qq1Vnj01oNURFjKZaZN+nNaVgTBiYhdJEgmiVG/dT6Jk6zlhFXUmwfEdeDHz1K+QKk7v
         Qr7QC231FBTwCgiD133Z8YTy/8aV7sAsPbj3sTUIg016uV1cE93r2Quaw1C2jJuHyNPJ
         /rx4HimNxva0J6WSHtlGJDY+5q7LDNPVCiJdljNmbg8n1dMoKMg/C3MRZrtELDYFvw3a
         awPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFABy9U7esu++afwwpsJQiDnIZRoaCQ7T2FtObsP3io=;
        b=YylzSO4yJTMxRA2GmzQvzVRENlmjf5o4iriGdmBBs57tgfBuU8tWA3RMd1ZrbjF2eV
         S+YthzVR5F6fx8RZr3tLsRKLCzxWVWrdYmSumV+nfaFO+TXGljmRyPbwesDKIMDPQgvz
         qTyRm3cgrfjY/Yw1rPuzIm4jGkayTtVVi/0QM7fXJU+QNOdGuiMya+hL9cXMt2f3fIem
         VT3RCl38ZGXPVtLnL0QhIRLFLKgVGFbB2b6ZdqIWmnr6wcgDM5QsCPnyg+VR1eOdV0ib
         EoY/ER97Wr0dJGIcOshcLD6/LEZ6e62G/BYW8GUWN1rFpZmCEVyWZMF4yG6eqASW0Kik
         0uNQ==
X-Gm-Message-State: AO0yUKWTSXFMfIncGl+Mpzvxn0sIANcgsZ3MCgUSWQGPB+lbeVv9Knwy
        Tk6Ln+JMgBxMnVZuKBCcWUhETw==
X-Google-Smtp-Source: AK7set+C7U+DtyopUxx2vW7YdSkRAjedWzNsOMtGriAwgL9ZCFn9LzJVtn+nGFhe7mYGjehkdPQYCA==
X-Received: by 2002:aa7:d78b:0:b0:4ac:c029:ea72 with SMTP id s11-20020aa7d78b000000b004acc029ea72mr12779040edq.36.1678180626355;
        Tue, 07 Mar 2023 01:17:06 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b004c5d1a15bd5sm2350448eds.69.2023.03.07.01.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:17:05 -0800 (PST)
Message-ID: <bcb5c17f-da78-9d68-66eb-b620ee583602@linaro.org>
Date:   Tue, 7 Mar 2023 10:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 8/9] dt-bindings: display/msm: dsi-controller-main: Add
 SM6115
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
 <20230213121012.1768296-9-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213121012.1768296-9-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 13:10, Konrad Dybcio wrote:
> Add a compatible for the DSI on SM6115.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 2494817c1bd6..f195530ae964 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -25,6 +25,7 @@ properties:
>                - qcom,sc7280-dsi-ctrl
>                - qcom,sdm660-dsi-ctrl
>                - qcom,sdm845-dsi-ctrl
> +              - qcom,sm6115-dsi-ctrl

This looks incomplete. You also need to add it to MDSS binding.

Best regards,
Krzysztof

