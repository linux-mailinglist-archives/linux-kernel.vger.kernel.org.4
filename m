Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4B6B38F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjCJIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjCJIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:40:35 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81749DB6E0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:38:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cw28so17428054edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8P0RjPPjJ6gDx/O+UOt7XYuZJFBYo2c+dJvtzrcfc8=;
        b=Qm6w9iISowR+oMVJYM/hQSnZ4JRKkanoVQFKUhlTESl8dqbNr4Qghw4HziigDxrHb+
         3uCO8RrB0vZVGj3UAekguMmehIXsYMTd1fjEMpnGTvZWSntMe9MxdJc9TCxeN1qRnss1
         9x/nQEu0IpMw3T+pD7CKP1FZIqqKK3F54sneBXx1k+LoI2TVcVgBMOdtduWQIqOMNt5E
         F8xY8xlmYVP+l3SrXc3O9D7anX14xNKTDiBvRrCnIK91MDso/N8+UvT+qJ1iwRDjSu9E
         h+xcHj5cMsZYP8lylmurMTu8vfkN8t8MS0IluatHJWeHR8WkV+ikebzhhc6GDU/bIGIg
         StaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8P0RjPPjJ6gDx/O+UOt7XYuZJFBYo2c+dJvtzrcfc8=;
        b=L1KjKid6Z6AkyGqKW65EDsg3X6f0UsN9Hq9yixkz4VIlnGXov4T9Vk8PTR80KIIdvA
         Pb6+zV906sqyYxBNRZGXS8BWw+wkNtFY9VIqREIDFEMwRMTX6BUPiHJKvvMo5VwrDOHK
         1IYumPYKT/sC/Sr2j7/8DjgpC3JlFZIQvEieAqFa3sS3o9jY4b1yIH856EGGWUhfBfio
         WkOkhcMX1GwdYPy2lh5ZziNC3M3YzPRycDey4IrAeCDWcrjnJdATa+ETTb5INlG91++v
         7F6jDNHovA2PcsSd7Ur6d/a+ZkgbpfLr3YD8ofCu5xSZ6LXCbT/KgnROEjUXA+XjeNI/
         SzKQ==
X-Gm-Message-State: AO0yUKVm3VNehaeSxZHnBhItqqE34rQRdXaYwN5so9oNhgJWk9LP4+hp
        OP77vMVOeB3kbj1AOzjbzcAVgw==
X-Google-Smtp-Source: AK7set9lDeUYOs5nAUvtFokDH1WpVjNALEB4b0oSQYXxs4FuVsLXJyZ8SKM7u+8wBouXS4esT6UkBQ==
X-Received: by 2002:a17:906:2a55:b0:878:66bc:2280 with SMTP id k21-20020a1709062a5500b0087866bc2280mr24741630eje.12.1678437500095;
        Fri, 10 Mar 2023 00:38:20 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090668c500b008ee64893786sm681605ejr.99.2023.03.10.00.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:38:19 -0800 (PST)
Message-ID: <89e8b1a4-8063-da12-1b91-a9d7bf82fcde@linaro.org>
Date:   Fri, 10 Mar 2023 09:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/21] dt-bindings: display: mediatek: gamma: add binding
 for MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-8-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-8-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 15:22, Alexandre Mergnat wrote:
> Display GAMMA for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

