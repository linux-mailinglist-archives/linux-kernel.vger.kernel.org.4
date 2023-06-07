Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04044726919
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjFGSoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjFGSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:44:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E194319AC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:44:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-976a0a1a92bso975451666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686163444; x=1688755444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Dae8dZiTsM2lOHOWA+ivaRCZrMy5pd+W9PJihkcNNA=;
        b=As/3M3FyPUHVMPeG7viKKVkqqDYwP7HZ8xH1xEUZ/TtpYOJDXSEPjUMmVqksZCFPrV
         sKSpo21dppXVWiUcU7HXvfa/un7XQJ9Rp4Y+3sqYbVSgqT8xkNzoNapmjj98kWXfGS6z
         P0sB3oYsBZWcz3zhStve0ANTXSK75jNysa4GurYLT7t43LoBZHLTdOU9lEM+LS5Pxnmp
         1+Y6Kv5Ewt62FWWEJOf4/gZo8DmDuFNhdWGiUnETTosMXiVOrzecIOj4ap8cNBwXazl+
         VpkPg3QLRw8cvJVIA0smCADjSaX4gh1KO9WrWOq/qB1uQwcxffopjuFVaMTZW3rxBaJ7
         3oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163444; x=1688755444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dae8dZiTsM2lOHOWA+ivaRCZrMy5pd+W9PJihkcNNA=;
        b=SPSxmynFY59JnXYuckj2gc92LYqd9rpvx1gH9U8uAubZryHK2YSZ8y0vimU5DgCQ6f
         X1HFvhfttrGTMRVTevIGl2Qh4glzEgNpe4VSI6LxJAvl3IJ/SA1ez12LUmS4IuvQV9bR
         +KG4M9WMzvAAhlozdjkDVR4mio6iUcvo6AzOfP9FVdVPoM4RUxLDoJpFtI+KR8qNBWTy
         3g0vOacXH9chN0ofVGV9HSBXvglVyNXl//QDwXbywUc5jcXnxqvroUjrnu6r+OxvmLDG
         OcLZ+1vYAwHRojo3/vXt85p5O400WT0mj4H0gAqoieuX1Wl6XOMrHkLNvMVpj8jBJEfS
         q5IA==
X-Gm-Message-State: AC+VfDx9ZtdkHP6nIEf7Ynn0ACyUjyZC+wzfrb8CaWH/DRszNGf9hhqM
        5tNbjll4rTTOU9joZSXmNdnPoA==
X-Google-Smtp-Source: ACHHUZ5ehFpgK4APWouGQ0tCzLqe03SIcw3PO5Qn5jK1/EC0TqUbVVr6dKDAQCT/L+3KCQEwf8nX7g==
X-Received: by 2002:a17:907:7baa:b0:96a:30b5:cfb0 with SMTP id ne42-20020a1709077baa00b0096a30b5cfb0mr7151833ejc.22.1686163444351;
        Wed, 07 Jun 2023 11:44:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bm11-20020a0564020b0b00b00514b2717ec6sm6545000edb.28.2023.06.07.11.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:44:03 -0700 (PDT)
Message-ID: <44267461-e6f9-b549-a8eb-cba76384660b@linaro.org>
Date:   Wed, 7 Jun 2023 20:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH v1 1/2] dt-bindings: misc: fastrpc: add fastrpc
 group IDs property
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 18:30, Ekansh Gupta wrote:
> Add "qcom,fastrpc-gids" property to the list of optional properties.
> This property contains the list of privileged group IDs which is
> used to offload process to remote subsystem with increased privileges.

Why or when anyone would use this property?

> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 1ab9588..2a2124f 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -57,6 +57,11 @@ properties:
>        Virtual machine IDs for remote processor.
>      $ref: "/schemas/types.yaml#/definitions/uint32-array"
>  
> +  qcom,fastrpc-gids:
> +    description:
> +      Group IDs for fastrpc.

You just pasted here property name. It does not help me to understand
what's this. Explain in description.

> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"

Drop quotes.

missing min/maxItems.

> +
>    "#address-cells":
>      const: 1
>  
> @@ -120,6 +125,7 @@ examples:
>              qcom,glink-channels = "fastrpcglink-apps-dsp";
>              label = "sdsp";
>              qcom,non-secure-domain;
> +            qcom,fastrpc-gids = <2908>

Eh, what does 2908 stands for? Why not 3012 or 1842? How anyone can
figure this out?

Best regards,
Krzysztof

