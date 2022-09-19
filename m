Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6B95BCBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiISMgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiISMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:36:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64691C139
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:36:34 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220919123630epoutp03344e95edd8566726c2476d163ef7ac3f~WQzEDJ9Ex0300503005epoutp034
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:36:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220919123630epoutp03344e95edd8566726c2476d163ef7ac3f~WQzEDJ9Ex0300503005epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663590990;
        bh=XZ044w9AY2d+UUji9QBWi3CcUG7L0amZ+DgWq1BhVZE=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Utry8MIm/R7HNVCsTMusp8sBPaD52pU16Rf5KDn7/z04bkS8XDQyJFwBwACwbmhP4
         AEjyxCkiBY88J0zjOXItwZ++oJzGTy2d6fChX9hEjxhjX1dWPgKPzSqcD+Unv8XfOF
         Y1VhVaQe375yUSzlX0jdRUqVtE/Bb0wrbt1jkHsI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220919123629epcas5p4efd931982c17aad4d6af81c12d242285~WQzD0RAaK1581615816epcas5p4I;
        Mon, 19 Sep 2022 12:36:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MWPLM3Gndz4x9Py; Mon, 19 Sep
        2022 12:36:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.B4.26992.B4268236; Mon, 19 Sep 2022 21:36:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220919123627epcas5p2b74a743ebf5b2401cebc68d86dde8b67~WQzBIp_Qz0163301633epcas5p2h;
        Mon, 19 Sep 2022 12:36:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220919123627epsmtrp21f50f4036da12043d6ac8257460bca86~WQzBHzSCW1793617936epsmtrp2g;
        Mon, 19 Sep 2022 12:36:27 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-f6-6328624bbd2d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.BA.18644.A4268236; Mon, 19 Sep 2022 21:36:26 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220919123625epsmtip2bd66adc86d402ee8248077a603cad3dc~WQy-oWXCj3180331803epsmtip21;
        Mon, 19 Sep 2022 12:36:25 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'SEO HOYOUNG'" <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <bvanassche@acm.org>, <bhoon95.kim@samsung.com>,
        <kwmad.kim@samsung.com>
