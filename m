Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28604651E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiLTKGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiLTKF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:05:56 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B266267
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:05:55 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id x11so11911912ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBMyTgqn80aag6e4czcq9I1jxLK0LYrMKeS+03hzF/Y=;
        b=y40Wht56aSwxUxYGrzsaqpwCwXSJBVxvzIaOEjkaueFL7y+kex4bJ3QNj+J7nlii6h
         CrKWdfMAEzNpZ+rEmnVXxuroCklK2+TWlkxSAWnqnHxLlYR2UOhGVxkIvvqy4LTLo1ax
         Y2/MONjTBIdQv54CHQeeLJuqTlqX0yVCnXgdIusH1frxzKwur2bc7HhMEeRvRgKsdX5E
         3Ckr8IZFBA3IPGkb0YTwE3lpMx8IBnrc5jhRPmL1tUPD8l0SIy0xBEsvBU2mwGJM6KTc
         hh30eBWzpUgNVS+0OqLpaXxJ0sOyDUziI8JLn8hPgQ2qVpl5HlH8BK/oXhEwqge+Wl2u
         MnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBMyTgqn80aag6e4czcq9I1jxLK0LYrMKeS+03hzF/Y=;
        b=EuFfgZBu/paT48PitdLSponOZFnLAhyfpFyIgN0BZMDeYZdxWXQ1ZoNmf87/xHYGlU
         oRazfKR3feNbYf4v8EwQHtuTbhdznfWXOfUBkHB00qa127n4ZQYDbgROvMhfx9ODUdXB
         5siGXmDSMoclLQ8wynP332ViEYJAanmkZLIfUi2S3zuSg7E71aALXT9Epmsy2jLWAtjm
         iVq5+XFzJaiXDh8n0TC4SzQcMZH4i4mXoJOMAhN7OrWPxBe47ZeM0u6jvAla0I3cCWXL
         Xl+3Uq8X2rEEFXoZzjwD1/PRmUse843YTe2mva9HkhSMKJsI3IItRc6VndzFxI9w09IU
         c/+g==
X-Gm-Message-State: ANoB5pnPMwfp+f5fruq5QGtDd3Duuzjya8vN0KCeYGCoynT3TbhZLqB+
        Sy8TZ9kc7871/ps2z3mMS2aoPg==
X-Google-Smtp-Source: AA0mqf464jb6PUw+DV+OSW7ZY+nzwAFUNzb2Epe91dSCKe8EdfbJlkqEo+cYuIL9Fqj1xovm7LbURw==
X-Received: by 2002:a2e:984b:0:b0:279:fe95:c353 with SMTP id e11-20020a2e984b000000b00279fe95c353mr11789124ljj.48.1671530753290;
        Tue, 20 Dec 2022 02:05:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512070200b004c325f34050sm1122604lfs.91.2022.12.20.02.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:05:52 -0800 (PST)
Message-ID: <4c528a35-d3eb-db20-2a1e-3d79d0977d91@linaro.org>
Date:   Tue, 20 Dec 2022 11:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/7] dt-bindings: riscv: Add StarFive JH7110 SoC and
 VisionFive 2 board
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-2-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220011247.35560-2-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 02:12, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add device tree bindings for the StarFive JH7110 RISC-V SoC
> and the VisionFive 2 board equipped with it.
> 
> VisionFive 2 board has version A and version B, which are
> different in gmac and phy chip. The version A board has one
> 1000Mbps and one 100Mbps Ethernet ports while the version B
> board has two 1000Mbps Ethernet ports.
> 
> Link: https://doc-en.rvspace.org/Doc_Center/jh7110.html
> Link: https://doc-en.rvspace.org/Doc_Center/visionfive_2.html
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

I assume you did not add my tag because of changes?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

