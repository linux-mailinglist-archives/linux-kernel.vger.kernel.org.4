Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466375B6677
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiIMEUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiIMEUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:20:04 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD6D8C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:19:36 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220913041931epoutp0385a097e76cffd6bde1e437779e5c7d59~UUJbd7Lo33083130831epoutp03b
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:19:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220913041931epoutp0385a097e76cffd6bde1e437779e5c7d59~UUJbd7Lo33083130831epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663042771;
        bh=q6UhaAbrAvqjY4jiBf1SsYMS2OYviW61fcualYF1754=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=EdB+xK9ESdAh7ckgQX3G8snl/+ExoPCkzAAoOu3TnuwirJeg45TDnjVhbNWFS0fG5
         zIzex2xRsGB66ym8ldfogRcOoCm7IQ5UmqGOG2Stkn9uXvuql063DQLWwHB4MWnlHj
         yLgIm9wuM7eMlH/1qHY7suvF14GthkpXaInchfjQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220913041930epcas5p39995c0270e74c2fa128840a840bf4739~UUJbBa5DN1940819408epcas5p31;
        Tue, 13 Sep 2022 04:19:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MRVbh1zDtz4x9Py; Tue, 13 Sep
        2022 04:19:28 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.86.54060.0D400236; Tue, 13 Sep 2022 13:19:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220913041927epcas5p102034c1619414864d734c2f53e4c6f66~UUJXylF_l2375523755epcas5p1o;
        Tue, 13 Sep 2022 04:19:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220913041927epsmtrp2116aad6dec2e5b87bc6feb82d58fadff~UUJXxsavV0807708077epsmtrp2O;
        Tue, 13 Sep 2022 04:19:27 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-c6-632004d0d773
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.52.18644.FC400236; Tue, 13 Sep 2022 13:19:27 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220913041925epsmtip2f8fc64bc8633c11878143c4a22ab8d52~UUJWBdmNI2533325333epsmtip2x;
        Tue, 13 Sep 2022 04:19:25 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'SEO HOYOUNG'" <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>, <bhoon95.kim@samsung.com>,
        <kwmad.kim@samsung.com>
