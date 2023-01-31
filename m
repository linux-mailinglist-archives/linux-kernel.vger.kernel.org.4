Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627C0683693
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjAaTaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjAaTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:30:05 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C2410B2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:30:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t7so6876226wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Sqp+i041X6Qm4IzxVl4qjEyMByr/avhmwvDBw1CS5A=;
        b=JWDsYbMsNRsCYRgxe3JdOY1OJdj2xTL65WwqfEyjvY4zLpdPz4XB0RU1ABnwHqYmMf
         VB98xFYiPIBhHPISriWQaan36Oms3u0ZcqwbCEjd1UGkyk5Gn2lBqzWChfYJQxHgjWuS
         XnnGwJE87oQaWHeFROmmqQJwzngjoCxw0kq8/nGOo6rWPreRdkldWyySYWXUcdHSFaW/
         nMJPQ54JvIDdvYd4UfP31Q5tsJrPE3ktp/DHhMflUeroVIMJXwGkqFwnBr0bqzbxCXCQ
         DuU30+O5Vpf9Mfi7GdhGT2WpVF9tiJqkQu9s20YUM2maHA+XF9IYRtNJ0o34X15VKDHY
         cpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sqp+i041X6Qm4IzxVl4qjEyMByr/avhmwvDBw1CS5A=;
        b=ytLHYX8wUNAPMDE4j52msvJ1eRpftP9WI0bMZ+KxG8tFoWd7brg0DiZsrAN+0tTe1L
         6zXqYNhMGtp/eLkAel2kjf+9qld0kbD6JGnOEeDMxu4ldipD9ExZ4QD/A14H3MuX7cMX
         yZVN3uLaXo8wRQJ16S481rpBpa3qooTCm6uCRv64YLWlcdHp8JpqwzVrBmW1+9sLQPke
         iGNPUsaCe3SMSVS7u9JPsAl4YAmxRU7JpxHUwa8cbUbuxfjkSiZkUaI4KL7xel4bZ0aU
         aexxO7kQNI2gm2hmvI8NGouTTlLs7JgZ/bg6PFutlmliTqWr/56hE/4jle5uDdPbHBaE
         yFTQ==
X-Gm-Message-State: AO0yUKUGyk4tWxWapqM3rJM0kSM1FzomN0mc789dao9zxctHvst7IMdg
        s2iFYHrbK4gxux4MVUqCFlXF3A==
X-Google-Smtp-Source: AK7set8awXxxwA/ZITfn99j4vlzEVcZiRjHcu0qDqQTK8AhEAyFv06Uvmfk/GKiGguoibgGp/mLZyg==
X-Received: by 2002:a5d:44d2:0:b0:2bf:95dc:436b with SMTP id z18-20020a5d44d2000000b002bf95dc436bmr3801026wrr.59.1675193402350;
        Tue, 31 Jan 2023 11:30:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d5607000000b0029a06f11022sm15388477wrv.112.2023.01.31.11.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:30:02 -0800 (PST)
Message-ID: <141d6394-b062-1bbd-12de-06aaac038881@linaro.org>
Date:   Tue, 31 Jan 2023 20:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 6/9] dt-bindings: qcom: add ipq5332 boards
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
 <20230130114702.20606-7-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130114702.20606-7-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 12:46, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> Document the new ipq5332 SoC/board device tree bindings
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- No changes
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 22553637c519..0a339b8d2319 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -30,6 +30,7 @@ description: |
>          apq8084
>          apq8096
>          ipq4018
> +        ipq5332
>          ipq6018
>          ipq8074
>          mdm9615
> @@ -87,6 +88,7 @@ description: |
>          hk10-c2
>          idp
>          liquid
> +        ap-mi01.2

Now it is not correctly ordered (alphabetically).

Best regards,
Krzysztof

