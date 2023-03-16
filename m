Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01D6BC82B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCPIEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCPIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:04:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1E1631E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:04:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd5so4129746edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678953875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYB052YukoVdHW+qtRSlTHvZr0e0YBjYSQAsxVr9fBE=;
        b=z1vfVSpJ6do8mfJMS+4lrkAz3tA2qhe1UIpap1YHopgEFIxrup8SNosmJSJDEI7tNs
         wFfDO3mGj4g4HmkuKDvl+My2rfs1R47oG59emGK26zJYJpe3oJ5QbK5L7a0KH0nNmbkT
         5YfqUKui3cWOkZ4qZezj/q79D5jEXBrhLrFCnrt3zLtNQ3xqzh+HfIHxUbddMvXGxFjd
         FkdLktkcLu8CLObIpI/8tGUr9zHgXExrsjGOFWNpw5KWk6jVwcvGqEkd+JHjJmbLIlUH
         +tjotKe1/1nMvqrnhgs9hLoBSygJ3nzEyE0MElFR8n+tfOgWu6mHzsqjJOAKbUl/adFb
         KaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYB052YukoVdHW+qtRSlTHvZr0e0YBjYSQAsxVr9fBE=;
        b=SXFbl7qXMrMFi9NRa0sBD0UpFc6VPWYFZ2K97LKv5vp5Hj6ryYkGMVnT1ChjV8RfS0
         WFZv9VtccSA1QoN01LYtod3U7CJfEpo3SEJd8dO/omBzaoZjEI6rSeCuDGHa+22S7fp+
         YY4sX1nkFRGuCWfuRVSNdqI4fNSzkycpnYD+ubF2/NvMWGwqpaMaBz7vMh2x3zjhLXlB
         9wRtmaSwV86PiJaNtE/eRXsqz2bFHFbWLPcz4mdaOHURa+kU7vo+Rzpc70Z+U4+alB5M
         BSzhV0r6z6uVhWzNI/z5jMslxowSRm4gvji97dq/NHUpDdiHPD3w6zgANGJ7pojqn6rl
         GyDg==
X-Gm-Message-State: AO0yUKXWAsC1puK27jXTlIEX01V8nyCifJWXVhhP+jYKeiKGKqofLEtR
        CKLMGdaCEQSmYqguiVTG1KgylQ==
X-Google-Smtp-Source: AK7set8Ka9X8JPp0aKGg1LcB+NwytW8t2PaNfKlUoBo8WqOamHE19YTjKMWphrZondIJnlpijj3z8g==
X-Received: by 2002:a17:906:fe02:b0:930:a3a1:bede with SMTP id wy2-20020a170906fe0200b00930a3a1bedemr898911ejb.50.1678953875270;
        Thu, 16 Mar 2023 01:04:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id cb15-20020a170906a44f00b009226f644a07sm3486809ejb.139.2023.03.16.01.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 01:04:34 -0700 (PDT)
Message-ID: <7b3ec8b5-f12b-fd29-96cb-7a1e1656eb42@linaro.org>
Date:   Thu, 16 Mar 2023 09:04:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next 05/16] dt-bindings: net: dwmac: Elaborate
 snps,clk-csr description
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230313225103.30512-1-Sergey.Semin@baikalelectronics.ru>
 <20230313225103.30512-6-Sergey.Semin@baikalelectronics.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313225103.30512-6-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 23:50, Serge Semin wrote:
> The property is utilized to set the CSR-MDC clock selector in the STMMAC
> driver. The specified value is used instead of auto-detecting the
> CSR/application clocks divider based on the reference clock rate. Let's
> add a more detailed description to clarify the property purpose and
> permitted values. In the later case the constraints are specified based on
> the DW *MAC CR registers permitted values.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 10 +++++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

