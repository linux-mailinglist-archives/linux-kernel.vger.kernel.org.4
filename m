Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A46D9E48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbjDFRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjDFRPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:15:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6FB72BC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:15:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5002e950e23so1271313a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680801326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/acLh4KOig99xCm/V9WrFZvIgzSBqVUp64UT391SRw=;
        b=JIwo5ZGRMeYyE/7IQxTnC3A+fotsrn9neIdNq6E4NRFpsndyz0JehvXFSIylJBK8ub
         LoTdXHdIv2pb2QHJk08i423+1ZXsWKfwfXardNdMMYqjl8XGrTBflzMzgYxYb8Dq8cZY
         wmFzjrSzL7x8l6aUC8Q4BP2jrAE/YIwbG/XNaUI+kc4U0I8JRag7J4iMb9aYymowQB4C
         IUMSUOHYgOMSvXKup2jBydbq1nnvIb4coRAOpHIxHHhYUfJPfZczqErwZQwFsbNvUrlg
         8WAFrQaSH9sYi2CpuOlwjZ0y97RysFZID/bdh+9H5ozb+Xki4QUP1xWCMvxjMZPB/Qv0
         SMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/acLh4KOig99xCm/V9WrFZvIgzSBqVUp64UT391SRw=;
        b=v854l0bmlb1Z3Vvb+BmPrn1Elfz/hKt50eULWjXldwaTl6ltTx+tqhQlXQFKVkkrbK
         WWS+yFI9cZgpIWNZGQhckE0kKzm1ms/Lf7iUzNwNDk55EJqiVOlMEVxa3zK/FS/VbUGk
         GWi6fmuGrj0jvTqfecAi722blqeyl5e8iiMSo+l3gnz1lN0FGPbmuPzQQrLSQRkixkCN
         tJDgW+mX12cfFMa3s5uRlS+Gr5P4r0yw4j1P6paaxbXqJ5tGqT5Ml8aE6BSBjOFOsNz8
         f9+icbZrfnGu4q/c7Yl9UBst1a9//XB4CzmjEj2bZb6BxTpg9W5GIl86isPN3kqh6f+g
         CoDQ==
X-Gm-Message-State: AAQBX9fIdQowjCyqPDX1fGjc212KE4UMInayeYjRK5zUNFzpXpERbFyQ
        CVzhAJfHYHai4WLIcms4Ssb9wg==
X-Google-Smtp-Source: AKy350bE/vnELTyryVtVPyEHqcyqo0/nGsw5Ao9XOGbN+UWCla4cqusv78f8aqXGcfYpdxMYmQ7eyw==
X-Received: by 2002:a05:6402:611:b0:502:4c82:9b4d with SMTP id n17-20020a056402061100b005024c829b4dmr347667edv.15.1680801326585;
        Thu, 06 Apr 2023 10:15:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id k30-20020a508ade000000b005024aff3bb5sm965527edk.80.2023.04.06.10.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:15:26 -0700 (PDT)
Message-ID: <223892d0-9b1b-9459-dec1-574875f7c1c6@linaro.org>
Date:   Thu, 6 Apr 2023 19:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: Convert ATH10K to YAML
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230406-topic-ath10k_bindings-v3-0-00895afc7764@linaro.org>
 <20230406-topic-ath10k_bindings-v3-1-00895afc7764@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v3-1-00895afc7764@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 14:55, Konrad Dybcio wrote:
> Convert the ATH10K bindings to YAML.
> 
> Dropped properties that are absent at the current state of mainline:
> - qcom,msi_addr
> - qcom,msi_base
> 
> qcom,coexist-support and qcom,coexist-gpio-pin do very little and should
> be reconsidered on the driver side, especially the latter one.
> 
> Somewhat based on the ath11k bindings.


> +  - reg
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq4019-wifi
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 17
> +          maxItems: 17
> +
> +        interrupt-names:
> +          minItems: 17

Drop minItems (the number of items is defined by listing them below, as
you did).

> +          items:
> +            - const: msi0
> +            - const: msi1
> +            - const: msi2
> +            - const: msi3
> +            - const: msi4
> +            - const: msi5
> +            - const: msi6
> +            - const: msi7
> +            - const: msi8
> +            - const: msi9
> +            - const: msi10
> +            - const: msi11
> +            - const: msi12
> +            - const: msi13
> +            - const: msi14
> +            - const: msi15
> +            - const: legacy
> +
> +        clocks:
> +          items:
> +            - description: Wi-Fi command clock
> +            - description: Wi-Fi reference clock
> +            - description: Wi-Fi RTC clock
> +
> +        clock-names:
> +          items:
> +            - const: wifi_wcss_cmd
> +            - const: wifi_wcss_ref
> +            - const: wifi_wcss_rtc
> +
> +      required:
> +        - clocks
> +        - clock-names
> +        - interrupts
> +        - interrupt-names
> +        - resets
> +        - reset-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,wcn3990-wifi
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          items:
> +            - description: XO reference clock
> +            - description: Qualcomm Debug Subsystem clock
> +
> +        clock-names:
> +          minItems: 1
> +          items:
> +            - const: cxo_ref_clk_pin
> +            - const: qdss
> +
> +        interrupts:
> +          items:
> +            - description: CE0
> +            - description: CE1
> +            - description: CE2
> +            - description: CE3
> +            - description: CE4
> +            - description: CE5
> +            - description: CE6
> +            - description: CE7
> +            - description: CE8
> +            - description: CE9
> +            - description: CE10
> +            - description: CE11

What about interrupt-names here? If they are not expected, then just
interrupt-names: false



Best regards,
Krzysztof