In-Reply-To: <20220915134956.90086-1-hy50.seo@samsung.com>
Subject: RE: [PATCH v3] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Date:   Mon, 19 Sep 2022 18:06:24 +0530
Message-ID: <000001d8cc24$6f6b46a0$4e41d3e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIJ5gQnVd9W8QZv3SjtwcOT2uQaQwHRNqnPrXXytCA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmuq53kkayQf8FCYuXP6+yWRx82Mli
        8XXpM1aLaR9+MlusXvyAxWLRjW1MFje3HGWxuLxrDptF9/UdbBbLj/9jcuDyuHzF22PCogOM
        Ht/Xd7B5fHx6i8Wjb8sqRo/Pm+Q82g90MwWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzri1aRVzwRSlipUbf7A0MN6T6WLk5JAQMJF4
        NbORpYuRi0NIYDejRGvLezYI5xOjxNSrSxkhnM+MEm3L+1lgWi7dboeq2sUo0XP+JTtIQkjg
        JaPE4/vmIDabgK7EjsVtYEUiAjOZJG52XgUaxcHBKWAlsfaaMEiNsECUxNIT3WC9LAKqEvvO
        3mcFsXkFLCWm9y1hgbAFJU7OfAJmMwvIS2x/O4cZ4ggFiZ9Pl4HViwCN7HtzmBmiRlzi5dEj
        7BA1KzkklrxKg7BdJK5ducYKYQtLvDq+BapGSuLzu71sIKdJCHhILPojBRHOkHi7fD0jhG0v
        ceDKHBaQEmYBTYn1u/QhNvFJ9P5+wgTRySvR0SYEUa0q0fzuKjSkpCUmdnezwgyf9lIEEk69
        jBLnHhlNYFSYheTFWUhenIXklVkIexcwsqxilEwtKM5NTy02LTDMSy2HR3Zyfu4mRnDK1fLc
        wXj3wQe9Q4xMHIyHGCU4mJVEeN8maiQL8aYkVlalFuXHF5XmpBYfYjQFhvtEZinR5Hxg0s8r
        iTc0sTQwMTMzM7E0NjNUEuedos2YLCSQnliSmp2aWpBaBNPHxMEp1cDEJNlYo5hfWDWxvNA+
        sGhHadsi7isfF1XO2GBuUeA+kfXcpZ02s7t/rryy4liohOKGys+Tsi94/87jc1/4WWJ67Y93
        My2kJpl1LJ6qpf2nYkLl7gu8T+5FnrbTknV5/WuB/JprGtwaxmbWd+wXJn4WFt39tf/CjjsT
        4pnXBr995MX9/kPuu2+TTPT4n9f/2fKCnUtgs9X8t3IfooyD43nkD/QsXxK33G1puvjVqa9i
        zr77lJIglBRkoDRPtHrL8odlewIl+ZPescTmiFV+q2TtEw+bPjWJ5eX1XV8NjGevnOEx1fHr
        p41vc12ahTqjS6yC7+80Ul5+VST55kTz67c2/d2/6FR0g8PUiOtZ/24EKbEUZyQaajEXFScC
        AFQYLDdCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXtcrSSPZ4OUXU4uXP6+yWRx82Mli
        8XXpM1aLaR9+MlusXvyAxWLRjW1MFje3HGWxuLxrDptF9/UdbBbLj/9jcuDyuHzF22PCogOM
        Ht/Xd7B5fHx6i8Wjb8sqRo/Pm+Q82g90MwWwR3HZpKTmZJalFunbJXBl3Nq0irlgilLFyo0/
        WBoY78l0MXJySAiYSFy63c7WxcjFISSwg1Hi6/KljBAJaYnrGyewQ9jCEiv/PWeHKHrOKPHt
        y0qwIjYBXYkdi9vAukUEljJJ3P33EqxDSKCbUaLrt30XIwcHp4CVxNprwiBhYYEIieufmllA
        bBYBVYl9Z++zgti8ApYS0/uWsEDYghInZz4Bs5kFtCWe3nwKZctLbH87hxniIAWJn0+XgfWK
        AI3ve3OYGaJGXOLl0SPsExiFZiEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFi
        bnFpXrpecn7uJkZwnGlp7WDcs+qD3iFGJg7GQ4wSHMxKIryvbDWShXhTEiurUovy44tKc1KL
        DzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamA6eYpRUOPFXo62hqb7FetDl/8IV3pb
        3RcqpbzsSfmzqZLtU+IF/q2QE/n9q21bPfuOlGom94S1Ud+4ti5PPm1nn7Tl87kDp37IGO3x
        q77DeNvNuyxhVRZTh/TbS/HO6X73nQoZY9fInPJL9mNWmJYhyMO9+5AE2+q1x48YvJXdJXeZ
        M9ctTfV5uEIT25t//s/33zJy1Wtx53O/0/T2lOGSVvPZFqHHJdSFEi58/nyD2+/dVcbS1MAK
        LbXObUliB8R/hW1dyHVZKaQnWbFIaH9OUPcdAdmTlcxMRzjdny3sZ7hh5V+0mmPaKuWAk7Z+
        VgsfH14iHBh6fdsfvQAdI8cnktP+cIXvqpSW9vKoV2Ipzkg01GIuKk4EANvGofMiAwAA
X-CMS-MailID: 20220919123627epcas5p2b74a743ebf5b2401cebc68d86dde8b67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220916020702epcas2p2c4f7c7bcc1507db171b40aa45d7fa7d9
References: <CGME20220916020702epcas2p2c4f7c7bcc1507db171b40aa45d7fa7d9@epcas2p2.samsung.com>
        <20220915134956.90086-1-hy50.seo@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Seo

>-----Original Message-----
>From: SEO HOYOUNG [mailto:hy50.seo@samsung.com]
>Sent: Thursday, September 15, 2022 7:20 PM
>To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
>alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
>martin.petersen@oracle.com; beanhuo@micron.com; bvanassche@acm.org;
>bhoon95.kim@samsung.com; kwmad.kim@samsung.com
>Cc: SEO HOYOUNG <hy50.seo@samsung.com>
>Subject: [PATCH v3] scsi: ufs: add a variant operation in struct
>ufs_hba_variant_ops
>
>Add ufs_hba_variant_ops about vendor error in check_error.
>It need to reset when occurred ah8 related error.
>At that time could not recovery with pwr cmd.
>So add vendor error check function at ufs_hba_variant_ops.
>
>v1->v2
>fixed warm message of auto build test
>
>v2->v3
>fixed operator error
>
>Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
>---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

