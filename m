Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96568D035
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBGHLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjBGHLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:11:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D051423C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:11:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so12552144wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS0V+GLlaD2KUKWgU7WfhuI+UXfHxHE5nFGEqvgoxzY=;
        b=KDG8DY2Z+0qWLkniGX8jdRJcYQ4jrZLIdgu6z5KFhaDyVVS+un3nIKhRVjkwt8sXE1
         4YvoBlmjNv/tjFXKfJrA55qERO0Werbaybh9iv1rhaaDmnWcJ8zDxNSTylFlNQ34Dz5q
         LYHDt4pDa+EetASYqbdQE0iShp7LIDpITQ/onsyR2Nh2oaUcBZKbjNc9a0fQueNi4UF7
         5VhLe+13xufFfUNG7rsLdL/fmXLIeQIh9eZKM107+8QO+NcAH2P6UwWOpMAWyiDRjPb8
         DZMLmdXtXisjFRARgnvOxb9Xzzq0U8j4Jk7NXoLUxA6ytmM0oO4hY/WMsj0gX5FOo9K9
         68AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS0V+GLlaD2KUKWgU7WfhuI+UXfHxHE5nFGEqvgoxzY=;
        b=JoqNMlC8itbbHVIR1iDVeyP+IVOF4hkEGNCjXeCPTCCbvC+zEbcxRF9PGMY7Fn231/
         M3Q53l622M8okHbdpsd/3YCzJILXiF52tgs0kmbh29PBP7hiiKJKk266hsiGIKOcdY0R
         bCPm3mJz9D8cFuXXEI4vDT9ChP58FYJBb1Ig/TOdtRtcS6zPV1ONNOQvyD48jFFiLKDf
         x9C+BQ/5Y5lUr9wdfn6ECvDHz5hJZ70CkL8yJCQxKauBBM2FQ+B2x0sCoMoTth8hK4te
         8yf7pg5/uYN2DgAdushIog6f8Sq9xlIwgfBdIqESyuaFoLufAZeTfB14ZNkaWkZyuTQP
         O8xA==
X-Gm-Message-State: AO0yUKXGzYaFl0LZ5Sa50veTWx2jtvOw/6BYw4LcTp47PxsIqoUzXklk
        PkwV2ifk2V09wI9LQaW5ErEXtYEpjM0kxlgJ
X-Google-Smtp-Source: AK7set/+DJI2TrZhXfy4vttaEra/sZ7v5Prc0mU2ulprWaz5rtIS9fkzlWRBcRotXQsQA5THKFnzzQ==
X-Received: by 2002:a05:6000:1081:b0:2bf:d333:219d with SMTP id y1-20020a056000108100b002bfd333219dmr1862710wrw.17.1675753865767;
        Mon, 06 Feb 2023 23:11:05 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d13-20020adffbcd000000b002c3f6cd1f0fsm471504wrs.83.2023.02.06.23.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 23:11:05 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:11:03 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v3 5/7] phy: qcom: phy-qcom-snps-eusb2: Add support for
 eUSB2 repeater
Message-ID: <Y+H5hxaOeGTP+wrt@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
 <20230202133816.4026990-6-abel.vesa@linaro.org>
 <Y90Q4rDYw9kcXmCQ@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90Q4rDYw9kcXmCQ@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-03 19:19:22, Vinod Koul wrote:
> On 02-02-23, 15:38, Abel Vesa wrote:
> > From: Neil Armstrong <neil.armstrong@linaro.org>
> > 
> > For USB 2.0 compliance, eUSB2 needs a repeater. The PHY needs to
> > initialize and reset it. So add repeater support
> > 
> > Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > index 23ec162cc3bd..8d972d49732b 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > @@ -128,6 +128,8 @@ struct qcom_snps_eusb2_hsphy {
> >  	struct regulator_bulk_data vregs[EUSB2_NUM_VREGS];
> >  
> >  	enum phy_mode mode;
> > +
> > +	struct phy *repeater;
> >  };
> >  
> >  static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int submode)
> > @@ -136,7 +138,7 @@ static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int
> >  
> >  	phy->mode = mode;
> >  
> > -	return 0;
> > +	return phy_set_mode_ext(phy->repeater, mode, submode);
> >  }
> >  
> >  static void qcom_snps_eusb2_hsphy_write_mask(void __iomem *base, u32 offset,
> > @@ -235,6 +237,12 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = phy_init(phy->repeater);
> > +	if (ret) {
> > +		dev_err(&p->dev, "repeater init failed. %d\n", ret);
> > +		goto disable_vreg;
> > +	}
> > +
> >  	ret = clk_prepare_enable(phy->ref_clk);
> >  	if (ret) {
> >  		dev_err(&p->dev, "failed to enable ref clock, %d\n", ret);
> > @@ -342,6 +350,8 @@ static int qcom_snps_eusb2_hsphy_exit(struct phy *p)
> >  
> >  	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
> >  
> > +	phy_exit(phy->repeater);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -386,6 +396,12 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return dev_err_probe(dev, ret,
> >  				     "failed to get regulator supplies\n");
> > +
> > +	phy->repeater = devm_phy_get(dev, "eusb2-repeater");
> > +	if (IS_ERR(phy->repeater))
> > +		return dev_err_probe(dev, PTR_ERR(phy->repeater),
> > +				     "failed to get repeater\n");
> 
> That implies repeater is assumed to be there for all designs, how about
> older devices, they may not have a repeater?

Well, no other (older) platform has eUSB2 support, IIRC.

And the eUSB2 can't be used as USB 2.0 without the repeater.

> 
> > +
> >  	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_eusb2_hsphy_ops);
> >  	if (IS_ERR(generic_phy)) {
> >  		dev_err(dev, "failed to create phy %d\n", ret);
> > -- 
> > 2.34.1
> 
> -- 
> ~Vinod
