Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93405EF7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiI2OeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiI2Odj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:33:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945B1C00DA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:33:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i26so2517785lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1Du+LCP4zo2JIvr0KRiMiBlM15dglqZfGoGPYt4had4=;
        b=X5fyPN/suqcgHeLtbGI2GxpL3HBgnu/OxfV5+pN0HPNynf/bXHC5BZ5rn619NrHC7+
         jmBKTEb3MjfvOPVbqMhw7cE01/QMuvWz3v8sJXexiMqYTamHBxbSQAKtbXJ4R+2mfv43
         6tH7CkMzmK0FxSEmfAfkULZhKyIUWXWP7Ms1Ng1m2ubiop/o2GnRHNsQcu7IPy8c5+jn
         RBkHhXc3rf4QHi1sfb7r5kSgABjIKamw5mgdLtQxJ4+St2RrXaT22007dPjQT7XkeVTD
         hfuq9kcoLlFfDOIMut7wVpPQKk5GJSH3kB9F/boaDGFGjFJSWMbyhYaF3sSNUFzUnJ9y
         T8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1Du+LCP4zo2JIvr0KRiMiBlM15dglqZfGoGPYt4had4=;
        b=a+Immd9VBSb8oK2/aIfdLz6rREH+pimvQngCe6zV9CwMqRli5DzXjxnmDNpDrz9+V8
         IU8M5YoCEkfKkSfKFP1JU30IfLPTjPJvGoFXMG5/l7Hhybjj1SsbDJqyI8eHkYzcZd/H
         PM11FoSfZ0pCMs4JcmGY1XdNKFWQFQIoLSkJCN9j1dFyKPKQV/5qXcNtm7+Gx1+cMbow
         6Oldiy1+MDxvOZu4cCFXwRUc0ZAXO/sdfzcYNLZ0Ew7V0aQdEqZM6tdmKOplGYVusHwP
         qRXgJRNIeW91trQtfb7AM6HfjHnxxZzf7KdeH94XE6hUXDClxbs8augsSJg2ZWh+WJ9w
         uAKQ==
X-Gm-Message-State: ACrzQf3VPD6vR+ZlIgnvumD7umaEXm/RyBSreC5yoFrwWFeL3xsRQKlk
        G/+6YAnqACMQu3qy5joFAIaMgA==
X-Google-Smtp-Source: AMsMyM78X6A0lJO+2KyzfxmyCRQIKMwSdmnQXFMMKcYiuOkV8KHto6m1G+GLQmFGKcMFzjFvOOLKjw==
X-Received: by 2002:a05:6512:1047:b0:49d:a875:8d90 with SMTP id c7-20020a056512104700b0049da8758d90mr1589006lfb.630.1664462005219;
        Thu, 29 Sep 2022 07:33:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d15-20020ac244cf000000b00497ab39bcd0sm803711lfm.96.2022.09.29.07.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:33:24 -0700 (PDT)
Message-ID: <0cb853c1-0c07-bf59-3c7b-e9366d7db5b0@linaro.org>
Date:   Thu, 29 Sep 2022 16:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] dt-bindings: rng: nuvoton,npcm-rng: Add npcm845
 compatible string
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, olivia@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220929133111.73897-1-tmaimon77@gmail.com>
 <20220929133111.73897-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929133111.73897-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 15:31, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 RNG.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

