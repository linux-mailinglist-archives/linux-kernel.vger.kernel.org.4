Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4733D5FBCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJKVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:15:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB175BE2F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:15:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso162478pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gib0D3vn7iV7gqguQs5TQEHyewiBRG4GFbEpfMrpB/A=;
        b=eYOV8ko8c6DZ3A9ZdE3Ma+3KmlyiN6cbiSKUtmhaPcm8bfzitRg2oQ1cPYkUbZy642
         IxLvRST2IqwuhIYNLPYkCEjfcAJsPH68jP5zPFL16RX7V7v4j5PI+Ph6/iYldjYKceu5
         fFpjETMd59+CUTVJ8tkgVvJR6eTuB5t+izPA/KDK9h6OY+XhmFZuIEfl2w1ZATkTBRfs
         yxzFq+9w4w1raqTU8fcgRa+lcoIpQ9Bu5oAx+MMCtN0vk25Z8Bhz6gJ1t7gBYF+W8Tzu
         kRHBm4EnUwbQ7tlez0gy++QgAWw/nVMWHCOUJFqad38QM/u6cKum6pRFV68lFqar/qGG
         U3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gib0D3vn7iV7gqguQs5TQEHyewiBRG4GFbEpfMrpB/A=;
        b=hfN5HcEZkLiNAxLF8Q1UrMm7w5hAJDOqgfw/fEqEOV9qMNn2xsvHdyPcLh9qHYY5yR
         CX+gUCLj9S4xs1sTUOdYmXPs8WvfKKpglQreWYTtLf/feM1u55zo19QjkD/2oGDmMFfm
         oKeP0W9mKAkK++Xp9n2/07nFeMB2fZDsJsf9Tv8V+dJX0GotJAQDzTLlCJacBF4MWeLK
         cz5+nt9D+r8Y7P7ctOoGprCbiIyD6BJhMN1tML/JK+REYoH95tDYFWUGIM+e325FpkmQ
         firKzyBO500OQuOAngNrF0y4QrEv151PvmBI/BxrPbg3ok0UUcVFZt6/n2cJh3pRwwYs
         cWyA==
X-Gm-Message-State: ACrzQf1Stfp8m6ZfPButvjJ0fsxfWz5i+xyAOFbAGGVHND+99byqMScB
        xz+kwsYPFc6Sa14TQXb0kjwZkjOtpvjkIMMFdyROMA==
X-Google-Smtp-Source: AMsMyM5cyH0QdUroNV1X808aq9m/XnJUr8P0b5DSxK+VseOwU2ix4qzVSDBVNwtrzK9gp+4pocYmWLvFo2eZsCMYKPw=
X-Received: by 2002:a17:902:b218:b0:184:710c:8c52 with SMTP id
 t24-20020a170902b21800b00184710c8c52mr33869plr.95.1665522950969; Tue, 11 Oct
 2022 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <202210090815.526C76396@keescook> <20221011012904.2330473-1-lizetao1@huawei.com>
 <20221011012904.2330473-2-lizetao1@huawei.com>
In-Reply-To: <20221011012904.2330473-2-lizetao1@huawei.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Oct 2022 14:15:39 -0700
Message-ID: <CAKwvOdkj7PxeYT__ctaOX1wgf=PcoR-+H_VTBovwoyN+tQh_OQ@mail.gmail.com>
Subject: Re: [PATCH -next v4 1/2] x86/boot: Remove unused variables
To:     Li Zetao <lizetao1@huawei.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, masahiroy@kernel.org, michael.roth@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nathan@kernel.org,
        brijesh.singh@amd.com, peterz@infradead.org,
        venu.busireddy@oracle.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 6:32 PM Li Zetao <lizetao1@huawei.com> wrote:
>
> Gcc report warning as follows:
>
> arch/x86/boot/compressed/efi.c: In function =E2=80=98efi_get_system_table=
=E2=80=99:
> arch/x86/boot/compressed/efi.c:62:23: warning: unused variable =E2=80=98e=
t=E2=80=99
>   [-Wunused-variable]
>
> arch/x86/boot/compressed/efi.c: In function =E2=80=98efi_get_conf_table=
=E2=80=99:
> arch/x86/boot/compressed/efi.c:134:13: warning: unused variable
>   =E2=80=98ret=E2=80=99 [-Wunused-variable]
>
> arch/x86/boot/compressed/acpi.c: In function =E2=80=98__efi_get_rsdp_addr=
=E2=80=99:
> arch/x86/boot/compressed/acpi.c:27:13: warning: unused variable
>   =E2=80=98ret=E2=80=99 [-Wunused-variable]
>
> arch/x86/boot/compressed/acpi.c: In function =E2=80=98efi_get_rsdp_addr=
=E2=80=99:
> arch/x86/boot/compressed/acpi.c:55:22: warning: unused variable
>   =E2=80=98nr_tables=E2=80=99 [-Wunused-variable]
>
> arch/x86/boot/compressed/sev.c: In function =E2=80=98enforce_vmpl0=E2=80=
=99:
> arch/x86/boot/compressed/sev.c:256:13: error: unused variable =E2=80=98er=
r=E2=80=99
>   [-Werror=3Dunused-variable]
>
> Fix these warnings by removing unused variables.
>
> Fixes: 58f3e6b71f42 ("x86/compressed/acpi: Move EFI system table lookup t=
o helper")
> Fixes: 61c14ceda840 ("x86/compressed/acpi: Move EFI config table lookup t=
o helper")
> Fixes: dee602dd5d14 ("x86/compressed/acpi: Move EFI vendor table lookup t=
o helper")
> Fixes: f9d230e893e8 ("x86/boot: Correct RSDP parsing with 32-bit EFI")
> Fixes: 81cc3df9a90e ("x86/sev: Check the VMPL level")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v1 -> v2: Remove unused variables "et" in efi_get_system_table(), "ret" i=
n
> efi_get_conf_table(), "ret" in __efi_get_rsdp_addr() and  "nr_tables" in
> efi_get_rsdp_addr()
> v2 -> v3: None
> v3 -> v4: Put this patch in front
>
>  arch/x86/boot/compressed/acpi.c | 2 --
>  arch/x86/boot/compressed/efi.c  | 2 --
>  arch/x86/boot/compressed/sev.c  | 1 -
>  3 files changed, 5 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/a=
cpi.c
> index 9caf89063e77..21febd9f21ab 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -24,7 +24,6 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned =
int cfg_tbl_len)
>  {
>  #ifdef CONFIG_EFI
>         unsigned long rsdp_addr;
> -       int ret;
>
>         /*
>          * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_=
GUID to
> @@ -52,7 +51,6 @@ static acpi_physical_address efi_get_rsdp_addr(void)
>         unsigned long cfg_tbl_pa =3D 0;
>         unsigned int cfg_tbl_len;
>         unsigned long systab_pa;
> -       unsigned int nr_tables;
>         enum efi_type et;
>         int ret;
>
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/ef=
i.c
> index 6edd034b0b30..6ffd22710ed2 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -59,7 +59,6 @@ unsigned long efi_get_system_table(struct boot_params *=
bp)
>  {
>         unsigned long sys_tbl_pa;
>         struct efi_info *ei;
> -       enum efi_type et;
>
>         /* Get systab from boot params. */
>         ei =3D &bp->efi_info;
> @@ -131,7 +130,6 @@ int efi_get_conf_table(struct boot_params *bp, unsign=
ed long *cfg_tbl_pa,
>  {
>         unsigned long sys_tbl_pa;
>         enum efi_type et;
> -       int ret;
>
>         if (!cfg_tbl_pa || !cfg_tbl_len)
>                 return -EINVAL;
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
> index c93930d5ccbd..b9451761a69a 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -253,7 +253,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned=
 long exit_code)
>  static void enforce_vmpl0(void)
>  {
>         u64 attrs;
> -       int err;
>
>         /*
>          * RMPADJUST modifies RMP permissions of a lesser-privileged (num=
erically
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
