Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0672AE5E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjFJT0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFJT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:26:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95986270F;
        Sat, 10 Jun 2023 12:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686425161; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F2AghggULwt/ZeiEpJ2qIatYOdMEV/Ex2T51+BhA+ifEps64XOxZ4hu9+/WzIB0CR6
    GOh1QxhSyKHHCKrNiGL/2xfg1E963A4eal/XS2woCf7BAuU6QTLmRvbWnJU30snk7ADt
    jo9ySaq9Y2bzS58o0MBKfKEN9MlGROrQBfSeQZDaPiuhIYEbnzkhf/6ekOa6zG5q+UTm
    t86M35z82q8J8j0/tdKRYjqYDZBMeIJWiDpq8L4l2VZcKU2me3782IOMKxSh798dNxkw
    8KOo4cTmNd/bveYUKrRsGTF/IsVw9gxkiBMQLF2vNCibX2eD4kXxETxptrgOYfE9ebZN
    8F6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686425161;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=sTVVvt1c/XSzjVATPFIPyP1Oj06m2UGEpkH6Jg370tw=;
    b=fwhQnHob1aZdI4tBdx0xbmqinEJyxxr1SPJoaYv3twqST8xUDBrjanOgdj7aYcqALz
    hsn7p8r7X4pyd5XZ2JquH3kYxICnQ0iWN+JaskMv0Ls+X646xy3lw5IIw9LvC8CEJizu
    oqcEW5DzNyLCIYXluFFobSx94m+vzQIRIlCk4TruyDbc3NyftTPL6Rw2i4ydcG1Z56st
    3CUy6Av/TA+Kk9dCyP+gNu4WixlVaqqrO3kRDp/DOER2h6pLMIStSb46tirT6bPnWMfE
    5etdz5OTqmPZioT4LWedFznZUWn3MZ7aX2slfQIeUGvOCRgSlcBZ+0cqLHi2uz4QOPt3
    25xQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686425161;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=sTVVvt1c/XSzjVATPFIPyP1Oj06m2UGEpkH6Jg370tw=;
    b=MPrjt2/dh/UU1JrjyzldKk0N2ShgxeUWR92sDeGbjjrnZjIxWEdFasRHX/ciXlkgRV
    rbbt3yoyezYz1m1QCCVvhOj0mXsHX9zM5aIJfjAqJSd7kjG7WX1xGa3Ba7mG46WeHDJE
    qBj2gKI5KrBGtPmnOji3ZUZfEj3RLhI4Z/l1C0Kog7mrpaJW8Ojtlaaog8FkuHUXTdAb
    FMoZ8yBWhFDpwq5q0Qy4o+vZlc5YvppPrgPHLe7e8NeKDExuNjEiTQwQMIEEcZpETj5y
    CA8jMwsP4tyOS8ZRwYQIvVB44ENIgfUZKfbGNrmgpfqTaOySFqAqP3XKrrnMhKbrXzl0
    w3tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686425161;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=sTVVvt1c/XSzjVATPFIPyP1Oj06m2UGEpkH6Jg370tw=;
    b=d2urnGtz+emTXEXVL6XhZ8Thw0IRSvLeSY52f2aZH3zSVojhoqRxAHVwsuoPikj5V9
    yTzvi5aaCF81A0ZiRqAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AJQ0Qet
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 21:26:00 +0200 (CEST)
Date:   Sat, 10 Jun 2023 21:25:59 +0200
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
Message-ID: <ZITOR3Y25Bv4msdm@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-4-e5934b07d813@linaro.org>
 <ZIRgGXwKD6mcgTRY@gerhold.net>
 <40f937bb-0d7e-a237-1672-5905983622ce@linaro.org>
 <b7b1d19c-b87d-b3fd-36aa-374065a45ede@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b1d19c-b87d-b3fd-36aa-374065a45ede@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 08:53:05PM +0200, Konrad Dybcio wrote:
> On 10.06.2023 14:15, Konrad Dybcio wrote:
> > On 10.06.2023 13:35, Stephan Gerhold wrote:
> >> On Fri, Jun 09, 2023 at 10:19:09PM +0200, Konrad Dybcio wrote:
> >>> Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
> >>> clock rate requests will not be commited in hardware. This poses a
> >>> race threat since we're accessing the bus clocks directly from within
> >>> the interconnect framework.
> >>>
> >>> Add a marker to indicate that we're good to go with sending new requests
> >>> and export it so that it can be referenced from icc.
> >>>
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >>>  drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
> >>>  include/linux/soc/qcom/smd-rpm.h | 2 ++
> >>>  2 files changed, 11 insertions(+)
> >>>
> >>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> >>> index 937cb1515968..482fe30ee6f0 100644
> >>> --- a/drivers/clk/qcom/clk-smd-rpm.c
> >>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> >>> @@ -151,6 +151,7 @@
> >>>  #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
> >>>  
> >>>  static struct qcom_smd_rpm *rpmcc_smd_rpm;
> >>> +static bool smd_rpm_clk_scaling;
> >>>  
> >>>  struct clk_smd_rpm {
> >>>  	const int rpm_res_type;
> >>> @@ -385,6 +386,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
> >>>  	return r->rate;
> >>>  }
> >>>  
> >>> +bool qcom_smd_rpm_scaling_available(void)
> >>> +{
> >>> +	return smd_rpm_clk_scaling;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
> >>> +
> >>>  static int clk_smd_rpm_enable_scaling(void)
> >>>  {
> >>>  	int ret;
> >>> @@ -410,6 +417,8 @@ static int clk_smd_rpm_enable_scaling(void)
> >>>  		return ret;
> >>>  	}
> >>>  
> >>> +	smd_rpm_clk_scaling = true;
> >>> +
> >>
> >> If you move the platform_device_register_data(&rpdev->dev,
> >> "icc_smd_rpm", ...) from drivers/soc/qcom/smd-rpm.c to here you can
> >> avoid the race completely and drop this API. I think that would be
> >> cleaner. And it will likely probe much faster because probe deferral
> >> is slow. :)
> > Sounds like an idea.. especially since it's pretty much the only
> > dependency other than SMDRPM itself!
> It sounds great, but to not break bisecting one has to:
> 
> 1. change the registration in soc/smd-rpm to store rpm ptr in driver
>    data, in addition to parent driver data
> 
> 2. change icc/smd-rpm to use the device and not parent data
> 
> 3. add a platform_device_register_data call in clk-smd-rpm that will
>    always fail because the device is always registered
> 
> 4. remove the registration from soc/smd-rpm
> 

