Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D56B1C47
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCIHaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCIHaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:30:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B025FE9A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:30:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cw28so3340614edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/22MdafNm4FKoxnbLfNBQXnvqpzeoVWKMXqp2Oll14=;
        b=Vq36nEc8g7mIpo/VFbRKg5FMlaheTgvtr7tzK30IOy6RSEXsumDuSHT/6qQf210+iN
         5LGlhkHPNjU6dC1rBfySYwcWeTPtw2qEeA8aY9bG1XRBIBnE9IjpVtxxw4LTvTUA6j+0
         lNSJyYbVXW1JN8Ji2IGE6+7TjMHNNo2SbJcMhnEC6eabuqZO5MHCf+uYjO6vRnKQTV07
         25JZbhRccHw5LsXotBA88AEnaN5amwV6EB8rHG5PRgbCv9jUExgGKnOyrvb+WWQAFNgS
         7HP44UrIL6hw9EV+Qg7qKRVgBAsD1BDB6pD4Xde095n9mxAvvCDIeqSO5bQ6aZC2sUV4
         3ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/22MdafNm4FKoxnbLfNBQXnvqpzeoVWKMXqp2Oll14=;
        b=75+UFXV4KtcUPDKToBIFvwyz9yd+Y/yrEGcJqQL7vcEIRnW+beXO9LPScqHcK17LnD
         e8ZziNFDLEUC23fDz3zEhty5GhIhWRyeE5mMHuPhg0WoN7P5fxT2DJuwkwCOCBr2OY7u
         33hDuqh7aKATJPMTAPWTCCIwd1jmkKbjMRJ4o4nqZif3UrI9u//+vcZAE0gE/qiUFrPK
         rxbCmG/jFzjWk7Db173X0DUEwVv5oKFbKiFF7Tp/Lo2aC4dpNUSS8lnfzBlp6pPI3wdH
         WLh85rUdmLPOxZsgy7IHpngnSjOKfVrQlS9GPY1haRMs3rud8bS6abPB37uwAN3uIhhk
         9bMQ==
X-Gm-Message-State: AO0yUKXRqj97NsZWPzau5m44Dqn0WKpUo7FwdDRk8Q9S+aZszl+U0cXx
        3VRFver5z9QpxWu67hx37hwb6w==
X-Google-Smtp-Source: AK7set9Mg1SPFpN7kjqfzf5y5X29pTuyYLdiehsZW6a1rjetEIlurobM2qIZJVgSOtKscqg7Ht2yyA==
X-Received: by 2002:a17:907:7205:b0:8b2:fa6d:45d5 with SMTP id dr5-20020a170907720500b008b2fa6d45d5mr26703620ejc.71.1678347010938;
        Wed, 08 Mar 2023 23:30:10 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b008b17b123a47sm8385818ejb.208.2023.03.08.23.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 23:30:10 -0800 (PST)
Message-ID: <94ba1427-21ea-86ee-d60d-7817f8e673fa@linaro.org>
Date:   Thu, 9 Mar 2023 08:30:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: Add watchdog for StarFive
 JH7100 and JH7110
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
 <20230308034036.99213-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308034036.99213-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 04:40, Xingyu Wu wrote:
> Add bindings to describe the watchdog for the StarFive JH7100/JH7110 SoC.
> And Use JH7100 as first StarFive SoC with watchdog.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---

What happened here? You wrote in changelog "Modified" but what exactly?
How am I supposed to find it?

Provide detailed description, since you decided to remove my tag.
Otherwise, standard response:

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

