Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E122272B123
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjFKJVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFKJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:20:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5F173B;
        Sun, 11 Jun 2023 02:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686475255; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C0qjHhlylhb7WQO68W5yOLY7+82DBv5Sjwn4Vavvik/XYiCZ97ypMAADj9qXIHkhyT
    GnA4FFmJ+ik4RQdv2X0EIbeZe7d9x0IE3nKazwd9bJkskl38edBkdojJlvinJfNet6aQ
    GZXpA/aNml7SO3BcIc1Q+yGJd/avLSmUX7jGYW8De+ZRMmY9kzq/7VqattoQs1RAF7Yj
    37z6yk4z45Ul2I5BQ6miSAKIMBQjaLu7xjlAdldxN6S3p3CQBbjD68NTzpelh+nmb/d3
    CFGuYQaeTJ8ELqudKVJ3dfAgs+O/4zp+lNJPbwgNEfX/Cdf0GMK7EZ+060RsQtEoJrKg
    E8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686475255;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4mKf/VEq1qjA8SMzrQnOE6vF0s+OB1YlRbk6YIxSLLQ=;
    b=Beij99zB5E9+WBKKorN15ItB/v7NawJsCtbLzlqnLW7JmQEM8Vj80qNgYdrSFMQkYH
    /KHk1sGLYvJLd67VVSnNSknOOuKZlnGNII4jgzePFjYKbgrIq6EL1bbNrxFsnh/J26vr
    9SdYk9i/SqtiWHl5VTCVJeOUXcZ0yf6uQz9CEvfI1byV53GfjEgALFb3a14BYVzHgc98
    CXv8Y/NQ34edcHHNX2Epb07+x2Sl5u+BM4vPxA2ovtWQWSoOjTrWRUT5yZIOadaBrdRn
    ZSanott41S7OnFdJI7bcUtWuzeTNUy5Td76Q4ruZQ5BQYkejinFUIKyKgYFKLnWVVPTI
    kYQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686475255;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4mKf/VEq1qjA8SMzrQnOE6vF0s+OB1YlRbk6YIxSLLQ=;
    b=Wk0kbmzzRwixKmmR4KIGEF8TQq+I3H69ahtCkWHKwe4vw/QSktH296ZwHxrD8bj+PW
    F3RAmOwdjA2zhLbnitB/UPBK+7dkLCLTLPg/vXYMMxJ9k9isOsk/iUSzx2A/xaSi0HBz
    KPdiWQF5XYYzqzGvDLU4+xnVyIHCW/7EElaE7sagEJSFE/LHO7GouPLiRud+PhD9or2g
    KYUnZ1aygRzTaYjRxFWp2NqlBKplvRJuFAdi0b5RO40LAChPu+2KF6wVshp09MuzTYb1
    ZxfOIQ7bMG84ZpQLqWOoj1fvNRPwHA09MMbVeXTZzU1RzckcYPCu2pIboYZ+RDmfjs3t
    1Tfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686475255;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4mKf/VEq1qjA8SMzrQnOE6vF0s+OB1YlRbk6YIxSLLQ=;
    b=3I8q3VrNYCz6HcVzGPjLYnkkQeIPufFtnDFXDGB+/rc+7bfYUXhUl0NJJLGgn6ktwA
    F3RnzSaExvDUD2NXvGCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5B9KsRJ3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 11 Jun 2023 11:20:54 +0200 (CEST)
Date:   Sun, 11 Jun 2023 11:20:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/22] clk: qcom: smd-rpm: Export clock scaling
 availability
Message-ID: <ZIWR7uVHJ-eJWhHw@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-4-e5934b07d813@linaro.org>
 <ZIRgGXwKD6mcgTRY@gerhold.net>
 <40f937bb-0d7e-a237-1672-5905983622ce@linaro.org>
 <b7b1d19c-b87d-b3fd-36aa-374065a45ede@linaro.org>
 <ZITOR3Y25Bv4msdm@gerhold.net>
 <c52f0311-a8a0-79af-2a08-51a8564a8b25@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c52f0311-a8a0-79af-2a08-51a8564a8b25@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 09:39:00PM +0200, Konrad Dybcio wrote:
