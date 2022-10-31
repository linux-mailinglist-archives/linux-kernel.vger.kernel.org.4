Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333E613A40
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiJaPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiJaPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:39:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F31015
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:39:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5so3141776pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDJlQVCguNnJGzrf7cy1BrTUPSikkGc5f2fzu23Hw8E=;
        b=WRBu6OGXkoxGY9UDJlisGfoLlWfiXqVHG1Cnz3WRejo/gU3au2sQfiQ2tkakym9Xvo
         iH0CoovbBegwAiep1sHg4TttXjjq/HrCIkyI5/TCaJ/H1IvYg1JbIrhO+s7yVMVLua/z
         PpUHd3lFUJZDfkqQOe5GQoNE02nWPKbltKJPZ5xwKdhWQ6o3Cr0QxictvbOI80ElcM0p
         HiVEDIlcAC13c7U2uQ2TLdQKZNhDaf3ENAUc+8Q1XXgGxebLZa30nags0BnoeAp4nlFu
         WESqHLfEHr+Q/91YoMfMixV2mv12PzOybQqyz88iiau13lhaZ2on32Go4ucT9oqwOR2V
         5HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDJlQVCguNnJGzrf7cy1BrTUPSikkGc5f2fzu23Hw8E=;
        b=t2BB1nTBo+rA3EYBg5/72ORgtplABZyxn0+OjZAjlug0cBWFHazLVxyMpa0BFbatHH
         0wAB/1NflrzejHqdTQ0cjkfxBDIh6mkAJxaJDJW+l/ycrLhL0lYnNVgNdIGQ/fGtNqsJ
         4LBP5JKZE189vCKbIU7aT0pAM8yjwZ4K7P7rZBoL5seLVvpnsiQe3j9dvWcu2FpUDfvK
         zU31FU3Fr0wpajhkTiVTivY9w5jd/SzQHCO/JqPh+kagclJY06X4KAxUuOV3llxsBkJf
         ytV0OJ3gP4DxLWlti0IwWaSp48kUdyttZ3jjjOu0v/ifiPRjwQvwCmB/cTbQBjGp/ucS
         Kj3g==
X-Gm-Message-State: ACrzQf0gaCsNSt2e4rHmF6Z51WBdz/4SP3x939jU/BEBR1JlcfaPw3Wh
        BU03cRwIaNswzpSFyGv6+VPz
X-Google-Smtp-Source: AMsMyM6vZZ75FfRX28onYwNDU8BBGjMy3OIm0+QuUmPhw/ZrPNPrK/WEn/ojZGHcsog6PjRh9KLgjQ==
X-Received: by 2002:a17:90a:6b0d:b0:213:b85a:3bd4 with SMTP id v13-20020a17090a6b0d00b00213b85a3bd4mr12287233pjj.169.1667230768366;
        Mon, 31 Oct 2022 08:39:28 -0700 (PDT)
Received: from thinkpad ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b0017f49b41c12sm4628832plh.173.2022.10.31.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:39:27 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:09:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 14/15] scsi: ufs: ufs-qcom: Add support for finding HS
 gear on new UFS versions
Message-ID: <20221031153919.GA12738@thinkpad>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-15-manivannan.sadhasivam@linaro.org>
 <cf8dcf53-f131-68f4-c6aa-d41e02ac6d5c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf8dcf53-f131-68f4-c6aa-d41e02ac6d5c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 12:48:21AM +0300, Dmitry Baryshkov wrote:
