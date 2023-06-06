Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1AB72421B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjFFM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFFM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:29:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB64E10C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:29:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9768fd99c0cso776892366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686054581; x=1688646581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8bjNW006lIGeXXTvLEmyObQQvWZdXaKzwPi+Kg6QFQ=;
        b=UANglB0IvH5VFytUBHWTDZr279hkDNYZk3bE/mwXdOIJ7a/USJf7JT6YT4ZlctCbJz
         V/CbT4QIfMBx0oNExmEx1Ij/xUHn56+RkvgHEiSouvLIELitNpRnb5fRv0rMNDjc1Tl9
         VAvbPCj1O0oSo0ZGenpnc5S4sJqXEJRcvB8sFoTDPCzSxoZeUCbdUtsJsDa/2bwXg7jA
         P2PQuYDoNqPZK+24zDTYSUgGI1WwS8Ve0VcxUmYlJxuMPrkj99Y2nJGjz03w/F8E24E6
         QKioE5gtAQLwV3ugVZNCGApZ5NfE5ijPrYUvWsWcW4mDYXftPpr+P8qKUyusJwJNk1V6
         GW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054581; x=1688646581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8bjNW006lIGeXXTvLEmyObQQvWZdXaKzwPi+Kg6QFQ=;
        b=a6PXbJPM/nWU7L7zG94+YWLgZa1X+WbAPTOqceW+Al0ww6h4Nd+OiuSB0KC+58LKNT
         tIOmn8RJn4vnagqM1gAU6/u+hMuyXyDmHlPnJuYmcQC7aiNC2iWJG6GFbpj9HSY0zonM
         Vj9PzTZshxdf/3GIWEh/F5PjH/QQZM6RmOrig1q0poiuQQM8cnYJQM3KwTtKkDYdzusU
         4fTCo6DztK1/jsvI4Y2S+bIfEDGYMhV7jnRv3vlVtyX/E82qkkU7LLkQFISBALaWnrKu
         UBv8YNUUUFGUdLUWgWNzU48Gjr2YizHayoKnMGz9FfMerBapzWP11iG7J+itWYyzj/Zm
         p/aA==
X-Gm-Message-State: AC+VfDxt1KiPkX6/wyu4Q0q1w+1+TRmn1z5jNvJqQZtm+MzTVu38ETD9
        qpJFZHGzDXJU8tUykd4Yn1q5FQ==
X-Google-Smtp-Source: ACHHUZ74gCkWdqGt68D2uqIK/FVkMqv6PEjoxCaeOaRCVaW8otYDttPJwhpDSCZcZtZGFkgL/JjU6Q==
X-Received: by 2002:a17:907:70a:b0:94e:bf3e:638 with SMTP id xb10-20020a170907070a00b0094ebf3e0638mr2152290ejb.11.1686054581099;
        Tue, 06 Jun 2023 05:29:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l4-20020a170906644400b0095707b7dd04sm5421948ejn.42.2023.06.06.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:29:40 -0700 (PDT)
Message-ID: <ba853327-9faf-3b2f-6e4a-e674c8b75b8f@linaro.org>
Date:   Tue, 6 Jun 2023 14:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: stm32: document audio of graph
 port for i2s
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606115605.1633595-1-olivier.moysan@foss.st.com>
 <20230606115605.1633595-2-olivier.moysan@foss.st.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606115605.1633595-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 13:56, Olivier Moysan wrote:
> When linking the STM32 I2S to another DAI component, according
> to audio graph cards bindings, an OF graph port property is expected
> in the node. Document the port property.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

