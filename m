Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4A5FFA38
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJONTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJONTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 09:19:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44CA17A95
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:19:34 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bb5so5288913qtb.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCSwBkwZXdfMuWsk1P1u/17KwJcVR/Zaj8waJZyviMA=;
        b=gE19VCZPTc1WzOZvTW/RwwowIeLE19BpAVizDq1z042x9ClQTwMdU4vUO6iz8l/tFO
         WCqOQWpVRZZNUohu5DSbS2ds60Lfwa3zy+NNtFufMCBSjVO6JUKuzezomXeseqJwZeg4
         MlBdFevqY8qb5n+C6gU5MBzzp1KUcjk9ws8bxhhfKN2rY13nPkw8rYgrKecqzb9uH9DA
         YGrhZAysjoh9YWJlfu9KSbQDYeInPdusBDHAUUdgs0DEShSAAADOcIJp0ommS3ZhAvdH
         ie4057izyck/v6SA8k8zhosrMOXCkI/DPb/5y1F5jrPXRpy7Lh6cQIXteahspVn8tbqy
         WFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCSwBkwZXdfMuWsk1P1u/17KwJcVR/Zaj8waJZyviMA=;
        b=eYrFVZdYe2CusmR0DF1rdi/L27d7q8snO/w6z/AGP4bbjOLYb7t8yp0QwCtoq4KdxQ
         RZ+LjEEzboqGtcKvQRhuBkLm40Dzpmv5xkZ0sK2DN5oI9GOmwwTH0puyMiNgvZb0N5dO
         uhYeaXAQJhetda6k/cwFuLZd2wNXolqPF+31WiZs1wGzNWsLRI80QyNw/e8BP+3gf/CN
         e7HsMk13UBjZIYtdNRHohZ23QoMtV6p1m+8FXHnNcTOuPTqnJvnS5PLExY2pQy0l5I9P
         2CtHGcnjdxrKjpAm3LLAZkeduKnKmN+zMvhPJKMSHCDh1ZXgOwiLwgVkowg17xns5lz0
         3VRw==
X-Gm-Message-State: ACrzQf2EBd6uhiNapFCrSWzd5UnxEZhOjT9C+4Olhy4JR/I88TNJkHGx
        tpjl3xjVRW3xuGN1hyh+rYgs1ralfODsjQ==
X-Google-Smtp-Source: AMsMyM4kq7rQa7ljXuMMZTYKm/dBZMYoq01Eq1Y/RbRArMT13cL8p/kHh5EbvBTFyGn/SgktmacgFg==
X-Received: by 2002:a05:622a:54:b0:399:5b6c:654b with SMTP id y20-20020a05622a005400b003995b6c654bmr1882983qtw.362.1665839973816;
        Sat, 15 Oct 2022 06:19:33 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:161:5720:79e9:9739? ([2601:42:0:3450:161:5720:79e9:9739])
        by smtp.gmail.com with ESMTPSA id y11-20020ac8524b000000b0039bde72b14asm3817450qtn.92.2022.10.15.06.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 06:19:32 -0700 (PDT)
Message-ID: <bcd3e840-ea25-51fd-6bca-683fd7680ab5@linaro.org>
Date:   Sat, 15 Oct 2022 09:19:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: Document QDU1000/QRU1000
 SoCs and boards
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221138.7552-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:11, Melody Olvera wrote:
> Document the QDU1000 and QRU1000 SoC bindings and the boards that use
> them.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 1b5ac6b02bc5..3370a50644a6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -40,6 +40,8 @@ description: |
>          msm8996
>          msm8998
>          qcs404
> +        qdu1000
> +        qru1000
>          sa8155p
>          sa8540p
>          sc7180
> @@ -76,6 +78,7 @@ description: |
>          mtp
>          qrd
>          sbc
> +        x100
>  
>    The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
>    where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
> @@ -493,6 +496,19 @@ properties:
>            - const: google,pompom-sku0
>            - const: qcom,sc7180
>  
> +      - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
> +          - items:
> +              - enum:
> +                  - qcom,qdu1000-idp
> +                  - qcom,qdu1000-x100
> +              - const: qcom,qdu1000
> +
> +      - description: Qualcomm Technologies, Inc. Radio Unit 1000 platform
> +          - items:
> +              - enum:
> +                  -qcom,qru1000-idp
> +              - const: qcom,qru1000

This is still wrong order. All entries are ordered by SoC compatible. So
this should go before sc7180, not after.

> +
>        - description: Google Quackingstick (newest rev)
>          items:
>            - const: google,quackingstick-sku1537

Best regards,
Krzysztof

