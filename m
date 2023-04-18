Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704756E6986
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjDRQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjDRQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:28:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D913C3C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:28:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dm2so74826996ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681835324; x=1684427324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1izybgkMQUv0KTZ7YUu7PpN/DThKjHSmFy8njwpB1c=;
        b=X8Ey7dsXee/yR992EOF1qafczskzajgK8aFDKxqtfkXTxWYc8uaP/XuMS9H0A3G5tv
         3kTEz9+1Z6LOeYKHEZhVU1LveHkTxwzVtlzH15y7MgvrqXji6nqomuIJakAV//iNHh+u
         9GFj8faUSKqt5Crr2sa9eBDogCBMymWnJEi2oC42aa++dD/WAuvPMoxvaFwa657oyY+g
         zSoVXCNVQtAvORQcYpD3yCfpu4ZgxGjqZ9fYu5wfticR61IdbB+OkbkxBlGW/3lEEVjN
         VFE4eGNHw5Hb180xJ8ZK0gHR0dK2+pWrkahxOAY6q4+dvPfwYawXBIwt9oSMTQC45EmL
         r+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835324; x=1684427324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1izybgkMQUv0KTZ7YUu7PpN/DThKjHSmFy8njwpB1c=;
        b=eFZxFVIWRUinLC/P5k379f1iftHfpOXngxR0UpBSNtpLo49/Iujx+98zDdN/wo2Pkk
         b1caEwevVKCSU3vO7UmrTHRzT5ZhblS5krgM6sybhwefUWAaNZoRq9ursdLOxamf2yLI
         h2YjISaxkTvg0Mu1ZtyFOjFPe9eDO1ab3Tia5vnL0tf14DcXC1qBgcZeUmjRL82EjYPE
         cCluTd426WR0LSmOA4SkLMWTwgdUdivpj/WqX2WOzBp3H0w0UrgQYVdQ4vKF+HEtdmXK
         aPcKl8+rZijzru/P7qDcajYsJPvW4hQYfO1FZavMnJqenscvOHjqafWD7+6U0PPyaceI
         qK3g==
X-Gm-Message-State: AAQBX9fzpkOYfALR87LVMcYX7GCw1/4fgZTFeH5raCoBiryfn2diD8aT
        Xj9NquFqDZxF9yh5M8ISwVBJdg==
X-Google-Smtp-Source: AKy350ZT/VNF6S77XnDwAlGAQQrnfDmKzogv1WdK+lyOcAFAAwcnhCm6pUEJv1P0LOWRQ4MDvnlNFA==
X-Received: by 2002:a17:906:dc8c:b0:94f:2927:1f0d with SMTP id cs12-20020a170906dc8c00b0094f29271f0dmr10575212ejc.53.1681835324273;
        Tue, 18 Apr 2023 09:28:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id wt10-20020a170906ee8a00b0094f225c0cd3sm5160756ejb.86.2023.04.18.09.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:28:43 -0700 (PDT)
Message-ID: <98c66dd5-2621-b194-d49c-b03047f52cc1@linaro.org>
Date:   Tue, 18 Apr 2023 18:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: rockchip: Add rk3588
 compatible
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230418120624.284551-1-cristian.ciocaltea@collabora.com>
 <20230418120624.284551-3-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418120624.284551-3-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 14:06, Cristian Ciocaltea wrote:
> Add compatible string for Rockchip RK3588 timer.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(Wait 24h before sending new version for fix in 1st patch)

Best regards,
Krzysztof

