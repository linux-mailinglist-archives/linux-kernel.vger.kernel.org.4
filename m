Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ADB71F0DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjFARe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjFAReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:34:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0C189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:34:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso16728641fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685640861; x=1688232861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+b+rm5/R5ibyZ6r+rF+iVWDROGMd6iETnPBcFk9ix0=;
        b=DjlDIFNQZZGoxm1uB8R37Rjp2aLRL2RDbSWtuhgWaVxwcGTOcOj6y3qv+MKdft3aGn
         NdtUdrvjh32aTOHDk1kgv5IC3amiUISeVyqGPOtEiSBH32tHleRafyshPLJbdMtffK77
         pqUq3ztqF/ZTblQjr3nCozLnKPrC97dU/uw5YEbTR3nO3g6/O2ukfhKEEG7bn44BU1pQ
         rKAd645Psbmxs0qH57GZ8d1dHPiLNZyzQgHj3T3/qMOMh5JfYms0ETSmvSIoefTdbmz+
         o01d6TxTpIf82ewAeqILFkUQn7DdWUb1mnmRH6HsPj1TletzRiko4juIJE4a3lFdPcJ7
         82+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685640861; x=1688232861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+b+rm5/R5ibyZ6r+rF+iVWDROGMd6iETnPBcFk9ix0=;
        b=P4Nvo4/3KoBh8nj/1aRJ/AGLtPEUJosJNJiV+nGgd1RkqD9mm2tEKJQx+xIxXNJQUB
         a73WkKK0iGko19ewFzVxzhhUX941CWCvJG2b/g/2k93GOEpaYktUk/TGtmkdenCG7ZSa
         cua5TsE56EqfGq3F4WgUsv08m5yzAQ7cbMkQAThm8ZdsSICoTnc3xTcyFYA9uoCceJmI
         WzWNguSo6L/NJToTS1+UMTJnVtVgUKL2VSCGcyr3CEMTWDzwScmw+9rd850BBo7W5nlg
         XIACJPexvRXhSA8t/DFCqFZG/52PmmlCFmn4dKvMZ/7Gmb3T6k2FOVN05Ljtx152zK0j
         C3bw==
X-Gm-Message-State: AC+VfDwX/Q9Sg8RokxBMEdG0PzzA+9o1Jzvz4y5wfDNi/nl1ts3T8/db
        AJLMurgiqxfauJtaZbyOI1Xmcg==
X-Google-Smtp-Source: ACHHUZ5irQ0RkTnQ1lBHCjsd2sQ1wVrK2U3EDXl6D//XltvtFhl1/qp+G0DqX6qDFNUg5cCMBSrGgQ==
X-Received: by 2002:a2e:8ed0:0:b0:2ac:79df:cb49 with SMTP id e16-20020a2e8ed0000000b002ac79dfcb49mr97407ljl.27.1685640861002;
        Thu, 01 Jun 2023 10:34:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7c241000000b0050bfeb15049sm7294362edo.60.2023.06.01.10.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:34:20 -0700 (PDT)
Message-ID: <d74a4aea-7e8c-cde7-0293-2c3a41997e41@linaro.org>
Date:   Thu, 1 Jun 2023 19:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: pse-pd: Allow -N suffix for
 ethernet-pse node names
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230531102113.3353065-1-o.rempel@pengutronix.de>
 <20230531102113.3353065-2-o.rempel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531102113.3353065-2-o.rempel@pengutronix.de>
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

On 31/05/2023 12:21, Oleksij Rempel wrote:
> Extend the pattern matching for PSE-PD controller nodes to allow -N
> suffixes. This enables the use of multiple "ethernet-pse" nodes without the
> need for a "reg" property.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

