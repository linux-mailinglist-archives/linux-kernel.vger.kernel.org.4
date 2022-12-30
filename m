Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF6659B51
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiL3SNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiL3SNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:13:48 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9CAFC3;
        Fri, 30 Dec 2022 10:13:48 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id p66so11493029iof.1;
        Fri, 30 Dec 2022 10:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjjFYrn+Z6BrwQksjCuz3/lydaArAzbP2sbV0KLxPy8=;
        b=irqIXhOR+QG3T3O+d81CHOLzqANbrlZCJ/hoiDso9hEtIoXY4sZYtRECMCY/KQe6Zd
         NrT9Sh86QdStcjfAPoLI6+dQXWaQLoU9B0iAf2pI1nHv0PVR954WU/1fWFfm59f70Cmd
         YZteNu2cyPgm8HOmrP6G9DRxTojK/ojzM+gHcPWi6Ve72tWzoVdENndoFX19UaWMTuvT
         YNDH8q3Z4fRMQGsbkTeiIyB7g9fNJQeZloWEdeFc1oCNKX81/0lPzk8TjqtxNpAa7ipr
         iyvS2SVrVtddhGIRAN4k3aB0H2ps8HVBCoR4dqKm/+9TQp1HzGDPfsBtENf5+KuNG3Js
         L7bw==
X-Gm-Message-State: AFqh2kqLfZwHM4sVvsTHTKHkIO/Lr7t9nq1/hPT5g5iBm3fxboAZt82g
        Gj5tFc04BqgRUvYnQBd4DHE84224YIqS7aMqR5M=
X-Google-Smtp-Source: AMrXdXsFDmiFbOwAISGoYvX96GPBHqjsnblzpwinRTNmG/43jaVn4C/GjMuEMo/LrdYQwGIRK6DNTbQ8+wvW98l2lTo=
X-Received: by 2002:a5e:c00c:0:b0:6a2:8015:afef with SMTP id
 u12-20020a5ec00c000000b006a28015afefmr2425943iol.149.1672424027483; Fri, 30
 Dec 2022 10:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20221223142419.3781410-1-ammar.faizi@intel.com> <20221223142419.3781410-2-ammar.faizi@intel.com>
In-Reply-To: <20221223142419.3781410-2-ammar.faizi@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 19:13:35 +0100
Message-ID: <CAJZ5v0j1nB9W=uNHKhqLHovTgAq_5ZYkzp6z==AspY4Dfp3PxA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: Silence missing prototype warnings
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPICA Mailing List <devel@acpica.org>,
        LLVM Mailing List <llvm@lists.linux.dev>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 3:25 PM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>
> Compiling with clang-16:
>
>   drivers/acpi/acpi_lpit.c:142:6: error: no previous prototype \
>   for function 'acpi_init_lpit' [-Werror,-Wmissing-prototypes]
>
>   drivers/acpi/ioapic.c:212:6: error: no previous prototype \
>   for function 'pci_ioapic_remove' [-Werror,-Wmissing-prototypes]
>
>   drivers/acpi/ioapic.c:229:5: error: no previous prototype \
>   for function 'acpi_ioapic_remove' [-Werror,-Wmissing-prototypes]
>
> Include "internal.h" to silence them.
>
> Cc: LLVM Mailing List <llvm@lists.linux.dev>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>  drivers/acpi/acpi_lpit.c | 1 +
>  drivers/acpi/ioapic.c    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index 50540d4d4948..3843d2576d3f 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <asm/msr.h>
>  #include <asm/tsc.h>
> +#include "internal.h"
>
>  struct lpit_residency_info {
>         struct acpi_generic_address gaddr;
> diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
> index a690c7b18623..6677955b4a8e 100644
> --- a/drivers/acpi/ioapic.c
> +++ b/drivers/acpi/ioapic.c
> @@ -24,6 +24,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <acpi/acpi.h>
> +#include "internal.h"
>
>  struct acpi_pci_ioapic {
>         acpi_handle     root_handle;
> --

Applied as 6.3 material, thanks!
