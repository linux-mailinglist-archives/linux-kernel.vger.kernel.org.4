Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100026404E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiLBKkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiLBKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:40:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14656CEFBF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:40:31 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id be13so6795623lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPk3ApbRCS0/4hhMFJ/d7DRNyPwO/DR9Aal7CDZHgzk=;
        b=HEiPaeK82n8UhnGfAkC3Ydjm03bumfbVLUgTH1il6UfUvynI2T3gUniZgCOp+PROe8
         +oAFrM3Xl4qkJRsGqLZ6jmHVDk/BHtAi8WteHEfOdlMfmuzppFHUSk2TOSkGHX2RDM/4
         F9hzOPgWwLl3vrVFTuM+6wB5B4vpuS3uSaz6nhGDksqtXs8u2AxTU8QapxZmwAOVQZvd
         /L0n7ivXdQ9BmSVqY7tidcdCt8+uWlfA/G6gWvKu0zXfuf7n3F6OGX78JRcj+J0f+Xts
         XaHLzli5Rjry5b4JHkVlvBTFzGvWHA5+NhqkeDHHPsIJVHNquIJYjj2lg4oQ/U/AEACN
         Q7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPk3ApbRCS0/4hhMFJ/d7DRNyPwO/DR9Aal7CDZHgzk=;
        b=uzVYI2RF82YvVT6js4+vysPZqKpfMBJrXeWvNzju/pgwyd3ofDdNrC2KBou44Yykk0
         RBnawMn8RobD5tAW/tdydR/nq+sPhuP2rBN2quqIKV1kVOYNGyy98esN35GjWq1ADhVN
         pWnxALTLBz0dvyWtYKhRcb2clinhEIOBQa6ixFWUeXF1pqGht1rFqLAH6iJAvxt2ST5e
         SNObyC2k3xKXR1OcJ2Zu6FJ7IfExa4M/Fvdm87SUTgFgM1wb4xBLENd8dL+og8fi3a81
         aMBTxnKlct2eC99R34uhYCMau30PfCQSVh0dNVqvPqsrUMDJrp68gS3ePTHOFdr0doDH
         Hdng==
X-Gm-Message-State: ANoB5pkIscRr9bN/x+91MqGWx33uJZO7QiglD9tvWLWygePBGGiJXKEY
        VxF9hQ7Ak2y8QgLUQZJH/LAK3Q==
X-Google-Smtp-Source: AA0mqf7w4T+ArramDxaYnxkQZkngy0bGcYs96DDb75oY+RO84Yx8wbbk5xolu8+QOpXawniNAqT39g==
X-Received: by 2002:a19:2d0a:0:b0:4ac:e5ff:d1d8 with SMTP id k10-20020a192d0a000000b004ace5ffd1d8mr22660150lfj.304.1669977629431;
        Fri, 02 Dec 2022 02:40:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e4-20020a05651236c400b00485caa0f5dfsm981818lfs.44.2022.12.02.02.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:40:28 -0800 (PST)
Message-ID: <05cadb7d-2087-a507-f33d-c4501361175f@linaro.org>
Date:   Fri, 2 Dec 2022 11:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 08/11] dt-bindings: clock: meson: fixup A1 PLL clkc
 dtb_check errors
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-9-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201225703.6507-9-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 23:57, Dmitry Rokosov wrote:
> During running dtbs_check and dt_binding_check checkers the following
> problems were found and resolved:
>     - $id is not correct, it has wrong url path
>     - CLKIDs aren't applied by names, just magic int constants there
>     - address and size cells are required for long reg definition
>     - wrong indentations
> 
> Also this patch adds new A1 clk controllers dt bindings to MAINTAINERS.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 27 ++++++++++++-------
>  MAINTAINERS                                   |  1 +
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> index d67250fbeece..83f98a73c04e 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/amlogic,a1-pll-clkc.yaml#"
> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  
>  title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings

NAK.

This must be squashed.

Best regards,
Krzysztof