In-Reply-To: <20220912140000.95483-1-hy50.seo@samsung.com>
Subject: RE: [PATCH v1] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Date:   Tue, 13 Sep 2022 09:49:24 +0530
Message-ID: <000001d8c728$030bbdb0$09233910$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEcao4nPtwVTObTQc0w1QKI2Ly9EwFvEqAzr0oBWuA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmlu4FFoVkgzfreCz2tp1gt3j58yqb
        xcGHnSwWX5c+Y7WY9uEns8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zE5
        8HhcvuLtcbmvl8ljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMFcERl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaukUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64tO8SY8ExlYoz
        E+ezNzC2yncxcnJICJhI7F/2laWLkYtDSGA3o8SFB3/YIZxPjBLnXk5lhHA+M0q8nvQUKMMB
        1rLpoBREfBejRMOBa2wQzktGiSd9M9hB5rIJ6ErsWNwGlhAROMsksXriWrBuTgEriR8bc0Fq
        hAWiJO4d2coKYrMIqEosvHyBEcTmFbCU2LOhgwnCFpQ4OfMJC4jNLKAtsWzha2aIuxUkfj5d
        BtYrAjRy2677TBA14hIvjx4Be0FC4AiHxJbVPxkhGlwk1k9cww5hC0u8Or4FypaS+PxuLxvE
        Zx4Si/5IQYQzJN4uXw/Vai9x4MocFpASZgFNifW79CFW8Un0/n7CBNHJK9HRJgRRrSrR/O4q
        C4QtLTGxu5sVwvaQ6N97EhpUvYwSPxdPZJnAqDALyZezkHw5C8k3sxA2L2BkWcUomVpQnJue
        WmxaYJyXWg6P7+T83E2M4LSs5b2D8dGDD3qHGJk4GA8xSnAwK4nwbleVTxbiTUmsrEotyo8v
        Ks1JLT7EaAoM+onMUqLJ+cDMkFcSb2hiaWBiZmZmYmlsZqgkzjtFmzFZSCA9sSQ1OzW1ILUI
        po+Jg1OqgenBTg/dfWZ931Mmvop2WZv0fQ/bLesOZo5f/QGJyot1lmfM370l4LHN2vcmy2cW
        PuuMnb3BdtMb03m39bf0GibI+P+w5825s8nxylOP68b8whEpP37NkZ6gE3iWg+9SgL+uXc7H
        7PP2UgFXV/e6Wy3cdPOrqeqqmNvb7jdNrHpm8ogt0ezJ67bbE3ljMiVNGQMP9aa8Dmud86nm
        mHXa1oJTLEERwtIs74t8lmW/0f94OuHk0d/nXG1Fnsc1RQYaxv/Y/fd442LBx8sZrO4r31+S
        9y1JIUDrYaPHlwRR6Wqb+4db25cd+1Nw+dTMHz63WvnmWMk9X/6f6Wm8hLB7eeWNSqm5k5lO
        HFBT+bUt3FmJpTgj0VCLuag4EQC20ry0VAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvO55FoVkg+dPBSz2tp1gt3j58yqb
        xcGHnSwWX5c+Y7WY9uEns8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zE5
        8HhcvuLtcbmvl8ljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMFcERx2aSk5mSWpRbp
        2yVwZSxb9pG1YJFyxaXeZcwNjA9luxg5OCQETCQ2HZTqYuTiEBLYwShx6Nkb9i5GTqC4tMT1
        jROgbGGJlf+es0MUPWeUmPbmBDNIgk1AV2LH4jY2EFtE4DaTxIxzQhBF3YwSX5rnsYFs4BSw
        kvixMRekRlggQuLbtpWsIDaLgKrEwssXGEFsXgFLiT0bOpggbEGJkzOfsIDYzALaEk9vPoWz
        ly18zQxxkILEz6fLWCH2Wkls23WfCaJGXOLl0SPsExiFZiEZNQvJqFlIRs1C0rKAkWUVo2Rq
        QXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwDGpp7WDcs+qD3iFGJg7GQ4wSHMxKIrzbVeWT
        hXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCS5vC25Uzk
        27lplX6tjLO7hEJ/85nDfelscxanBD45UJC8u/4b34GAusPqulMPVZzWtLy15yfT2YT0XJ1P
        m6NsSwVNEvk4T/NoaUzYoGjPpbnyFc8lnhnHSlZ7+fHrLrqsP//edwshvd670+/YTBXaG143
        +fo/qeuCO6JTTH7yXHuW/VhHdtXPhSZ9V5bkyCldMW2y47y/ZeHkvhQWtUlZ26dd0LbZsd15
        mwBrzSt3b/EFXmHNL7PnMx9pTLdyf3qBgaFesfGIdv2niNs3lz3L5JCOuzWLtVfUPeNbpcXW
        z6cOv00KDvX4yBH4heHJaov3JQExGm80TJd4la/8yCUR4vPun8oKQ4lplneeMyuxFGckGmox
        FxUnAgBkuHoiMAMAAA==
X-CMS-MailID: 20220913041927epcas5p102034c1619414864d734c2f53e4c6f66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f
References: <CGME20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f@epcas2p1.samsung.com>
        <20220912140000.95483-1-hy50.seo@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: SEO HOYOUNG =5Bmailto:hy50.seo=40samsung.com=5D
>Sent: Monday, September 12, 2022 7:30 PM
>To: linux-scsi=40vger.kernel.org; linux-kernel=40vger.kernel.org;
>alim.akhtar=40samsung.com; avri.altman=40wdc.com; jejb=40linux.ibm.com;
>martin.petersen=40oracle.com; beanhuo=40micron.com;
>asutoshd=40codeaurora.org; cang=40codeaurora.org; bvanassche=40acm.org;
>bhoon95.kim=40samsung.com; kwmad.kim=40samsung.com
>Cc: SEO HOYOUNG <hy50.seo=40samsung.com>
>Subject: =5BPATCH v1=5D scsi: ufs: add a variant operation in struct
>ufs_hba_variant_ops
>
>Add ufs_hba_variant_ops about vendor error in check_error.
>It need to reset when occurred ah8 related error.
>At that time could not recovery with pwr cmd.
>So add vendor error check function at ufs_hba_variant_ops.
>
I didn't understand why you need this, looks like you are using AH8.
So IS (interrupt status) bit=5B5=5D, bit=5B6=5D , HIBERNATE_EXIT and HIBERN=
ATE_ENTRY should still give you the error status?


>Change-Id: I24c76a372931e702b357c86a5dc36e93ce4b5fda
This is something unwanted

