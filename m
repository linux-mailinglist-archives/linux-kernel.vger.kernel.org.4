Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3A6406D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiLBMaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiLBMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:30:02 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD7CAFB7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:30:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i81-20020a1c3b54000000b003d070274a61so5907556wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eot+x6gSKfCBcQDdT+E+ufyT2ddBF+fzHgyL4rDDkCo=;
        b=EGFzBk3soIrFl+ejWEtv+azDjP9gntvI1AhFtEeJRgYqSAdJsqC2IzgHlN8Yd1Gps9
         6SBE/QR3JivHIv811HgLeGP0TKAmYfV3sfhk+GAAHvmkEBaoOGwaMKiafIOhoqrTjoZN
         sdWsQWEF9lpiB8MQc4Tcj95wPtJfxCW92zoYuxQQCqwIBbxCZTX3UNJf+pCkI49Tc6gA
         78JkKFIfqJnQ77cT+HptBppagDsU+iq7Dgw2Lk1OSYpC+55+BaDQC63pP9xrBnnDNBED
         5CV9U56FIhrbCF1ZxGbyzZFp8BFK1tG6E1Gsr0F5NZJz38mC8eHIGh2N2+HivrC/C2IR
         Eehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eot+x6gSKfCBcQDdT+E+ufyT2ddBF+fzHgyL4rDDkCo=;
        b=LiHBo96EIZ90veT+mKeV7DHUXJvhZyQdezcVmC/XYuqHqn28Tls6vU6c/vt8T3eKwO
         LCXhJFilWBucAjrjusJvYbBLfJqo1Kjv+2f1THWut8VQPph3UNQbrmj9L6PSCYXY4iVl
         huyoN+k3kTY6MA+p6A4C4MCC+4sDaKAFGtt6PPUijjzzVvYymNDeAckEgsR3Gw2cyGxZ
         rxG22aby1FgMC0tZ+dS35BgSlOWnjPOOfrvqteljQKg3jrzH2s9CKXd8dLgbn8D6oSSd
         3QntuVplohrdBBpHK5tUce+mH0xo2W0KpWxXUGBYpU1bHk/Eo1vOexKz6Luq0Jctsod6
         YWww==
X-Gm-Message-State: ANoB5pm9BrQgbf3GUwBm/15jxsLUsRz1SJMeb5sc8rwiGePbjpDJSHCA
        tp2bTF8K+XMqMLgW01FFKwvIUA==
X-Google-Smtp-Source: AA0mqf4zkiOXKaHo/zY+8X2z2puykSqk5Ho3aejzJuO5sF/SnwNhfPFMm+Kx8D6CZ2hgoRl3iNxwZQ==
X-Received: by 2002:a05:600c:c3:b0:3c6:c0e7:88b9 with SMTP id u3-20020a05600c00c300b003c6c0e788b9mr51193779wmm.47.1669984199385;
        Fri, 02 Dec 2022 04:29:59 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d5-20020a5d6445000000b002368f6b56desm8084174wrw.18.2022.12.02.04.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:29:58 -0800 (PST)
Message-ID: <29c41ba0-b0ca-12c1-65b7-75e51f560ef6@linaro.org>
Date:   Fri, 2 Dec 2022 13:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Add r8a779g0 support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 21:48, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

