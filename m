Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26E5712752
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbjEZNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbjEZNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:14:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F712C;
        Fri, 26 May 2023 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685106877; x=1716642877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=51xbnpVnSv7kK/CIAJA3IJI4ao4C21LGwC97orFloNk=;
  b=XtT6FHJqTLUl/qFQROwyxiQ3EjaJ2foowIfzqHvJ58gaP7Svn4j4h0mB
   1E2yAyMfi4H8IXb5RGH3QZOJc0tfYqBhFglhRSZLTuxXChZwuxCjBR817
   +77qcyOknldU3vslGGqQP1ujlXg+88ZSuTF6lnQXa3kAHQhR/mFQkMbby
   nM1U9QdqU2zUJ317lfZweESlCDYqz6WfdO7NPOKEV19V5mkvHHeS528bC
   ABkHEm6ssbZUeNmacKGXgNVLVKhcf3qpMXC2NlemWIcozInLi/aPoixOI
   K7N2gTWCcXVNsE2qLRVkaPor4zt/SX9OqPZNHsac5Q1B6mJ5oskfUvUxg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="419955118"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="419955118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 06:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="849555297"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="849555297"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2023 06:14:34 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v2 2/2] usb: typec: mux: Remove alt mode parameters from the API
Date:   Fri, 26 May 2023 16:14:34 +0300
Message-Id: <20230526131434.46920-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526131434.46920-1-heikki.krogerus@linux.intel.com>
References: <20230526131434.46920-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alt mode descriptor parameters are not used anymore.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Tested-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Prashant Malani <pmalani@chromium.org>
---
v2: No changes. Adding the Acked-by a Reviewed-by tags.

 drivers/platform/chrome/cros_ec_typec.c |  2 +-
 drivers/soc/qcom/pmic_glink_altmode.c   |  5 +----
 drivers/usb/typec/class.c               |  4 ++--
 drivers/usb/typec/mux.c                 |  6 ++----
 include/linux/usb/typec_mux.h           | 11 ++++-------
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index a673c33424706..25f9767c28e82 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -77,7 +77,7 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 {
 	int ret = 0;
 
-	port->mux = fwnode_typec_mux_get(fwnode, NULL);
+	port->mux = fwnode_typec_mux_get(fwnode);
 	if (IS_ERR(port->mux)) {
 		ret = PTR_ERR(port->mux);
 		dev_dbg(dev, "Mux handle not found: %d.\n", ret);
diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 4d7895bdeaf2f..df48fbea4b686 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -369,7 +369,6 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 {
 	struct pmic_glink_altmode_port *alt_port;
 	struct pmic_glink_altmode *altmode;
-	struct typec_altmode_desc mux_desc = {};
 	const struct of_device_id *match;
 	struct fwnode_handle *fwnode;
 	struct device *dev = &adev->dev;
@@ -427,9 +426,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
 		alt_port->dp_alt.active = 1;
 
-		mux_desc.svid = USB_TYPEC_DP_SID;
-		mux_desc.mode = USB_TYPEC_DP_MODE;
-		alt_port->typec_mux = fwnode_typec_mux_get(fwnode, &mux_desc);
+		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
 		if (IS_ERR(alt_port->typec_mux))
 			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
 					     "failed to acquire mode-switch for port: %d\n",
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 349cc2030c903..faa184ae3dac8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2110,7 +2110,7 @@ typec_port_register_altmode(struct typec_port *port,
 	struct typec_mux *mux;
 	struct typec_retimer *retimer;
 
-	mux = typec_mux_get(&port->dev, desc);
+	mux = typec_mux_get(&port->dev);
 	if (IS_ERR(mux))
 		return ERR_CAST(mux);
 
@@ -2274,7 +2274,7 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
-	port->mux = typec_mux_get(&port->dev, NULL);
+	port->mux = typec_mux_get(&port->dev);
 	if (IS_ERR(port->mux)) {
 		ret = PTR_ERR(port->mux);
 		put_device(&port->dev);
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index f2eee6322815d..80dd91938d960 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -287,15 +287,13 @@ static void *typec_mux_match(const struct fwnode_handle *fwnode,
 /**
  * fwnode_typec_mux_get - Find USB Type-C Multiplexer
  * @fwnode: The caller device node
- * @desc: Alt Mode description
  *
  * Finds a mux linked to the caller. This function is primarily meant for the
  * Type-C drivers. Returns a reference to the mux on success, NULL if no
  * matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a connection
  * was found but the mux has not been enumerated yet.
  */
-struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
-				       const struct typec_altmode_desc *desc)
+struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode)
 {
 	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
 	struct typec_mux *mux;
@@ -308,7 +306,7 @@ struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
 		return ERR_PTR(-ENOMEM);
 
 	count = fwnode_connection_find_matches(fwnode, "mode-switch",
-					       (void *)desc, typec_mux_match,
+					       NULL, typec_mux_match,
 					       (void **)mux_devs,
 					       ARRAY_SIZE(mux_devs));
 	if (count <= 0) {
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 9292f0e078464..11bfa314529fd 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -60,8 +60,7 @@ struct typec_mux_desc {
 
 #if IS_ENABLED(CONFIG_TYPEC)
 
-struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
-				       const struct typec_altmode_desc *desc);
+struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode);
 void typec_mux_put(struct typec_mux *mux);
 int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state);
 
@@ -74,8 +73,7 @@ void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
 
 #else
 
-static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
-				       const struct typec_altmode_desc *desc)
+static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode);
 {
 	return NULL;
 }
@@ -102,10 +100,9 @@ static inline void *typec_mux_get_drvdata(struct typec_mux_dev *mux)
 
 #endif /* CONFIG_TYPEC */
 
-static inline struct typec_mux *
-typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc)
+static inline struct typec_mux *typec_mux_get(struct device *dev)
 {
-	return fwnode_typec_mux_get(dev_fwnode(dev), desc);
+	return fwnode_typec_mux_get(dev_fwnode(dev));
 }
 
 #endif /* __USB_TYPEC_MUX */
-- 
2.39.2

