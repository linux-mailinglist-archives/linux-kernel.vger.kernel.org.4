Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228970728D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEQTwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQTws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:52:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB254680;
        Wed, 17 May 2023 12:52:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3094910b150so76589f8f.0;
        Wed, 17 May 2023 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684353163; x=1686945163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4q3W+L+Vfzur/6BczG0eeOcwKoF74+LjwJDCgGx6qc=;
        b=o+I1q9Iyd1Ji/bc6jZ27mS1G7Q/l1EhT1fbrhwtT7UD8BxyI1gd9Ued7rIwOYH2yMQ
         C9Ru2mFlgaVkcBjcwQ44dOeY7rEy8eI+naDPQL248WoWr//6XTpXXOoECT0PMXn5G0Ui
         x5nB8OAyvGrwOcWZR8JfxmrTdMwgMrZCdXoRLMfscmx3kCDl6GS8sD8QIG7DCkjL33Wp
         Z3yGotDEmT70Ap32/maDFe1dcuESZF5AQUsIfNqlKgqQwiOo6sZrKiWZNHsyWQmgXlgT
         YF+iohssdBkj30ZtISID8n4csOt+ZZd+EdVwpgoRkgsuJJTc1ySSRLMyVdFXkAXWWcOr
         3QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353163; x=1686945163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4q3W+L+Vfzur/6BczG0eeOcwKoF74+LjwJDCgGx6qc=;
        b=E2b5e+nOCMRfucgYpqxmnDRhloYlkW+LXIS4WFhqjRy4imZUjKYCik9guQbqmlJXmr
         cpsjVkZLx9hzSRc4I3V5ftT01VS1LS/MIdTtR5hj9xwXnAyUG0yqs+BUmbg9xhQnDzkW
         gHR96M/HkxOsHMCTwFOAUpvTJKG6OUCFtOslmsuyW3OC27vEvdGLLGQprOqHVVRA/QpR
         ylDvfFsmi4V8LXG/T44sm+femY5RmLNIfd6NsSVSX3dYyu+BD8aoFtkTa+GiytjtQbyR
         f81K+WaU6f2CahXiOQASqLi9skfSptHFSJcBXCfHM8npiTvFqsWecFI2A4eHT2+U0zVK
         ikrg==
X-Gm-Message-State: AC+VfDwSmLDNAtOuvdPcjf6oBKxTmbCG5Bxy4v2nQ+3q7ywhW8RQb+G1
        sO/Kp4q7q2zTq1IvCGQFVxg=
X-Google-Smtp-Source: ACHHUZ5mwvh4XOkXKTtv9V5ZRaNwlIKSDc48Iq+CI+ICJNOSp0D3mpqak5mT4LiKmJ5M2zjcwpIDlg==
X-Received: by 2002:a05:6000:1a4e:b0:2fb:ad8:288f with SMTP id t14-20020a0560001a4e00b002fb0ad8288fmr1590414wry.11.1684353162805;
        Wed, 17 May 2023 12:52:42 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f4247fbb5fsm3101349wmi.10.2023.05.17.12.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:52:42 -0700 (PDT)
Date:   Wed, 17 May 2023 20:52:40 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
Message-ID: <ZGUwiOkAc25BPi7M@debian>
References: <20230515161736.775969473@linuxfoundation.org>
 <ZGNJfAPd8eeVoCJ3@debian>
 <2023051711-thespian-sponsor-8878@gregkh>
 <CA+G9fYvw6HJopruUn4QKPCcqbdgw++AFf1wnwMP9hP1rJsmq3g@mail.gmail.com>
 <2023051704-catnip-vitality-d6cb@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vH2dFomHXNO2tTaN"
