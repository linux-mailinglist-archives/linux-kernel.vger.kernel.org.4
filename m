Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1A7471BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGDMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGDMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:50:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08193E7E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:50:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3142970df44so3908239f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688475023; x=1691067023;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=khN7qL20jiNV+2YUoL2VVrDQ7HuxSVd+7myuCssgPgE=;
        b=lhpZ5J9XdadmPSr1QR/AG8UcCx6nsBh7S96ptZWO01NVbdAD32ga6ND/rHGK/0nLeG
         OcILfAAZH2QGjuXC0E1sxnz8ySI0riahZV4a/8Vh0qOFuPLDeYuLhNivNpQ42YBQZpR1
         n52OFNS0gHnHJ4ORnADm7dkH4XGhkKGL6bdV3HcGb/JLkgwlITETOv6im3jy+/aeghKo
         SoRqplSJRCRJRm91vnJY56FDVLzwhoIazir8wpfpbMjF7lfBWguiZ9/WFTsJGIwwwgsO
         /SRYchDhQsYGOB5Pi+dm1/EQ35yHwT5u3gaFUFxuzSwiOobh/h9Vc1OIagL99AHBAmRV
         s8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688475023; x=1691067023;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khN7qL20jiNV+2YUoL2VVrDQ7HuxSVd+7myuCssgPgE=;
        b=V61bQwULeSUM5KOt3peTHBKFCy2veV0LbRUvdQKPul1awwD2wze7RM2RVL77FvVPP+
         Pk/XaqpbWa6iXu9bIsxn9IFeoM4VtuFMoc7ieKKAWv/O7b2T8f36wWZ8nvwf51B4U5Cu
         8Y7k0do7WXS8pg5QikIVO06uMRfCs8nQy+xujXEXwXB5orgGnH+Q/4RKtFxFjqJPm1se
         LyY0aaiKMi2ITnZlREB8XYrTjkqw9fySnQSB1osSKnI01q4OY1E2MtTbEDCxzrkUKb+b
         J7GewOdXkI9Ql+M42o8RCuCoEATu4w9eskIYHPZgUmQNUXy6FNvXiZId6WHbznCwsuCx
         fdmg==
X-Gm-Message-State: ABy/qLYZ9NAhzwHxRASd5u4X4LWmqLgXHJtJKtTfmeAOmb27NznWigit
        FIt/Rd7wFXw7TYx9v0L3GbBSQA==
X-Google-Smtp-Source: APBJJlGYnTg9Odl6AdblWp67O67QkMbjypzSdthrdvhcA+ODLfuCZz/bh+UKd6Sl1gTFpqUPb6nUyw==
X-Received: by 2002:a5d:4203:0:b0:313:f395:f5a3 with SMTP id n3-20020a5d4203000000b00313f395f5a3mr9492911wrq.38.1688475023459;
        Tue, 04 Jul 2023 05:50:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:106:cd85:84ae:7b? ([2a01:e0a:982:cbb0:106:cd85:84ae:7b])
        by smtp.gmail.com with ESMTPSA id g5-20020adff405000000b003143cb109d5sm2634842wro.14.2023.07.04.05.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 05:50:23 -0700 (PDT)
Message-ID: <12266deb-4602-c557-fd80-689765fbf302@linaro.org>
Date:   Tue, 4 Jul 2023 14:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 06/15] dt-bindings: mtd: oxnas-nand: remove obsolete
 bindings
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-6-fb6ab3dea87c@linaro.org>
 <20230704103026.6db56915@xps-13>
Organization: Linaro Developer Services
In-Reply-To: <20230704103026.6db56915@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 04/07/2023 10:30, Miquel Raynal wrote:
> Hi Neil,
> 
> neil.armstrong@linaro.org wrote on Fri, 30 Jun 2023 18:58:31 +0200:
> 
>> Due to lack of maintenance and stall of development for a few years now,
>> and since no new features will ever be added upstream, remove the
>> for OX810 and OX820 nand bindings.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Daniel Golle <daniel@makrotopia.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> I assume these two mtd related patches will be picked-up through the
> soc tree as well, if that's not the case just ping me and I'll take
> them.

As of today, there's no strong plan, so maintainers can pick their patches
and I'll probably funnel the remaining ones via a final SoC PR.

Thanks,
Neil

> 
> Thanks,
> Miquèl

