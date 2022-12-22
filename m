Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB596546FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiLVUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLVUG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:06:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225681B1C0;
        Thu, 22 Dec 2022 12:06:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m29so4266035lfo.11;
        Thu, 22 Dec 2022 12:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xJWdK6g8RNg0tbX7DSdDlyoxHtFOwWkvjJQ959FY74=;
        b=QqZn58xjqXdTXRFOZ9n/cNbHc2HPSzK3pEW4GXVdeTcBmqLU40uL55OX2zgWp4LZYl
         QorS9Sl65LDN3NbsM+sEw1aauMYnph8tHnACNBsrjyx5HvFE3kBfoWiwKNaRgEX4sdPQ
         DNgjwxzKBTCwf7ZNjRaH/VmNb2n6JEB9ctBcXmbXB8M3Zy5fT3suv9eFKMD2a0FBKSEb
         MnBvv/xZwEvkgnul6SaupsScNvx2oFVIsY8xIW2xliXfnB1iSQkTzYgJxFYwvLQKWq7k
         RtWyPou0NkecpkIxD3sREwJn6n5NrsEEPf+FWTEjP6JaLU8soLUqWuldMRkKYbgUsqWx
         DncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xJWdK6g8RNg0tbX7DSdDlyoxHtFOwWkvjJQ959FY74=;
        b=npAcX4b1r8+x0TuS+84JxeqL0Uzmfa8bpckjdQGL3mH2ZJJ+GqTsB9evLSu4TimAyi
         77IRerbNv8IBY0E/6fikWyGWPnt2m5ix2CjDKwtJgVO/H4rmNo1khZ7HtZHnfkMm5J4T
         bTDglCpCCCN1uLSQFsiMO0BV30yuUUaR7pbuKheBQUHec5Ljr/w8oUu+f74gE//dm3L+
         U916xSSa6nqIaWHc4gE/3++4laEGZl3U2JJiHe5CprrGSSA5n6LlRMdNGc3OpYEBxwbV
         fJfUhPSxrYjZi7rxH6IYw4Mo72vZpbOlALU5jOVrCjbx8TRZ2bOqYITd5uh5arKnKnhD
         qG6w==
X-Gm-Message-State: AFqh2koxpbslMqupce9Vz9XIu6m/I+ua+2XVWbjO2DnawzJFCuwZNPIV
        iB0LN3IQXKaJhZdb8qCUVPw=
X-Google-Smtp-Source: AMrXdXu3IYj35bd8BBRhLKnppBsoqCruE0oNBLAv1GAPxljH5POv5pCeEQRfRoyNEWD3bVAZ57fCfw==
X-Received: by 2002:a05:6512:2987:b0:4a4:68b7:d642 with SMTP id du7-20020a056512298700b004a468b7d642mr2053171lfb.41.1671739585506;
        Thu, 22 Dec 2022 12:06:25 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id y11-20020a19750b000000b004b4b0a68f67sm184767lfe.185.2022.12.22.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:06:24 -0800 (PST)
Date:   Thu, 22 Dec 2022 23:06:23 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Bin Meng <bmeng@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] serial: Add RISC-V support to the earlycon
 semihost driver
Message-ID: <Y6S4v7t0n0BI1P7d@curiosity>
References: <20221209150437.795918-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209150437.795918-1-bmeng@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

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

Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

Applied the patches on top of Linux 6.1 and tested earlycon logs from
RISC-V target in OpenOCD.

Regards,
Sergey
