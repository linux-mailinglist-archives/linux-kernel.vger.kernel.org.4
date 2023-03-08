Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B26B06F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCHMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjCHMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:22:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFEBF3A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:22:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so65077432eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678278105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1+QoiB0k7uK9HwVoaPFB3R0wsTQ3wETZ1dYhPGfX2I=;
        b=uNbCAtDRe7cRmmmBtkPCr0ZzwY6e6K7KsgA2K6mCUj33OWW6/+RKq16XEes4f6E0C5
         ZH6zitE0olyk59gTq/3/USR67zm3uf8aORzkwKFvvsl5yqMlDDs48kHn5UmlSADlXpeN
         hN7+uvMGBjvwUFutWz/KFmVmgT3ZDcTexetCRpj10DximvboLm2kRiqFgyvy6EnZEZ0L
         wEE2h6bDoDSl5PsYSv2GAEyS5os9L/+CyXC6x+nfj4+vm+CzCSot3fYYlpxOx1YFX7kc
         c2FNdrEQrP6FnzWG9Ww9iVHm8AUno2xhoqJw8uftgYwqBaJErvi9kf/QDD5MLwUhnCcr
         8Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678278105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1+QoiB0k7uK9HwVoaPFB3R0wsTQ3wETZ1dYhPGfX2I=;
        b=qgd4UlkajzauOkCFbNlsIJpYXFBK9CHAgY98pAY2EWsE7R+PfNpploIcWJzF+aMf6n
         +bdcMudvtMLov7wbo0nQC+dkYrFrr6VgOdCtbdjIMjed0eEaL6LjSpQ3sT+bOUkaQRUa
         e1hUwYCJo5Sy7DOEOj0Xxe2JUX4q2uNQxNZ/RIBr7QgQyhxRpgEZ3oniwF625uHp83pB
         2EY1FukCr6MjYYVthbgpyJzttk+5w0VwVMEIbm8Vfy2SufQJxkOIsqRo1H5ALbpURdxQ
         MnJG5nFAHjTlfA3xLYann8+tfVSRwP0n+LnDwNRVp2c+ixS1yd1HdZ2si2COBOtthjKs
         OBlQ==
X-Gm-Message-State: AO0yUKUDGkwYysiWlkkG78ORl+x0O1FaStugN6P+bQQxlE95s1EELRg2
        hgezdstKpKPBtvTHGO+wM0XYbA==
X-Google-Smtp-Source: AK7set//pnG/hUfU9dnpKwgyOtGLLsGngkBOwgX0mXHkioCCsnLFf9+5fdRAS06P4j5ui/g+tHOHEA==
X-Received: by 2002:a17:907:a0d5:b0:88e:e498:109b with SMTP id hw21-20020a170907a0d500b0088ee498109bmr23363670ejc.5.1678278105564;
        Wed, 08 Mar 2023 04:21:45 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id e19-20020a50a693000000b004ad61135698sm8062309edc.13.2023.03.08.04.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:21:45 -0800 (PST)
Message-ID: <c4d53e9c-dac0-8ccc-dc86-faada324beba@linaro.org>
Date:   Wed, 8 Mar 2023 13:21:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: pinctrl: k3: Introduce debounce select mux
 macros
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230308084309.396192-1-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308084309.396192-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 09:43, Nishanth Menon wrote:
> Introduce the debounce select mux macros to allow folks to setup
> debounce configuration for pins. Each configuration selected maps
> to a specific timing register as documented in appropriate Technical
> Reference Manual (example:[1]).
> 
> [1] AM625x TRM (section 6.1.2.2): https://www.ti.com/lit/pdf/spruiv7
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  include/dt-bindings/pinctrl/k3.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

So these are register values? You should consider moving them out of
bindings, like we do for some other platforms.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

