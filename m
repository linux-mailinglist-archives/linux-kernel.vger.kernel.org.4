Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548535EDB82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiI1LOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiI1LOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:14:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C41117C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:13:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j24so13945693lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=F99mTczSxOdNAN6W4JqadV98hAJQX4pGEisajQkbFpU=;
        b=wrotcg3/HeGgo3IHOLG+qLERYGRLjzhDBFippdTXUXJIzm0FXqnm0xt4PA+09J11Ta
         PjNi5F8i7zulKsFmjj6H9MJvisUm5lW5NsSNbgU9LCjXtwyiyd98oNrKH3xsYLVKbX4V
         Iqv9pwreSrZ2I0TIGoKfT4tTcLbn3zvZXJO//SAquS7WKUl90T28EcVt8/7xMFAexgBW
         PYK2nBIJ3Lu/EPvHpn2BChVbSFcwW8cCGAGRaZykjphHywFxRR9EuFda2OFwuYCAZSld
         GxtZ03xOwTXSsM1cc4wevT0h2kInApMJNzRIIBhkWp9O1hxkGg2zpk++V5hQ8Dix8W3P
         9shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=F99mTczSxOdNAN6W4JqadV98hAJQX4pGEisajQkbFpU=;
        b=7pUipXuk+NdV++d2OnScMVwb7bd//h3/CdGZSWBVYJ0CYmip0euFF1/+wWHEMm542Z
         OEWE7paV2O4aoyO7d7D8vCaE87jQIyDOui2CTKKcvLBWRVPIBY+YXMF8Ox4W4NErdGW6
         D11rWEj1W5QBq2DEBeWOskO1Gpx5xdnt9Eh/DsMMRph4kUG5sj+XSHG9tdB335Na+nHr
         8Yvw3+I0xm/AGjTflpUtTVwTo4IY7l7AIFO5wZq+sGNYaFI644lDX+qZsnFYJe+xGkwd
         Y0XuRyKz+LTXNxwq19Vr33l1rIJONQkBs3U/AYDE3u4E5CQKNxy3gwP0Pb+JuvyVhgtb
         krEg==
X-Gm-Message-State: ACrzQf2Y/RIb8GY0buthh7+WUNGHnajxsrqejzVuNG5pfk9cDWH4o1pH
        GE3aZ7DKKC5husA7qOvm5pyEzw==
X-Google-Smtp-Source: AMsMyM6qVX4OKTkuH0HP9YpXpMKG2FaKhkTj8gjxJVRcBU6NdRZ3PzpuAGruLVSgf0MhE0x6RomTOw==
X-Received: by 2002:a2e:a54d:0:b0:26c:64ae:236a with SMTP id e13-20020a2ea54d000000b0026c64ae236amr12359061ljn.207.1664363581102;
        Wed, 28 Sep 2022 04:13:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651c118c00b00261d6f45c2csm409600ljo.124.2022.09.28.04.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:13:00 -0700 (PDT)
Message-ID: <2f9f0b2f-4380-a155-f6ac-3ce1be3bcf91@linaro.org>
Date:   Wed, 28 Sep 2022 13:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: add xiaomi,sagit board based on
 msm8998 chip
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928103319.621698-1-dsankouski@gmail.com>
 <20220928103319.621698-3-dsankouski@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928103319.621698-3-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 12:33, Dzmitry Sankouski wrote:

Missing commit msg.

> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> To: linux-kernel@vger.kernel.org
> CC: Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> CC: Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
> CC: Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
> CC: Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> CC: linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> CC: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

None of these go to commit msg. Remove leaving only your SoB.


> 
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index fb1d00bcc847..00e51d22aeb1 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -76,6 +76,7 @@ description: |
>          mtp
>          qrd
>          sbc
> +        sagit

You do not use this way of compatibles, so don't extend it.

>  
>    The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
>    where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
> @@ -239,6 +240,7 @@ properties:
>                - sony,xperia-lilac
>                - sony,xperia-maple
>                - sony,xperia-poplar
> +              - xiaomi,sagit
>            - const: qcom,msm8998
>  
>        - items:

Best regards,
Krzysztof

