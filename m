Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346576991F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBPKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBPKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:42:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0D55E66
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:41:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n20so2331834edy.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEu9tYl9ixT0RlhKmk5fLsaHMUiQpUecJLWHV/pC3Vw=;
        b=DKbXymnOtF1XMHNi83FzONMNiNoqYbtL7TmCr1PS+KGak8EsrVXSsL0NNRcgyZGpal
         6ascZ91tN9Yb+ngczhbwHLNNLoucV1ocvvIrT+9AYzjFYmMPnvWu2lbd2jElDsQ2tMLj
         AF9zkCKZdpf6Jv9vbw1dikIeJ/Wr35mGPS4NgfdtUTxpPthlw6Xfofb+dIw0Spe1tVfD
         o/YPPzvsYXb/W89QkRqqxnpZ4wmcgtRjqTnwP5eJF0ntjaue1RRwYQmYIh432uHJDTlu
         OYblgom9b+A0JlF+iVuh5I18gr911j7CEZfh7SVhMgN6OLn4NuUNMZEnZZa7TR2Qt0rw
         O+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEu9tYl9ixT0RlhKmk5fLsaHMUiQpUecJLWHV/pC3Vw=;
        b=OWtw7ToiNtr+jvqo/jLkesKsYwT+/gQygwWQVsOmKn0awWZVvuv/Wh57+uz6BII7Jb
         yJhA98zUTk3HgUygIiyVAKwEP1fj52uhjVZPyRC17pUVCkHrJi/UtOBqCLS0CzaG4MgF
         AxBjuLfU0YiJPC9O+tENpzEToLJ+GeMazbrx5MHbtR6pE4ZsxcSyM6NPHPyv+a66bM+b
         V7DXHy3tfN0chsthZjxoLMt0XONdJqWWMAuJTsBYbb01mLRxlDV0HdHSkiKucLwN7+PV
         PP9tpPqUYPiTPwUF1QJEOKzTzf1hk2UoJ77A1N+6zyzEbIgBizjYkPohVrhkVZqLMLlq
         a0tQ==
X-Gm-Message-State: AO0yUKUKyAUSSCIWB+9gYdb3XxVJG7lIFWO1ysG6vgrM8f0VAeLzCCRd
        Rgw2OwpNG9M9IwzO+khpc6n8dQ==
X-Google-Smtp-Source: AK7set8vXxoTnXCznhpP6QpzCw4O9JO6x+mEM/Snm10J14uNMw42kLP4DGVtoqnjUdjsyMeSGP2GQA==
X-Received: by 2002:aa7:df99:0:b0:4ac:c5c1:e1ed with SMTP id b25-20020aa7df99000000b004acc5c1e1edmr5914411edy.12.1676544107911;
        Thu, 16 Feb 2023 02:41:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b004acbf563d88sm657183edb.15.2023.02.16.02.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:41:47 -0800 (PST)
Message-ID: <d94a8e7b-1c1e-34dc-5262-f16a260d813a@linaro.org>
Date:   Thu, 16 Feb 2023 11:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] dt-bindings: gpio: rockchip,gpio-bank: add compatible
 string per SoC
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, brgl@bgdev.pl
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
 <038585bd-7226-b28b-93a5-e1676a57298e@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <038585bd-7226-b28b-93a5-e1676a57298e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 22:01, Johan Jonker wrote:
> Currently all Rockchip gpio nodes have the same compatible.
> Compatible strings should be SoC related.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

