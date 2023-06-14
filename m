Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84BF7305F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbjFNRUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbjFNRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:19:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B832711
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:19:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso134303466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686763169; x=1689355169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/V9sS1B/pwcwoG8RF5xCj8Xtln38ZYgUZAYH/ImFjA=;
        b=LvSOpgczb7AjbvIhit/n8YKOrP4JYYkzcqOb4rIBl/hQyW7G0Xc+rQaKur6RT518LV
         zT9jC6qYuRowzTnnUa/lqQa/Cq/UBev+O3+xNOpROEW95ym9SzkkqLE+1zbjFeW5Q9JL
         i4Svw0ihLpc8T+qCmTODB4qUwp+Ng9JblfzZYIvgd0MAEl8Pd6dDTav+S93Yx7Nf8Qwc
         IRy9E7XgaIpjOKkOP/vusQpNcb9rwk0xiwQtr5F3LtOhq8Iu4/Qplc8Isd7ZR4oXX5Cy
         h2xpEzXbSBRAdK1xlV910zsQ8EySqjxJj1MTq73ljUexXe1lZLs3fLiA6xXBkJCJT3iB
         Bf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686763169; x=1689355169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/V9sS1B/pwcwoG8RF5xCj8Xtln38ZYgUZAYH/ImFjA=;
        b=RRAZuuzWvDsjTutgeLvTfC+hsb0ilYf30pwz7pwaRdu2/k7CzCVRetE/4OGwC9DnRL
         Ef+O3uT8XxY3wSBOwoGD233mznfdLKlVmOfaZo3EOGI6VsjF1eMBvhz3kR8P1mk9CeYX
         rr2FQePiKIsCAOby/HsN6U2R6qyRwg37oNHKkxJuKakkJHbQQm4HgKoKdj1Cs/bWHZY/
         RwNBKq3o5Dyhm0JZGASDzXpAq5BAge+GnSTr9h6kjlaz6LOyJPrG+qaWxoIcQ6IgKtHU
         zdQp7mUh5jQtRgCz5+0gKnswKwf7XqvCrfAgQUKT/hFHVA60f/PlRI6Z3h7i3XYIo6BC
         NA5g==
X-Gm-Message-State: AC+VfDxvSM5001cywUpBOJmgIv0NjugwXd89/9ZxEeBvhhi+X4Ss2AyY
        ynboQ9MrCk5jCqFMwxaQGAgHpw==
X-Google-Smtp-Source: ACHHUZ4hFm0T58vo3VpKFnXc4g6q5a/vGYtHy7wzkd/vW/9pGo0+W7FfsWdWf3SVTPAnSijtaUy0rQ==
X-Received: by 2002:a17:906:6a28:b0:982:79c5:612a with SMTP id qw40-20020a1709066a2800b0098279c5612amr1846668ejc.62.1686763169096;
        Wed, 14 Jun 2023 10:19:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b009663582a90bsm8389151ejj.19.2023.06.14.10.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 10:19:28 -0700 (PDT)
Message-ID: <8f2d0993-4b19-18f3-1261-01c7149672e2@linaro.org>
Date:   Wed, 14 Jun 2023 19:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: timer: fsl,imxgpt: Add imx8mp-gpt compatible
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230614113612.365199-1-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614113612.365199-1-linux@rasmusvillemoes.dk>
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

On 14/06/2023 13:36, Rasmus Villemoes wrote:
> The imx8mp has the same GPT as imx6dl. Add fsl,imx8mp-gpt to the set
> of values that can be used together with fsl,imx6dl-gpt.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> This allows what imx8mp.dtsi already does, namely
> 
> 	compatible = "fsl,imx8mp-gpt", "fsl,imx6dl-gpt";
> 

https://lore.kernel.org/all/20230327173526.851734-2-u.kleine-koenig@pengutronix.de/

Best regards,
Krzysztof

