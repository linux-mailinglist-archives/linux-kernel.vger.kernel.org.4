Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB436C7E04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCXM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjCXM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDF244BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A667662A94
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976B1C4339C;
        Fri, 24 Mar 2023 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679660844;
        bh=Ba5v5E23etqC18T6sxALRRUecTgwNf99pEvvSfDejN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxHxDgbUTnXK2UsSrL5v5ziLBeFO0fQvlOImIoxM/lL1rmwRtIMfNVuG4UFcP5Yyq
         SLznbASoBJES0GRdri9etmUIFpl6kLKTkboEH4VFztxPhbhm1Od9ccSMCxdnBRIxxs
         Xjd9ygbRqM5GJ19WxZs4qsMjslysyzVvuGRnndEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/6] driver core: driver.h: remove extern from function prototypes
Date:   Fri, 24 Mar 2023 13:27:08 +0100
Message-Id: <20230324122711.2664537-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
References: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573; i=gregkh@linuxfoundation.org; h=from:subject; bh=Ba5v5E23etqC18T6sxALRRUecTgwNf99pEvvSfDejN8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmy0+X+t9Y/m6vgzF9mE7/+8aapwct27rQ+e1DrWu6/+ XteRlhZdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEXNIZZrPznfEQyFPd1G4b lNLwJpifTfTEM4b5LjXmruzGa3Vi/8tECjdyt/L92TMLAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from include/linux/device/driver.h as they
are not needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device/driver.h | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 0f22a6f46f8c..c244267a6744 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -122,13 +122,12 @@ struct device_driver {
 };
 
 
-extern int __must_check driver_register(struct device_driver *drv);
-extern void driver_unregister(struct device_driver *drv);
+int __must_check driver_register(struct device_driver *drv);
+void driver_unregister(struct device_driver *drv);
 
-extern struct device_driver *driver_find(const char *name,
-					 const struct bus_type *bus);
-extern int driver_probe_done(void);
-extern void wait_for_device_probe(void);
+struct device_driver *driver_find(const char *name, const struct bus_type *bus);
+int driver_probe_done(void);
+void wait_for_device_probe(void);
 void __init wait_for_init_devices_probe(void);
 
 /* sysfs interface for exporting driver attributes */
@@ -147,18 +146,15 @@ struct driver_attribute {
 #define DRIVER_ATTR_WO(_name) \
 	struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
 
-extern int __must_check driver_create_file(struct device_driver *driver,
-					const struct driver_attribute *attr);
-extern void driver_remove_file(struct device_driver *driver,
-			       const struct driver_attribute *attr);
+int __must_check driver_create_file(struct device_driver *driver,
+				    const struct driver_attribute *attr);
+void driver_remove_file(struct device_driver *driver,
+			const struct driver_attribute *attr);
 
 int driver_set_override(struct device *dev, const char **override,
 			const char *s, size_t len);
-extern int __must_check driver_for_each_device(struct device_driver *drv,
-					       struct device *start,
-					       void *data,
-					       int (*fn)(struct device *dev,
-							 void *));
+int __must_check driver_for_each_device(struct device_driver *drv, struct device *start,
+					void *data, int (*fn)(struct device *dev, void *));
 struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, const void *data,
 				  int (*match)(struct device *dev, const void *data));
-- 
2.40.0