Content-Disposition: inline
In-Reply-To: <2023051704-catnip-vitality-d6cb@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vH2dFomHXNO2tTaN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 17, 2023 at 11:51:21AM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 17, 2023 at 03:11:48PM +0530, Naresh Kamboju wrote:
> > On Wed, 17 May 2023 at 14:21, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, May 16, 2023 at 10:14:36AM +0100, Sudip Mukherjee (Codethink) wrote:
> > > > Hi Greg,
> > > >
> > > > On Mon, May 15, 2023 at 06:24:11PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 5.10.180 release.
> > > > > There are 381 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > >
> > > > Build test (gcc version 11.3.1 20230511):
> > > > mips: 63 configs -> no failure
> > > > arm: 104 configs -> no failure
> > > > arm64: 3 configs -> 1 failure
> > > > x86_64: 4 configs -> no failure
> > > > alpha allmodconfig -> no failure
> > > > powerpc allmodconfig -> no failure
> > > > riscv allmodconfig -> no failure
> > > > s390 allmodconfig -> no failure
> > > > xtensa allmodconfig -> no failure
> > > >
> > > > arm64 allmodconfig build fails with the error:
> > > >
> > > > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid_ipa':
> > > > (.hyp.text+0x1a4c): undefined reference to `__kvm_nvhe_memset'
> > > > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid':
> > > > (.hyp.text+0x1b20): undefined reference to `__kvm_nvhe_memset'
> > > > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_flush_cpu_context':
> > > > (.hyp.text+0x1b80): undefined reference to `__kvm_nvhe_memset'
> > >
> > > That's odd, I don't see that symbol anywhere in the tree at all.
> > >
> > > And the only arm-related kvm changes don't have those symbols either
> > > (the other kvm changes are x86-only)
> > >
> > > Also, no one else has seen this issue.  Can you bisect?
> > 
> > This is an old issue,
> > Many other reported long back [1]
> > 
> > [1] https://lore.kernel.org/stable/CADYN=9KSKQx816id-zWepV-E3ozph3k2_i9Rhs6QseFv0hkPfg@mail.gmail.com/
> 
> Then maybe someone should submit it properly for inclusion?

Attached the backported patch. Also verified that my build failure is fixed with it.

-- 
Regards
Sudip

--vH2dFomHXNO2tTaN
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-KVM-arm64-Link-position-independent-string-routines-.patch"

From f57cddd458d9d49e39c061960014ec6f09187ac0 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Fri, 19 Mar 2021 10:01:10 +0000
Subject: [PATCH] KVM: arm64: Link position-independent string routines into .hyp.text

commit 7b4a7b5e6fefd15f708f959dd43e188444e252ec upstream

Pull clear_page(), copy_page(), memcpy() and memset() into the nVHE hyp
code and ensure that we always execute the '__pi_' entry point on the
offchance that it changes in future.

[ qperret: Commit title nits and added linker script alias ]

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210319100146.1149909-3-qperret@google.com
[sudip: adjust context]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 arch/arm64/include/asm/hyp_image.h |  3 +++
 arch/arm64/kernel/image-vars.h     | 11 +++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile   |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index daa1a1da539e7..e068427560510 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -31,6 +31,9 @@
  */
 #define KVM_NVHE_ALIAS(sym)	kvm_nvhe_sym(sym) = sym;
 
+/* Defines a linker script alias for KVM nVHE hyp symbols */
+#define KVM_NVHE_ALIAS_HYP(first, sec)	kvm_nvhe_sym(first) = kvm_nvhe_sym(sec);
+
 #endif /* LINKER_SCRIPT */
 
 #endif /* __ARM64_HYP_IMAGE_H__ */
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index c615b285ff5b3..48e43b29a2d5f 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -103,6 +103,17 @@ KVM_NVHE_ALIAS(gic_nonsecure_priorities);
 KVM_NVHE_ALIAS(__start___kvm_ex_table);
 KVM_NVHE_ALIAS(__stop___kvm_ex_table);
 
+/* Position-independent library routines */
+KVM_NVHE_ALIAS_HYP(clear_page, __pi_clear_page);
+KVM_NVHE_ALIAS_HYP(copy_page, __pi_copy_page);
+KVM_NVHE_ALIAS_HYP(memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(memset, __pi_memset);
+
+#ifdef CONFIG_KASAN
+KVM_NVHE_ALIAS_HYP(__memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(__memset, __pi_memset);
+#endif
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index ddde15fe85f2f..230bba1a6716b 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,9 +6,13 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
+lib-objs := clear_page.o copy_page.o memcpy.o memset.o
+lib-objs := $(addprefix ../../../lib/, $(lib-objs))
+
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o hyp-main.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
+obj-y += $(lib-objs)
 
 ##
 ## Build rules for compiling nVHE hyp code
-- 
2.30.2


--vH2dFomHXNO2tTaN--
