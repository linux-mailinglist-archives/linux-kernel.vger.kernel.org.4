Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39768715C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjE3K7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjE3K7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:59:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6698D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:59:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f850b32caso836668966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685444378; x=1688036378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LGgCr7/b+a2Fs9r07vnAt9lfnJMeFMsXenMfhKtxd8=;
        b=Cf98Uynmb1ssXOGDPewzLb6fhpY2eG17l2AnTzby9cShpiRwXjCWMghvAjfMrhnhyZ
         j0/iL7wmP8LyLXcTMN43s+4AF/veTDAOY8k64dq052KdQTm5gx6lcGZ/jtq3J11Dyj/R
         il7s05sD7C8A+CotCV75vYh/H1NMJW7JmJ/wTYlzo+RBxxlq+HF7AVEfgVB33uAyD2Cw
         2Ze1+I4ofoixDwnEs586HVZ9z91+VjTVjBtuL/T8P7BYd4qj9dlh0prz3UCOM4KvawA9
         OT76ejdRFwQwYsp8wjTd4rZaiQpIrJwr2hrZCfJ50TgxFEGfDY7TbpETCQ6SfI8ZcMHN
         x9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444378; x=1688036378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LGgCr7/b+a2Fs9r07vnAt9lfnJMeFMsXenMfhKtxd8=;
        b=FvTnpSvk/s7q+l9KV2i2LF/s/V2wcC4AH9yJXpuMK6VyciazmnIKQMB1ngsZSnf4X7
         2EQLZ6pJyG8fG8WJ9UzowePHuYN2sQeNzqV3rPCC/3vFMT05Ncb2wiz8S9fGKsgicX60
         UIS8dS2KYhGsO4zJzMjRetgo9Eb//SMaVmGcHzoPP9ostXwgB1ezJ7z+JWKeeAjt5KEU
         /QlUZ8+UrdDo/9Ukug7x7EuV7SGxWFdUCHsOYejuzVKLGx1vkW3ekE/FhdmNUdCKJS4O
         5+AkbBh37avbLjk6w01CPbGK6oszrsGQG+PqG6SkX1d/vzb8jGt0yuTVKDQcVLzbHlMD
         edTQ==
X-Gm-Message-State: AC+VfDzKfQa7dVW6afccrWeK84XXQzWpWHcvPUGfRdY0cAsTTL5f4eho
        rBGrlm9W45BBYx1gif1TlNrMqw==
X-Google-Smtp-Source: ACHHUZ4r+LhHj2nOrTPPY0XUSIir9vyAUi+8HJd6dq36MjTRh6EGPLnK+XO0v36RsP9zv2t1bP3uVg==
X-Received: by 2002:a17:907:9305:b0:974:1c90:b3d3 with SMTP id bu5-20020a170907930500b009741c90b3d3mr1952724ejc.12.1685444378125;
        Tue, 30 May 2023 03:59:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906504600b00965ac1510f8sm7148101ejk.185.2023.05.30.03.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 03:59:37 -0700 (PDT)
Message-ID: <fbef157d-88ef-7cce-9bff-06cee53b9a16@linaro.org>
Date:   Tue, 30 May 2023 12:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 03/13] dt-bindings: arm: qcom: Document the Qualcomm
 rdp432-c1 board
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        kvalo@kernel.org, loic.poulain@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-4-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230521222852.5740-4-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
> Document the Qualcomm rdp432-c1 board based on IPQ5018 Soc.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V2:
> 	- Renamed mp03.5-c1 to rdp432-c1
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 33a9a97d7b5b..53ae2b6b2da6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -337,6 +337,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,ipq5018-rdp432-c2
> +              - qcom,ipq5018-rdp432-c1

Then keep it before c2, to have it sorted.

Best regards,
Krzysztof

