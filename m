Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47817640E2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiLBTE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiLBTEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:04:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC4DEA5C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:04:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k79so5732010pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imr/GnqPcqLqa9JjMVgPxbyj/eiQHdpFYtFNeUfm5rU=;
        b=gjGe+7auDv+ZXu6qt73zTRHUZnU4jIZZDL8KgYXKoGC8YpiLul81hfXyWSVs8xKDya
         t46krBPFaRKw9a19sjeRINFTz7UVLN6gOzU36gNecQUBhsUnE22CNUE+K4xhyRNaUBM+
         p8I9Og0ekoekO2mPafx4QjwACLsfml6Z6s+j2L61u/ZKeaPYRl7AEEFelJj6Whh8nNXV
         eiye/7Dl58HiuzcKADeL0yHqi6QrhQKHVwgx/vxEkwSdfKEsTmTgqLl0LRZATTbULKB3
         p0QOn4w0Sg5f7gdC2LWyBahjjxFDIiqEIMv8r9AJNnux9OJVgDNi5yAS6L2MvsVP94Qb
         Fd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imr/GnqPcqLqa9JjMVgPxbyj/eiQHdpFYtFNeUfm5rU=;
        b=eJ/OiG9EtrK2wCh4zsNGx135RVwLtydx6Q6QOg5NDaRXWQOMOu/wkuNhIZKsy3igt5
         2pDJMt8uDVgAs+R8P+1C0ao79tqLd0qRU009iYhb4hMzUCm+WYSMHm3vxlmdrwzUeqHD
         6Ua2cJYch9KZza75WfqkVExWZWk2tb0AnL+Zd3bJ5O0FUXoIlB0RiUhG4tUhpX+34E39
         ZQoPixLX7KIezUQ2SqdWeTzyR1cSIfS/T69QqoYD7w3Z6Nzrp2lQnpyCP5Id2EwiyRYF
         VzOoCGxuaepf021i4IYsAPBNJqDNltVsDVOYkHWSphTmNtUnxqQ6aly4ZcrbtmN5m1Jl
         W2Fg==
X-Gm-Message-State: ANoB5pkBBnSaYm5SX8JU9Oh9UV3IIBbOW0GZyQzXK2Votxzlu4cKG5Yj
        66gUKQhhbonbBaEesAPZWWRO2A==
X-Google-Smtp-Source: AA0mqf6FmyD0wOrbzu3xmRH000pMYIZ+lhNtF3BHMD8wby88YkYEyGqw52oKyOS+R5dIP4i/6feQ8w==
X-Received: by 2002:a65:588b:0:b0:456:f7bd:a1 with SMTP id d11-20020a65588b000000b00456f7bd00a1mr64729248pgu.79.1670007862734;
        Fri, 02 Dec 2022 11:04:22 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id pl11-20020a17090b268b00b001faafa42a9esm5104893pjb.26.2022.12.02.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:04:22 -0800 (PST)
Date:   Fri, 02 Dec 2022 11:04:22 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 11:04:12 PST (-0800)
Subject:     Re: [PATCH v2 0/8] Basic device tree support for StarFive JH7110 RISC-V SoC
In-Reply-To: <167000761729.13669.16471163583440376052.git-patchwork-notify@kernel.org>
CC:     hal.feng@starfivetech.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ben.dooks@sifive.com, tglx@linutronix.de,
        Marc Zyngier <maz@kernel.org>, sboyd@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, emil.renner.berthing@canonical.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     patchwork-bot+linux-riscv@kernel.org
Message-ID: <mhng-9bf55be8-1ce6-4f4d-91ef-7a18f694d8da@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Dec 2022 11:00:17 PST (-0800), patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
>
> This series was applied to riscv/linux.git (for-next)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Fri, 18 Nov 2022 09:17:06 +0800 you wrote:
>> The original patch series "Basic StarFive JH7110 RISC-V SoC support" [1]
>> is split into 3 patch series. They respectively add basic clock&reset,
>> pinctrl and device tree support for StarFive JH7110 SoC. These patch
>> series are independent, but the Visionfive2 board can boot up successfully
>> only if all these patches series applied. This one adds basic device
>> tree support. This patch series is pulled out from the patch 1~6 and
>> patch 27~30 of v1 [1]. You can simply get or review the patches at the
>> link [2].
>>
>> [...]
>
> Here is the summary with links:
>   - [v2,1/8] dt-bindings: riscv: Add StarFive JH7110 SoC and VisionFive2 board
>     (no matching commit)
>   - [v2,2/8] dt-bindings: timer: Add StarFive JH7110 clint
>     (no matching commit)
>   - [v2,3/8] dt-bindings: interrupt-controller: Add StarFive JH7110 plic
>     (no matching commit)
>   - [v2,4/8] dt-bindings: sifive,ccache0: Support StarFive JH7110 SoC
>     (no matching commit)
>   - [v2,5/8] soc: sifive: ccache: Add StarFive JH7110 support
>     (no matching commit)
>   - [v2,6/8] riscv: dts: starfive: Add initial StarFive JH7110 device tree
>     (no matching commit)
>   - [v2,7/8] riscv: dts: starfive: Add StarFive JH7110 VisionFive2 board device tree
>     (no matching commit)
>   - [v2,8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
>     https://git.kernel.org/riscv/c/6925ba3d9b8c
>
> You are awesome, thank you!

Looks like the bot is a little confused here, it's just that last patch 
that's been merged.
