Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05D5E6705
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiIVPZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIVPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:25:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557FFD98C6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:25:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so15240161lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SebGlyoCBeyORbtHZUgO5KrpqiG5bAtgXYnFFgwOGLc=;
        b=WzfOZ6ZQKoy1j6NOftVIkE+RehmME9E7kvFL2s6wYMG93zr90StvWZ/dHteFAXfXAZ
         t9SdI4lzSl+IG8kuQTftJeJx+dZ4mNSzNQjXQgn0KxWoLAAWGKZ5CMvu+bdKbcbx74sz
         OixnDhin7iajnmJ31S1GgkWk3k4W6xkleekCRdjWR6NpbjXOYy7rXxlCsGTxApUJaIu3
         eoe6LmJIKHwcx0RwyV/UuWxLcWkHJgfU3faHXdn6vrxgv2sKAeu29QBS/QwwpUabCEJc
         fODl3xrb32WYqru7wm0+RBC3+cJyjHEjfoRhyVKJOkGWFsciPVNgpsRfMSpmf/cZdVFx
         nmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SebGlyoCBeyORbtHZUgO5KrpqiG5bAtgXYnFFgwOGLc=;
        b=vJyyCe4aYkZk12wTEYgUPpHoYjy3dMNd4ZJVuwnZSRiWYdX6kluO3pkKSOrCWINlQ5
         c3hVB2JNvtcTyevH8mRDfjJm63RJ6/p8taDnceczBHuuDCgm2q/cm2i5GCpI3WjjDH02
         wHNtZWpahKMbNL5Oy5/GL7D2UWCoduVeXeLuRYW8eCcZOk4raK6Rhs9Turmgs6nickdQ
         QzZNKJn2CiGUpdsqYqn/G4Rhe04WRpgEXNee56oJbZAHzT5qZBrCeMrlXfyWbAO7LikF
         ox/2e0pHGcNafe2sLlXvMBPfQ/qvlnZW39cD5xTF+16Cd/j/72c33kwmiRCY5kOTPLnb
         7QKg==
X-Gm-Message-State: ACrzQf0v8VvFQHvhyFKBEztBmDFsu9MYb0SB7gCyST3yR1f4rSBqjCxP
        eGdxa5aWAiBOLJZwCCZGS/mIOw==
X-Google-Smtp-Source: AMsMyM46JiJFaWTWduwhsDIfXq6R6eoXzvp7GfTJ7zxWTMR5TAlGpKpemRzJwLWXst3j/uBtwxvYNg==
X-Received: by 2002:a19:f80d:0:b0:49b:29a8:db54 with SMTP id a13-20020a19f80d000000b0049b29a8db54mr1424520lff.178.1663860322701;
        Thu, 22 Sep 2022 08:25:22 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a2e5c03000000b0026c2baa72d4sm957870ljb.27.2022.09.22.08.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:25:22 -0700 (PDT)
Message-ID: <2abe9158-e6a4-ce6d-9a40-f4758e8b2d7b@linaro.org>
Date:   Thu, 22 Sep 2022 17:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [internal][PATCH] dt-bindings: dsa: lan9303: Add lan9303 yaml
Content-Language: en-US
To:     Jerry Ray <jerry.ray@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220922152438.350-1-jerry.ray@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922152438.350-1-jerry.ray@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 17:24, Jerry Ray wrote:
> Adding the dt binding yaml for the lan9303 3-port ethernet switch.
> The microchip lan9354 3-port ethernet switch will also use the
> same binding.
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>

Please do not post internal patches to upstream mailing lists and
upstream people.

Best regards,
Krzysztof

