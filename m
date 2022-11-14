Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1C26276FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiKNIDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiKNIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:03:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1CE18E34
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:03:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d20so12071744ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKmWNZJlOnau4StwqZyONEbrRvfjS2DujC8qtPDDjM4=;
        b=gV9Ilq7P+Z4hbTD+JeqZURGb3PtUHOW8dvDxnEeBwSYP7QOtPWJQdBxGfPtrEgjNpj
         Expjm5p7p4asTpQm07PzIRUaiBVDEmy1btW7GiuiMOq5jpeIBQeI3me+U3cg3p3eBGlp
         jXJFe3HeBRnUzSnnuQMCBpenOK5cNjsTeYhyaS3w2c59GukMd6T9jHlvdnICFf5KfdeX
         XGt9NGRtsAP/GxjYCI8qPdhsXTn74cwb0mb4FJds/0cxytNcuDo8IByaVvQbbnuVnfn+
         XQAIxqPYxx5hFyFHpJAA/Mj08pVR9ms50GcpiGw39vSEzGC1F5msv60+GKAjl4v5jXoD
         FwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKmWNZJlOnau4StwqZyONEbrRvfjS2DujC8qtPDDjM4=;
        b=rYbVFZv8Xz0Bh+boPN3yAp9m/vl6Nh8Wry2zOScaVvZ/yWzBI0YeRlI1fuVKsxxAsG
         jIoyBM/MNdHRRIgfNrdAfpMQGJVKM0TJ1jvGPfUwZai9na7t11Kc9X4M1QDZDmdmm+aq
         pN78OZwfqPAsYzrkbLr/mobVNQukCg26qhMGp6E305cC+aOPqNIChlli9k+lmqJ08JvG
         F0Fii7Y9n/jCNq3w/HUn0sZgx5ceXmJLmywVJFFdbslK+rWC5FimfUyTesTmKkGu4Eex
         u++96ycohbnkqo3KytArMTEKBBEMZwMIGcElOUu5TZIhbArtGnpkKMaX4Q+x2gFcMses
         7h3Q==
X-Gm-Message-State: ANoB5pm/lBzUgpBbLq2/9EREeD2ACZUULD+SVOQRKFAR1f1qir74DDYS
        +gBH20Zd3em6VsqbPL4ewRhNAA==
X-Google-Smtp-Source: AA0mqf58urzLPioNb2gJywNrITZjJ29as4vp/DGV47d2eOF6J8wynEuPNdRFUU4zn8oY1OaWLLkrzw==
X-Received: by 2002:a2e:9845:0:b0:26d:c072:ddd with SMTP id e5-20020a2e9845000000b0026dc0720dddmr3822929ljj.158.1668412985306;
        Mon, 14 Nov 2022 00:03:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p22-20020a2eb7d6000000b0026dfbdfc1ddsm1891227ljo.11.2022.11.14.00.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:03:04 -0800 (PST)
Message-ID: <b49601d7-701a-1047-79bb-dbed27f0f485@linaro.org>
Date:   Mon, 14 Nov 2022 09:03:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] extcon: max77843: Replace irqchip mask_invert with
 unmask_base
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20221112152446.41690-1-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221112152446.41690-1-aidanmacdonald.0x0@gmail.com>
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

On 12/11/2022 16:24, Aidan MacDonald wrote:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

This is a resend? Or v2?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

