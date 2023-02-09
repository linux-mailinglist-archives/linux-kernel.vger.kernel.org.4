Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A65690281
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBIIvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBIIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:51:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888CF47436
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:51:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso932166wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eUi0+pogx97QXn9Rou5pDGb9vpsF0M/z1DxS9OrlVt8=;
        b=D0xWK2k4J17lzN1JTnVZZLkR/zBiywl6ZILZC+DlL6jrOlWFbSXF6oZb80PMMOR8fQ
         YtaYePUeL5CDLM3hFUn0aPZ3Lt8CmWSRXKTSNGcaaIbajfbHAXUmwLgsoPMcPsv9+kG5
         S5mZvVutg91cRWcVJqxqZfJlTtpCLiE9+7YPJ/zkDcI1icQQe3a+u+N41ugvaskBQ4hZ
         j4nheCT1W1EDNRZGAzMfkX3gBF3Cw8eC8izpcalohsgh8VPeaJ6c4bE8tFz9gHbuehwV
         PRnBj4QakLPvD6nRRPeSJ/o7Ef3cZXKPDeLJnZQRIXYCKJbyxyThBLY0Lrixq8i/d1Tv
         +NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUi0+pogx97QXn9Rou5pDGb9vpsF0M/z1DxS9OrlVt8=;
        b=xYkkbCvOM/ef0a3ju9FB8LPI7DGaLvoV/ugoEfvE4SMuRnqFw5o0pLg1jNXmpWPSag
         ANYP1GR/2dqshIuTvrIzEqlgK6OMcD0V0cSD37rK2iIfcvX5Tqkp3aDw3Th6ggykKnbJ
         cLwJ8cCX7Ljeuq1pJ1H4/q51L2y18EBcyHB3dq6m4L1QllNXzxG6wz1l3YObto8aXI80
         fmathIftsVcbENuSymx9O+8AV5d7TZSiBirRNK0IirLBkzjwRfJbEWh057Ti9Xr1kWa7
         BvZGnLJItIdv21UGw9z4CDcdljUuKrDMkQJYD4g5MdP15+3gYbP8USEzm3AOmFVHMxHF
         /XVA==
X-Gm-Message-State: AO0yUKVoPfpl8SVTFFmNklakNMwk8Am+vVUmZ8L5B6mgphSBRHIywoYt
        lyIe1ZRqMW+QAbT2F8ArcKMCVg==
X-Google-Smtp-Source: AK7set8JFBpCe5jDMzxfhVcIA++GWsEDtFaCTKiFFNZALmRqoMovDG1mXJo0c8dvi4wiqVRsMb7qrA==
X-Received: by 2002:a05:600c:91e:b0:3db:331b:bd57 with SMTP id m30-20020a05600c091e00b003db331bbd57mr9153036wmp.23.1675932676186;
        Thu, 09 Feb 2023 00:51:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm4287082wmm.40.2023.02.09.00.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:51:15 -0800 (PST)
Message-ID: <cbf10de1-ba6a-8e5a-6222-25f2322995c9@linaro.org>
Date:   Thu, 9 Feb 2023 09:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: ata: Add UniPhier controller binding
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230209014052.17654-1-hayashi.kunihiko@socionext.com>
Content-Language: en-US
In-Reply-To: <20230209014052.17654-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 02:40, Kunihiko Hayashi wrote:
> Add UniPhier SATA controller compatible string to the platform binding.
> This controller needs two reset controls.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 7dc2a2e8f598..3f6b21032d02 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -45,6 +45,9 @@ properties:
>                - marvell,armada-8k-ahci
>                - marvell,berlin2-ahci
>                - marvell,berlin2q-ahci
> +              - socionext,uniphier-pro4-ahci
> +              - socionext,uniphier-pxs2-ahci
> +              - socionext,uniphier-pxs3-ahci
>            - const: generic-ahci
>        - enum:
>            - cavium,octeon-7130-ahci
> @@ -74,7 +77,8 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

You now allow two resets for each other platform, which is not justified
in commit msg. Constrain it per device/compatible.

Best regards,
Krzysztof

