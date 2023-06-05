Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE47220EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFEIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFEIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:24:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1E0DB;
        Mon,  5 Jun 2023 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685953457; x=1717489457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7pBf4vD4b/2caO4wlqGj7bEZRvWRHUq5ziET/g0/Hs=;
  b=nDmPURk630KmoerIA99Ug5EXup/y67O+7gVoD1xu4PffD8CRtAqYYx3B
   NVB/K43JKqGk5j2RVvS8iFaO03Jtr70y6H8MOGUkR6BEGTG+RFd2/IJU4
   2depMMaDSq6GZ2D0TU7QJEQ9Sxz5hK5L6/AtSBMNzbF255kpPgOLvPiGT
   8cKJj2+ck2xXB4moIQyvuIgDdLS+rnRCqvK3S9ptKy5Gb+4SRj3ie7Y8K
   kaAjmlMyEmyLdEgCHqdOHSqXoWrSAjGvoCvxSY+xPIcGdfW7DH8sqR/nt
   ah4Oq78ewfW+yfFdzRxdRjfxkbTbd5pif3MhqzcV3UtGqiKqyxcxHlFc4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353805987"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="diff'?scan'208";a="353805987"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 01:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="852889775"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="diff'?scan'208";a="852889775"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 05 Jun 2023 01:24:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 05 Jun 2023 11:24:12 +0300
Date:   Mon, 5 Jun 2023 11:24:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     neil.armstrong@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: add support for the nb7vpq904m Type-C
 Linear Redriver
Message-ID: <ZH2brE5oq5d7tQbO@kuha.fi.intel.com>
References: <20230601-topic-sm8x50-upstream-redriver-v1-0-6ad21094ff6f@linaro.org>
 <20230601-topic-sm8x50-upstream-redriver-v1-2-6ad21094ff6f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2Xc2uqbG1mUluy38"
Content-Disposition: inline
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v1-2-6ad21094ff6f@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Xc2uqbG1mUluy38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Neil,

On Thu, Jun 01, 2023 at 11:21:13AM +0200, neil.armstrong@linaro.org wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add support for the ON Semiconductor NB7VPQ904M Type-C USB SuperSpeed
> and DisplayPort ALT Mode Linear Redriver chip found on some devices
> with a Type-C port.
> 
> The redriver compensates ultra High-Speeed DisplayPort and USB
> Super Speed signal integrity losses mainly due to PCB & transmission
> cables.
> 
> The redriver doesn't support SuperSpeed lines swapping, but
> can support Type-C SBU lines swapping.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/typec/mux/Kconfig      |   8 +
>  drivers/usb/typec/mux/Makefile     |   1 +
>  drivers/usb/typec/mux/nb7vpq904m.c | 526 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 535 insertions(+)

This looks good to me, but I think you should register a retimer
instead of a mode switch (the orientation switch is fine).

Retimers are handled just like the muxes, so this patch would not need
that many changes, but you would need to change the first patch too.
You would need to declare a "redriver-switch" instead of "mode-switch"
property in your DT (or perhaps make it just "redriver" instead of
"redriver-switch"?).

We just need to add a device type for redrivers to the retimer class -
check the attached diff. Something like that.

Let me know what you guys think.

thanks,

-- 
heikki

--2Xc2uqbG1mUluy38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="redriver_device_type.diff"

diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index 4a7d1b5c4d866..0eb7d7433cd63 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -19,7 +19,8 @@
 
 static int retimer_fwnode_match(struct device *dev, const void *fwnode)
 {
-	return is_typec_retimer(dev) && device_match_fwnode(dev, fwnode);
+	return (is_typec_retimer(dev) || is_typec_redriver(dev)) &&
+	       device_match_fwnode(dev, fwnode);
 }
 
 static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char *id, void *data)
@@ -49,6 +50,8 @@ struct typec_retimer *fwnode_typec_retimer_get(struct fwnode_handle *fwnode)
 	struct typec_retimer *retimer;
 
 	retimer = fwnode_connection_find_match(fwnode, "retimer-switch", NULL, typec_retimer_match);
+	if (!retimer)
+		retimer = fwnode_connection_find_match(fwnode, "redriver-switch", NULL, typec_retimer_match);
 	if (!IS_ERR_OR_NULL(retimer))
 		WARN_ON(!try_module_get(retimer->dev.parent->driver->owner));
 
@@ -90,6 +93,11 @@ const struct device_type typec_retimer_dev_type = {
 	.release = typec_retimer_release,
 };
 
+const struct device_type typec_redriver_dev_type = {
+	.name = "typec_redriver",
+	.release = typec_retimer_release,
+};
+
 /**
  * typec_retimer_register - Register a retimer device.
  * @parent: Parent device.
@@ -120,10 +128,10 @@ typec_retimer_register(struct device *parent, const struct typec_retimer_desc *d
 	retimer->dev.parent = parent;
 	retimer->dev.fwnode = desc->fwnode;
 	retimer->dev.class = &retimer_class;
-	retimer->dev.type = &typec_retimer_dev_type;
+	retimer->dev.type = desc->redriver ? &typec_redriver_dev_type : &typec_retimer_dev_type;
 	retimer->dev.driver_data = desc->drvdata;
-	dev_set_name(&retimer->dev, "%s-retimer",
-		     desc->name ? desc->name : dev_name(parent));
+	dev_set_name(&retimer->dev, "%s-%s", desc->name ? desc->name : dev_name(parent),
+		     desc->redriver ? "redriver" : "retimer");
 
 	ret = device_add(&retimer->dev);
 	if (ret) {
diff --git a/drivers/usb/typec/retimer.h b/drivers/usb/typec/retimer.h
index d6a5ef9881e1f..b552cdb985724 100644
--- a/drivers/usb/typec/retimer.h
+++ b/drivers/usb/typec/retimer.h
@@ -13,7 +13,9 @@ struct typec_retimer {
 #define to_typec_retimer(_dev_) container_of(_dev_, struct typec_retimer, dev)
 
 extern const struct device_type typec_retimer_dev_type;
+extern const struct device_type typec_redriver_dev_type;
 
 #define is_typec_retimer(dev) ((dev)->type == &typec_retimer_dev_type)
+#define is_typec_redriver(dev) ((dev)->type == &typec_redriver_dev_type)
 
 #endif /* __USB_TYPEC_RETIMER__ */
diff --git a/include/linux/usb/typec_retimer.h b/include/linux/usb/typec_retimer.h
index 5e036b3360e25..b2daf8e6caeb0 100644
--- a/include/linux/usb/typec_retimer.h
+++ b/include/linux/usb/typec_retimer.h
@@ -25,6 +25,7 @@ struct typec_retimer_desc {
 	typec_retimer_set_fn_t set;
 	const char *name;
 	void *drvdata;
+	bool redriver;
 };
 
 struct typec_retimer *fwnode_typec_retimer_get(struct fwnode_handle *fwnode);

--2Xc2uqbG1mUluy38--
