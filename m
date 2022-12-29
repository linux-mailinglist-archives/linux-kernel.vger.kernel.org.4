Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220D0658EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiL2QXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiL2QWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:22:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EAC13D1E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:22:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so23365968pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OLkB5mMsHKDwbR+cM0W/wmV6jqAoejRkqxG5WHPUJQ=;
        b=yQiDJFyvnV+prccj0GMjiX10frFzC9Mfv04bocJ0Bh8oX7y+0k1z6Z0xnkfyFjqKTN
         tecrdMMOKsT+GF9HeX5ucR840RKiPVlcQdFksm2EpP7XAJ9W8nteo/euV7HUtU/7XVos
         1gbq8i/EFYMDbJSxlFINjqZCWh0Or2riyQhU8vz0xkkzkh6Xzo+J8F5WBgOl4kH4tth7
         8xSe/BGB6hbIfuiW/binFvc8fGWyKCJQHaCCfH+RS8RzQ2jbZpqI50KJAWYN2ASGpeVk
         C4Ws88CuuQy79JJarYmebhTN4nklASG/JuK2M5upTdnlTHNIhG+lCB/FISII85YP2K5G
         kyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OLkB5mMsHKDwbR+cM0W/wmV6jqAoejRkqxG5WHPUJQ=;
        b=d8LfiLPxs2xtJSzQVbWg8XUWAYbYsIi1R3O+BuFdyzyf1NQYqTqETS5oOn3dpzXEPP
         PlpEoCACPkY/WdkuFXBw6SyN5A/Ot0FDDVZiMxelBdpZ1q6wTMx0X/WM1oU9iSWYCVAA
         xTd2I0M+/BS/oHZsH5GjZBVJaQmVcydtuyMo7SV3u+KzdRhly035jrM3vwBF1CE2PymL
         vB7Jsl39V1U0o55ox6gyr+8rzJcE2d3PFzNkwNHiPmycheyg0O3OtuXzTKxzdbRf8pab
         zEGQGvERg4Dx/HarNW2AdrpsGOuaru4jt+rx7rDqWGQCimw/m88YXEUc8oNl5bcENrlt
         3f3g==
X-Gm-Message-State: AFqh2koh3gxy1AZq7us65sfDl2JxRc8N67058424p1zUgtIX0wARQen0
        tsm6vwBSXCb/D6oZbQoag6nDu8HvxjcRaH4S
X-Google-Smtp-Source: AMrXdXvbOxeambP1FNrtoSqupKLHR5ZUV5b4qXQ2GRZNGFk8nmQRfBqHImgd60VPFJ/uowpsCdY3Pg==
X-Received: by 2002:a17:90a:d511:b0:225:dce3:8b9e with SMTP id t17-20020a17090ad51100b00225dce38b9emr19076607pju.5.1672330942227;
        Thu, 29 Dec 2022 08:22:22 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a4fc200b00225d963fbc2sm8493338pjh.34.2022.12.29.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:22:21 -0800 (PST)
Date:   Thu, 29 Dec 2022 08:22:21 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 07:49:50 PST (-0800)
Subject:     Re: [PATCH v3 0/3] serial: Add RISC-V support to the earlycon semihost driver
In-Reply-To: <20221209150437.795918-1-bmeng@tinylab.org>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux@armlinux.org.uk, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng@tinylab.org
Message-ID: <mhng-93a78d3a-6372-4972-94fe-31607664bb67@palmer-ri-x1c9>
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

On Fri, 09 Dec 2022 07:04:34 PST (-0800), bmeng@tinylab.org wrote:
>
> RISC-V semihosting spec [1] is built on top of the existing Arm one;
> we can add RISC-V earlycon semihost driver easily.
>
> This series refactors the existing driver a little bit, to move smh_putc()
> variants in respective arch's semihost.h, then we can implement RISC-V's
> version in the riscv arch directory.
>
> Link: https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc [1]
>
> Changes in v3:
> - add #ifdef in the header to prevent from multiple inclusion
> - add forward-declare struct uart_port
> - add a Link tag in the commit message
>
> Changes in v2:
> - new patch: "serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h"
> - Move the RISC-V implementation to semihost.h
>
> Bin Meng (3):
>   serial: earlycon-arm-semihost: Move smh_putc() variants in respective
>     arch's semihost.h
>   riscv: Implement semihost.h for earlycon semihost driver
>   serial: Rename earlycon semihost driver
>
>  arch/arm/include/asm/semihost.h               | 30 +++++++++++++++++++
>  arch/arm64/include/asm/semihost.h             | 24 +++++++++++++++
>  arch/riscv/include/asm/semihost.h             | 26 ++++++++++++++++
>  drivers/tty/serial/Kconfig                    | 14 ++++-----
>  drivers/tty/serial/Makefile                   |  2 +-
>  ...con-arm-semihost.c => earlycon-semihost.c} | 25 +---------------
>  6 files changed, 89 insertions(+), 32 deletions(-)
>  create mode 100644 arch/arm/include/asm/semihost.h
>  create mode 100644 arch/arm64/include/asm/semihost.h
>  create mode 100644 arch/riscv/include/asm/semihost.h
>  rename drivers/tty/serial/{earlycon-arm-semihost.c => earlycon-semihost.c} (57%)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
