Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6075B68E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiIMHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiIMHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:47:25 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791E4620C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:47:22 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220913074716epoutp033eb5b2cd3a6263bd365ee2b25186fe02~UW_0XfGJV0104001040epoutp03F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:47:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220913074716epoutp033eb5b2cd3a6263bd365ee2b25186fe02~UW_0XfGJV0104001040epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663055236;
        bh=CgjXg2SCTLfM9Jgj1tahlnR33ieCMLJXRXEg1u9cTZQ=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=nCPoPMaH/MdnN3uQgyfoaBkPczh/BdrMiBom8yFUVUbFq3TR07UoszGnQ6ZqguZCB
         nfIkERyvjbEdwNqqnx729zYKwHp9rtkbJllEo1CRyd8CuIL8LmVLtKWr9omt81kAT4
         YibEWloR+GJBWBmEb1LiUYYjtjFQfLEDj1W6TBqk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220913074715epcas2p4ef4664b7470af955cafc34023ece3957~UW_zqI0pO1341413414epcas2p42;
        Tue, 13 Sep 2022 07:47:15 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MRbCQ75S7z4x9Pv; Tue, 13 Sep
        2022 07:47:14 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.17.18832.28530236; Tue, 13 Sep 2022 16:47:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220913074714epcas2p469bce22e4504dd82349970c1ab0e845f~UW_yuN0-J1566115661epcas2p4P;
        Tue, 13 Sep 2022 07:47:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220913074714epsmtrp18dc7e12f989471a617f7a7742a18a61b~UW_ytFQXb2873728737epsmtrp14;
        Tue, 13 Sep 2022 07:47:14 +0000 (GMT)
X-AuditID: b6c32a45-f31fb70000014990-da-632035827668
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.CB.14392.28530236; Tue, 13 Sep 2022 16:47:14 +0900 (KST)
Received: from KORDO040863 (unknown [10.229.8.56]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220913074714epsmtip15368a13a3f19604ce5e9c6d4eae78371~UW_ygzTXa2825028250epsmtip1k;
        Tue, 13 Sep 2022 07:47:14 +0000 (GMT)
From:   "Hoyoung SEO" <hy50.seo@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>, <bhoon95.kim@samsung.com>,
        <kwmad.kim@samsung.com>
In-Reply-To: <000001d8c728$030bbdb0$09233910$@samsung.com>
Subject: RE: [PATCH v1] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Date:   Tue, 13 Sep 2022 16:47:14 +0900
Message-ID: <150001d8c745$0a13cbd0$1e3b6370$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQEcao4nPtwVTObTQc0w1QKI2Ly9EwFvEqAzAlL76ZyvN5gLcA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmuW6TqUKywd7HFhYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WHRjG5PFzS1HWSwu75rDZtF9fQebxfLj/5gc
        eDwuX/H2uNzXy+QxYdEBRo/v6zvYPD4+vcXi0bdlFaPH501yHu0HupkCOKKybTJSE1NSixRS
        85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlVSKEvMKQUKBSQWFyvp
        29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGec3riSqeCMdsWK
        KQuZGhh7VboYOTkkBEwkLj+6xtLFyMUhJLCDUWLyug+MIAkhgU+MEg3TdCES3xgl7vXuY4Lp
        eDDxIxtEYi+jxKqrb6Cc54wSz1ccYAGpYhPQkrg+8S0zSEJE4AKTxPzbrewgCU4BK4mfB86A
        2cICURL3jmxlBbFZBFQlbkycxAZi8wpYSnRtmssCYQtKnJz5BMxmFpCX2P52DjPEGQoSO86+
        BrtVRMBJYsPHf2wQNSISszvbwBZLCBzhkJhysYcFosFFYnXLD6gfhCVeHd/CDmFLSbzsb4Oy
        iyV+vFnNBNHcwCixtP0Y1DZjiVnP2oG2cQBt0JRYv0sfxJQQUJY4cgvqNj6JjsN/2SHCvBId
        bUIQjUoSZ+behgpLSBycnQMR9pDo33uSbQKj4iwkT85C8uQsJM/MQli7gJFlFaNYakFxbnpq
        sVGBITyyk/NzNzGCE7KW6w7GyW8/6B1iZOJgPMQowcGsJMK7XVU+WYg3JbGyKrUoP76oNCe1
        +BCjKTDYJzJLiSbnA3NCXkm8oYmlgYmZmaG5kamBuZI4r6s2Y7KQQHpiSWp2ampBahFMHxMH
        p1QD08zPNxc+tlaXvH2aXyH8y779J8tdVBOeNMgKe5vZ3n110SSr2qzoQrzWwauuIhcybM8a
        iC+7d8k6rGlB0ZLyCxxh/sLKu2412nw/8Vh47a5S9oOedifcb/AG/979aYmNzpZ9PXf9LzsI
        SgWX24TH7bKZZN5WdHxzSG/LJ/k9O1dqnHqm5vF9/saWL5GSx/YrGzfKv3t9afP3r/ZHTtRu
        Ydhy3nx1/uLolf8z+99ks/I++75au+aibKK+x/fLfPF3RNNiRRz797+9Vyc9x9nxwKpX9qf/
        z+Pq0kzjzdhnM+XsQYkPHfP4ZqVwpejqqfxgnXX+qt+kg7da4hMKtXLXPpzEner3lWdGldp9
        mbJni5VYijMSDbWYi4oTAZsPDqdRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG6TqUKyweEtEhYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WHRjG5PFzS1HWSwu75rDZtF9fQebxfLj/5gc
        eDwuX/H2uNzXy+QxYdEBRo/v6zvYPD4+vcXi0bdlFaPH501yHu0HupkCOKK4bFJSczLLUov0
        7RK4Mk5vXMlUcEa7YsWUhUwNjL0qXYycHBICJhIPJn5k62Lk4hAS2M0ocXLiP3aIhITE/8VN
        TBC2sMT9liOsEEVPGSW29y9iBkmwCWhJXJ/4lhkkISJwj0mi5ct8qFE7GSUOXzjIAlLFKWAl
        8fPAGbCxwgIREt+2rWQFsVkEVCVuTJzEBmLzClhKdG2aywJhC0qcnPkEzGYW0JbofdjKCGHL
        S2x/O4cZ4iQFiR1nX4PFRQScJDZ8/McGUSMiMbuzjXkCo9AsJKNmIRk1C8moWUhaFjCyrGKU
        TC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5ELc0djNtXfdA7xMjEwXiIUYKDWUmEd7uq
        fLIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTD3Gi9RS
        VExvp6etv/jWoab5cbfA/qvpPi57908xDTm2uCifZdJrnpmZ78M7Z+9oyjYTPPOKre/PAnub
        l3O7s+6YMxf7bBH+sTtmEcMki9A1l0w3eYrYXp7o/zAx8f/dqlut0SeWJO35G37W9mfDvD+s
        tsennvArWud0f+GnnK0CB2Q+NVyYtofZxuJ027/wkpfvd770vFvkvJmr/hGfAceLdIui0ysn
        91pUKL8P3/dhEU/fx3Lj3H1Sn1d8Dgu57fjvz8oAS5mgmF98VZ5psr+co04ri709PNeZe+tr
        hQ1V+c9OhZYZn35yxL96UYvHnNSulGshO/KWrLyZs4ZLS0K0/LWxiKtv+gqJ19z5X5RYijMS
        DbWYi4oTAfbsJW0zAwAA
X-CMS-MailID: 20220913074714epcas2p469bce22e4504dd82349970c1ab0e845f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f
References: <CGME20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f@epcas2p1.samsung.com>
        <20220912140000.95483-1-hy50.seo@samsung.com>
        <000001d8c728$030bbdb0$09233910$@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alim Akhtar [mailto:alim.akhtar@samsung.com]
> Sent: Tuesday, September 13, 2022 1:19 PM
> To: 'SEO HOYOUNG'; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; avri.altman@wdc.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com; beanhuo@micron.com; asutoshd@codeaurora.org;
> cang@codeaurora.org; bvanassche@acm.org; bhoon95.kim@samsung.com;
> kwmad.kim@samsung.com
> Subject: RE: [PATCH v1] scsi: ufs: add a variant operation in struct
> ufs_hba_variant_ops
> 
> 
> 
> >-----Original Message-----
> >From: SEO HOYOUNG [mailto:hy50.seo@samsung.com]
> >Sent: Monday, September 12, 2022 7:30 PM
> >To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
> >martin.petersen@oracle.com; beanhuo@micron.com;
> >asutoshd@codeaurora.org; cang@codeaurora.org; bvanassche@acm.org;
> >bhoon95.kim@samsung.com; kwmad.kim@samsung.com
> >Cc: SEO HOYOUNG <hy50.seo@samsung.com>
> >Subject: [PATCH v1] scsi: ufs: add a variant operation in struct
> >ufs_hba_variant_ops
> >
> >Add ufs_hba_variant_ops about vendor error in check_error.
> >It need to reset when occurred ah8 related error.
> >At that time could not recovery with pwr cmd.
> >So add vendor error check function at ufs_hba_variant_ops.
> >
> I didn't understand why you need this, looks like you are using AH8.
> So IS (interrupt status) bit[5], bit[6] , HIBERNATE_EXIT and
> HIBERNATE_ENTRY should still give you the error status?

The AH8 FSM machine check power_local result.
If the expected value of power_local is different 
during hibern8 Enter/Exit, then will occur UHES/UHXS.
Other than that, errors could not occurred IS(interrupt status)
bit[5], bit[6].
So we need to check 'vendor IS' for checking error of AH8 FSM.

> 
> 
> >Change-Id: I24c76a372931e702b357c86a5dc36e93ce4b5fda
> This is something unwanted
> 
> >Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> >---
> > drivers/ufs/core/ufshcd-priv.h |  7 +++++++
> > drivers/ufs/core/ufshcd.c      |  2 ++
> > drivers/ufs/host/ufs-exynos.c  | 19 +++++++++++++++++++
> > include/ufs/ufshcd.h           |  1 +
> > 4 files changed, 29 insertions(+)
> >
> >diff --git a/drivers/ufs/core/ufshcd-priv.h
> >b/drivers/ufs/core/ufshcd-priv.h index d00dba17297d..6172da4d3484
> >100644
> >--- a/drivers/ufs/core/ufshcd-priv.h
> >+++ b/drivers/ufs/core/ufshcd-priv.h
> >@@ -221,6 +221,13 @@ static inline void
> >ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
> > 		hba->vops->config_scaling_param(hba, p, data);  }
> >
> >+static inline void ufshcd_vops_check_int_error(struct ufs_hba *hba,
> >+					       bool *queue_eh_work)
> >+{
> >+	if (hba->vops & hba->vops->check_int_error)
> >+		hba->vops->check_int_error(hba, queue_eh_work); }
> >+
> > extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
> >
> > /**
> >diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> >index 7c15cbc737b4..39ee5192f26a 100644
> >--- a/drivers/ufs/core/ufshcd.c
> >+++ b/drivers/ufs/core/ufshcd.c
> >@@ -6542,6 +6542,8 @@ static irqreturn_t ufshcd_check_errors(struct
> >ufs_hba *hba, u32 intr_status)
> > 		queue_eh_work = true;
> > 	}
> >
> >+	ufshcd_vops_check_int_error(hba, &queue_eh_work);
> >+
> > 	if (queue_eh_work) {
> > 		/*
> > 		 * update the transfer error masks to sticky bits, let's do
> this
> >diff --git a/drivers/ufs/host/ufs-exynos.c
> >b/drivers/ufs/host/ufs-exynos.c index eced97538082..b351b8e48b08 100644
> >--- a/drivers/ufs/host/ufs-exynos.c
> >+++ b/drivers/ufs/host/ufs-exynos.c
> >@@ -67,6 +67,10 @@
> > #define CLK_CTRL_EN_MASK	(REFCLK_CTRL_EN |\
> > 				 UNIPRO_PCLK_CTRL_EN |\
> > 				 UNIPRO_MCLK_CTRL_EN)
> >+
> >+#define HCI_AH8_STATE		0x50C
> >+#define HCI_AH8_STATE_ERROR	BIT(16)
> >+
> > /* Device fatal error */
> > #define DFES_ERR_EN		BIT(31)
> > #define DFES_DEF_L2_ERRS	(UIC_DATA_LINK_LAYER_ERROR_RX_BUF_OF
> >|\
> >@@ -1376,6 +1380,20 @@ static void exynos_ufs_hibern8_notify(struct
> >ufs_hba *hba,
> > 	}
> > }
> >
> >+static void exynos_ufs_check_int_error(struct ufs_hba *hba, bool
> >+*queue_eh_work) {
> >+	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
> >+
> >+	if (ufshcd_is_auto_hibern8_supported(hba)) {
> >+		val = hci_readl(ufs, HCI_AH8_STATE);
> >+
> >+		if (val & HCI_AH8_STATE_ERROR) {
> >+			 ufshcd_set_link_broken(hba);
> >+			 queue_eh_work = true;
> >+		}
> >+	}
> >+}
> >+
> > static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op
> >pm_op,
> > 	enum ufs_notify_change_status status)  { @@ -1569,6 +1587,7 @@
> static
> >const struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
> > 	.setup_xfer_req			=
> >exynos_ufs_specify_nexus_t_xfer_req,
> > 	.setup_task_mgmt		=
> >exynos_ufs_specify_nexus_t_tm_req,
> > 	.hibern8_notify			= exynos_ufs_hibern8_notify,
> >+	.check_int_error		= exynos_ufs_check_int_error,
> > 	.suspend			= exynos_ufs_suspend,
> > 	.resume				= exynos_ufs_resume,
> > };
> >diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h index
> >24c97e0772bb..40078c4b9f55 100644
> >--- a/include/ufs/ufshcd.h
> >+++ b/include/ufs/ufshcd.h
> >@@ -335,6 +335,7 @@ struct ufs_hba_variant_ops {
> > 			       const union ufs_crypto_cfg_entry *cfg, int slot);
> > 	void	(*event_notify)(struct ufs_hba *hba,
> > 				enum ufs_event_type evt, void *data);
> >+	void	(*check_int_error)(struct ufs_hba *hba, bool
> >*queue_eh_work);
> > };
> >
> > /* clock gating state  */
> >--
> >2.26.0
> 


