Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353DE6FB836
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjEHURL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjEHURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:17:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5C6C1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683577026; x=1715113026;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZlDXXAwo1WtNfImJAMiXHOP6+jiRZhJDK8h1GAtwQ0=;
  b=njLDymkBFAwtCI8MMapTZlJxwamitbQIwFrwR3E0NVbMZj+7zAyUXXnp
   eUFeh+1FASMX3ovAhgsQdgaiilv5afZwQpaODRLoagXv5pG1yK2ukF3Jd
   xrp45Ysf8lcZOPP3HEWMkjTeQ+g+TJmVdEhenhpNFiBI1m1+/a6Mj8GTs
   0DflH3Bg1rCCttC+hENUCXDcA2vTyBhQUFMFOAnrbbWqCvxdJtrfWAT/+
   TvEBAjs+EumE9jvpDXmJuT8eQNAfdqknR6mu2oENYzO+SNUqG+uRxxZZI
   H0U2gvmovzI5tsa1RGAebFdsB4IssGiKjAsLUfGxPyaYF1iq0hzPjD6L0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="352807002"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="352807002"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="842836102"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="842836102"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:17:06 -0700
Date:   Mon, 8 May 2023 13:21:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        jacob.jun.pan@linux.intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Message-ID: <20230508132130.5a6feb0b@jacob-builder>
In-Reply-To: <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
        <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
        <20230506150741.2e3d2dcc@jacob-builder>
        <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
        <20230508094014.53913cf3@jacob-builder>
        <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
        <ZFkpk8y8mUZuZjkV@nvidia.com>
        <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 8 May 2023 10:17:53 -0700, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> On Mon, May 8, 2023 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
> >
> > CONFIG_IOMMU_MM_PASID perhaps? Says what it does without a clue about
> > why it does it. x86 arch code could select it ideally? =20
>=20
> Maybe we don't even need the "IOMMU" part. It's a core x86
> architecture feature. Maybe it usually (always?) gets used within the
> framework of some IOMMU work, but I guess ENCQCMD could be used in
> some hardwired way even without that (ie is it possible to have just
> some "basic PASID set up by VMM environment" thing?)
>=20
> I don't actually know who uses it and how, so I'm probably not the
> right person to name it, but just looking at the x86 code that sets
> it, the PASID code technically has no connection to any iommu code,
> it's literally a core CPU feature with an MSR and some magic faulting
> thing, and seems to be possibly usable as-is.
>=20
> That existing
>=20
>     #ifdef CONFIG_IOMMU_SVA
>=20
> in the x86 traps.c code just looks odd, and making it be
> CONFIG_IOMMU_MM_PASID sounds better to me. I'm just not sure about the
> "IOMMU" part either. Just "MM_PASID"?
>=20
> That said, the arm-smmu-v3-sva.c code clearly *also* uses pasid,
> except it seems to really want to call it "ssid".
>=20
> So "having a per-mm ASID for IO" is clearly a common feature. But
> naming seems hard, with x86 calling it PASID, arm64 seemingly calling
> it "SSID".
>=20
> Right now the only user *does* seem to be through the IOMMU SVA code,
> but that may or may not be fundamental.
>=20
> Now, "SSID" is a completely horrible name, as I immediately realized
> when I tried to google for it. So arm64 is just wrong, and we're most
> definitely continuing to call it PASID.
>=20
> I'd lean towards just "CONFIG_MM_PASID" or something, but at some
> point this is bikeshedding, and I don't know about any possible
> non-iommu direct uses?
+Jean who has mentioned potential use of PASID without IOMMU. But I don't
think there is anything in the current kernel.
Leave the name MM_PASID aside, I am trying to capture the discussion with a
patch below. I am struggling to get a clean solution since SVA code is
common as you said "having a per-mm ASID for IO". Having x86 Kconfig select
MM_PASID would be redundant if it is already selected by IOMMU_SVA. Perhaps
I am totally missing the point.

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58b1f208eff5..d69acc69bbbb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -652,7 +652,7 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
  */
 static bool try_fixup_enqcmd_gp(void)
 {
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_PASID
 	u32 pasid;
=20
 	/*
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index db98c3f86e8c..7106f3af74ee 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -153,9 +153,13 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
=20
+config IOMMU_MM_PASID
+	bool
+
 # Shared Virtual Addressing
 config IOMMU_SVA
 	bool
+	select IOMMU_MM_PASID
=20
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 2e56bd79f589..b4d7bd68a911 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -50,6 +50,7 @@ config INTEL_IOMMU_SVM
 	depends on X86_64
 	select MMU_NOTIFIER
 	select IOMMU_SVA
+	select IOMMU_MM_PASID
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8c9a7da1060..bdd7f4c1b9ad 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1166,22 +1166,12 @@ static inline bool tegra_dev_iommu_get_stream_id(st=
ruct device *dev, u32 *stream
 }
=20
 #ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid =3D IOMMU_PASID_INVALID;
-}
-static inline bool mm_valid_pasid(struct mm_struct *mm)
-{
-	return mm->pasid !=3D IOMMU_PASID_INVALID;
-}
-void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 #else
-static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+static inline struct iommu_sva *iommu_sva_bind_device(struct device *dev, =
struct mm_struct *mm)
 {
 	return NULL;
 }
@@ -1194,9 +1184,22 @@ static inline u32 iommu_sva_get_pasid(struct iommu_s=
va *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+#endif /* CONFIG_IOMMU_SVA */
+
+#ifdef CONFIG_IOMMU_MM_PASID
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid =3D IOMMU_PASID_INVALID;
+}
+static inline bool mm_valid_pasid(struct mm_struct *mm)
+{
+	return mm->pasid !=3D IOMMU_PASID_INVALID;
+}
+void mm_pasid_drop(struct mm_struct *mm);
+#else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
-#endif /* CONFIG_IOMMU_SVA */
+#endif /* CONFIG_IOMMU_MM_PASID */
=20
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..70740a4ab58a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -771,7 +771,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
=20
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_PASID
 		u32 pasid;
 #endif
 #ifdef CONFIG_KSM
diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..0b6498eafb0c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -945,7 +945,7 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd:1;
 #endif
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_PASID
 	unsigned			pasid_activated:1;
 #endif
 #ifdef	CONFIG_CPU_SUP_INTEL
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..cb02ddadd6fb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1177,7 +1177,7 @@ static struct task_struct *dup_task_struct(struct tas=
k_struct *orig, int node)
 	tsk->use_memdelay =3D 0;
 #endif
=20
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_PASID
 	tsk->pasid_activated =3D 0;
 #endif
=20
diff --git a/mm/init-mm.c b/mm/init-mm.c
index efa97b57acfd..b97414c2b2f7 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -42,7 +42,7 @@ struct mm_struct init_mm =3D {
 #endif
 	.user_ns	=3D &init_user_ns,
 	.cpu_bitmap	=3D CPU_BITS_NONE,
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_PASID
 	.pasid		=3D IOMMU_PASID_INVALID,
 #endif
 	INIT_MM_CONTEXT(init_mm)



Thanks,

Jacob
