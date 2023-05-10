Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B946FDB52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjEJKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjEJKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:06:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8609D65A4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:06:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so10685441a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683713200; x=1686305200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHA/k/RgGDONtBrZGU/7VTall+Sksv/4FrflWbfAxOo=;
        b=A+hT/cFhB+AW1QpTOmLW2CydiAqaYzyyxuM4dIDdN3rrZMR0BY/y8mtxBBpK/hg6GQ
         tWbzIwpUWNlAJ+9/nekTn+kzhigNAcSxyLEPFUjJg0thZD1wa7DmgvIcynjwepbKmv1H
         54wF9Yxuwt1dfUORAfpS8vptvTNBQNtzs8TNkIrBuscRono5InXdcddcqUxfJXlqWhQM
         eIIK6pQ1XBujOa4DTprF1J5UNTL3lp0hKS3OVUDpgIqQMM2qTtSQFNRXjYwWBaDpjjwX
         kZ3W0T45e+tlO/cG/CyNqoM2Y9pgjHopJQDxjHv7lbJL28/nRlAR+eztRH5DcrFwnVMk
         ax/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713200; x=1686305200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHA/k/RgGDONtBrZGU/7VTall+Sksv/4FrflWbfAxOo=;
        b=fQo4+S3U1cjIe/Fj3GkJ2CNjJz5rDBrEVcTWUfEO3JvTwuCBj6u3g0hyXF5RX42Pr3
         EdULjOlX17t6+A4Q/poYL73qIr08rhWH7u4bhrLoN9LRnLEBK8Mzkh8zvVbjQAvbrK+x
         J9+nWtyzWJP4NIG54zhDcFmIQr/IsBaaLI+Svhh6IAZLKBTSzkQgZltSleOFBOKuxe7N
         ADJA53AwTDjtDQhmzuZLueVRNgMmAZQZu7fVrZiCyxCS8hD96WeloH6FPELy2Hedi1wB
         /LaZvAPwMpeH9LpI9SoQNGEo9AC4DHkEueXEhRDW8Ukhl5nPtIT0FRc6SWlSGNCxWy/E
         PpWA==
X-Gm-Message-State: AC+VfDw0e+VyFodRd5vD+XoKxFp0iMI4SdOkKCtgvm/pJ+A1XoSyNz1R
        gqZdL2PZbDXyl+iYMdRJbUbN1Q==
X-Google-Smtp-Source: ACHHUZ4FuhIEwze31HOFtxQYMx2O7pL2PiiDW/gzAU7qPXI7Q8ilqsAHtbG5WXY3stBFlpQkv4G6XA==
X-Received: by 2002:a50:fb92:0:b0:50b:d270:6b6f with SMTP id e18-20020a50fb92000000b0050bd2706b6fmr15435461edq.4.1683713199992;
        Wed, 10 May 2023 03:06:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c7cb000000b0050bde945c00sm1689077eds.78.2023.05.10.03.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 03:06:39 -0700 (PDT)
Message-ID: <f6d2a885-b5cc-212c-7768-c71d8370ffec@linaro.org>
Date:   Wed, 10 May 2023 12:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] dt-bindings: vendor-prefixes: Add Emtop
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510083346.3692555-1-himanshu.bhavani@siliconsignals.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510083346.3692555-1-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 10:33, Himanshu Bhavani wrote:
> Add an entry for Emtop to vendor-prefixes.yaml
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> ---

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof

