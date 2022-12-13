Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8820264BA97
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiLMREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbiLMREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:04:06 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FA20358;
        Tue, 13 Dec 2022 09:04:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s10so3967176ljg.1;
        Tue, 13 Dec 2022 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jdv/9Wbrqh81zZL/X/QwbMewBfzQZFI6F3JeWT7jcoU=;
        b=SW4r+twtRer3sbhKPsy4VHSvZew1ilW/wQtEMZn8GMmYrssSuAst+enQ+EE1mxWDd8
         TISTl4+GEQ83NDwRWmvwnZFjp2SMeMG4MnLwyNQvtww4X2Ph9kpnBZXsteLzwFx+VCnn
         MGwNdof31bCYukVfjoRISe4tPLw3TBbIyJL7zxY7ftSThPSFJMcKPoyhSCjKS31Qx964
         GWXe6ZyZnxwxtzrxAHlBERrdsD5vvrYVVBfOl/8s+1Lbw+w8/z/pkHufgaoM6RpCNt9r
         PWI40PMNivoo4pSAYXOccpXZaVi2g5ScrZbtWTUl7uFV/Mh6xVgDp2CQ7/YC9IbjCpCH
         Syzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdv/9Wbrqh81zZL/X/QwbMewBfzQZFI6F3JeWT7jcoU=;
        b=JhWB4Ox3L6TbEW4Dra0OlMoz8UdiYP3tfxSafLri1FHpUZaM6bAJo6zs6cduHOj1dM
         EqbB4ThAu+LhBhlN0jVq7cw/r6VRUNCKgyKuN9KLlK8dlkIHTBsI23FnnJgO9wDMoBHG
         31Ef8wJzpG4+l53jJKa+p2cnYMdgTHmgpSMad/y05X9WXFWosxGe7fCK/U0GJ1bLw9Lw
         8nfH32aONXZApXyd1At/7xDMxM5ZC5eEx+BSEKhLTOMSAjAi1qJMYcXPkWGR9pG/WW4c
         67BihkSQlKiqwy0MLCv3RP23LweQZOmQnBturN5JmeqRi74EA/YVYPXBhuyA2wvT4kc0
         1LpA==
X-Gm-Message-State: ANoB5pmCcejqsS9tZlaYNfOdNwGwpa4fFaUUDSZZvfyT73ZIAffX5IXv
        TSeuDKTBpb1M4TB3QLwq5VuRSW5fNStu57ir5g==
X-Google-Smtp-Source: AA0mqf5J24j4v0oPrhTmSeo5m/CDFyKvgHRBsRySwK8s0wmk/rE7mmg5VC9IRowRD5ab81vlcCivuTUrDsBbewz8zTw=
X-Received: by 2002:a05:651c:19ab:b0:276:66a4:47c3 with SMTP id
 bx43-20020a05651c19ab00b0027666a447c3mr24952647ljb.49.1670951042719; Tue, 13
 Dec 2022 09:04:02 -0800 (PST)
MIME-Version: 1.0
From:   "Seija K." <doremylover123@gmail.com>
Date:   Tue, 13 Dec 2022 12:03:51 -0500
Message-ID: <CAA42iKzgsHDC5b+nUyiH8TV0od8LjGp4G-WRyamB=NYtoDtMMw@mail.gmail.com>
Subject: [PATCH] arch: change variable types to match those of what is
 assigned to them
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many places where "int len = strlen(foo);" is written, just
for len to be passed as a parameter of size_t. This causes truncation
and then expansion back from int to size_t. Not to mention this is
poor logic and needless truncations can add extra unneeded
instructions.
This patch aims to fix the worst offenders.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..27f5acb69c3b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -117,7 +117,7 @@ static unsigned long initial_pmd_value __initdata = 0;
*/
void __init init_default_cache_policy(unsigned long pmd)
{
- int i;
+ unsigned i;
initial_pmd_value = pmd;
@@ -140,20 +140,22 @@ void __init init_default_cache_policy(unsigned long pmd)
*/
static int __init early_cachepolicy(char *p)
{
- int i, selected = -1;
+ size_t i, selected = 0;
for (i = 0; i < ARRAY_SIZE(cache_policies); i++) {
- int len = strlen(cache_policies[i].policy);
+ size_t len = strlen(cache_policies[i].policy);
if (memcmp(p, cache_policies[i].policy, len) == 0) {
selected = i;
- break;
+ goto no_err;
}
}
- if (selected == -1)
- pr_err("ERROR: unknown or unsupported cache policy\n");
+ pr_err("ERROR: unknown or unsupported cache policy\n");
+no_err:
+ if (selected != cachepolicy) {
+ unsigned long cr;
/*
* This restriction is partly to do with the way we boot; it is
* unpredictable to have memory mapped using two different sets of
@@ -161,14 +163,12 @@ static int __init early_cachepolicy(char *p)
* change these attributes once the initial assembly has setup the
* page tables.
*/
- if (cpu_architecture() >= CPU_ARCH_ARMv6 && selected != cachepolicy) {
- pr_warn("Only cachepolicy=%s supported on ARMv6 and later\n",
- cache_policies[cachepolicy].policy);
- return 0;
- }
-
- if (selected != cachepolicy) {
- unsigned long cr = __clear_cr(cache_policies[selected].cr_mask);
+ if (cpu_architecture() >= CPU_ARCH_ARMv6) {
+ pr_warn("Only cachepolicy=%s supported on ARMv6 and later\n",
+ cache_policies[cachepolicy].policy);
+ return 0;
+ }
+ cr = __clear_cr(cache_policies[selected].cr_mask);
cachepolicy = selected;
flush_cache_all();
set_cr(cr);
@@ -445,7 +445,7 @@ static void __init build_mem_type_table(void)
unsigned int cr = get_cr();
pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
int cpu_arch = cpu_architecture();
- int i;
+ size_t i;
if (cpu_arch < CPU_ARCH_ARMv6) {
#if defined(CONFIG_CPU_DCACHE_DISABLE)
diff --git a/arch/arm/probes/kprobes/test-core.c
b/arch/arm/probes/kprobes/test-core.c
index c562832b8627..7e8694eb772c 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -723,9 +723,9 @@ static const char coverage_register_lookup[16] = {
unsigned coverage_start_registers(const struct decode_header *h)
{
unsigned regs = 0;
- int i;
+ unsigned i;
for (i = 0; i < 20; i += 4) {
- int r = (h->type_regs.bits >> (DECODE_TYPE_BITS + i)) & 0xf;
+ unsigned r = (h->type_regs.bits >> (DECODE_TYPE_BITS + i)) & 0xf;
regs |= coverage_register_lookup[r] << i;
}
return regs;
@@ -774,12 +774,12 @@ static int coverage_start(const union decode_item *table)
static void
coverage_add_registers(struct coverage_entry *entry, kprobe_opcode_t insn)
{
- int regs = entry->header->type_regs.bits >> DECODE_TYPE_BITS;
+ u32 regs = entry->header->type_regs.bits >> DECODE_TYPE_BITS;
int i;
for (i = 0; i < 20; i += 4) {
enum decode_reg_type reg_type = (regs >> i) & 0xf;
int reg = (insn >> i) & 0xf;
- int flag;
+ unsigned flag;
if (!reg_type)
continue;
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..c491ed8e5cf2 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -227,7 +227,7 @@ static void vfp_raise_sigfpe(unsigned int sicode,
struct pt_regs *regs)
static void vfp_panic(char *reason, u32 inst)
{
- int i;
+ unsigned i;
pr_err("VFP: Error: %s\n", reason);
pr_err("VFP: EXC 0x%08x SCR 0x%08x INST 0x%08x\n",
@@ -700,7 +700,7 @@ static struct undef_hook vfp_kmode_exception_hook[] = {{
static int __init vfp_kmode_exception_hook_init(void)
{
- int i;
+ size_t i;
for (i = 0; i < ARRAY_SIZE(vfp_kmode_exception_hook); i++)
register_undef_hook(&vfp_kmode_exception_hook[i]);
diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 309648c17f48..7417da4d1236 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -92,7 +92,7 @@ int set_foreign_p2m_mapping(struct
gnttab_map_grant_ref *map_ops,
struct gnttab_map_grant_ref *kmap_ops,
struct page **pages, unsigned int count)
{
- int i;
+ unsigned i;
for (i = 0; i < count; i++) {
struct gnttab_unmap_grant_ref unmap;
@@ -137,7 +137,7 @@ int clear_foreign_p2m_mapping(struct
gnttab_unmap_grant_ref *unmap_ops,
struct gnttab_unmap_grant_ref *kunmap_ops,
struct page **pages, unsigned int count)
{
- int i;
+ unsigned i;
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
- int i;
+ u32 i;
/* disable all first */
__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x0);
diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index b13d8adf3be4..7b28b9ce1d3a 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -111,7 +111,7 @@ static inline unsigned char str2hexnum(unsigned char c)
static inline void str2eaddr(unsigned char *ea, unsigned char *str)
{
- int i;
+ unsigned i;
for (i = 0; i < 6; i++) {
unsigned char num;
diff --git a/arch/mips/alchemy/devboards/bcsr.c
b/arch/mips/alchemy/devboards/bcsr.c
index 8df0ccdc9287..894916e95ff6 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -28,7 +28,7 @@ static int bcsr_csc_base; /* linux-irq of first
cascaded irq */
void __init bcsr_init(unsigned long bcsr1_phys, unsigned long bcsr2_phys)
{
- int i;
+ unsigned i;
bcsr1_phys = KSEG1ADDR(CPHYSADDR(bcsr1_phys));
bcsr2_phys = KSEG1ADDR(CPHYSADDR(bcsr2_phys));
diff --git a/arch/mips/alchemy/devboards/platform.c
b/arch/mips/alchemy/devboards/platform.c
index 754bdd2ca630..a69d9d56f130 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -122,10 +122,10 @@ int __init
db1x_register_pcmcia_socket(phys_addr_t pcmcia_attr_start,
i = 5;
if (stschg_irq) {
- sr[i].name = "stschg";
- sr[i].flags = IORESOURCE_IRQ;
- sr[i].start = sr[i].end = stschg_irq;
- i++;
+ sr[5].name = "stschg";
+ sr[5].flags = IORESOURCE_IRQ;
+ sr[5].start = sr[5].end = stschg_irq;
+ i = 6;
}
if (eject_irq) {
sr[i].name = "eject";
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 5810d3993fc6..dda3ed6934ac 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -144,7 +144,7 @@ static void __init add_adam2_var(char *name, char *value)
static int __init parse_psp_env(void *psp_env_base)
{
- int i, n;
+ unsigned i, n;
char *name, *value;
struct psp_env_chunk *chunks = (struct psp_env_chunk *)psp_env_data;
@@ -171,7 +171,7 @@ static int __init parse_psp_env(void *psp_env_base)
static void __init ar7_init_env(struct env_var *env)
{
- int i;
+ unsigned i;
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
- unsigned char buf[10];
- int i;
- for (i = 7; i >= 0; i--) {
- buf[i] = "0123456789ABCDEF"[val & 0x0F];
- val >>= 4;
- }
- buf[8] = '\0';
- puts(buf);
+ char buf[9];
+ size_t i = sizeof(buf) - 1;
+ for (buf[i] = '\0'; i; val >>= 4)
+ buf[--i] = "0123456789ABCDEF"[val & 0xF];
+ puts(buf);
}
diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
index 155c5e911723..5b05069fec8f 100644
--- a/arch/mips/fw/arc/cmdline.c
+++ b/arch/mips/fw/arc/cmdline.c
@@ -47,7 +47,7 @@ static char __init *move_firmware_args(int argc,
LONG *argv, char *cp)
while (actr < argc) {
for(i = 0; i < ARRAY_SIZE(used_arc); i++) {
- int len = strlen(used_arc[i][0]);
+ size_t len = strlen(used_arc[i][0]);
if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
/* Ok, we want it. First append the replacement... */
@@ -86,7 +86,7 @@ void __init prom_init_cmdline(int argc, LONG *argv)
while (actr < argc) {
for (i = 0; i < ARRAY_SIZE(ignored); i++) {
- int len = strlen(ignored[i]);
+ size_t len = strlen(ignored[i]);
if (!strncmp(prom_argv(actr), ignored[i], len))
goto pic_cont;
diff --git a/arch/xtensa/platforms/iss/console.c
b/arch/xtensa/platforms/iss/console.c
index 10b79d3c74e0..3159917ffd2f 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -64,7 +64,7 @@ static int rs_write(struct tty_struct * tty,
static void rs_poll(struct timer_list *unused)
{
struct tty_port *port = &serial_port;
- int i = 0;
+ size_t i = 0;
int rd = 1;
unsigned char c;
@@ -192,7 +192,7 @@ late_initcall(rs_init);
static void iss_console_write(struct console *co, const char *s, unsigned count)
{
if (s && *s != 0) {
- int len = strlen(s);
+ size_t len = strlen(s);
simc_write(1, s, count < len ? count : len);
}
}
