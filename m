Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C101F640CBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiLBSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiLBSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:00:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46EE467E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:00:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a9so5300559pld.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVnmEptgROI9IUZaX1f1yIZ6ff25eT2l+091wj20Eo4=;
        b=AgXPoK7ajSsa+YF9S97rT0pFxSb5esUwmDvXnV9B8vTumik2EPC0khwMfSy3rA7lNN
         fH/L0BdbXYNNf63U6/0OZRuMwlB44FLG7gJxo69AyF730lNztNl3A+KEadcTHJWbmL9m
         +UR7MYiBSt4xlPjXWLAmkLyDJJCO1sUdosLIg2TAKyEBy96xAPSbFBF5uZykQ7KCj660
         bD4Dm5l1BIs6CxEtxZSgewN4+TC0ZFFoZimqojrNoomjta3Rmjuwkgi7hrf+10QH6+Kr
         gfWr4wBpkzwjsEd3BtJWy68oiQ48aC9OMw60iZWxnNzPHTkdenYGtpyr5UcT31DFldLT
         puzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVnmEptgROI9IUZaX1f1yIZ6ff25eT2l+091wj20Eo4=;
        b=ndmvPakAxXtCLGweaLj4TPzn+3kSH9MpyZMiL6YJgEtMglCI6+WDhPzvyNh20j3GdH
         I5w5/sRcgdnPu6y/AwfQeRAFUSaK5vaYa/fcOUv/6IwSkFvEJdUDv9bJHuay8FCz8+Dh
         Mw+1Uat7vsRTsfYkihkJZdkxXiIV8spYLucPCFyzU1unpz5cqKHnaT84CBmSVnOcDjMs
         5fe5Qg9wPyZ8ArdhI4axe9uKdmt17Iq/MB4IBoNjNBul6e+JO+TjsqNVR8us535G84Ak
         PZ5GqdpPanK4GqmleXaR5ZX2FTki8eOeF3EhwwI6frfMaBdL/qaXCMdOlLmXSFAsoq/0
         /4rw==
X-Gm-Message-State: ANoB5pkuHZsO1HdVqukQrWHpPjXBLJfLI6/2kGosO+8Jna+N3GG0Mm/g
        gTDpAKh6oIrDLtKa2TJF69xN6w==
X-Google-Smtp-Source: AA0mqf6qsLB4Xz5iPXZah/+o9AROQaXWF5EkEGyIqCOjOZB4npvpJ0RF1db0zL2vl62HhCAqah/EWw==
X-Received: by 2002:a17:902:e807:b0:189:117c:fcfe with SMTP id u7-20020a170902e80700b00189117cfcfemr53798277plg.124.1670004035863;
        Fri, 02 Dec 2022 10:00:35 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709026b0b00b00186616b8fbasm5853160plk.10.2022.12.02.10.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:00:35 -0800 (PST)
Date:   Fri, 02 Dec 2022 10:00:35 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 10:00:18 PST (-0800)
Subject:     Re: [PATCH v2 8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
In-Reply-To: <20221118011714.70877-9-hal.feng@starfivetech.com>
CC:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ben.dooks@sifive.com, tglx@linutronix.de,
        Marc Zyngier <maz@kernel.org>, sboyd@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, emil.renner.berthing@canonical.com,
        hal.feng@starfivetech.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hal.feng@starfivetech.com
Message-ID: <mhng-cf616c36-e110-4274-9bbf-cc6a22b75ed5@palmer-ri-x1c9a>
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

On Thu, 17 Nov 2022 17:17:14 PST (-0800), hal.feng@starfivetech.com wrote:
> Add CONFIG_SERIAL_8250_DW=y, which is a necessary option for
> StarFive JH7110 and JH7100 SoCs to boot with serial ports.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 05fd5fcf24f9..a23d022974ad 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -122,6 +122,7 @@ CONFIG_MICROSEMI_PHY=y
>  CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
