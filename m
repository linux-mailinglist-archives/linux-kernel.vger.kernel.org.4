Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE8468ECD3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjBHK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjBHK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:28:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737A4743F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:28:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so2180805wmp.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFc/zShdZ2vyU1OZpHtlfV+CGb2m53vsLYDRUV8liWI=;
        b=xaSM/jWqR6bQkqcxRtJzlOIT03gykSIhaTbvPUkNx0hbnwJmnYFkF+Zu6onPA4HRmG
         lXZgaUjDO/LT0hRHLdbRWGj56GduycCESGBibQdAxpTNcqZvflWnTkyuF5XK0/9kvzgy
         X2TjP7qCZcCogDWcI2pLS4qlWHZ2vVoNCMLUEcTzNc0jBSO+/tSGithhcb7UyIW+GoLt
         gOoxfrwx7YcUxwvYJCVY2WzaDGXZ1set1RCnzN9mHMxBg28o48MrHNjPTQVzG3IGTK8C
         7j3XYMoIHeDe1t6Xs1c76vcXl8oJYhj6Ti38b/IvqwTt7ctrY0tsBD3dTEgxEe3unT4Q
         8qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFc/zShdZ2vyU1OZpHtlfV+CGb2m53vsLYDRUV8liWI=;
        b=vOuOIaOrkMdAJDk5RbNzRBckddb1N15D59W8KV6DZwB3Lc+ZZn48U3+LFR3QdL6SZA
         2p5Mmid95S1W7rH4HcTqU+XxUZnFgZtQCSP7s4V2Si/RKyn/YqhdErqPrt9dUEV2yfn+
         iN80c7iWOwrRHartZ7e5zD17gNWtTKl2ikzN0QltayjjkGBzOGj37/onLqVwAnSFyS8H
         WqqX/0bbXDaqSK9Gpf7e0OBkR3U9ScMLewlmEXOgu15zXaCBqyJPsGq0P1NpmnC2Nf1p
         5OvtnTZfTcqGUQW0rZrcdHG8Yna7GbItB24CnpMLlHpppAXNVMgbblaj6YaEcZuv/VPk
         YJng==
X-Gm-Message-State: AO0yUKVo9Dg2ngaOVZ3PDR9lkSvHuCfSDXRbNGQJzSCpz14sswNNGyC6
        pXaJJb9GG186X7FKzNfILiEtrQ==
X-Google-Smtp-Source: AK7set8U9QhWOzH/AO4xLLOtmHz339mkzSlM2XELZI6NMCjYgropZNgWwZTUW546mef+UUALSnQp/Q==
X-Received: by 2002:a05:600c:3089:b0:3e0:270f:dc88 with SMTP id g9-20020a05600c308900b003e0270fdc88mr4532053wmn.33.1675852112916;
        Wed, 08 Feb 2023 02:28:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g20-20020a7bc4d4000000b003a3442f1229sm1492099wmk.29.2023.02.08.02.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:28:32 -0800 (PST)
Message-ID: <6855cd0d-16ed-a55f-5a03-32a127fd9bb2@linaro.org>
Date:   Wed, 8 Feb 2023 11:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: aspeed: document Ufispace
 NCPLite BMC
Content-Language: en-US
To:     Jordan Chang <jordan.chang@ufispace.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
References: <20230202081843.2358-1-jordan.chang@ufispace.com>
 <20230202081843.2358-3-jordan.chang@ufispace.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202081843.2358-3-jordan.chang@ufispace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 09:18, Jordan Chang wrote:
> Document Ufispace NCPLite board compatible.
> 
> Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

