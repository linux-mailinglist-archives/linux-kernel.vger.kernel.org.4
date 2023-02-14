Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE6695C70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjBNIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjBNILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:11:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A353974F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:11:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso13037378wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGsFo18c/iJsIdNsFMrw/WmgdLS9HoC+zWGEtEOqm+8=;
        b=ODCsRzZ5i7h/F61SCzHPiPRHNm7+BAs4NJh88K94neI3yD3XMH3fmQ9SIgm9oW5dbT
         ITkh/CyjSK+nod6gPSfq447YzPSjXJtWhtvv4ZAvusoKlfgiv1ITG7ZVzJkv5KmPSaxx
         XyqvwVHrvPEdQK3lrKOI79HapL5oWpFdE3cHTJXGAlSEFIQAm/l8rWTmn9qckQfC9M2V
         meuNGZk8O55/zRj0PsOKGqPnJta8dJ+4k/IMZ9/e15rvxC42dn3Y8G79p8mi+NPTRseV
         GXAQzEYRk6dJY63z3Te3FbkS25bCfGslgXjp18DeHIMLPoZcvjQiH88Z0gYEV7Cszd0S
         S7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGsFo18c/iJsIdNsFMrw/WmgdLS9HoC+zWGEtEOqm+8=;
        b=vxnh7bGbN86/i4B52VY+ccYHrM3rHmKGKwmpC/HN3pYdGDv/IMcunRaHBLuOrnrlT+
         HXS+LAYp2Tv0xnpe35gOZqRQc2oobQsSLj95OhBUUVVRuNrfb9F7ViUdiOk9tZGBPqZR
         mFNvgOGuFefB010+xft8A0+X8taLBBUy4zF3VSiFSqh9gho93yRdiMgvVqrtwU1HZ9Kq
         x/nPg2BrxVQ6et+sJVX3e38ir7FbFjYNbrI+nFaTNNQrUg2k2SBhdCdxvtDKcJJFnzFf
         paRWBcgGWLBIV6sXafpUTtbrskkhaqlmZev3Ru/+CAONqr0tO8gYIBCu350gtLvA0qNZ
         I8lA==
X-Gm-Message-State: AO0yUKW0U1yiKpQvCcjuP6WxEn5yN6Xg6aOjUb58HN4VA+Ycsm4j60Af
        E2ORsukzRv2BxCOQ+MbqRaP26Q==
X-Google-Smtp-Source: AK7set+P05DL+o1TdU0O/pnJdPDtnx9vg09Z0nrZR0z6+ES2IVpanMy+5HhPcuHsaNUm7dzmg6CvDw==
X-Received: by 2002:a05:600c:3caa:b0:3df:f85a:46fe with SMTP id bg42-20020a05600c3caa00b003dff85a46femr1165239wmb.40.1676362298873;
        Tue, 14 Feb 2023 00:11:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z6-20020a1c4c06000000b003d1d5a83b2esm18944372wmf.35.2023.02.14.00.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:11:38 -0800 (PST)
Message-ID: <34984128-5214-036c-e384-9139cf0cf772@linaro.org>
Date:   Tue, 14 Feb 2023 09:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: net: snps,dwmac: Fix
 snps,reset-delays-us dependency
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, devicetree@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, alexandre.torgue@foss.st.com,
        peppe.cavallaro@st.com, joabreu@synopsys.com, mripard@kernel.org,
        shenwei.wang@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230213213104.78443-1-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213213104.78443-1-ahalaney@redhat.com>
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

On 13/02/2023 22:31, Andrew Halaney wrote:
> The schema had snps,reset-delay-us as dependent on snps,reset-gpio. The
> actual property is called snps,reset-delays-us, so fix this to catch any
> devicetree defining snsps,reset-delays-us without snps,reset-gpio.
> 
> Fixes: 7db3545aef5f ("dt-bindings: net: stmmac: Convert the binding to a schemas")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