And you forget to add Bart's Reviewed-by on v2

> drivers/ufs/core/ufshcd-priv.h |  7 +++++++
> drivers/ufs/core/ufshcd.c      |  2 ++
> drivers/ufs/host/ufs-exynos.c  | 20 ++++++++++++++++++++
> include/ufs/ufshcd.h           |  1 +
> 4 files changed, 30 insertions(+)
>
>diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
>index d00dba17297d..a615f3533d75 100644
>--- a/drivers/ufs/core/ufshcd-priv.h
>+++ b/drivers/ufs/core/ufshcd-priv.h
>@@ -221,6 +221,13 @@ static inline void
>ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
> 		hba->vops->config_scaling_param(hba, p, data);  }
>
>+static inline void ufshcd_vops_check_int_error(struct ufs_hba *hba,
>+					       bool *queue_eh_work)
>+{
>+	if (hba->vops && hba->vops->check_int_error)
>+		hba->vops->check_int_error(hba, queue_eh_work); }
>+
> extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
>
> /**
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
>7c15cbc737b4..39ee5192f26a 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>@@ -6542,6 +6542,8 @@ static irqreturn_t ufshcd_check_errors(struct
>ufs_hba *hba, u32 intr_status)
> 		queue_eh_work = true;
> 	}
>
>+	ufshcd_vops_check_int_error(hba, &queue_eh_work);
>+
> 	if (queue_eh_work) {
> 		/*
> 		 * update the transfer error masks to sticky bits, let's do this
>diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
>index eced97538082..5d9db6870a66 100644
>--- a/drivers/ufs/host/ufs-exynos.c
>+++ b/drivers/ufs/host/ufs-exynos.c
>@@ -67,6 +67,10 @@
> #define CLK_CTRL_EN_MASK	(REFCLK_CTRL_EN |\
> 				 UNIPRO_PCLK_CTRL_EN |\
> 				 UNIPRO_MCLK_CTRL_EN)
>+
>+#define HCI_AH8_STATE		0x50C
>+#define HCI_AH8_STATE_ERROR	BIT(16)
>+
> /* Device fatal error */
> #define DFES_ERR_EN		BIT(31)
> #define DFES_DEF_L2_ERRS	(UIC_DATA_LINK_LAYER_ERROR_RX_BUF_OF
>|\
>@@ -1376,6 +1380,21 @@ static void exynos_ufs_hibern8_notify(struct
>ufs_hba *hba,
> 	}
> }
>
>+static void exynos_ufs_check_int_error(struct ufs_hba *hba, bool
>+*queue_eh_work) {
>+	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
>+	u32 val;
>+
>+	if (ufshcd_is_auto_hibern8_supported(hba)) {
>+		val = hci_readl(ufs, HCI_AH8_STATE);
>+
>+		if (val & HCI_AH8_STATE_ERROR) {
>+			ufshcd_set_link_broken(hba);
>+			*queue_eh_work = true;
>+		}
>+	}
>+}
>+
> static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op
>pm_op,
> 	enum ufs_notify_change_status status)
> {
>@@ -1569,6 +1588,7 @@ static const struct ufs_hba_variant_ops
>ufs_hba_exynos_ops = {
> 	.setup_xfer_req			=
>exynos_ufs_specify_nexus_t_xfer_req,
> 	.setup_task_mgmt		=
>exynos_ufs_specify_nexus_t_tm_req,
> 	.hibern8_notify			= exynos_ufs_hibern8_notify,
>+	.check_int_error		= exynos_ufs_check_int_error,
> 	.suspend			= exynos_ufs_suspend,
> 	.resume				= exynos_ufs_resume,
> };
>diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h index
>24c97e0772bb..40078c4b9f55 100644
>--- a/include/ufs/ufshcd.h
>+++ b/include/ufs/ufshcd.h
>@@ -335,6 +335,7 @@ struct ufs_hba_variant_ops {
> 			       const union ufs_crypto_cfg_entry *cfg, int slot);
> 	void	(*event_notify)(struct ufs_hba *hba,
> 				enum ufs_event_type evt, void *data);
>+	void	(*check_int_error)(struct ufs_hba *hba, bool
>*queue_eh_work);
> };
>
> /* clock gating state  */
>--
>2.26.0


