Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF16C7E05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCXM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjCXM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA16124CAF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED17DB823BF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D71C4339B;
        Fri, 24 Mar 2023 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679660847;
        bh=vexpV3jwfugz6KwY37PadVQbqMog/NNLVcvl6rCvWvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JX4w8fhDRl8BuOfif1Fp0vlpTNoxRYOUcy6J+Pw42jJN4CUmUxAYm6LYq06vBL8n0
         gl8ajknlOC1fopwe4e4XQ1aO98QiJoH7y9GjTPH/tWAK9JeLE1AhnEdsLwjoJWwkIf
         lZQgQPuMKZydN4ecoWy8Oi+kjCDvrre161FlP9bA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/6] driver core: base.h: remove extern from function prototypes
Date:   Fri, 24 Mar 2023 13:27:09 +0100
Message-Id: <20230324122711.2664537-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
References: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6319; i=gregkh@linuxfoundation.org; h=from:subject; bh=vexpV3jwfugz6KwY37PadVQbqMog/NNLVcvl6rCvWvk=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmy0+X3XMq0f9EQqfjRL0s0ptFf8ucti+WXdT23Les9+ 6d6R9/LjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIMSfDgskRoupXmme1zt68 PfFUSEXXnCN5txnmqan3bVz3WVLsxbxq+0+aH99Lb9whAwA=
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
in .h files, so remove them from drivers/base/base.h as they are not
needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h | 88 ++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 5cca43a124ba..d3e081dc4b13 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -125,42 +125,40 @@ struct device_private {
 	container_of(obj, struct device_private, knode_class)
 
 /* initialisation functions */
-extern int devices_init(void);
-extern int buses_init(void);
-extern int classes_init(void);
-extern int firmware_init(void);
+int devices_init(void);
+int buses_init(void);
+int classes_init(void);
+int firmware_init(void);
 #ifdef CONFIG_SYS_HYPERVISOR
-extern int hypervisor_init(void);
+int hypervisor_init(void);
 #else
 static inline int hypervisor_init(void) { return 0; }
 #endif
-extern int platform_bus_init(void);
-extern void cpu_dev_init(void);
-extern void container_dev_init(void);
+int platform_bus_init(void);
+void cpu_dev_init(void);
+void container_dev_init(void);
 #ifdef CONFIG_AUXILIARY_BUS
-extern void auxiliary_bus_init(void);
+void auxiliary_bus_init(void);
 #else
 static inline void auxiliary_bus_init(void) { }
 #endif
 
 struct kobject *virtual_device_parent(struct device *dev);
 
-extern int bus_add_device(struct device *dev);
-extern void bus_probe_device(struct device *dev);
-extern void bus_remove_device(struct device *dev);
+int bus_add_device(struct device *dev);
+void bus_probe_device(struct device *dev);
+void bus_remove_device(struct device *dev);
 void bus_notify(struct device *dev, enum bus_notifier_event value);
 bool bus_is_registered(const struct bus_type *bus);
 
-extern int bus_add_driver(struct device_driver *drv);
-extern void bus_remove_driver(struct device_driver *drv);
-extern void device_release_driver_internal(struct device *dev,
-					   struct device_driver *drv,
-					   struct device *parent);
+int bus_add_driver(struct device_driver *drv);
+void bus_remove_driver(struct device_driver *drv);
+void device_release_driver_internal(struct device *dev, struct device_driver *drv,
+				    struct device *parent);
 
-extern void driver_detach(struct device_driver *drv);
-extern void driver_deferred_probe_del(struct device *dev);
-extern void device_set_deferred_probe_reason(const struct device *dev,
-					     struct va_format *vaf);
+void driver_detach(struct device_driver *drv);
+void driver_deferred_probe_del(struct device *dev);
+void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
@@ -175,27 +173,25 @@ static inline void dev_sync_state(struct device *dev)
 		dev->driver->sync_state(dev);
 }
 
-extern int driver_add_groups(struct device_driver *drv,
-			     const struct attribute_group **groups);
-extern void driver_remove_groups(struct device_driver *drv,
-				 const struct attribute_group **groups);
+int driver_add_groups(struct device_driver *drv, const struct attribute_group **groups);
+void driver_remove_groups(struct device_driver *drv, const struct attribute_group **groups);
 void device_driver_detach(struct device *dev);
 
-extern int devres_release_all(struct device *dev);
-extern void device_block_probing(void);
-extern void device_unblock_probing(void);
-extern void deferred_probe_extend_timeout(void);
-extern void driver_deferred_probe_trigger(void);
+int devres_release_all(struct device *dev);
+void device_block_probing(void);
+void device_unblock_probing(void);
+void deferred_probe_extend_timeout(void);
+void driver_deferred_probe_trigger(void);
 const char *device_get_devnode(const struct device *dev, umode_t *mode,
 			       kuid_t *uid, kgid_t *gid, const char **tmp);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
-extern void devices_kset_move_last(struct device *dev);
+void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
-extern void module_add_driver(struct module *mod, struct device_driver *drv);
-extern void module_remove_driver(struct device_driver *drv);
+void module_add_driver(struct module *mod, struct device_driver *drv);
+void module_remove_driver(struct device_driver *drv);
 #else
 static inline void module_add_driver(struct module *mod,
 				     struct device_driver *drv) { }
@@ -203,24 +199,24 @@ static inline void module_remove_driver(struct device_driver *drv) { }
 #endif
 
 #ifdef CONFIG_DEVTMPFS
-extern int devtmpfs_init(void);
+int devtmpfs_init(void);
 #else
 static inline int devtmpfs_init(void) { return 0; }
 #endif
 
 /* Device links support */
-extern int device_links_read_lock(void);
-extern void device_links_read_unlock(int idx);
-extern int device_links_read_lock_held(void);
-extern int device_links_check_suppliers(struct device *dev);
-extern void device_links_force_bind(struct device *dev);
-extern void device_links_driver_bound(struct device *dev);
-extern void device_links_driver_cleanup(struct device *dev);
-extern void device_links_no_driver(struct device *dev);
-extern bool device_links_busy(struct device *dev);
-extern void device_links_unbind_consumers(struct device *dev);
-extern void fw_devlink_drivers_done(void);
-extern void fw_devlink_probing_done(void);
+int device_links_read_lock(void);
+void device_links_read_unlock(int idx);
+int device_links_read_lock_held(void);
+int device_links_check_suppliers(struct device *dev);
+void device_links_force_bind(struct device *dev);
+void device_links_driver_bound(struct device *dev);
+void device_links_driver_cleanup(struct device *dev);
+void device_links_no_driver(struct device *dev);
+bool device_links_busy(struct device *dev);
+void device_links_unbind_consumers(struct device *dev);
+void fw_devlink_drivers_done(void);
+void fw_devlink_probing_done(void);
 
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
-- 
2.40.0