Logically the icc_smd_rpm device still fits better as child of
smd-rpm and not clk-smd-rpm. So I would probably just continue
registering it on the parent device from clk-smd-rpm.
Then there are no changes necessary in icc_smd_rpm.

You could use this. Both touched files are Bjorn-maintained so should be
manageable to have it in one commit. (note: compile-tested only)

Thanks,
Stephan

From a2610adb2551b01e76b9de8e4cbcc89853814a8f Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Sat, 10 Jun 2023 21:19:48 +0200
Subject: [PATCH] soc: qcom: smd-rpm: Move icc_smd_rpm registration to
 clk-smd-rpm

icc_smd_rpm will do bus clock votes itself rather than taking the
unnecessary detour through the clock subsystem. However, it can only
do that after the clocks have been handed off and scaling has been
enabled in the RPM in clk-smd-rpm.

Move the icc_smd_rpm registration from smd-rpm.c to clk-smd-rpm.c
to avoid any possible races. icc_smd_rpm gets the driver data from
the smd-rpm device, so still register the platform device on the
smd-rpm parent device.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/clk/qcom/clk-smd-rpm.c | 21 +++++++++++++++++++++
 drivers/soc/qcom/smd-rpm.c     | 23 +----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index e4de74b68797..91adb16889b3 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1302,12 +1302,20 @@ static struct clk_hw *qcom_smdrpm_clk_hw_get(struct of_phandle_args *clkspec,
 	return desc->clks[idx] ? &desc->clks[idx]->hw : ERR_PTR(-ENOENT);
 }
 
+static void rpm_smd_unregister_icc(void *data)
+{
+	struct platform_device *icc_pdev = data;
+
+	platform_device_unregister(icc_pdev);
+}
+
 static int rpm_smd_clk_probe(struct platform_device *pdev)
 {
 	int ret;
 	size_t num_clks, i;
 	struct clk_smd_rpm **rpm_smd_clks;
 	const struct rpm_smd_clk_desc *desc;
+	struct platform_device *icc_pdev;
 
 	rpmcc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
 	if (!rpmcc_smd_rpm) {
@@ -1357,6 +1365,19 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	icc_pdev = platform_device_register_data(pdev->dev.parent,
+						 "icc_smd_rpm", -1, NULL, 0);
+	if (IS_ERR(icc_pdev)) {
+		dev_err(&pdev->dev, "Failed to register icc_smd_rpm device: %pE\n",
+			icc_pdev);
+		/* No need to unregister clocks because of this */
+	} else {
+		ret = devm_add_action_or_reset(&pdev->dev, rpm_smd_unregister_icc,
+					       icc_pdev);
+		if (ret)
+			goto err;
+	}
+
 	return 0;
 err:
 	dev_err(&pdev->dev, "Error registering SMD clock driver (%d)\n", ret);
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 0c1aa809cc4e..427dd5392b82 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -19,7 +19,6 @@
 /**
  * struct qcom_smd_rpm - state of the rpm device driver
  * @rpm_channel:	reference to the smd channel
- * @icc:		interconnect proxy device
  * @dev:		rpm device
  * @ack:		completion for acks
  * @lock:		mutual exclusion around the send/complete pair
@@ -27,7 +26,6 @@
  */
 struct qcom_smd_rpm {
 	struct rpmsg_endpoint *rpm_channel;
-	struct platform_device *icc;
 	struct device *dev;
 
 	struct completion ack;
@@ -197,7 +195,6 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
 static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
 {
 	struct qcom_smd_rpm *rpm;
-	int ret;
 
 	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
 	if (!rpm)
@@ -210,24 +207,7 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
 	rpm->rpm_channel = rpdev->ept;
 	dev_set_drvdata(&rpdev->dev, rpm);
 
-	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
-						 NULL, 0);
-	if (IS_ERR(rpm->icc))
-		return PTR_ERR(rpm->icc);
-
-	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
-	if (ret)
-		platform_device_unregister(rpm->icc);
-
-	return ret;
-}
-
-static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
-{
-	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
-
-	platform_device_unregister(rpm->icc);
-	of_platform_depopulate(&rpdev->dev);
+	return devm_of_platform_populate(&rpdev->dev);
 }
 
 static const struct of_device_id qcom_smd_rpm_of_match[] = {
@@ -256,7 +236,6 @@ MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
 
 static struct rpmsg_driver qcom_smd_rpm_driver = {
 	.probe = qcom_smd_rpm_probe,
-	.remove = qcom_smd_rpm_remove,
 	.callback = qcom_smd_rpm_callback,
 	.drv  = {
 		.name  = "qcom_smd_rpm",
-- 
2.40.1
