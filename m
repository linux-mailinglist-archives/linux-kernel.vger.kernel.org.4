Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B069D643D84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiLFHRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiLFHRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:17:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FF915702
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:16:58 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jn7so13084421plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 23:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JTSI5HR3WnDKTZRPXK83rcPbsVP3u6ffhCyIodP1cOE=;
        b=U7IwrxKy55O+MBd8SJHKPNWSuF4KNbjNhF1YooLxi2VEdgVHSw3ovfcvB/YwZ3HX3w
         3HwNyR7QI99qbW6UOXX3dJbELbIXCEu1PN1OyuEnXvWU95ydPQ7qc/YjlIIAXCDgAOY2
         zNNJ2/9FkyNktHGqVn2A6no+H4pIr0Qvk0mqpi8huWC7HAgtxNoKiZKsrCsyXTlI2YRI
         yUkpDoiLVYo5/1otKAU3tswHNyA4pWMcXLGcLu+LYIkxkYzcc6SJ2CCBVUnMYLUN0EaZ
         LtKTTDFbLcF9ipHxbr70nzAxju3ObgBvBO1SlDKMCjlodv5iaCs34E2AavZ10uu6360t
         ZsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTSI5HR3WnDKTZRPXK83rcPbsVP3u6ffhCyIodP1cOE=;
        b=D2O7HMnBKVkTv6TOmtrnTA8enxr8PVLA3VeEfjpkBIQXS8feuifBsHVD3KZrFwDC3L
         mD4/v+icgFgabrLsN1p7zyOajcT08VOa4g5Uqzy8oPyCmUB/KX5gmvmk3V1sDQcipddv
         EZ1Twq3299AnhTy6/A90Gv/0Wq++Riep8DEqsn677zIlIGL51vR6rk5y9nSQl5/Uq0JW
         yH8aB0RD6C0vKvT71QNvu6mo9/DYdmg1Q67ZWjVc+9jLN9aZjw16/7+MixafNz/zTKKh
         7hx+mPgbFpNzq9iGw6nGQvVQvy3A/tRuaCno8fQbpEyqLnauDDFCExHEVhLLD1Jed2Lw
         1CZQ==
X-Gm-Message-State: ANoB5pkMdC2vyaSkkaZBZY25lN+zxgirNHbfncJ7S3Zbt1mjnwp8F1hg
        TY9LYqsUL5qHXwve+hJRy4h2
X-Google-Smtp-Source: AA0mqf7jSwpa+9rghz3/A9hAT95/JbAfuSu06LB1bPty8KOCs3MVv+9OSXhjs04A6Quh0Scp4qu6xg==
X-Received: by 2002:a17:90a:394d:b0:219:c8f9:b286 with SMTP id n13-20020a17090a394d00b00219c8f9b286mr10576513pjf.5.1670311017514;
        Mon, 05 Dec 2022 23:16:57 -0800 (PST)
Received: from thinkpad ([117.207.29.147])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b0016d72804664sm11671719plr.205.2022.12.05.23.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 23:16:56 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:46:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v4 09/23] phy: qcom-qmp-ufs: Avoid setting HS G3 specific
 registers
Message-ID: <20221206071650.GB15486@thinkpad>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
 <20221201174328.870152-10-manivannan.sadhasivam@linaro.org>
 <29FC6095-645C-46B1-BFD1-0CB9F05214FD@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29FC6095-645C-46B1-BFD1-0CB9F05214FD@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:55:06AM +0300, Dmitry Baryshkov wrote:
> 
> 
> On 1 December 2022 20:43:14 GMT+03:00, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >SM8350 default init sequence sets some PCS registers to HS G3, thereby
> >disabling HS G4 mode. This has the effect on MPHY capability negotiation
> >between the host and the device during link startup and causes the
> >PA_MAXHSGEAR to G3 irrespective of device max gear.
> >
> >Due to that, the agreed gear speed determined by the UFS core will become
> >G3 only and the platform won't run at G4.
> >
> >So, let's remove setting these registers for SM8350 as like other G4
> >compatible platforms. One downside of this is that, when the board design
> >uses non-G4 compatible device, then MPHY will continue to run in the
> 
> QMP PHY?
> 

No. MPHY is the actual IP that does the negotiation.

> >default mode (G4) even if UFSHCD runs in G3. But this is the case for
> >other platforms as well.
> 
> Should this be fixed by adding a separate set of tables used to setup g3?
> 

The default table is G3 only but the issue here is that, with these register
writes, the UFS device PA_MAXHSGEAR register becomes G3 only during MPHY
negotiation. So the host cannot scale up to G4 even if the UFSHCD supports it.

Thanks,
Mani

> 
> >
> >Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >---
> > drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 7 -------
> > 1 file changed, 7 deletions(-)
> >
> >diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >index d5324c4e8513..6c7c6a06fe3b 100644
> >--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >@@ -567,13 +567,6 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs[] = {
> > 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> > 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_DEBUG_BUS_CLKSEL, 0x1f),
> > 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xff),
> >-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_PLL_CNTL, 0x03),
> >-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB, 0x16),
> >-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB, 0xd8),
> >-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_PWM_GEAR_BAND, 0xaa),
> >-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_HS_GEAR_BAND, 0x06),
> >-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x03),
> >-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x03),
> > 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_SIGDET_CTRL1, 0x0e),
> > 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> > };
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
