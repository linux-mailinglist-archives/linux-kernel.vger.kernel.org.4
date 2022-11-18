Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31362F86B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiKROz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbiKROzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD18FE7A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:55:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y16so9585405wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dlGYFl6XUQyH5xQEd1E/V0bevUlACNWAQdHVOgdC8jc=;
        b=yObTaGsa5pkib3AbTNfuBC8H28vZJR4hDG74Zwave5uRYVAMPPJnAqtb7j/mH3O6sN
         wSI/DxmsBmlohnlux6f8e/e9cy7iWKwXJCmVCa+yuWo3AVE4YbIYGt2IWhm86Zq4G+OS
         E3L1fUEWkIpmVIIkYfL9qjsgDvQO0DOUXmLsULq5Ujw5FFziIj5vypCFGt6pI/SXp4VV
         VmcT6KR0S7KVvA08BB1W8rW3T8NaXj7nGnTZiw5Kc11R4HGgm15/moMqyaz+f2pi/hMG
         ecIwHwlKULEctd20uFy9dkSyyiJ7/+B4TWUVhNONlzQQRZEEYY/ujUkktx7nHhV1YDKL
         p/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlGYFl6XUQyH5xQEd1E/V0bevUlACNWAQdHVOgdC8jc=;
        b=o0imYBuoN8kM71+yWzB2FsV0Itq+BUZcNWWBtk+GUaTpxLbMkCzFCzTFs2ibzwP7z9
         MULoz/tq8ETpJ0o4Y0wTC0XUqYbgADGflQvxkSjDUHQkBE0TeIp+oRvdLwxB5/PygDqf
         KARQuFPQ8g7SOJoHcWG1AAcT1Hd0hlTpisgRE/z909JkxcGg7CRN1xvp1p5XOPKB8gQ0
         CPbpYar04aBZWAJVMs8w90tVpmMbuAvPXqhXft+mqfVgXvNwEWsZwhoSqAlVN9AJEOKK
         mYjNE2+lgBlTlkxnJ4uyeKdM8e8Q/Q7xn8iHWOItBGYnqIz8r0HhA4XUB3pJ1w1p8bcn
         MM9Q==
X-Gm-Message-State: ANoB5pmWusFZsGzKmx6dBp/UY/rfXpB88cq/mcX+9iUYRDPY+QKNMZcG
        CIvu4SELLNAV4//Ym+rYDYHW6A==
X-Google-Smtp-Source: AA0mqf5B4c3Ofn4nvA8MCzk2t7U4aqKAjKRq8PhiFCL67Pk/bpuzhbbgJcn6qstPNN1EKZyNDibw0g==
X-Received: by 2002:adf:fc48:0:b0:236:e0d:9ad with SMTP id e8-20020adffc48000000b002360e0d09admr4594782wrs.692.1668783324421;
        Fri, 18 Nov 2022 06:55:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f7cc:460c:56ae:45a? ([2a01:e0a:982:cbb0:f7cc:460c:56ae:45a])
        by smtp.gmail.com with ESMTPSA id a8-20020adffb88000000b002383fc96509sm3742721wrr.47.2022.11.18.06.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:55:24 -0800 (PST)
Message-ID: <95abd39d-b084-68e5-f012-6a1149bdb8a3@linaro.org>
Date:   Fri, 18 Nov 2022 15:55:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 07/12] dt-bindings: power: remove deprecated
 amlogic,meson-gx-pwrc.txt bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <20221117-b4-amlogic-bindings-convert-v1-7-3f025599b968@linaro.org>
 <15840da8-bae2-3bb2-af0c-0af563fdc27d@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <15840da8-bae2-3bb2-af0c-0af563fdc27d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 18/11/2022 15:52, Krzysztof Kozlowski wrote:
> On 18/11/2022 15:33, Neil Armstrong wrote:
>> Remove the deprecated amlogic,meson-gx-pwrc.txt bindings, which was
>> replaced by the amlogic,meson-ee-pwrc.yaml bindings.
>>
>> The amlogic,meson-gx-pwrc-vpu compatible isn't used anymore since [1]
>> was merged in v5.8-rc1 and amlogic,meson-g12a-pwrc-vpu either since [2]
>> was merged in v5.3-rc1.
>>
>> [1] commit 5273d6cacc06 ("arm64: dts: meson-gx: Switch to the meson-ee-pwrc bindings")
>> [2] commit f4f1c8d9ace7 ("arm64: dts: meson-g12: add Everything-Else power domain controller")
> 
> As of next-20221109 I see both compatibles used, so something here is
> not accurate.

Yes driver still exists, was left for compatibility with older DTs during the migration.

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/power/amlogic,meson-gx-pwrc.txt       | 63 ----------------------
>>   1 file changed, 63 deletions(-)
>>
> 
> 
> Best regards,
> Krzysztof
> 

