Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0206BE543
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCQJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCQJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:16:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3499B1024D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:16:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so17688462edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044567;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0oeLyNfd8INjHtERjaxe36cGB4+loSHIwbTN8QYeus=;
        b=r1Ey9awg5yYcy4na36SfkGZgDeBbTR70Klqn5vB6SjfNI+wN0ESrIrpJdduu0/mSx4
         spsbHUdTur6CMBjZW37DdhgOH1eJV3KRJFaV5Uzudjs1CUha4Tft8QDNU6CPwrBpRO/X
         8vAUeJaA7Mk0t6BFlnDhMd0Q7Qj/KbqzeneEz9yLoUL4H6qh9JakQlqqeCIsAO+TaoAY
         RijF60AkHzlCljHSPM/K2y2yv2t2r5edMj9NjtFNVEeGCLjww5WcNDEfKmXBemHHYSsz
         eW6m4kPttL+W86qLQSjXyYtywp/gDLC/qeplKYQ6WBjv0kaWcTXp0rWIPdGzVj6cvuCc
         rpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044567;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0oeLyNfd8INjHtERjaxe36cGB4+loSHIwbTN8QYeus=;
        b=krYYCPvG0pm1jBlDq2QOTOQ4jhofOmBkIvoXUcKpOpfIgKsxNJiV6N/N68onEeFKDj
         McoG90OmwP0eQCLHA/q6p2WNi33dga2M/H3YZDqKX7kTyNxuyWCJmV1dtVjmhzgEyWA7
         BfQAVJSAvzA7Fkcf2aLaGuoUvsE4gKJykWu1EClPrgnxZemzC/Ay/20u88zgAvzN8r3B
         /7fmmbl2eUv5efv6coBta/lfmYAkoannqP8Xsw7kF8cienya15lKXAMiFIonX5A95ABD
         5urPWpI005mMl9O+wm48xJllMVkefDPmhWhSKW/mQBdxhQBhba6V2HC1uKo4ujVG7Tvr
         tdUw==
X-Gm-Message-State: AO0yUKUSn/oIAWQlvOfBiKFrn65486EXa3a5ASTi7awlCjCXiiludW0X
        jXld9N9D1+GxlxOQShMzR6m6zg==
X-Google-Smtp-Source: AK7set/wACy7YqjpgaUoezd1YxrsDIHP34IU0l2uHdUCEgocAK4gqmYO1KivPl3ykrSMyiCvh8o8fw==
X-Received: by 2002:a17:906:3417:b0:92a:f756:28fa with SMTP id c23-20020a170906341700b0092af75628famr2289156ejb.31.1679044567716;
        Fri, 17 Mar 2023 02:16:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id lt2-20020a170906fa8200b00930bbf7e894sm746627ejb.35.2023.03.17.02.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:16:07 -0700 (PDT)
Message-ID: <de305bbd-b912-a1bd-6bd1-b9c1835ed47c@linaro.org>
Date:   Fri, 17 Mar 2023 10:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add compatible string for
 Tolino Vision
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        marex@denx.de, max.krummenacher@toradex.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230317081618.2387407-1-andreas@kemnade.info>
 <20230317081618.2387407-2-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317081618.2387407-2-andreas@kemnade.info>
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

On 17/03/2023 09:16, Andreas Kemnade wrote:
> Add a compatible string for the Tolino Vision eBook reader.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