>Signed-off-by: SEO HOYOUNG <hy50.seo=40samsung.com>
>---
> drivers/ufs/core/ufshcd-priv.h =7C  7 +++++++
> drivers/ufs/core/ufshcd.c      =7C  2 ++
> drivers/ufs/host/ufs-exynos.c  =7C 19 +++++++++++++++++++
> include/ufs/ufshcd.h           =7C  1 +
> 4 files changed, 29 insertions(+)
>
>diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv=
.h
>index d00dba17297d..6172da4d3484 100644
>--- a/drivers/ufs/core/ufshcd-priv.h
>+++ b/drivers/ufs/core/ufshcd-priv.h
>=40=40 -221,6 +221,13 =40=40 static inline void
>ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
> 		hba->vops->config_scaling_param(hba, p, data);  =7D
>
>+static inline void ufshcd_vops_check_int_error(struct ufs_hba *hba,
>+					       bool *queue_eh_work)
>+=7B
>+	if (hba->vops & hba->vops->check_int_error)
>+		hba->vops->check_int_error(hba, queue_eh_work); =7D
>+
> extern const struct ufs_pm_lvl_states ufs_pm_lvl_states=5B=5D;
>
> /**
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
>7c15cbc737b4..39ee5192f26a 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>=40=40 -6542,6 +6542,8 =40=40 static irqreturn_t ufshcd_check_errors(struc=
t
>ufs_hba *hba, u32 intr_status)
> 		queue_eh_work =3D true;
> 	=7D
>
>+	ufshcd_vops_check_int_error(hba, &queue_eh_work);
>+
> 	if (queue_eh_work) =7B
> 		/*
> 		 * update the transfer error masks to sticky bits, let's do this
>diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
>index eced97538082..b351b8e48b08 100644
>--- a/drivers/ufs/host/ufs-exynos.c
>+++ b/drivers/ufs/host/ufs-exynos.c
>=40=40 -67,6 +67,10 =40=40
> =23define CLK_CTRL_EN_MASK	(REFCLK_CTRL_EN =7C=5C
> 				 UNIPRO_PCLK_CTRL_EN =7C=5C
> 				 UNIPRO_MCLK_CTRL_EN)
>+
>+=23define HCI_AH8_STATE		0x50C
>+=23define HCI_AH8_STATE_ERROR	BIT(16)
>+
> /* Device fatal error */
> =23define DFES_ERR_EN		BIT(31)
> =23define DFES_DEF_L2_ERRS	(UIC_DATA_LINK_LAYER_ERROR_RX_BUF_OF
>=7C=5C
>=40=40 -1376,6 +1380,20 =40=40 static void exynos_ufs_hibern8_notify(struc=
t
>ufs_hba *hba,
> 	=7D
> =7D
>
>+static void exynos_ufs_check_int_error(struct ufs_hba *hba, bool
>+*queue_eh_work) =7B
>+	struct exynos_ufs *ufs =3D ufshcd_get_variant(hba);
>+
>+	if (ufshcd_is_auto_hibern8_supported(hba)) =7B
>+		val =3D hci_readl(ufs, HCI_AH8_STATE);
>+
>+		if (val & HCI_AH8_STATE_ERROR) =7B
>+			 ufshcd_set_link_broken(hba);
>+			 queue_eh_work =3D true;
>+		=7D
>+	=7D
>+=7D
>+
> static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op
>pm_op,
> 	enum ufs_notify_change_status status)
> =7B
>=40=40 -1569,6 +1587,7 =40=40 static const struct ufs_hba_variant_ops
>ufs_hba_exynos_ops =3D =7B
> 	.setup_xfer_req			=3D
>exynos_ufs_specify_nexus_t_xfer_req,
> 	.setup_task_mgmt		=3D
>exynos_ufs_specify_nexus_t_tm_req,
> 	.hibern8_notify			=3D exynos_ufs_hibern8_notify,
>+	.check_int_error		=3D exynos_ufs_check_int_error,
> 	.suspend			=3D exynos_ufs_suspend,
> 	.resume				=3D exynos_ufs_resume,
> =7D;
>diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h index
>24c97e0772bb..40078c4b9f55 100644
>--- a/include/ufs/ufshcd.h
>+++ b/include/ufs/ufshcd.h
>=40=40 -335,6 +335,7 =40=40 struct ufs_hba_variant_ops =7B
> 			       const union ufs_crypto_cfg_entry *cfg, int slot);
> 	void	(*event_notify)(struct ufs_hba *hba,
> 				enum ufs_event_type evt, void *data);
>+	void	(*check_int_error)(struct ufs_hba *hba, bool
>*queue_eh_work);
> =7D;
>
> /* clock gating state  */
>--
>2.26.0


