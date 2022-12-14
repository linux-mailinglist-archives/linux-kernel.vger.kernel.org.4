Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63B64C181
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiLNAv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiLNAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:51:57 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BD55BF;
        Tue, 13 Dec 2022 16:51:55 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id fu10so1440722qtb.0;
        Tue, 13 Dec 2022 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agc2D5uYmPBhslvrwBFEjc9DPi+bA6UTLkfJdzaASJc=;
        b=IRmaO3gTkbp/3ZHH3PwmQ3dcmX2tUXE9ATSXJYxd82SbVNdvwyCcKiVtkLpVFdmZda
         3iZRMHIc9o9FPGD+hJroEnSNWflBT6bu1WlCsgF2mLuja5Sw0OqtjXeHjV1fYMkQ+DMT
         WZDWp9MUQmkDm3ZysJxKeY/5dL4CfSD3bVYiqPLRMapFDGcHGnaL9sUT2YkABzYNDrpK
         jCrgiGxeycHPgimneAiL6B9nvf8I0nrDH9bYVsJ11popj2wYHO/TEuboSecLf0DE08L6
         lRrIoyR8T/B/55eMQDEDtpgyBxBo1w+3NN/5Nf4ZY/Vj2NFEOH0fPvO8ifu2eQUxhCwY
         mIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=agc2D5uYmPBhslvrwBFEjc9DPi+bA6UTLkfJdzaASJc=;
        b=Cc6THhLswfz9Ow1hUHeMl799Mwo9G9hlwgnSAM3jHNf790V7Op2jfrDvKRRnnS+Ota
         tE2fLZPoyr4Wf0rUPZJH7o5VkxUokKUxdmTeKJMFWST7twvhJslEVAEpSaIIUhRR0x3S
         VdGsDjy6y6pLmWHD02Rtopt94zqXVvGb8sAdNXqjY7iswFwmO+/305tgbBFKeQ0C9cuZ
         CAL6nfimxHqZxCOyiuA8fykplgJocS0ENyvcDShuHgoodQ95QX657+enqbbK2XLVY64d
         6DBTHyhMTJ+EWhRa1cmGUNdDuOsstwDDVN3tvZdTngxcOvoGwg2DLkPeBACXb4KrZNTY
         rstw==
X-Gm-Message-State: ANoB5pljuj5G9Tb/BJ90woQa0gnwwZ/PGU2t18MM3Lz5Vz50KBC+1o5U
        IvPkV3wWdO22UXPjzyPD+w==
X-Google-Smtp-Source: AA0mqf6xtw54xm0GMZdLZAEzR7nsKOAr/4XmlduLF8bSU3of4o7NGfBAgtwAq1Nc4Ln6pTf7X8o1FA==
X-Received: by 2002:ac8:1118:0:b0:3a5:fef7:dfe5 with SMTP id c24-20020ac81118000000b003a5fef7dfe5mr26533804qtj.12.1670979114961;
        Tue, 13 Dec 2022 16:51:54 -0800 (PST)
Received: from ?IPV6:2603:7080:a33a:d95d:20:71fc:7eaf:858a? (2603-7080-a33a-d95d-0020-71fc-7eaf-858a.res6.spectrum.com. [2603:7080:a33a:d95d:20:71fc:7eaf:858a])
        by smtp.gmail.com with ESMTPSA id p20-20020ac84614000000b003a611cb2a95sm833107qtn.9.2022.12.13.16.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 16:51:54 -0800 (PST)
Message-ID: <b2ada465-8eec-a7e3-0265-df9d0e8492d2@gmail.com>
Date:   Tue, 13 Dec 2022 19:51:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Content-Language: en-US
To:     sstabellini@kernel.org, tsbogend@alpha.franken.de,
        chris@zankel.net, jcmvbkbc@gmail.com
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
From:   Seija Kijin <doremylover123@gmail.com>
Subject: [PATCH] arch: change variable types to match those of what is
 assigned to them
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many places where "int len = strlen(foo);" is written, just for len to be passed as a parameter of size_t. This causes truncation and then expansion back from int to size_t. Not to mention this is poor logic and needless truncations can add extra unneeded instructions.

