Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF962F82C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbiKROuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbiKROt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:49:57 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3859B11471
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:49:56 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d3so7085329ljl.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz1fgFvu/EO4HMlO5FNKw0t0f66TQQFrAxbDNME5ooY=;
        b=mCXlT2aWEXGE5G4/8SDvVW5SPhpQwM/LAmoA1FXKxNWbMaxFQJ6lHchC1gmxGvjB1J
         qMGDIa/MyDLZ30UfBbe0oP1mkqBrn2eaC3kS9zBv48nUVlW6PMcU6EBTnuDULS6GTCi9
         e+ez4YhUacjysshZ2bdNrW47yRIj+wJeDXscMFG1mHOGFOWJ1R0r4D1qLEhBBa3s/tVf
         R2kLqtooeIfLpdqw/eBNUO3n+iKXn8zoetYxIGFw8jm9tUo5j2ff60TbmOi3rJhUrYpr
         9igjmxpTDX44ZKxpJxrgAGeCRaebTQnTP66S8cOg2pPG57WDFJrGzM4/6L4R/dmm7J3D
         UkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz1fgFvu/EO4HMlO5FNKw0t0f66TQQFrAxbDNME5ooY=;
        b=RRlLNe74W/Ft+KrQx7EWY8nCfZ7dq4IeiNDZopLOGZJsKIHyOxa8nMDLfLIgQnIMX0
         99X/IcaGSrzCAReXCdSKZZv0QEIQ8a4+jmMg/1eBBxpe8dY7XbjtxPMLlUDJmCwKg/Or
         +AQCTR843D1hLmTwZU9REDt1+uNuKWqLJu5l1fkp4hiyw3031qHe50SuJkqhOsCWlMXT
         7J9Ec0sJKyUTwV/zsQd4xfqtT0udsMfZgonej90j9zrnNx+VtIHJZeriLS+FS17Sskk0
         qeXtEr9XBUh90MmLz+OyuJ5iMsuAWQuklQXTFQEfkUZGjs6tEuniSi/Qbt2z+NNdPGD8
         hJ0w==
X-Gm-Message-State: ANoB5pkFRNMWC5PBH1CbNizBM7WOuv3iXjoEtNnFtH0Bav5qzHPnuuVJ
        95/wO3f9QWbGL8w51CqBZ36lLA==
X-Google-Smtp-Source: AA0mqf6L9W5MCkqEZsf64R6Fo8bZ58XpODRGgBZIIWvJLUKFWkuvQd/iPa+mcXNvtk+PBNvZ12YO+Q==
X-Received: by 2002:a2e:a4c8:0:b0:26c:4c27:a478 with SMTP id p8-20020a2ea4c8000000b0026c4c27a478mr2420022ljm.92.1668782994596;
        Fri, 18 Nov 2022 06:49:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h3-20020ac250c3000000b00492c463526dsm686190lfm.186.2022.11.18.06.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:49:53 -0800 (PST)
Message-ID: <2e10ec36-46a4-020f-34f0-30359001ff43@linaro.org>
Date:   Fri, 18 Nov 2022 15:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/12] dt-bindings: media: convert meson-ir.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v1-5-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-5-3f025599b968@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 15:33, Neil Armstrong wrote:
> Convert the Amlogic Meson IR remote control receiver bindings to
> dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/media/amlogic,meson6-ir.yaml          | 43 ++++++++++++++++++++++
>  .../devicetree/bindings/media/meson-ir.txt         | 20 --------


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

