Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66955634155
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiKVQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiKVQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:21:15 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38B2BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:21:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b11so13666990pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T82+qptXBJG7eHFalgFxGvJty6XiRIjJgNv/yNtgHQU=;
        b=CGayHwcXg4RlZZiXO3+tUzsOCvK8+vITVedxsiYG01Ss5kJwmGUgFPk6owHSTWmQ3W
         wQHRC3wrfFBRZWEZCf4pFcqI/wGhEGE+cPVCJrqlub2MCcRMFBfJPaANDUjtyVE3Aq8m
         GcKQxnU7LBJ3O+7SNmIb4f+N2iYtUnI2yTmc253T7s8GhKrujsacLHFDO8Q5T4D8u4+4
         BY15dWh/csAxaVDAOpNT80j6yNiGvrffn1tPO5i5P5CPDTrD/wBsnPBweHeKiUOV0BvU
         nkPn4R701VMBsuQc0Gc1vwVwlIG7eZrcQtz8BJYndEqEKKdSKIs/9D+rkHOJLfLujfvQ
         FtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T82+qptXBJG7eHFalgFxGvJty6XiRIjJgNv/yNtgHQU=;
        b=zkOA6eIXhESZnKjLHCR2NuiAt/W7AhG3v/oypv4SDfZfoTNn5QoegArXH617KgCMmg
         F5gmkl9Ya1DvEjqE/WCqSp4aUfoSYvl1M+e5Gp3K+XHXdfViQWaWgt6rMWE98epKOqFe
         +9ocrEOcHi02tQo9EJfq5MNv7MGxrueyz4niq9VlKAT8RaWJZZaacJu1U8kGaFNLHmBm
         u4c5O44S1xrGa66DRf9GeXfddS/I/t66/2CghifIBamZSaFfQwUvEbIJbvhPPaiKkFoq
         jGOb2zYerF6OUvbStFGAAukA/40b2qTZyQ7RCTmdPUAlxzfUnA2NRTE0PRyLkXU8J6vY
         6vCQ==
X-Gm-Message-State: ANoB5pks4eJ2eztklOjmi1SO367kBcEd1N0WtcfCsD8keoTZ2Rr09All
        7ziU24CCOqkdx4hz/FS5GjF3
X-Google-Smtp-Source: AA0mqf6l92+V2KEY1154uP2hV83L/YjK1ubsJ6Y9kmK7IiIOfO9aiOuPLeSZeThlmngtXhyCVoG+lQ==
X-Received: by 2002:a17:90a:2b47:b0:218:9671:3b85 with SMTP id y7-20020a17090a2b4700b0021896713b85mr17801148pjc.4.1669134072427;
        Tue, 22 Nov 2022 08:21:12 -0800 (PST)
Received: from thinkpad ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id mn23-20020a17090b189700b002187a4dd830sm9522876pjb.46.2022.11.22.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:21:11 -0800 (PST)
Date:   Tue, 22 Nov 2022 21:51:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com
Subject: Re: [PATCH v2 02/15] phy: qcom-qmp-ufs: Add support for configuring
 PHY in HS Series B mode
Message-ID: <20221122162103.GF157542@thinkpad>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-3-manivannan.sadhasivam@linaro.org>
 <Y23zO68Bb5R0xLq/@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y23zO68Bb5R0xLq/@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:31:15PM +0530, Vinod Koul wrote:
> On 31-10-22, 23:32, Manivannan Sadhasivam wrote:
> > Add separate tables_hs_b instance to allow the PHY driver to configure the
> > PHY in HS Series B mode. The individual SoC configs need to supply the
> > serdes register setting in tables_hs_b and the UFS driver can request the
> > Series B mode by calling phy_set_mode() with mode set to PHY_MODE_UFS_HS_B.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > index cdfda4e6d575..4c6a2b5afc9a 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > @@ -20,6 +20,8 @@
> >  #include <linux/reset.h>
> >  #include <linux/slab.h>
> >  
> > +#include <ufs/unipro.h>
> > +
> >  #include <dt-bindings/phy/phy.h>
> >  
> >  #include "phy-qcom-qmp.h"
> > @@ -549,6 +551,8 @@ struct qmp_phy_cfg {
> >  
> >  	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
> >  	const struct qmp_phy_cfg_tables tables;
> > +	/* Additional sequence for HS Series B */
> > +	const struct qmp_phy_cfg_tables tables_hs_b;
> 
> what am i missing, where was tables_hs_b added?
> 

This patch adds the infrastructure for HS_B mode. The actual table is added in
patch 5/15.

Thanks,
Mani

> >  
> >  	/* clock ids to be requested */
> >  	const char * const *clk_list;
> > @@ -582,6 +586,7 @@ struct qmp_phy_cfg {
> >   * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
> >   * @pcs_misc: iomapped memory space for lane's pcs_misc
> >   * @qmp: QMP phy to which this lane belongs
> > + * @mode: PHY mode configured by the UFS driver
> >   */
> >  struct qmp_phy {
> >  	struct phy *phy;
> > @@ -594,6 +599,7 @@ struct qmp_phy {
> >  	void __iomem *rx2;
> >  	void __iomem *pcs_misc;
> >  	struct qcom_qmp *qmp;
> > +	u32 mode;
> >  };
> >  
> >  /**
> > @@ -983,6 +989,8 @@ static int qmp_ufs_power_on(struct phy *phy)
> >  	int ret;
> >  
> >  	qmp_ufs_serdes_init(qphy, &cfg->tables);
> > +	if (qphy->mode == PHY_MODE_UFS_HS_B)
> > +		qmp_ufs_serdes_init(qphy, &cfg->tables_hs_b);
> >  
> >  	qmp_ufs_lanes_init(qphy, &cfg->tables);
> >  
> > @@ -1070,6 +1078,15 @@ static int qmp_ufs_disable(struct phy *phy)
> >  	return qmp_ufs_exit(phy);
> >  }
> >  
> > +static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> > +{
> > +	struct qmp_phy *qphy = phy_get_drvdata(phy);
> > +
> > +	qphy->mode = mode;
> > +
> > +	return 0;
> > +}
> > +
> >  static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
> >  {
> >  	struct qcom_qmp *qmp = dev_get_drvdata(dev);
> > @@ -1105,6 +1122,7 @@ static int qmp_ufs_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
> >  static const struct phy_ops qcom_qmp_ufs_ops = {
> >  	.power_on	= qmp_ufs_enable,
> >  	.power_off	= qmp_ufs_disable,
> > +	.set_mode	= qmp_ufs_set_mode,
> >  	.owner		= THIS_MODULE,
> >  };
> >  
> > -- 
> > 2.25.1
> 
> -- 
> ~Vinod

-- 
மணிவண்ணன் சதாசிவம்
