Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE142700CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbjELQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241871AbjELQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:15:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047941B9
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:15:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so17935772a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683908115; x=1686500115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUq6/DZf13eTt0uNBk3s77EkqNPgzOna1aPYktM8nTw=;
        b=kBUkwgxaZvyrfNKUDntJk6u1EOyyeVTf8HJWeOMB6SZ9rdONr8Oe2K2T7OKWDaNT8G
         VATv9aNeZynsG8bHCMHBDbCQ9918ijbrtIqqOrWDcnos81MyU0BovNVVXxlkIm+ObGN9
         9gvBMLTML36e6o5MQtwEEOngCNwsdQ0wKPu7Ol3Y4ldWCpIJ6LT527AqN+DGMxITpAPd
         OR7CZhQa/WMOI4mcqi7lMWjESnGCpO0sKK0f1j5kHXpsdpEyN4OUIRAidrcaI7/rBKnO
         OikRxKdIF4s2Slm7029f4wiTdRPifsKMPiTTIMC+cJEkqYXxkTfwuHOminwCNVZX0QR/
         pjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683908115; x=1686500115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUq6/DZf13eTt0uNBk3s77EkqNPgzOna1aPYktM8nTw=;
        b=Ux7p7bI3LZ1qoF1YwvITGQEicVOG+Gk7Ry0T7EcSvTVp6ZJc6E6wpuO2cDbXw+95V0
         P27NPMnMU6/ZunFuqUDM2g9KUhznOG36zPAx9K2A6Ilu2Y7GlCwbnn8uoSe33hAKZcPG
         ppDZgjPF/rss4EeEeC/+O9jjp5x9Ekao1cz+FPQ8neiuk/qF+LJFIY3U0D5kfNGjazNJ
         7aGuwRnAaTw1bKmPrpGgFCkpv0iGrx/kvs4I1hYRdqiyN3ilmlmGK9QUlR+a9VjsddIC
         47xoIxxxDBXkKZ1SzvYPuAk95wNzZ/Ips/avUjjfRsUUsQH9wxRZMjfiVB/U4c6TKPJc
         RENw==
X-Gm-Message-State: AC+VfDy3+nnB/9nDmNOinj+shRvGhHEfx2rMPHvSDIvXyBF57Du4sY/r
        +3oHY2ot6EKSQ0RQy0RnuI6q8w==
X-Google-Smtp-Source: ACHHUZ5sgulPYe5AhCZyHfJGTCnGic0FeB3uppKq4p/w0ozgyCOZ9N6sAHz3JhMS+OVeOmz1kVSx2w==
X-Received: by 2002:a17:907:16a5:b0:957:2e48:5657 with SMTP id hc37-20020a17090716a500b009572e485657mr24821909ejc.68.1683908115463;
        Fri, 12 May 2023 09:15:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906845a00b00965cd15c9bbsm5625220ejy.62.2023.05.12.09.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 09:15:15 -0700 (PDT)
Message-ID: <053b4f08-5a3d-b88a-c808-babffd78aed4@linaro.org>
Date:   Fri, 12 May 2023 18:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-6-xingyu.wu@starfivetech.com>
 <20230512065046.bhblj4uci7hnjoof@krzk-bin>
 <6cb0a92b-df60-7b04-775e-d7f0147ce737@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6cb0a92b-df60-7b04-775e-d7f0147ce737@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 09:51, Xingyu Wu wrote:
> On 2023/5/12 14:50, Krzysztof Kozlowski wrote:
>> On Fri, 12 May 2023 10:20:34 +0800, Xingyu Wu wrote:
>>> From: William Qiu <william.qiu@starfivetech.com>
>>>
>>> Add documentation to describe StarFive System Controller Registers.
>>>
>>> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> ---
>>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 67 +++++++++++++++++++
>>>  MAINTAINERS                                   |  7 ++
>>>  2 files changed, 74 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> ./Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml
>>
>> See https://patchwork.ozlabs.org/patch/1780353
>>
>> This check can fail if there are any dependencies. The base for a patch
>> series is generally the most recent rc1.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit.
> 
> This patch need patch 1 about pll clock driver binding.
> Do I need to merge syscon binding and pll binding together?

No, bot has hickups due to failures in Linus' tree, thus false positives
are possible.

Best regards,
Krzysztof

