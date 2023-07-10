Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66B74DED6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGJUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGJUK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:10:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8BD194
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:10:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso2192428a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689019826; x=1691611826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LG2saCTYJSC7eBsyVYymYJSHBn+A2yhJLV7FlenaZC8=;
        b=o4yHp1OW+bpUZUIQ6HL0GJR+sWu6EKzJVmUkRxy+kdwAJm0fz0+G4PznQcM+ZUYVm7
         KO6KMz3EKfhH6jzaUtyrnxd1RnGVEn3hLTTPPhJR0AWST2/9GzaRaWbSspHv6+zeorrW
         LiaElXEg9kZ+WS+fvfvEGJ5zp0/8bvKKt4iQalVRmJN09foq1Z3t7IYirM0Q1tqwbMoc
         itmJc1UKdlTgZCvPge5AM+g7i/J6ZOno4NIcr9PfUuavrfsYAcXdlRXGJzP2zBUfqh92
         5eds7h0wYmzC1/aCb69CAJPAp/cT5sYSgmcznlhtxRzZyZ3VWr3pG6kE6iLJqH4Vv4km
         +9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019826; x=1691611826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LG2saCTYJSC7eBsyVYymYJSHBn+A2yhJLV7FlenaZC8=;
        b=TQeuT6Z2wyTiEXNvxMF1/FipOgcO9Qqg4/al8jAnEiYY1VIJq2i7gC/XuY08RbPyUr
         YCXRdHHBF2/D5z04CXZBlkKxn0ZMaVyHQxVZt6ZZkBGHLiAKb5ZQdWByRcG7iKa+Js/v
         RDEwQhAgr+LtPKX1yO9eBqmIJ502ql0ZYGQAzRjR1DJ57vgYYkIPmaKLdph/xU++Xp0r
         exptYLrjUrXZT88wzi/sW1aYeOQNlUVzVqSj/8nznJv3a6Cle21LAZyA8rejHH/FVGpi
         Q4qJ+7NRn2KdTiglYCugFJ70H4iL6TYJhBH8i+47ZCfcqJUcPEvLZijP9uT3/7MDh5aY
         F1oQ==
X-Gm-Message-State: ABy/qLacrzfSAvLbZs08jKFjMErOQsCCzFRq7VBHOft+66xPV7AwLYck
        qQqQdtrzDCG9zkDl2rfnXhxItQ==
X-Google-Smtp-Source: APBJJlGI28QFvkYBufy4+7hJUw6TnmXkwNEzBwUv/8pTP7JnzfHVkYAmdckWqMzr2Y8EslBgXuZERA==
X-Received: by 2002:aa7:c690:0:b0:51d:9110:4b11 with SMTP id n16-20020aa7c690000000b0051d91104b11mr12493459edq.12.1689019826065;
        Mon, 10 Jul 2023 13:10:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b0051d9de03516sm124055edt.52.2023.07.10.13.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 13:10:25 -0700 (PDT)
Message-ID: <09e33a89-c060-69b1-b94f-b21c45d1d249@linaro.org>
Date:   Mon, 10 Jul 2023 22:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] dt-bindings: thermal: tsens: Add nvmem cells for
 calibration data
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-2-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230710103735.1375847-2-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 12:37, Praveenkumar I wrote:
> Add TSENS V2 calibration nvmem cells for IPQ5332
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 26 +++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 27e9e16e6455..8b7863c3989e 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -91,7 +91,7 @@ properties:
>      maxItems: 2
>  
>    nvmem-cells:
> -    oneOf:
> +    anyOf:
>        - minItems: 1
>          maxItems: 2
>          description:
> @@ -106,9 +106,13 @@ properties:
>          description: |
>            Reference to nvmem cells for the calibration mode, two calibration
>            bases and two cells per each sensor, main and backup copies, plus use_backup cell
> +      - maxItems: 17
> +        description: |
> +          V2 of TSENS, reference to nvmem cells for the calibration mode, two calibration
> +          bases and one cell per each sensor

I think this is already included in one of the previous entries.
Otherwise, are you sure that all new devices will have exactly 17 entries?

>  
>    nvmem-cell-names:
> -    oneOf:
> +    anyOf:
>        - minItems: 1
>          items:
>            - const: calib
> @@ -205,6 +209,24 @@ properties:
>            - const: s9_p2_backup
>            - const: s10_p1_backup
>            - const: s10_p2_backup
> +      - items:
> +          - const: mode
> +          - const: base0
> +          - const: base1
> +          - const: s0_offset
> +          - const: s3_offset
> +          - const: s4_offset
> +          - const: s5_offset
> +          - const: s6_offset
> +          - const: s7_offset
> +          - const: s8_offset
> +          - const: s9_offset
> +          - const: s10_offset
> +          - const: s11_offset
> +          - const: s12_offset
> +          - const: s13_offset
> +          - const: s14_offset
> +          - const: s15_offset

Don't introduce new naming style. Existing uses s[0-9]+, without offset
suffix. Why this should be different?

>  
>    "#qcom,sensors":
>      description:

Best regards,
Krzysztof

