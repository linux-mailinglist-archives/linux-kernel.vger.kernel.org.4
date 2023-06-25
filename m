Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5485773D00E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjFYKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:13:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA21B8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 03:13:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98df6bc0048so128307566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687688029; x=1690280029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syq8wmqi5sxbhlG4LN2N7LL4Y7J7QS2HpSjUCteE4Go=;
        b=cj3kWNllURT0OTH7YF0bMiyfeZtq66AVLq2miBl6vvw6h4OEYAlcRcVTlbWXgAPAXv
         0C8xmW1ClUaBTaP0AfCgGu6A6ObdzuJucwt/nedD8JngLILtbQ9RUTYj9SaaPzvDK7rU
         ozv7fVHFxeQGEFfT97L6uZd3JlrNjL/uUDvmbHbOd8dp7Hq9iJy/0qraVRXrISitKmao
         FxhFF8Qx7JMCJH/3KFZBm6aoTunGqtEScQ3v1/WxYJ37RL1svytm5okfJTTkkatO5zPT
         zSqOShQlndDpr4v5ETkxX5BX97gCeAI8TNDw0LKj01WGkhSD+4xcgaFpO4Gtdo2koskg
         vSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687688029; x=1690280029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syq8wmqi5sxbhlG4LN2N7LL4Y7J7QS2HpSjUCteE4Go=;
        b=eqeEvtU1PClR9BlatIhrT3boE9ym98fxY8klrunUBR7OnICZM2zqH1zMiLyMbkb458
         WoGDN2/Z5UxlZzoEQEaM6v9B5FN6h8UFX/06r+BtvUBk6dyPFyvlq4k3V8BXnGvjv0z1
         EIF0zx2XkACqdRCGhyU9TEz3Pp/4M4MxnEqA1pH7RLH7wrl+8G7/3AL0ZJqCqtmTDruI
         WSkFIWj39011PcSWpbWZkJPVrFoA/z28zBeeRo6838iIPGxVcvY+F+Vmu2Q0dK+KsqlT
         oLheJrLgOKrk+B0u8ROnYfo3vd1VW+pCpjKQXv1Z0K57fDq0YWYt828sz5pCvaJ7HoJK
         3Nng==
X-Gm-Message-State: AC+VfDxXDcNNYTY+0AxNESy7L6QIRHxqMtxE4NTQgpTjNecGlbeJhgxq
        7XuNT2IPph8xWPCo4NxIGjqgTw==
X-Google-Smtp-Source: ACHHUZ6ue7nK+iXT+Gmb02ASDhOsmXu9P1FKk9ZoHujhTYqVKduxYzP5wOr0r58/UwUeL3oIS/UWxA==
X-Received: by 2002:a17:907:6095:b0:989:1cc5:24a with SMTP id ht21-20020a170907609500b009891cc5024amr14860344ejc.13.1687688028779;
        Sun, 25 Jun 2023 03:13:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906068c00b0098856d1470csm1903726ejb.75.2023.06.25.03.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 03:13:47 -0700 (PDT)
Message-ID: <41d0313b-f791-b274-d5a2-fd40b4be0fea@linaro.org>
Date:   Sun, 25 Jun 2023 12:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] arm64: dts: imx8ulp: remove "fsl,imx7ulp-lpuart"
 compatible for i.MX8ULP
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20230625094857.29644-1-sherry.sun@nxp.com>
 <20230625094857.29644-3-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230625094857.29644-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2023 11:48, Sherry Sun wrote:
> i.MX8ULP has specific "fsl,imx8ulp-lpuart" compatible in lpuart driver,
> "fsl,imx7ulp-lpuart" compatible is no longer needed, and i.MX8ULP is not
> fully compatible with i.MX7ULP, for example, i.MX8ulp can support
> EOP(end-of-packet) function while i.MX7ulp doesn't, so remove
> "fsl,imx7ulp-lpuart" compatible.

That's not how compatibility works. Your commit msg says that new device
comes with new features, but your code says they are incompatible. These
are two different things.

Either drop the patch or provide correct rationale.

Best regards,
Krzysztof

