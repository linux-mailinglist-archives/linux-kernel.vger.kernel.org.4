Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1906B3903
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCJIld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCJIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:40:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD23916AD6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:38:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so17389758edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tqTbN90TBZ0zefNDHJFQj8Y2oFNn+f8xqJtYKWO66M=;
        b=pRIzZ6UCXmZB2NcXkc7WBVCJ4vwl1sCOTvFMG/JG9/E2ijwpL3As5mJDTmX7etHMht
         WgTM2o0G/yHgu/7xR9eB3kGZC2f8kCyXdIQsjwN+HrGuFgrETv1P/8rPa2tNxxD6oi33
         frhXLk1Q5GFvR31T3l5/4FaRTdGwSo2HqtWQ0S/JQwyKkQ129k9Lc7NuWkgOffv1ilOc
         Y8iojBlVToX4Y1Y5KoZblpTphuQ3iuoO2WVQnRa0RqGEf4lispXd7kWN1algg0L5uuIm
         7U3mDuJzcm2kI6nqr+lRIlKgXojvbqImqJH7n8l7sa8Z3ODbpiOhFJk5Oxsc3czcombI
         7r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tqTbN90TBZ0zefNDHJFQj8Y2oFNn+f8xqJtYKWO66M=;
        b=cg3yzjIbVPV9sWhU1o89iYDgNK/FZzjvQ1TFQr6Cu4KGXObb4r34CNWqrzsdDq+rw5
         D4S8NFoj1GTx5T8LZeaR9VbikPiKdGuO/InVvtMvLWs3iLO6LaxAFeGdlh96g45h6Nhi
         Y2M0wYbU2nusx78eJv3SK5n8yKmX94D2f9cwGRAZKEu7HaHAzfuicGMg2S5UqWZtBwiW
         dOb8zvHN2m5cydK13sDX2zVqsEP6S0UovNNyJgWEX1nzFedkY/5SZwCQilJwW23z71Hx
         /BwD1TpQFUz308/w2X960Vk+x7w/IFS5d+ysRFxy9QcJUe7mDebNGtQkxMZR88AwymZt
         n/lw==
X-Gm-Message-State: AO0yUKXvdFTqlARlDmiF4wlnGBgWvcGJijx3ThvyBroD7kFsnDS+xf9T
        08zk8LEV00SGXJbc4t5QRwOQgQ==
X-Google-Smtp-Source: AK7set/h5FxPvnnKJlG+TPaefKxMrangV7NrqmrrnV6erBcJRruBPLyZhbPSj9qylkGQ7tlnCFxtog==
X-Received: by 2002:a17:906:40b:b0:8b2:7150:dcff with SMTP id d11-20020a170906040b00b008b27150dcffmr23818587eja.23.1678437518421;
        Fri, 10 Mar 2023 00:38:38 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906274f00b008d0dbf15b8bsm669297ejd.212.2023.03.10.00.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:38:38 -0800 (PST)
Message-ID: <24ba6ba6-7554-46e8-6ccd-191a385ab2bd@linaro.org>
Date:   Fri, 10 Mar 2023 09:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/21] dt-bindings: pwm: add binding for mt8365 SoC
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
 <20230220-display-v1-13-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-13-45cbc68e188b@baylibre.com>
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

On 09/03/2023 15:23, Alexandre Mergnat wrote:
> Display PWM for MT8365 is compatible with MT8183. Then, add MT8365 binding
> along with MT8183 SoC.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

