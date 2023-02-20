Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86469C6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjBTIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjBTIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:30:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0884C13503
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:30:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec43so890337edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Js7L+CkgcBF/y/Uhhz2Sc316S081v8fL7RAo0kHVqwk=;
        b=IGB4kXcYu67P245U4esqcKoLzMy8Kjkvo8zfwueszOkGC3HxvBxpRftuFL6CR+yVQL
         ejXHuDRCpdSZ75of2N6xqwXKIHoTyBILDODkcC3wPyNr4jTSWPSYhksUjim9EWz3fvJZ
         i5M7kaO2WFG0NvrM9AriGfWqLuhbqtq61LGCGmDz9dQXh8LdXOyT741FM2wiTifIxTvm
         BrW5hKvkRRjx0DQcFHAZZOAJyaei5EG6MfUUW5L74UWcDjxyZJnyW6dJzcSR6qf1uSlB
         6WpTPlMbaO2J+Lq36Nmn8mCz1KmorioT4Thf0lOdQ1juqCRwDYA48BwjKqL+qjxxacXQ
         mFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Js7L+CkgcBF/y/Uhhz2Sc316S081v8fL7RAo0kHVqwk=;
        b=MO1ArtAB/vbSUwNlu0nCLlMWt0sQIEIp/eWZ2DBepTgPry26jOgCiHsDpktu6FQiE+
         /mw3BBo7vapwoysv6FyB21RUUiJ2XNhhVelmH1hPJwH8R6YGx5qOsXVQWLBEFKljfKDC
         vZKaMuIJGuWA0H3KUEItaT7n4sFkJnb3tH1tn9kDRr7xMDufyhFPTeP/CAfmhyjSjqCt
         TX4Dg4uOsush4Z8uA9fmx9oUr6H8nLkZ9C/9yN41o/ZjTxnZb3y3Sxl8h62Gj5E5lh9N
         SmL0QKyqK+g2SrzIgGa9LYOQ/8PdoNa4p1pDHb7Ak0AXAFVFfkxG35OTnVnfhFaOI3tO
         cJKQ==
X-Gm-Message-State: AO0yUKXU1k1GZ9GyNd6fR4C1opRY8rDFisXrU7u/28YL28HQ3decN7Sd
        ERDu73BNBdUIDZ4HL6M3xw6TNA==
X-Google-Smtp-Source: AK7set+kA39fOKMbx4fa7bjTggtkXN1nyAZdsFsGIrOygGYCF8H99jPC9Z9nxFi5UUMXqsaVR8tAKg==
X-Received: by 2002:a17:907:6e8f:b0:878:4d11:f868 with SMTP id sh15-20020a1709076e8f00b008784d11f868mr13303080ejc.2.1676881826565;
        Mon, 20 Feb 2023 00:30:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id mj8-20020a170906af8800b008b12c368ba0sm5443723ejb.45.2023.02.20.00.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:30:26 -0800 (PST)
Message-ID: <54ef0dee-30dc-3ba9-d2f7-8270204b5505@linaro.org>
Date:   Mon, 20 Feb 2023 09:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2023 07:17, Ryan Chen wrote:
> This series add AST2600 i2cv2 new register set driver. The i2cv2 new
> register set have new clock divider option for more flexiable generation.

Typo: flexible

> And also have separate i2c master and slave register set for control.

Since several of my questions remained unanswered and quite frankly it's
fruitless... so let me read the commit msg directly - it's the same
device, just with different register layout. Having new compatible makes
sense, but this should be part of old binding.

Best regards,
Krzysztof

