Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477786D50C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjDCShy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjDCShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:37:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E83C29
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:37:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so121117114edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680547064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woHQBzslpxQn8sWqqC0TN46wIMWpqjyxk4syqknSbnU=;
        b=bFvBbagm8aL0eG1WpkUMpZ7aBLUx6PKp4lseK3TKYNSJLKFTvbdAL/UOpVLQNG7W80
         6+T9nAIO+CFbrpm+FWmXGLv3iRlsx77POHfwFU7a9hg24cauINgniJsEiBKhlm45+9Zt
         jdiSe4FQmK1ZDt9moJ7wCgte6na7VoYwXmxWvsdvyoUvAbqvjIPbDOZoIrfa+thb2oen
         pJKuwQuT1MPNg+BYN/L+ZUa0yIcZL3V7ad9X2JSCYn+GbtBET4ExYrhzv/dGLWNKMrX0
         aY8Wq8zP6tmnwHk2JvG3m5+v2BlZ5wTQPHX9GIHg7/lCDDWcpU5ePfRmEIyP882gWeQr
         nULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woHQBzslpxQn8sWqqC0TN46wIMWpqjyxk4syqknSbnU=;
        b=Vs/6sG0+nzxxeQ264GFvzYIuFtw0Pn/PL3GEQdMtuxsmzkDIBIF5tvJjTxC72R/OTf
         +X4zg8FRjWLpZLZB3LpNbVNPUz3IjZtGBzhwzXPgMI4KoS4sq4iXx1bd/SCQBTxsAYxR
         rXFw2dJL3m8llmNHpid2HlfbzfxC2euCSVgmbuoQFKQeR3uPsCaioxxDRYguFeiqSZjk
         y+Gx2figheVw3Rjakc1DhgbUi1BngXZIIThtc9ohfzbDeMR5afB0KK0CuFdHySXlDTmX
         1JzOOO9hoxiNc90UwOvd1bQVhqIX0/IcVoNVJyLdyhBMVb7c1rUhFYUYclPr0ldaS1ue
         LP8Q==
X-Gm-Message-State: AAQBX9cvSGn14cROwMMsZrt2MFt9/R70M77YUrpj2Qtyy3fmTQB7q4eN
        8/UkTSveMAiBH9swFmVBSyGqOQ==
X-Google-Smtp-Source: AKy350aGwqQCodZpb/gzcGe1S8OGxNbhVHt1iC2+Dk0P5OGvd+2PK7IQlx/UQ3iZewsFT9iUWIorCA==
X-Received: by 2002:a17:906:1c19:b0:92b:f118:ef32 with SMTP id k25-20020a1709061c1900b0092bf118ef32mr36754487ejg.48.1680547064210;
        Mon, 03 Apr 2023 11:37:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id b17-20020a170906491100b008e57b5e0ce9sm4826642ejq.108.2023.04.03.11.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:37:43 -0700 (PDT)
Message-ID: <ba5cf9c5-50b2-b31b-eba4-d22eda2de0f3@linaro.org>
Date:   Mon, 3 Apr 2023 20:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC 19/20] dt-bindings: interrupt-controller:
 arm,versatile-fpga-irq: mark oxnas compatible as deprecated
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
 <20230331-topic-oxnas-upstream-remove-v1-19-5bd58fd1dd1f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v1-19-5bd58fd1dd1f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
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
> and since no new features will ever be added upstream, mark the
> OX810 and OX820 IRQ compatible as deprecated.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

