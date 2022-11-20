Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C145663136B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKTKpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:45:40 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2E12D1D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:45:39 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d3so11720911ljl.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfjrrvM401chLEEhFMdPRN1cmntaerpR7WncWJ1zIxk=;
        b=JKN6r9dWXQYuszA/XTYDpyFWqOeIvK6wyxmzY6q3jw8yfWCtz6/LihuAcDmuIm5vLC
         OklP/dG2lHYcL+OF44gjxgbtLenFfKjpYaXOeNImtI2C1KiqFFtTYhue0aKzJhGaDJUR
         ooEtdNmdle27iw5JmKz3Z6yRfAJ9PTXo9X1P9jy0zic3Y/aJh3Jb0hX9uU7jsM9VwX0f
         6tCPuiA0+uXgZKhNCuAVVcx9BEjoBH6FcW5m+OpfoMNm876kDzNRiJD6mgUegubg9e2i
         jEmaDriCZ7x0p8x0aLxnjcKna9Ketv5KZJidYcM84FzSzu2r7ih2sddY51tc3aInTvwt
         Hhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfjrrvM401chLEEhFMdPRN1cmntaerpR7WncWJ1zIxk=;
        b=ltU1l+5OYk2lnroWMl77pfWv8+rbovvxhIFRWTlLv8xCLcxmtxJHfhhkGF4oBRF9Cd
         FLFzIavisXbEdQsnoW17fGQE1+WJQiM3gRq52MCR3A8gAYJ/AgXtujLyXxdzs0aWJoE6
         qj2BtSuBfAZIF5dpJyY53l7izD5Hjhwyj9vKrihoV0LCo+87ZOTNkf7XGJlakbcwLtuX
         ErxOpwirtSluPJTRLNsG/fFo/RgGImmTy7dDefmp7psGDKrQvkzDZ9s3eoE3t6RECJBe
         oT2UURIGk5yraDNQiErAw0Te1h3CupsNPeInVq44jh231uR+5uzYGubpGQjVbhPtiGbZ
         ZCIA==
X-Gm-Message-State: ANoB5pkn+1SuS2Pg20WbpEiPYxQ56S6iHodUndB/okvjH/YtXOO9+vj4
        K//6ln45XvajzCP9SEiSoTdW9A==
X-Google-Smtp-Source: AA0mqf7Ikj766/Ppw8jqYgYPMnH7OLugdvbfXSlNGYM0DawOyXuEDHvpcP6izLnUHKK9xV166S9wug==
X-Received: by 2002:a2e:be88:0:b0:26e:8e6f:3c4 with SMTP id a8-20020a2ebe88000000b0026e8e6f03c4mr4544861ljr.113.1668941138030;
        Sun, 20 Nov 2022 02:45:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a7-20020a056512374700b00492f0f66956sm1485066lfs.284.2022.11.20.02.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:45:37 -0800 (PST)
Message-ID: <94f23d11-dfa3-fd86-32ed-937c78592f20@linaro.org>
Date:   Sun, 20 Nov 2022 11:45:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatible
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221118182614.11774-1-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182614.11774-1-quic_molvera@quicinc.com>
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

On 18/11/2022 19:26, Melody Olvera wrote:
> Add compatible for scm driver for QDU1000 and QRU1000 platforms. These drivers
> only require the compatible field, so update the bindings accordingly for
> these platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> This patch is separated out from [1] and includes
> changes addressing comments from that patch set.
> 
> [1] https://lore.kernel.org/all/20221026190549.4005703-2-quic_molvera@quicinc.com/

Then this is a v4. Please always include the changelog.

Did you implement the changes requested? If they are no changes, then
review would stay the same as before.

> 
>  .../devicetree/bindings/firmware/qcom,scm.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 25688571ee7c..71012d43a32f 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -38,6 +38,7 @@ properties:
>            - qcom,scm-msm8994
>            - qcom,scm-msm8996
>            - qcom,scm-msm8998
> +          - qcom,scm-qdu1000
>            - qcom,scm-sc7180
>            - qcom,scm-sc7280
>            - qcom,scm-sc8280xp
> @@ -82,6 +83,16 @@ properties:
>      description: TCSR hardware block
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,scm-qdu1000
> +    then:
> +      properties:
> +        clocks: false
> +        clock-names: false
> +
>    - if:
>        properties:
>          compatible:
> 
> base-commit: 147307c69ba4441ee90c1f8ce8edf5df4ea60f67

Best regards,
Krzysztof

