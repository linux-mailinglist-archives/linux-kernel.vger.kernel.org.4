Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369246961F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBNLId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjBNLIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:08:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CEE28D10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:07:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so11243385wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/x/rsjIfX8cVukRoZpVMj8ulC9usfl++XExw7IzCvjc=;
        b=z5Vcg/uSLCCZaJnJRo/G5NZMMB9MEiYsaWxXG5fr4lJut+jv/Do/KA16eAC5Jz8nwA
         KBMeNVcgAzL6UC/EyTCOgn68JLJF+Lhh56qEJCT8DhVSSShSOLSjiZVo6vQdXsgqumX5
         1L2vNXJbljI1KS3ci7c9FZMKI1Ja+0+bfzAUpoPaIdYg7S2hY8QhO6hWbq3bFY6ztEkM
         Vjg3aXW5Mno8XyOqs1grcrRRrNO46nikPBkPTPFkZ2BiRHVeV4r/cHZjnq0zUry8I4js
         ibcZQRx3nTWKve7Qr23PCeItZzkQkH32b5RzTpD2o02doYNkRyMGwnhJsk7WoZd+mLxa
         n2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x/rsjIfX8cVukRoZpVMj8ulC9usfl++XExw7IzCvjc=;
        b=zkc7snl/4l0ylfDHKZ5SfQyDYt9bA2QH6VJYx7Zz/IoQDWKXPXC9MU+7SgUPZsonKt
         ZomxaYsK7i5I7wFR/Bp7Q5VCltTP6crlrf7V6js+5uRZnoKNUwNw8doG6BM0F3/OVOfT
         QIt3dm/fAOjlw+gtzD0YtzvCZjLoLlVx1sQC1exI6LqWfj/j1e/i90lyWRLp7XiKhmIg
         rT3ETQeqTDOkGxrRziwkdDp45y+TU5Zock8fwH/n/c+BJ5PNhLrutBAG4nbxNvwmDeeu
         46LcQtxz+di48VYQkmiTH7KII9tazeYiJC3Z7hGItZv5PSEWRpIVgR8ImJKrk/CV3Yxe
         ElJw==
X-Gm-Message-State: AO0yUKWjBxy+L4LRe0oFU/S62uZo2GuzCFTISKbYUmxoyVMC+oIwXrde
        HXjEBrVz10rXuvWFIWm+Cq+gPQ==
X-Google-Smtp-Source: AK7set9qqr12nSUuP1wmFNr7OQjf99rGM4R11LsGYRErJneSzpeH7Fy04rihSaD/pkp7ikEazUr8gg==
X-Received: by 2002:a05:600c:1817:b0:3e0:c0d:75d8 with SMTP id n23-20020a05600c181700b003e00c0d75d8mr2329271wmp.23.1676372822579;
        Tue, 14 Feb 2023 03:07:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w19-20020a05600c475300b003e11f280b8bsm14906852wmo.44.2023.02.14.03.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:07:02 -0800 (PST)
Message-ID: <57ff2267-93ac-2c31-9c6c-a752a8807eb1@linaro.org>
Date:   Tue, 14 Feb 2023 12:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 08/16] dt-bindings: nvme: apple: Add
 apple,t8112-nvme-ans2 compatible string
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-8-22926a283d92@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v2-8-22926a283d92@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:03, Janne Grunau wrote:
> "apple,t8112-nvme-ans2" as found on Apple M2 SoCs is compatible with the
> existing driver. Add its SoC specific compatible string to allow special
> handling if it'll be necessary.
> t8112 uses only 2 power-domains as no 4 and 8 TB configurations are
> offered.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

