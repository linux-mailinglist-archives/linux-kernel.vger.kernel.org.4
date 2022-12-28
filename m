Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26E2657A27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiL1PIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiL1PIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:08:15 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1449313D5A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:08:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so23996766lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvoaUVlI285DJxXau3dNL+g6kLRhbJT4y1ScX7i8GqI=;
        b=KRz1ugeTeE5shFPwKo2/mZX2HG1BAXYV25vlDoxH61FV1a/byeKAmLbT85OUcTwEnI
         k7a1z6tqBbOVHm+L4kEBUi4VkXVwLDpsFtaEHHX+aog84SzM9uL4e2j7XVD2z3Xdo/9c
         KSNgtASrBFziQzgpxKYn8Mz1YXG9odRbiAQkcLr/E4lGZEZZ5khszA3Ln9RBhIj1ZzAf
         0AVjtaWLRqHqDhroXTQxPfBq7u+mUDPZuGb8F5y90djUHG2cbxTg0oRLo24uhVvWJoG9
         ML95E3ivHoe+NCam7PKsWdV6qVc5QV2KMHl1h4kZTbUWivmlONKdUS5UgItgkscJrSXV
         lBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvoaUVlI285DJxXau3dNL+g6kLRhbJT4y1ScX7i8GqI=;
        b=E2uqkhZMZAzc6a6CT9bKF5+JkhtZQp54I62PzUQkHn5ZENUDXpKwfqqMU8a6SMy+go
         lZpaKdtct6L8Bxc0LUUxWJgSsXyizTQ88sBcnS/5oLx9FATrS1/+Jaalso0Hp5CvMgYz
         rWzqd6isXM191gWByoydMMBfQu4/wbB+aD6H3LBUJYDRO1RT0FEz0qnQHCNEarvV39MW
         sADMHZYeUKa1Ff1SAfi5pgTDvWDtyleEL7MNPdbaJP3n3BYpTerxt5M9c6CKXcx/EvC1
         5wTK5XoNmc/vH+ekbGT9g9E5vnMm0xgkGjojD5HdaMm0otQV1lp1xnsV4iGz8lk9jc1t
         /yfg==
X-Gm-Message-State: AFqh2kr/ij7Zm2yrx9nrQVkZMLyf1yXT/dEUvEaBY+fTvbRksekNa89W
        vm7xjLRudJINDmMCnyur1zPnvA==
X-Google-Smtp-Source: AMrXdXsyazxH9ayip6OwOKWlEqFs9prb83uyZtAy6fABC4Qtj1GpnFuz0aWl3a2VV3M1BIZoYotubQ==
X-Received: by 2002:a05:6512:2356:b0:4b5:6417:43bb with SMTP id p22-20020a056512235600b004b5641743bbmr9430166lfu.51.1672240090961;
        Wed, 28 Dec 2022 07:08:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004b15bc0ff63sm2671305lfr.277.2022.12.28.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 07:08:10 -0800 (PST)
Message-ID: <d0127811-6be1-4f1c-c138-1e8b0c69aaeb@linaro.org>
Date:   Wed, 28 Dec 2022 16:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 01/11] dt-bindings: usb: Add device id for Genesys
 Logic hub controller
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-2-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228100321.15949-2-linux.amoon@gmail.com>
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

On 28/12/2022 11:03, Anand Moon wrote:
> Add usb hub device id for Genesys Logic, Inc. GL852G-OHG Hub USB 2.0
> root hub and Genesys Logic, Inc. GL3523-QFN76 USB 3.1 root hub.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> index a9f831448cca..db009f3ef438 100644
> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> @@ -16,6 +16,8 @@ properties:
>    compatible:
>      enum:
>        - usb5e3,608
> +      - genesys,usb5e3,610
> +      - genesys,usb5e3,620

This does not look like correct compatible. Did you test the bindings
and DTS? This should fail.

Best regards,
Krzysztof

