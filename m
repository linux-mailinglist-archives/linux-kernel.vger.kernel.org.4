Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F6D719399
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjFAGx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFAGxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:53:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4E5107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:53:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96fdc081cb3so55605966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685602431; x=1688194431;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wy1nuKe9dp+eWuPldOf3TtXePfHrrKoH9eFDnQbPB2k=;
        b=ftFG+tInwul7DileJC7NDnJAXc5+mJ3bgyw1BujBWgZDXPjhLRNjPR788l2+dJOji3
         4yZ1W3mMltATahD5LFmm4nTdnflz7BA+odHKi+L/MpDbE7eFZKJLwS1Ck//C9iWtm6ht
         JVI/vq/aJAttbnZGSA8swxmGiJy621j1+vyvHcLMS5DqGGw36WdhJotMi0U9mtDKYHNj
         cwgwnwW8Ciqag4lTA65W4viTKLmoKJvQ00SGInpHwLsDHP65ME1KdWCH+qfQgx91vSqL
         SF29aHRsMGvtTvnZFf08XtBpRL+bIk7oy+/XN6+s+hvwYHAjXu3zrGXMUXBydRJajnGr
         710A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685602431; x=1688194431;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wy1nuKe9dp+eWuPldOf3TtXePfHrrKoH9eFDnQbPB2k=;
        b=Udls5fp3oZg82JDVnbvoexw1h2FfLuRjDPTC2BA+GIBoeRl04jBitLmLQdn33s7SAt
         AUikPQbfE7ORwHIZcs4FlYsC0xxrBA46+YclczQSHNj5xjHjedREmTh5zNZ4z+tZ9EOk
         1jiQKfXe0nxA0RhGIX0Eqr0f40EoNbUpbNv/ssTGMGNCoTtKxuv9LbJdAzADWXiLjVqg
         /SL7s0xDjnoqlVzNs2VNvHIzo+6CUgzVNTmXQ18P1dSTaZZKbHeAkcsPvw52qlJB7J2p
         xtE32uM31xXuX1mYRLeC9PfZYHfmPQUTVMgTd0U/EqsBMzUYwxhbkNeQ431Pf35MXXHG
         lodA==
X-Gm-Message-State: AC+VfDzdsCs8LClBJWdsOroCNNd7Ee5MRH0XBZAObw0R8geohfxvdcJs
        ZYWnm26peYjxQn6nSfK1FOF1Og==
X-Google-Smtp-Source: ACHHUZ7AcpoTcnH2btdZ20lRMn5AeEGvUeXhNkieDRwTI+omxRnH9Avyf/dCT/n9xHbBm+RMWQTd7g==
X-Received: by 2002:a17:907:6d23:b0:973:d9ad:273f with SMTP id sa35-20020a1709076d2300b00973d9ad273fmr6964433ejc.46.1685602431496;
        Wed, 31 May 2023 23:53:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709062dd500b0097404f4a124sm5264376eji.2.2023.05.31.23.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:53:51 -0700 (PDT)
Message-ID: <d2232369-c7e9-c572-8528-243800f0bc08@linaro.org>
Date:   Thu, 1 Jun 2023 08:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] dt-bindings: hwmon: hpe,gxp-fanctrl: remove fn2
 and pl regs
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-4-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531151918.105223-4-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 17:19, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Remove the fn2 register and pl register references as these memory areas
> are now consumed by the GXP GPIO driver. The fan driver now gathers fan
> information from GPIO driver.

How is it expressed in bindings? I don't see it.

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---


Best regards,
Krzysztof

