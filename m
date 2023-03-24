Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910A86C7E03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCXM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:27:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E69F1A971
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 486D7B823BF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6932EC433D2;
        Fri, 24 Mar 2023 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679660835;
        bh=XQOrsfdY8C1P2IV5KjmFgIMzWxPB/DkkynS3tgW+sc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnuCwaQRkRRbX8J+knfAwkswTutfpbA7eEq4VwQRZVfL89oBdDRMuHMHdND/9SeL1
         +2TNkRxvGzdERS32aUa6+M4WZQ9h4/15xjY9nHMuId5moQeIXQauvfKcCZtP7xsD79
         zQ2V9v0cUwGrAnUcZEhIsabiIxGp0/UsS8kAD4Ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/6] driver core: bus.h: remove extern from function prototypes
Date:   Fri, 24 Mar 2023 13:27:07 +0100
Message-Id: <20230324122711.2664537-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
References: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=gregkh@linuxfoundation.org; h=from:subject; bh=XQOrsfdY8C1P2IV5KjmFgIMzWxPB/DkkynS3tgW+sc8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmy0+V+31jTrOhw29lPeU30XTP+Qt65Dh/FJ70xYxCyF guwLtTriGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgInMXcIwh/tSyqb9ujvvvtu5 8/nyOm8lgZTEMIa5Alsj427Hbr9TvMTG592O7bUnWZWdAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from include/linux/device/bus.h as they are
not needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device/bus.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 05a0c4992a49..ae10c4322754 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -109,11 +109,11 @@ struct bus_type {
 	bool need_parent_lock;
 };
 
-extern int __must_check bus_register(const struct bus_type *bus);
+int __must_check bus_register(const struct bus_type *bus);
 
-extern void bus_unregister(const struct bus_type *bus);
+void bus_unregister(const struct bus_type *bus);
 
-extern int __must_check bus_rescan_devices(const struct bus_type *bus);
+int __must_check bus_rescan_devices(const struct bus_type *bus);
 
 struct bus_attribute {
 	struct attribute	attr;
@@ -243,10 +243,8 @@ void bus_sort_breadthfirst(struct bus_type *bus,
  */
 struct notifier_block;
 
-extern int bus_register_notifier(const struct bus_type *bus,
-				 struct notifier_block *nb);
-extern int bus_unregister_notifier(const struct bus_type *bus,
-				   struct notifier_block *nb);
+int bus_register_notifier(const struct bus_type *bus, struct notifier_block *nb);
+int bus_unregister_notifier(const struct bus_type *bus, struct notifier_block *nb);
 
 /**
  * enum bus_notifier_event - Bus Notifier events that have happened
@@ -278,7 +276,7 @@ enum bus_notifier_event {
 	BUS_NOTIFY_DRIVER_NOT_BOUND,
 };
 
-extern struct kset *bus_get_kset(const struct bus_type *bus);
+struct kset *bus_get_kset(const struct bus_type *bus);
 struct device *bus_get_dev_root(const struct bus_type *bus);
 
 #endif
-- 
2.40.0

