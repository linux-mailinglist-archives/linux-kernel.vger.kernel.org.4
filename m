Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AF681906
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjA3S0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbjA3S0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:26:17 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23508470BC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r8so5689681pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuVGWrNUUEjIXx2KjigY2fz+dkSBCOERpinGp69EYJM=;
        b=iIZwFAAWGocdPshz3LmlC28vm5OGG56ziFBKl6XO1HZptYcLVhgEw6dYylimgH3fPM
         /9B3J5Y8Z5oJw8BWXUq7KJyb9hzrJEQ6lFjc1pcEcZkbDfsSey1/GskMpm4Hehh4ioBU
         Wt5Pm8Wx6kDDEj97kMeoEwJqCcK8bmo/I04WY0p9wPLCQTVCK7oSRboKeRvATTbLoWjS
         /eXynBB9Ka/mxjLhT+mtMnDY71dEocS7MrjhN4DDRdN4Kj0dm292Qdi9kCBQTP+i8mj1
         uIkxGhN1NA5vTZ36y79ou9www5avH7oUT2PdeyaFoDgA5qOxVcK8Fof3w4fsrUICEmlw
         HjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuVGWrNUUEjIXx2KjigY2fz+dkSBCOERpinGp69EYJM=;
        b=bkHfVlzjf0U6xaVHAuzueVhhWqPZZ5db0BRVmSew1Nv49TmCReb6rNwURg/SNsSHrj
         TvIOtpAwRd94kbLNBpVtwfO/C5hGRo4CjQ7elZBHBZhOFVB8aalS0zlLTSqP8wMbbpIa
         92vbQ0CocgnMIQu/1DPcK8SqOJihJHrCHkKA9OUhlOBiVM1jFIMRKCv8u5juY8CKOPhn
         VBR5UaDP4Gxj4qQDuz7EInzvuEkZAZLMMSPMI8AtFnJl/H/N9WcJ8JSQ/R3Tl2bpjoZy
         MYdvlDmJ+9CgTPijoQ0kUhcKvSjvjHmLcb7wINjDQfFzaoCEsWxH3YXHFSwefPq48PJZ
         wNEg==
X-Gm-Message-State: AO0yUKUdqnkv/yI3msRP3VwPYBgMJ7wYob7titcPwWuqg3BrAKsexKUQ
        fqTfBg1ubwbGy4yN9ezzDzBwPQ==
X-Google-Smtp-Source: AK7set+n/r2CZrElPyDBS1vKdJq6Onz/PLzE1JlEypVANy/qXderCMMOJZw49AYfFbT7RutNUjOs0A==
X-Received: by 2002:a05:6a20:a003:b0:bc:3537:34a4 with SMTP id p3-20020a056a20a00300b000bc353734a4mr17049951pzj.39.1675103064549;
        Mon, 30 Jan 2023 10:24:24 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:23 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 24/24] Documentation/kernel-parameters.txt: Add RISC-V for ACPI parameter
Date:   Mon, 30 Jan 2023 23:52:25 +0530
Message-Id: <20230130182225.2471414-25-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ACPI support added for RISC-V, this kernel parameter also
supported on RISC-V. Hence, update the documentation.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..d9795418aaf8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,9 +1,9 @@
-	acpi=		[HW,ACPI,X86,ARM64]
+	acpi=		[HW,ACPI,X86,ARM64,RISC-V]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |
 				  copy_dsdt }
 			force -- enable ACPI if default was off
-			on -- enable ACPI but allow fallback to DT [arm64]
+			on -- enable ACPI but allow fallback to DT [arm64,riscv]
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
 			strict -- Be less tolerant of platforms that are not
@@ -12,6 +12,8 @@
 			copy_dsdt -- copy DSDT to memory
 			For ARM64, ONLY "acpi=off", "acpi=on" or "acpi=force"
 			are available
+			For RISC-V, ONLY "acpi=off", "acpi=on" or "acpi=force"
+			are available
 
 			See also Documentation/power/runtime_pm.rst, pci=noacpi
 
-- 
2.38.0

