Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78E16C7C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCXKBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9724BD4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98A14B82195
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D77C433EF;
        Fri, 24 Mar 2023 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679652097;
        bh=0clnbATA9VfATe4746ThObzt1WEqeVe1tU4HzAJpjo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZE0V/bYreIJl0TaFoHwb17WbnrzUI2kUAOJA4Jqk6NDmpDrO+xGKUcGzIaixxfbi
         o/quWp8uCH9qJSBe1U0/X2ryrMW5enrbnzKKhI7x0K/anNmfeyTWg+6wvzfbkQHXrX
         DU1A1hRk9sb1wUKjnuP7Kfp7MLIR9a0q9YBa9jNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] driver core: class.h: remove extern from function prototypes
Date:   Fri, 24 Mar 2023 11:01:32 +0100
Message-Id: <20230324100132.1633647-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324100132.1633647-1-gregkh@linuxfoundation.org>
References: <20230324100132.1633647-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4485; i=gregkh@linuxfoundation.org; h=from:subject; bh=0clnbATA9VfATe4746ThObzt1WEqeVe1tU4HzAJpjo8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmyJX8m16q926dXG9iueMj+ZFD+sePu/xn3tnGVyJRO4 3DhsZLpiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIkI3GNYMCes69FPX/+f836v czFtOPgns772E8P8vAM/mSbf99B0tItz/5n84pxl+O8oAA==
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
in .h files, so remove them from include/linux/device/class.h as they
are not needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device/class.h | 46 ++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 03d2f99f84c5..1dc7706cb42d 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -82,8 +82,9 @@ struct class_dev_iter {
 
 extern struct kobject *sysfs_dev_block_kobj;
 extern struct kobject *sysfs_dev_char_kobj;
-extern int __must_check class_register(struct class *class);
-extern void class_unregister(struct class *class);
+
+int __must_check class_register(struct class *class);
+void class_unregister(struct class *class);
 
 struct class_compat;
 struct class_compat *class_compat_register(const char *name);
@@ -93,19 +94,15 @@ int class_compat_create_link(struct class_compat *cls, struct device *dev,
 void class_compat_remove_link(struct class_compat *cls, struct device *dev,
 			      struct device *device_link);
 
-extern void class_dev_iter_init(struct class_dev_iter *iter,
-				const struct class *class,
-				const struct device *start,
-				const struct device_type *type);
-extern struct device *class_dev_iter_next(struct class_dev_iter *iter);
-extern void class_dev_iter_exit(struct class_dev_iter *iter);
+void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
+			 const struct device *start, const struct device_type *type);
+struct device *class_dev_iter_next(struct class_dev_iter *iter);
+void class_dev_iter_exit(struct class_dev_iter *iter);
 
-extern int class_for_each_device(const struct class *class, const struct device *start,
-				 void *data,
-				 int (*fn)(struct device *dev, void *data));
-extern struct device *class_find_device(const struct class *class,
-					const struct device *start, const void *data,
-					int (*match)(struct device *, const void *));
+int class_for_each_device(const struct class *class, const struct device *start, void *data,
+			  int (*fn)(struct device *dev, void *data));
+struct device *class_find_device(const struct class *class, const struct device *start,
+				 const void *data, int (*match)(struct device *, const void *));
 
 /**
  * class_find_device_by_name - device iterator for locating a particular device
@@ -191,12 +188,10 @@ struct class_attribute {
 #define CLASS_ATTR_WO(_name) \
 	struct class_attribute class_attr_##_name = __ATTR_WO(_name)
 
-extern int __must_check class_create_file_ns(const struct class *class,
-					     const struct class_attribute *attr,
-					     const void *ns);
-extern void class_remove_file_ns(const struct class *class,
-				 const struct class_attribute *attr,
-				 const void *ns);
+int __must_check class_create_file_ns(const struct class *class, const struct class_attribute *attr,
+				      const void *ns);
+void class_remove_file_ns(const struct class *class, const struct class_attribute *attr,
+			  const void *ns);
 
 static inline int __must_check class_create_file(const struct class *class,
 						 const struct class_attribute *attr)
@@ -223,8 +218,7 @@ struct class_attribute_string {
 	struct class_attribute_string class_attr_##_name = \
 		_CLASS_ATTR_STRING(_name, _mode, _str)
 
-extern ssize_t show_class_attr_string(struct class *class, struct class_attribute *attr,
-                        char *buf);
+ssize_t show_class_attr_string(struct class *class, struct class_attribute *attr, char *buf);
 
 struct class_interface {
 	struct list_head	node;
@@ -234,10 +228,10 @@ struct class_interface {
 	void (*remove_dev)	(struct device *, struct class_interface *);
 };
 
-extern int __must_check class_interface_register(struct class_interface *);
-extern void class_interface_unregister(struct class_interface *);
+int __must_check class_interface_register(struct class_interface *);
+void class_interface_unregister(struct class_interface *);
 
-extern struct class * __must_check class_create(const char *name);
-extern void class_destroy(struct class *cls);
+struct class * __must_check class_create(const char *name);
+void class_destroy(struct class *cls);
 
 #endif	/* _DEVICE_CLASS_H_ */
-- 
2.40.0