This patch aims to fix the worst offenders.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
  arch/arm/mm/mmu.c                      | 30 +++++++++++++-------------
  arch/arm/probes/kprobes/test-core.c    |  8 +++----
  arch/arm/vfp/vfpmodule.c               |  4 ++--
  arch/arm/xen/p2m.c                     |  4 ++--
  arch/mips/alchemy/common/irq.c         |  2 +-
  arch/mips/alchemy/common/prom.c        |  2 +-
  arch/mips/alchemy/devboards/bcsr.c     |  2 +-
  arch/mips/alchemy/devboards/platform.c |  8 +++----
  arch/mips/ar7/prom.c                   |  4 ++--
  arch/mips/boot/compressed/dbg.c        | 14 +++++-------
  arch/mips/fw/arc/cmdline.c             |  4 ++--
  arch/xtensa/platforms/iss/console.c    |  4 ++--
  12 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..27f5acb69c3b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -117,7 +117,7 @@ static unsigned long initial_pmd_value __initdata = 0;
   */
  void __init init_default_cache_policy(unsigned long pmd)
  {
-    int i;
+    unsigned i;

      initial_pmd_value = pmd;

@@ -140,20 +140,22 @@ void __init init_default_cache_policy(unsigned long pmd)
   */
  static int __init early_cachepolicy(char *p)
  {
-    int i, selected = -1;
+    size_t i, selected = 0;

      for (i = 0; i < ARRAY_SIZE(cache_policies); i++) {
-        int len = strlen(cache_policies[i].policy);
+        size_t len = strlen(cache_policies[i].policy);

          if (memcmp(p, cache_policies[i].policy, len) == 0) {
              selected = i;
-            break;
+            goto no_err;
          }
      }

-    if (selected == -1)
-        pr_err("ERROR: unknown or unsupported cache policy\n");
+    pr_err("ERROR: unknown or unsupported cache policy\n");

+no_err:
+    if (selected != cachepolicy) {
+        unsigned long cr;
      /*
       * This restriction is partly to do with the way we boot; it is
       * unpredictable to have memory mapped using two different sets of
@@ -161,14 +163,12 @@ static int __init early_cachepolicy(char *p)
       * change these attributes once the initial assembly has setup the
       * page tables.
       */
-    if (cpu_architecture() >= CPU_ARCH_ARMv6 && selected != cachepolicy) {
-        pr_warn("Only cachepolicy=%s supported on ARMv6 and later\n",
-            cache_policies[cachepolicy].policy);
-        return 0;
-    }
-
-    if (selected != cachepolicy) {
-        unsigned long cr = __clear_cr(cache_policies[selected].cr_mask);
+        if (cpu_architecture() >= CPU_ARCH_ARMv6) {
+            pr_warn("Only cachepolicy=%s supported on ARMv6 and later\n",
+                cache_policies[cachepolicy].policy);
+            return 0;
+        }
+        cr = __clear_cr(cache_policies[selected].cr_mask);
          cachepolicy = selected;
          flush_cache_all();
          set_cr(cr);
@@ -445,7 +445,7 @@ static void __init build_mem_type_table(void)
      unsigned int cr = get_cr();
      pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
      int cpu_arch = cpu_architecture();
-    int i;
+    size_t i;

      if (cpu_arch < CPU_ARCH_ARMv6) {
  #if defined(CONFIG_CPU_DCACHE_DISABLE)
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index c562832b8627..7e8694eb772c 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -723,9 +723,9 @@ static const char coverage_register_lookup[16] = {
  unsigned coverage_start_registers(const struct decode_header *h)
  {
      unsigned regs = 0;
-    int i;
+    unsigned i;
      for (i = 0; i < 20; i += 4) {
-        int r = (h->type_regs.bits >> (DECODE_TYPE_BITS + i)) & 0xf;
+        unsigned r = (h->type_regs.bits >> (DECODE_TYPE_BITS + i)) & 0xf;
          regs |= coverage_register_lookup[r] << i;
      }
      return regs;
@@ -774,12 +774,12 @@ static int coverage_start(const union decode_item *table)
  static void
  coverage_add_registers(struct coverage_entry *entry, kprobe_opcode_t insn)
  {
-    int regs = entry->header->type_regs.bits >> DECODE_TYPE_BITS;
+    u32 regs = entry->header->type_regs.bits >> DECODE_TYPE_BITS;
      int i;
      for (i = 0; i < 20; i += 4) {
          enum decode_reg_type reg_type = (regs >> i) & 0xf;
          int reg = (insn >> i) & 0xf;
-        int flag;
+        unsigned flag;

          if (!reg_type)
              continue;
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..c491ed8e5cf2 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -227,7 +227,7 @@ static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)

  static void vfp_panic(char *reason, u32 inst)
  {
-    int i;
+    unsigned i;

      pr_err("VFP: Error: %s\n", reason);
      pr_err("VFP: EXC 0x%08x SCR 0x%08x INST 0x%08x\n",
@@ -700,7 +700,7 @@ static struct undef_hook vfp_kmode_exception_hook[] = {{

  static int __init vfp_kmode_exception_hook_init(void)
  {
-    int i;
+    size_t i;

      for (i = 0; i < ARRAY_SIZE(vfp_kmode_exception_hook); i++)
          register_undef_hook(&vfp_kmode_exception_hook[i]);
diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 309648c17f48..7417da4d1236 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -92,7 +92,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
                  struct gnttab_map_grant_ref *kmap_ops,
                  struct page **pages, unsigned int count)
  {
-    int i;
+    unsigned i;

      for (i = 0; i < count; i++) {
          struct gnttab_unmap_grant_ref unmap;
@@ -137,7 +137,7 @@ int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
                    struct gnttab_unmap_grant_ref *kunmap_ops,
                    struct page **pages, unsigned int count)
  {
-    int i;
+    unsigned i;

      for (i = 0; i < count; i++) {
          set_phys_to_machine(unmap_ops[i].host_addr >> XEN_PAGE_SHIFT,
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index da9f9220048f..83f73ae7d225 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -809,7 +809,7 @@ static int alchemy_gpic_suspend(void)
  static void alchemy_gpic_resume(void)
  {
      void __iomem *base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
-    int i;
+    u32 i;

      /* disable all first */
      __raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x0);
diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index b13d8adf3be4..7b28b9ce1d3a 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -111,7 +111,7 @@ static inline unsigned char str2hexnum(unsigned char c)

  static inline void str2eaddr(unsigned char *ea, unsigned char *str)
  {
-    int i;
+    unsigned i;

      for (i = 0; i < 6; i++) {
          unsigned char num;
diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index 8df0ccdc9287..894916e95ff6 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -28,7 +28,7 @@ static int bcsr_csc_base;    /* linux-irq of first cascaded irq */

  void __init bcsr_init(unsigned long bcsr1_phys, unsigned long bcsr2_phys)
  {
-    int i;
+    unsigned i;

      bcsr1_phys = KSEG1ADDR(CPHYSADDR(bcsr1_phys));
      bcsr2_phys = KSEG1ADDR(CPHYSADDR(bcsr2_phys));
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 754bdd2ca630..a69d9d56f130 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -122,10 +122,10 @@ int __init db1x_register_pcmcia_socket(phys_addr_t pcmcia_attr_start,

      i = 5;
      if (stschg_irq) {
-        sr[i].name    = "stschg";
-        sr[i].flags    = IORESOURCE_IRQ;
-        sr[i].start = sr[i].end = stschg_irq;
-        i++;
+        sr[5].name    = "stschg";
+        sr[5].flags    = IORESOURCE_IRQ;
+        sr[5].start = sr[5].end = stschg_irq;
+        i = 6;
      }
      if (eject_irq) {
          sr[i].name    = "eject";
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 5810d3993fc6..dda3ed6934ac 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -144,7 +144,7 @@ static void __init add_adam2_var(char *name, char *value)

  static int __init parse_psp_env(void *psp_env_base)
  {
-    int i, n;
+    unsigned i, n;
      char *name, *value;
      struct psp_env_chunk *chunks = (struct psp_env_chunk *)psp_env_data;

@@ -171,7 +171,7 @@ static int __init parse_psp_env(void *psp_env_base)

  static void __init ar7_init_env(struct env_var *env)
  {
-    int i;
+    unsigned i;
      struct psbl_rec *psbl = (struct psbl_rec *)(KSEG1ADDR(0x14000300));
      void *psp_env = (void *)KSEG1ADDR(psbl->env_base);

diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
index f6728a8fd1c3..5957f9030e0c 100644
--- a/arch/mips/boot/compressed/dbg.c
+++ b/arch/mips/boot/compressed/dbg.c
@@ -25,13 +25,9 @@ void puts(const char *s)

  void puthex(unsigned long long val)
  {
-
-    unsigned char buf[10];
-    int i;
-    for (i = 7; i >= 0; i--) {
-        buf[i] = "0123456789ABCDEF"[val & 0x0F];
-        val >>= 4;
-    }
-    buf[8] = '\0';
-    puts(buf);
+    char buf[9];
+    size_t i = sizeof(buf) - 1;
+    for (buf[i] = '\0'; i; val >>= 4)
+        buf[--i] = "0123456789ABCDEF"[val & 0xF];
+    puts(buf);
  }
diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
index 155c5e911723..5b05069fec8f 100644
--- a/arch/mips/fw/arc/cmdline.c
+++ b/arch/mips/fw/arc/cmdline.c
@@ -47,7 +47,7 @@ static char __init *move_firmware_args(int argc, LONG *argv, char *cp)

      while (actr < argc) {
          for(i = 0; i < ARRAY_SIZE(used_arc); i++) {
-            int len = strlen(used_arc[i][0]);
+            size_t len = strlen(used_arc[i][0]);

              if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
              /* Ok, we want it. First append the replacement... */
@@ -86,7 +86,7 @@ void __init prom_init_cmdline(int argc, LONG *argv)

      while (actr < argc) {
          for (i = 0; i < ARRAY_SIZE(ignored); i++) {
-            int len = strlen(ignored[i]);
+            size_t len = strlen(ignored[i]);

              if (!strncmp(prom_argv(actr), ignored[i], len))
                  goto pic_cont;
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 10b79d3c74e0..3159917ffd2f 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -64,7 +64,7 @@ static int rs_write(struct tty_struct * tty,
  static void rs_poll(struct timer_list *unused)
  {
      struct tty_port *port = &serial_port;
-    int i = 0;
+    size_t i = 0;
      int rd = 1;
      unsigned char c;

@@ -192,7 +192,7 @@ late_initcall(rs_init);
  static void iss_console_write(struct console *co, const char *s, unsigned count)
  {
      if (s && *s != 0) {
-        int len = strlen(s);
+        size_t len = strlen(s);
          simc_write(1, s, count < len ? count : len);
      }
  }
-- 
2.38.2


