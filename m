Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F8F747D03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGEGZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjGEGZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:25:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34410E2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:25:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so8009039a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688538345; x=1691130345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8JPvTbXio/4o2dizd1zh30lCTah/Aako9+AdwCfXso=;
        b=grPAVe3iZANMCwV2H3vIahp6W4st50YgfOXHsQVgkiFsDNu8h0iv40AWyqdHXNEiQN
         VZuNFoQ4uHRDiLkfBu13pV5zYVq1FOMQfh99ZU8q9iSNUKJLKNkJ4ahwBybN7lfis1Lt
         /55FAQJHauoZ2Yrv1wtNM0wTepgsrNkuPGUtRxN+JCA54H8+mQEWJjhSF5kdT/ywXjy8
         9aAquzDtJ2vhly83FGIA1j13sRX1lT+jig28c/xwDx1/URIZzYRchPtL+wU1eMWoHuWM
         dBoKg5Ydm5YwKDdBsn2GHjkHwzbSZ536vvQp0wgD3+bu45MlGLYEjnFG3NS1MIAUIOSC
         Jpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538345; x=1691130345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8JPvTbXio/4o2dizd1zh30lCTah/Aako9+AdwCfXso=;
        b=gG8m2wTn8Ic8ulaJKVGFA9L7Cq5l/HaVQZGQswnMqJ5z67wWVf0ReLvdGga1MjYlCP
         rrZJw+pQWQK4gBxCrCurnlubtLxR+jQs+JxOY8qU61J8nsoBBehnmtsXMrLbBOe9rYLg
         JpDbkiHRbOlFC7Ce0rq0kModHeJ3XyrCk+ism0LsI1DNEEeRtld4EC2xaOh+xryKmbTn
         fm27L+rqk7Jr6HnEcGFa/dZSe2RlOxC7RFUoR2tuWqqZWZanozSP6kjr8PuP3eADFpBT
         jvfpKMFN0rqqLgD/EFY7faoDIX/I27trHAJfANyqscpWrgIzDEbWY45FR/9K09HIj3hn
         KTRA==
X-Gm-Message-State: ABy/qLY4ddI+zJM84ONIa4Pq0hVwQc9rtrOHwe12DYmAhsvCWzYsOJ+5
        cFKoocYGKESjDiTh+1S6kQxYqg==
X-Google-Smtp-Source: APBJJlEgEMF9emHGgsHWWQE4/hHEfhifZft4ABIYj7Ght6PTnOoS762iWwOGS1gxr/VjTKbZk0Ciwg==
X-Received: by 2002:a05:6402:3456:b0:51a:50f2:4e7a with SMTP id l22-20020a056402345600b0051a50f24e7amr10660268edc.13.1688538345105;
        Tue, 04 Jul 2023 23:25:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7d345000000b0051495ce23absm12641162edr.10.2023.07.04.23.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:25:44 -0700 (PDT)
Message-ID: <02bc22e9-393a-6695-f8b0-09e3fe0ff6e9@linaro.org>
Date:   Wed, 5 Jul 2023 08:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/3] clk: imx8: Add audio clock mux related clock
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1688521839-3036-1-git-send-email-shengjiu.wang@nxp.com>
 <1688521839-3036-3-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688521839-3036-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 03:50, Shengjiu Wang wrote:
> Audio Clock Mux is the IP for i.MX8QXP, i.MX8QM, and
> i.MX8XL platform, Add the clockid for them.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  include/dt-bindings/clock/imx8-clock.h | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

These are bindings!

Best regards,
Krzysztof