> On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> > Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
> > controller/PHY can be configured to run in two gear speeds). But that
> > requires an agreement between the UFS controller and the UFS device.
> > This commit finds the max gear supported by both controller and device
> > then decides which one to use.
> > 
> > UFS controller's max gear can be read from the REG_UFS_PARAM0 register and
> > UFS device's max gear can be read from the "max-gear" devicetree property.
> > 
> > The UFS PHY also needs to be configured with the decided gear using the
> > phy_set_mode_ext() API.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++++++---
> >   drivers/ufs/host/ufs-qcom.h |  4 ++++
> >   2 files changed, 36 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index f952cc76919f..268463e92d67 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -281,6 +281,9 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
> >   static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
> >   {
> >   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > +	struct device *dev = hba->dev;
> > +	u32 max_gear, hcd_max_gear, reg;
> > +	int ret;
> >   	if (host->hw_ver.major == 0x1) {
> >   		/*
> > @@ -292,8 +295,33 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
> >   		 */
> >   		if (hs_gear > UFS_HS_G2)
> >   			return UFS_HS_G2;
> > +	} else if (host->hw_ver.major > 0x3) {
> > +		/*
> > +		 * Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
> > +		 * controller/PHY can be configured to run in two gear speeds). But that
> > +		 * requires an agreement between the UFS controller and the device. Below
> > +		 * code tries to find the max gear of both and decides which gear to use.
> > +		 *
> > +		 * First get the max gear supported by the UFS device if available.
> > +		 * If the property is not defined in devicetree, then use the default gear.
> > +		 */
> > +		ret = of_property_read_u32(dev->of_node, "max-gear", &max_gear);
> > +		if (ret)
> > +			goto err_out;
> 
> Can we detect the UFS device's max gear somehow? If not, the 'max-gear'
> property name doesn't sound good. Maybe calling it 'device-gear' would be
> better.
> 
> > +
> > +		/* Next get the max gear supported by the UFS controller */
> > +		reg = ufshcd_readl(hba, REG_UFS_PARAM0);
> > +		hcd_max_gear = UFS_QCOM_MAX_GEAR(reg);
> > +
> > +		/*
> > +		 * Now compare both the gears. If the max gear supported by the UFS device
> > +		 * is compatible with UFS controller, then use the UFS device's max gear
> > +		 * speed. Otherwise, use the UFS controller supported max gear speed.
> > +		 */
> > +		return (max_gear <= hcd_max_gear) ? max_gear : hcd_max_gear;
> 
> return max(max_gear, hcd_max_gear); ?
> 

min() should work...

Thanks,
Mani

> >   	}
> > +err_out:
> >   	/* Default is HS-G3 */
> >   	return UFS_HS_G3;
> >   }
> > @@ -303,7 +331,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> >   	struct phy *phy = host->generic_phy;
> >   	int ret;
> > -	bool is_rate_B = UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B;
> > +	u32 hs_gear;
> >   	/* Reset UFS Host Controller and PHY */
> >   	ret = ufs_qcom_host_reset(hba);
> > @@ -311,8 +339,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >   		dev_warn(hba->dev, "%s: host reset returned %d\n",
> >   				  __func__, ret);
> > -	if (is_rate_B)
> > -		phy_set_mode(phy, PHY_MODE_UFS_HS_B);
> > +	/* UFS_HS_G2 is used here since that's the least gear supported by legacy Qcom platforms */
> > +	hs_gear = ufs_qcom_get_hs_gear(hba, UFS_HS_G2);
> > +	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, hs_gear);
> >   	/* phy initialization - calibrate the phy */
> >   	ret = phy_init(phy);
> > diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> > index 214ea50acab9..c93bc52ea848 100644
> > --- a/drivers/ufs/host/ufs-qcom.h
> > +++ b/drivers/ufs/host/ufs-qcom.h
> > @@ -89,6 +89,10 @@ enum {
> >   #define TMRLUT_HW_CGC_EN	BIT(6)
> >   #define OCSC_HW_CGC_EN		BIT(7)
> > +/* bit definitions for REG_UFS_PARAM0 */
> > +#define MAX_HS_GEAR_MASK	GENMASK(6, 4)
> > +#define UFS_QCOM_MAX_GEAR(x)	FIELD_GET(MAX_HS_GEAR_MASK, (x))
> > +
> >   /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
> >   #define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
