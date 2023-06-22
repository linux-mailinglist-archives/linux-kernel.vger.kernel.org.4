Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7373A33D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjFVOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjFVOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:39:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870671BD2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:39:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b505665e2fso5280675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687444782; x=1690036782;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fywfQQcEL0GxG1eX4F63s7nb2iZREKwcfrQ6rwdwNPE=;
        b=xf8CKA36/oLmYxy+fdt9/SIgAHOADxcKQwWHt2OPJ010QjBV7ny/Bz897WkbXfO/jj
         QUScKRVUhiEWoppl07WUKtz3q7jq2csqmYuD/uYCD1B1NuoKeRmf81rIZCOSDRwWLIG7
         IJUEZx8gFt+hCMCBTeXOMrgNlKv1xazDcEFPKhF5dcTbrIhOntzLkobunYJBlWKO0ePE
         rJbH981zxRuJlMxoRBi2+Y7hiNHeOWJOh4CCscYGlJVQnh2RMt8tfaiv0Rru036pVB02
         QXvN6zwgzfKuqJVGjBSpjXnX+zEtOR6UqWXRPIwyxyza21xi0bKV2wYlbLe5cl3opbHj
         g3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444782; x=1690036782;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fywfQQcEL0GxG1eX4F63s7nb2iZREKwcfrQ6rwdwNPE=;
        b=DM6DnLqWjOT1dE9wVq9SGgSCSzpXioroPFMAMC+76l3M1JAxAJGXKaAsHXzfGRXDQF
         Kifh1+YvBOa0nDK1u8pJZGEFxLnarwvb4Eo1IARWVj48Q3pfGGZH+8CbIoR4Og8+SMgX
         SXUz1ioe+9tljZz5WEsWKtTSnOsrEzJuXR5mfB3L7U4pdZnznvFskiVB78WGtJkjkNxf
         4ngTabRbINBRzPWpmz1pv72g8dLSoFxYbZinqqgoPZ83E7/R9+67X8cjZiU9ZEE6ZAx0
         2qCiSRgGuPfPHuj1RLEUhsazaJaG3vz20AQIls+TFPRSiutjLJRgeT/2qqVbsOFWra0S
         qOQA==
X-Gm-Message-State: AC+VfDxQcBZ8UlfgBiQ2fhNKQubDtesZCjjEX7NDC/ZQ7cHshLGF1Cj7
        DYjlVnQvbIm6AIrtMPGH0M1YdQ==
X-Google-Smtp-Source: ACHHUZ5cQ42qHvVOqN8SowGOFbhQIKbt++HSzmLWu/muSBA0/EWR8inOOqpqrL0YmzJHQxzE5J00uQ==
X-Received: by 2002:a17:902:a38b:b0:1b6:92f0:b6f5 with SMTP id x11-20020a170902a38b00b001b692f0b6f5mr7242972pla.14.1687444781930;
        Thu, 22 Jun 2023 07:39:41 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b001b55fe1b471sm5473292plb.302.2023.06.22.07.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:39:41 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:39:41 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 07:37:29 PDT (-0700)
Subject:     Re: [PATCH v2 1/3] Documentation: arm: Add bootargs to the table of added DT parameters
In-Reply-To: <20230621072234.9900-1-alexghiti@rivosinc.com>
CC:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
        sunilvl@ventanamicro.com, songshuaishuai@tinylab.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-8d50653b-2461-4020-be8c-be0b9afc6cfc@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 00:22:32 PDT (-0700), alexghiti@rivosinc.com wrote:
> The bootargs node is also added by the EFI stub in the function
> update_fdt(), so add it to the table.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/arm/uefi.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
> index baebe688a006..2b7ad9bd7cd2 100644
> --- a/Documentation/arm/uefi.rst
> +++ b/Documentation/arm/uefi.rst
> @@ -50,7 +50,7 @@ The stub populates the FDT /chosen node with (and the kernel scans for) the
>  following parameters:
>
>  ==========================  ======   ===========================================
> -Name                        Size     Description
> +Name                        Type     Description
>  ==========================  ======   ===========================================
>  linux,uefi-system-table     64-bit   Physical address of the UEFI System Table.
>
> @@ -67,4 +67,6 @@ linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
>
>  kaslr-seed                  64-bit   Entropy used to randomize the kernel image
>                                       base address location.
> +
> +bootargs                    String   Kernel command line
>  ==========================  ======   ===========================================

+Ard, who looks like he's the last one who touched this.

I'm OK picking this up along with the RISC-V doc patches, but I don't 
know the Arm bits.