> On 10.06.2023 21:25, Stephan Gerhold wrote:
> > On Sat, Jun 10, 2023 at 08:53:05PM +0200, Konrad Dybcio wrote:
> >> On 10.06.2023 14:15, Konrad Dybcio wrote:
> >>> On 10.06.2023 13:35, Stephan Gerhold wrote:
> >>>> On Fri, Jun 09, 2023 at 10:19:09PM +0200, Konrad Dybcio wrote:
> >>>>> Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
> >>>>> clock rate requests will not be commited in hardware. This poses a
> >>>>> race threat since we're accessing the bus clocks directly from within
> >>>>> the interconnect framework.
> >>>>>
> >>>>> Add a marker to indicate that we're good to go with sending new requests
> >>>>> and export it so that it can be referenced from icc.
> >>>>>
> >>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>> ---
> >>>>>  drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
> >>>>>  include/linux/soc/qcom/smd-rpm.h | 2 ++
> >>>>>  2 files changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> >>>>> index 937cb1515968..482fe30ee6f0 100644
> >>>>> --- a/drivers/clk/qcom/clk-smd-rpm.c
> >>>>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> >>>>> @@ -151,6 +151,7 @@
> >>>>>  #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
> >>>>>  
> >>>>>  static struct qcom_smd_rpm *rpmcc_smd_rpm;
> >>>>> +static bool smd_rpm_clk_scaling;
> >>>>>  
> >>>>>  struct clk_smd_rpm {
> >>>>>  	const int rpm_res_type;
> >>>>> @@ -385,6 +386,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
> >>>>>  	return r->rate;
> >>>>>  }
> >>>>>  
> >>>>> +bool qcom_smd_rpm_scaling_available(void)
> >>>>> +{
> >>>>> +	return smd_rpm_clk_scaling;
> >>>>> +}
> >>>>> +EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
> >>>>> +
> >>>>>  static int clk_smd_rpm_enable_scaling(void)
> >>>>>  {
> >>>>>  	int ret;
> >>>>> @@ -410,6 +417,8 @@ static int clk_smd_rpm_enable_scaling(void)
> >>>>>  		return ret;
> >>>>>  	}
> >>>>>  
> >>>>> +	smd_rpm_clk_scaling = true;
> >>>>> +
> >>>>
> >>>> If you move the platform_device_register_data(&rpdev->dev,
> >>>> "icc_smd_rpm", ...) from drivers/soc/qcom/smd-rpm.c to here you can
> >>>> avoid the race completely and drop this API. I think that would be
> >>>> cleaner. And it will likely probe much faster because probe deferral
> >>>> is slow. :)
> >>> Sounds like an idea.. especially since it's pretty much the only
> >>> dependency other than SMDRPM itself!
> >> It sounds great, but to not break bisecting one has to:
> >>
> >> 1. change the registration in soc/smd-rpm to store rpm ptr in driver
> >>    data, in addition to parent driver data
> >>
> >> 2. change icc/smd-rpm to use the device and not parent data
> >>
> >> 3. add a platform_device_register_data call in clk-smd-rpm that will
> >>    always fail because the device is always registered
> >>
> >> 4. remove the registration from soc/smd-rpm
> >>
> > 
> > Logically the icc_smd_rpm device still fits better as child of
> > smd-rpm and not clk-smd-rpm. So I would probably just continue
> > registering it on the parent device from clk-smd-rpm.
> > Then there are no changes necessary in icc_smd_rpm.
> > 
> > You could use this. Both touched files are Bjorn-maintained so should be
> > manageable to have it in one commit. (note: compile-tested only)
> > 
> > Thanks,
> > Stephan
> > 
> > From a2610adb2551b01e76b9de8e4cbcc89853814a8f Mon Sep 17 00:00:00 2001
> > From: Stephan Gerhold <stephan@gerhold.net>
> > Date: Sat, 10 Jun 2023 21:19:48 +0200
> > Subject: [PATCH] soc: qcom: smd-rpm: Move icc_smd_rpm registration to
> >  clk-smd-rpm
> > 
> > icc_smd_rpm will do bus clock votes itself rather than taking the
> > unnecessary detour through the clock subsystem. However, it can only
> > do that after the clocks have been handed off and scaling has been
> > enabled in the RPM in clk-smd-rpm.
> > 
> > Move the icc_smd_rpm registration from smd-rpm.c to clk-smd-rpm.c
> > to avoid any possible races. icc_smd_rpm gets the driver data from
> > the smd-rpm device, so still register the platform device on the
> > smd-rpm parent device.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> Generally it looks good.. I'll give it a spin next week. One
> thing below.
> 
> >  drivers/clk/qcom/clk-smd-rpm.c | 21 +++++++++++++++++++++
> >  drivers/soc/qcom/smd-rpm.c     | 23 +----------------------
> >  2 files changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> > index e4de74b68797..91adb16889b3 100644
> > --- a/drivers/clk/qcom/clk-smd-rpm.c
> > +++ b/drivers/clk/qcom/clk-smd-rpm.c
> > @@ -1302,12 +1302,20 @@ static struct clk_hw *qcom_smdrpm_clk_hw_get(struct of_phandle_args *clkspec,
> >  	return desc->clks[idx] ? &desc->clks[idx]->hw : ERR_PTR(-ENOENT);
> >  }
> >  
> > +static void rpm_smd_unregister_icc(void *data)
> > +{
> > +	struct platform_device *icc_pdev = data;
> > +
> > +	platform_device_unregister(icc_pdev);
> > +}
> > +
> >  static int rpm_smd_clk_probe(struct platform_device *pdev)
> >  {
> >  	int ret;
> >  	size_t num_clks, i;
> >  	struct clk_smd_rpm **rpm_smd_clks;
> >  	const struct rpm_smd_clk_desc *desc;
> > +	struct platform_device *icc_pdev;
> >  
> >  	rpmcc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
> >  	if (!rpmcc_smd_rpm) {
> > @@ -1357,6 +1365,19 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto err;
> >  
> > +	icc_pdev = platform_device_register_data(pdev->dev.parent,
> > +						 "icc_smd_rpm", -1, NULL, 0);
> > +	if (IS_ERR(icc_pdev)) {
> > +		dev_err(&pdev->dev, "Failed to register icc_smd_rpm device: %pE\n",
> > +			icc_pdev);
> > +		/* No need to unregister clocks because of this */
> > +	} else {
> > +		ret = devm_add_action_or_reset(&pdev->dev, rpm_smd_unregister_icc,
> > +					       icc_pdev);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> >  	return 0;
> >  err:
> >  	dev_err(&pdev->dev, "Error registering SMD clock driver (%d)\n", ret);
> > diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> > index 0c1aa809cc4e..427dd5392b82 100644
> > --- a/drivers/soc/qcom/smd-rpm.c
> > +++ b/drivers/soc/qcom/smd-rpm.c
> > @@ -19,7 +19,6 @@
> >  /**
> >   * struct qcom_smd_rpm - state of the rpm device driver
> >   * @rpm_channel:	reference to the smd channel
> > - * @icc:		interconnect proxy device
> >   * @dev:		rpm device
> >   * @ack:		completion for acks
> >   * @lock:		mutual exclusion around the send/complete pair
> > @@ -27,7 +26,6 @@
> >   */
> >  struct qcom_smd_rpm {
> >  	struct rpmsg_endpoint *rpm_channel;
> > -	struct platform_device *icc;
> >  	struct device *dev;
> >  
> >  	struct completion ack;
> > @@ -197,7 +195,6 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
> >  static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
> >  {
> >  	struct qcom_smd_rpm *rpm;
> > -	int ret;
> >  
> >  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
> >  	if (!rpm)
> > @@ -210,24 +207,7 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
> >  	rpm->rpm_channel = rpdev->ept;
> >  	dev_set_drvdata(&rpdev->dev, rpm);
> >  
> > -	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
> > -						 NULL, 0);
> > -	if (IS_ERR(rpm->icc))
> > -		return PTR_ERR(rpm->icc);
> > -
> > -	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> > -	if (ret)
> > -		platform_device_unregister(rpm->icc);
> > -
> > -	return ret;
> > -}
> > -
> > -static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
> > -{
> > -	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
> > -
> > -	platform_device_unregister(rpm->icc);
> > -	of_platform_depopulate(&rpdev->dev);
> > +	return devm_of_platform_populate(&rpdev->dev);
> >  }
> >  
> >  static const struct of_device_id qcom_smd_rpm_of_match[] = {
> > @@ -256,7 +236,6 @@ MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
> >  
> >  static struct rpmsg_driver qcom_smd_rpm_driver = {
> >  	.probe = qcom_smd_rpm_probe,
> > -	.remove = qcom_smd_rpm_remove,
> This reaches over the removal of the icc registration, the depopulate
> call should stay.
> 

I switched the of_platform_populate() to devm_of_platform_populate(),
that's why the remove callback is no longer necessary. It's a bit
hidden, perhaps it would be enough to add to the commit message:

"While at it, switch the remaining of_platform_populate() call to the
 devm variant and remove the remove callback."

Or maybe it should be split into two patches.

Thanks,
Stephan
