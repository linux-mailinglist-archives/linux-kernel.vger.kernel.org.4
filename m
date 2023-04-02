Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A506D3721
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDBKSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDBKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:18:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB9E902B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:18:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cn12so106468804edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680430718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sN4W0uppG11n4amgZQQ3mpLKRvCRZOSROsn8m2Kimkg=;
        b=jb+VJPdBqQST71dfQdR2PxUbmb8b02IKUIK2Nl00BYhPfKddUdEroPOVgXh5zH8cjW
         hT3PIhI0fncDCliWCt7mzQiKdfPcLIS9NpPFlqPg1wjloSsgZglYv2g9tXo6sXxlVhpv
         F1ZxTeu+g4yT8WAUGbizJsWrfQrI9Ck6M6ajArriv3d6TMFBfAupw95heEeutndZ2eZM
         h7A5KKcasAdAz3+zklThNj3h5nGmdqSI0jnHZBDxGlLh4Vag+yZ6jWlRe3RHzdps3aMZ
         WiXHL8dsKu+q+NaWMu12ZNa5se19Hb8+i3pVJXYsDDqt35BrNpNdRiqQWoBscwibJq3L
         w5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sN4W0uppG11n4amgZQQ3mpLKRvCRZOSROsn8m2Kimkg=;
        b=dH2O6SMpzXBtvQVEKaQm4Q5nHo/1/T69xLCXA2Uq+oDE7Q+krk/WWYYdhn7y78G8fv
         7UYhk35aHSr5jg2wwlFLwdv7rVSRMlf7SWbg5T54A3bH4uKWM1K+xvP6/daUg0J/R8yO
         tYMN8UT0ESMFbgmpyNyXfLLYSNwJHoz447T4HeT2Sm55LsjU8xFbIrLmDG/yz/za0vej
         j//gFIR1Wv/S0Db1e4fT9CA41wXNxktAPUE1qgXu4aOwbihVWmiZGHV8XYNMrPhxWrUF
         u/f15NJwKfjhyVY8rpLqJcAwiEAjQ4A+e/Uqt4pZH62dNzmKgWgHjnMKsYtIm/VHk0fV
         t9mA==
X-Gm-Message-State: AAQBX9dGTH/KQpaT0HmVuipO2/NVFzLZTZXiIHZsCyFW00M8J58lFqMI
        JUfAONG/nVgvrARCho0IuTNSbQ==
X-Google-Smtp-Source: AKy350bl5AI/ffJhjWXPUZDpoMYhYVGYbPhasRbUNkSaaqKcK5VPx7QaTdan03JTQnaAu7+DbiZjzw==
X-Received: by 2002:a17:907:744:b0:946:fa68:1a91 with SMTP id xc4-20020a170907074400b00946fa681a91mr17736295ejb.75.1680430718427;
        Sun, 02 Apr 2023 03:18:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709067cc300b0094776b4ef04sm3145749ejp.10.2023.04.02.03.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 03:18:38 -0700 (PDT)
Message-ID: <2c7e2f62-9f0e-3be4-0da2-e0cb89a197dc@linaro.org>
Date:   Sun, 2 Apr 2023 12:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC 06/20] dt-bindings: clk: oxnas: remove obsolete
 bindings
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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
        Sebastian Reichel <sre@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
 <20230331-topic-oxnas-upstream-remove-v1-6-5bd58fd1dd1f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v1-6-5bd58fd1dd1f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 10:34, Neil Armstrong wrote:
> Due to lack of maintainance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 clock bindings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

