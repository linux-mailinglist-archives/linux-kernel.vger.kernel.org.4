Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17CE6696D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjAMMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAMMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:22:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D4551D3;
        Fri, 13 Jan 2023 04:17:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s5so30895581edc.12;
        Fri, 13 Jan 2023 04:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zjJmv/1Y1vm7f3wbKvnY2AdxenvnF+7KOo8cw3lpY0=;
        b=hlMXqUUn8YBFEOZ7gdmwxg9CXeR/g8HHdUf8yHT0Lm4MZYvkbnjrdQ6XrJ+xDhRDPf
         t9i0gGX0pFxSBOHONHFisP4LLQRR2xdBHizXO7QSibvb31n04OCuncSp5Zt/KeYc49bM
         KUPyWQGzPJWZLMY0+rE0yYAV7rELv67bwq6RgHHsQ6nqNjJSDl+G1VdZgQWHrMRBtf44
         z7UZRDz+PqWDbEhYytn+tK+YyDdMPBh4Ol5L6YQlO6K7iI7qLFw1gFHgdFpgLlU4UUIS
         9yKKbVfvZgsDfn8+94XoNbibj2x9Gocaom3F54pPCmd77Gr98CO6H0sT1YueClxGXLGH
         ucrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zjJmv/1Y1vm7f3wbKvnY2AdxenvnF+7KOo8cw3lpY0=;
        b=ELhlmB8nTPxSJZngusrQICbhc/ZxQvdRcmGR9yr+C+v0MrA7XzWEMLv7UUpVXHJQ4s
         8zKGL+1qSr4stKaBOLreRLWyL8z7KM4cjz+hXM6bjiGfoVChE72g2HX2aEGPcGiUWMVw
         N0ykLpQf7uwo5g7Tgc2OVshXrOopjynwJD51T/EcHqMArPuhGpHn69uFSC+W6hdPdRP3
         F5XV90Igl3itfGwAIE30stpW6uJH+d+8z9/fjMJedeK69UfodQ9PTROUF0QIECngGsjt
         YcJlRfwRh8wqlrfPjgyMbB4nsusB0I7e2fnOphJd8IOuc8bmuUwzAa5oJm7ovSRI++q2
         Cfiw==
X-Gm-Message-State: AFqh2koNnqHrvXEDg8IOQ+ySou0preoYVyF0wRKyFASqmXTGyrHCvKkC
        a8lQi0XI1MUJd6NRS6a4A1Y9TG2h8I0=
X-Google-Smtp-Source: AMrXdXu9LByQiJONtDgeVa2vfdUtSprwpOe03cnTukxXiNVvFOOHYFutpz9HQoTwMpUYQZsyLqBdCA==
X-Received: by 2002:aa7:d411:0:b0:492:bf3d:1a1a with SMTP id z17-20020aa7d411000000b00492bf3d1a1amr28319184edq.18.1673612247328;
        Fri, 13 Jan 2023 04:17:27 -0800 (PST)
Received: from gmail.com ([31.46.242.235])
        by smtp.gmail.com with ESMTPSA id fd7-20020a056402388700b00483dd234ac6sm7951832edb.96.2023.01.13.04.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:17:26 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Jan 2023 13:17:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        maz@kernel.org
Subject: [PATCH] irqchip/imx: Do not unconditionally enable GENERIC_MSI_IRQ
Message-ID: <Y8FL0ATYr/fYk8Gh@gmail.com>
References: <20221111122014.524842979@linutronix.de>
 <166869769649.4906.4149362707512771458.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166869769649.4906.4149362707512771458.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the irq/core branch of tip:
> 
> Commit-ID:     13e7accb81d6c07993385af8342238ff22b41ac8
> Gitweb:        https://git.kernel.org/tip/13e7accb81d6c07993385af8342238ff22b41ac8
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Fri, 11 Nov 2022 14:54:40 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00
> 
> genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN
> 
> Adjust to reality and remove another layer of pointless Kconfig
> indirection. CONFIG_GENERIC_MSI_IRQ is good enough to serve
> all purposes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20221111122014.524842979@linutronix.de

The above commit started triggering a CONFIG_COMPILE_TEST=y build error on 
non-APIC x86 builds, the most straightforward fix is to only build that 
driver on ARM - given the dependency mess force-selected options generally 
cause.

Any better solutions?

Thanks,

	Ingo

=====================>
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 13 Jan 2023 13:10:05 +0100
Subject: [PATCH] irqchip/imx: Do not unconditionally enable GENERIC_MSI_IRQ

The IMX_MU_MSI ARM driver force-selects CONFIG_GENERIC_MSI_IRQ if CONFIG_COMPILE_TEST=y:

  config IMX_MU_MSI
        tristate "i.MX MU used as MSI controller"
        depends on OF && HAS_IOMEM
        depends on ARCH_MXC || COMPILE_TEST
        default m if ARCH_MXC
        select IRQ_DOMAIN
        select IRQ_DOMAIN_HIERARCHY
        select GENERIC_MSI_IRQ
        help

But that's not unconditionally valid - for example on x86 UP kernel builds
that have the local APIC disabled there's no MSI functionality - resulting
in build failures like:

  ./include/linux/gpio/driver.h:32:33: error: field ‘msiinfo’ has incomplete type
  kernel/irq/msi.c:739:19: error: invalid use of incomplete typedef ‘msi_alloc_info_t’ {aka ‘struct irq_alloc_info’}

Fixes: 13e7accb81d6 genirq: ("Get rid of GENERIC_MSI_IRQ_DOMAIN")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index caa952c40ff9..39578da6ee45 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -484,7 +484,7 @@ config IMX_INTMUX
 config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
-	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARCH_MXC
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
