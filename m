Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D026FF526
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbjEKOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbjEKOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:52:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B011D92
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:52:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso1590327466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683816738; x=1686408738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ALe41vj8YtdVBlnqq8zTHOZ56VPcsgqX2uPgQ06rBw=;
        b=YKNszbBPwyuTaC4x8+fmqlUq3UkOe3SrpjrfO1pVPV6U6ohX0OrktU8sb2dFKhEIrg
         pS2x0J7Ur6O4CfSMWTR0A7LgPcNcz2K+jVbSBkSpffpJGfEDKVJEYKUAQveIyrqUZ4Cm
         tp3721ZZ++BJHdTV6I311VEZm6r06CBHLGyFKYn+UZCyEE6X82A9c9bzhRCszrjSlAa9
         VIuZnsX+svsVPIjNwpBC/A1LuiobNdIIeAqW3veF/rf7PLtmHfz2WaqXQaCBdbvJCUe6
         Vdh2w96riTYAFQTOJ9DT/Y+v03yVeXOiI+2hOLkfQeZKSJ6Xt0sXquZdGPC7oHOasoAk
         +5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683816738; x=1686408738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ALe41vj8YtdVBlnqq8zTHOZ56VPcsgqX2uPgQ06rBw=;
        b=I/L8bnXfj32hAzQAIDmiRQKUfy4ZaKqNYg5oLECFYNbO448PaxtoDd2mkt7+jQUQQh
         wIRyepf/LJXtt5eH6kYe/nQhCdlSz2D2BYfKZK3muyk2/BdRvya8wCRfy0H3I6cNcbqQ
         KBGwpKlJ1oT3EUXpY33PUxHtACrvCT0rjE35LL3qElBHayLZKdFRRIPOwWcLbL/x+aW7
         1JQeS9x52bz6iWRoiuG5X1Zl7pA3Jgat1/gcC8bS4DxNq4QcfBPaesdFFuwOyvvDptV4
         UkxiE1tFYQe7hnrfM3Lo+A2sZ9QZDORN7N7BpirSJLlHeEN0Ql1E6h9uVs5DOSR1WuWe
         VEkA==
X-Gm-Message-State: AC+VfDxtaaMejGxw1vmei5dLOI1rsd4KrzOc8XjqEutjvXSXp0/AO9dG
        uCSsvPmmn+hsts14tv4+PzJy0Q==
X-Google-Smtp-Source: ACHHUZ6KCxmSUWU5lQIBkeim3qe8okHY2xnMQYkp2H+AWzgBls0HGNkeCV3uTGhSx4O1AjCt006TuQ==
X-Received: by 2002:a17:907:6088:b0:949:cb6a:b6f7 with SMTP id ht8-20020a170907608800b00949cb6ab6f7mr21380777ejc.56.1683816737898;
        Thu, 11 May 2023 07:52:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7cd:1be6:f89d:7218? ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id kz23-20020a17090777d700b009659fed3612sm4090813ejc.24.2023.05.11.07.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:52:17 -0700 (PDT)
Message-ID: <0828b8fa-992b-7964-154a-0feeb2ec5091@linaro.org>
Date:   Thu, 11 May 2023 16:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Loongson-1 watchdog
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>
References: <20230511121159.463645-1-keguang.zhang@gmail.com>
 <20230511121159.463645-2-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511121159.463645-2-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 14:11, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 watchdog.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Replaced the wildcard compatible string with specific ones
>           Use unevaluatedProperties instead of additionalProperties
>           (suggested by Krzysztof Kozlowski)
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

