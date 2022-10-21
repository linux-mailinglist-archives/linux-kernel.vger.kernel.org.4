Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D686078ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiJUN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiJUNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:55:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6029A24989E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:55:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id f22so1661857qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atOz8/XRKPnbyJLTPMaDXLOO7wN9bymw4gIbszWubUs=;
        b=UGaWLB6j8OxVe8dmmcIYNQnaOlpI+0eXu8BajNHD+ZMG4qzneObyu7rcUSIOi1ZUyv
         dYZtPdUG3VVmdsaxuvlXK78Ywy3c7nDrO67d1tfVEv0zq0uzHe4C8c8T/vOlljUe5Osr
         W050SZtwN9P7wkAea8/zllXsPavR27kWRVR8wC1dzNqXrqFOayIPUNPXWTn1SE8Dh/Ud
         0IjrnoiwKi5Dvq1Fvo2hod6lQ1Yjaa3D15s5MRZDDV+7OKM11BzUm+CsTaUz5l941+jT
         YPejLlRpQWjgJRMYEkyXEurngD0pP5Ok1BQU5chbCLayFYSBEb6M7l7Gu+ANz+k3j6EN
         uutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atOz8/XRKPnbyJLTPMaDXLOO7wN9bymw4gIbszWubUs=;
        b=DmseiSXybdmd4OQ3NaaeLH12R3BwiYN7UxbuJ8jhxUYvY1gPEID+BkalgCN2zx+x/P
         IczugwvWLmUYytU5awjibM2cwJ+pOhplgpaBVfIELfb5PbtSmgIjwT3WbPDme68Q9Bwz
         e+Yt5Dv/8Jh0BnHcsbimRzvBEtdM5dJkPkSXgBcSewAuOy4TNjPDnZIVWDgWjJyIJgj0
         d6GPOk31FPzFAMSasU27rwQD3lyVfjA8Ee+ccpsFHdqcV6h3W3Kiq5/j8z9VJcXJB8JY
         AR+BGUAjDstwRQOASZ3b8SE9FOS2HjOdkyqO0FV3oUm8D0nPieRvIwtuqABVQGn4cE2l
         C5tw==
X-Gm-Message-State: ACrzQf248LdX76ipt84bn97X4nMuubqqEQxHJrWu2uTAK2INDtP4RwzC
        dCD141ghackWQFO9PtDEV1+qkQ==
X-Google-Smtp-Source: AMsMyM7aTcTuZ74sxriHigv1CN8feEtvci/u09fLiaGKZ0olJSVSsi6r6gwV45XGCsHeYNqSA7mHww==
X-Received: by 2002:ac8:578b:0:b0:39c:f006:3563 with SMTP id v11-20020ac8578b000000b0039cf0063563mr16081124qta.636.1666360556530;
        Fri, 21 Oct 2022 06:55:56 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006ed61f18651sm9980834qko.16.2022.10.21.06.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 06:55:55 -0700 (PDT)
Message-ID: <7c6f47ea-5dc8-6662-eeed-81bb14ed3102@linaro.org>
Date:   Fri, 21 Oct 2022 09:55:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/4] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
 <20221004-up-aml-fix-spi-v4-1-0342d8e10c49@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004-up-aml-fix-spi-v4-1-0342d8e10c49@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 09:31, Amjad Ouled-Ameur wrote:
> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
> pin biais when idle. Therefore define three pinctrl names:
> - default: SPI pins are controlled by spi function.
> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
> by spi function.
> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
> by spi function.
> 
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

