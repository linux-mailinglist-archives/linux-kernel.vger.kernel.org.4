Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14773F4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF0Gry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjF0GrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:47:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E492944;
        Mon, 26 Jun 2023 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7zoVn6pt8mC/XFCWob4MAbf9NS9Enf9msdxXChlUhcs=; b=C/TUoCi3PofYR8dOAZKRmNZcOM
        ub+da7rv73DezRSsq2wYZAlFl8pkKtqzHvlhBrY6sGWCT5C3TIB+bsgAquiuaSSo3cswWgcwQ+k4W
        LuyfWiohu2PQ747t630wX/FM8CWqGz0yRDwlEov8EymQVb+wBZDLO4PhEzvXmMA89MxjvBeZBj/RQ
        qxmWDUZf00+uoUALelorMAcEKdQc+meM3mrSrYbwxy22oKJv+zGb+wnQuTvhKcpO/V5DLBKhZjWlu
        uhYqRJuGsZvvTj1BYf9qdy/RQjjdfvGL9pLz7/xO7kquI8lDEQ8oPDENIZVLmOub1YBobUiKO/kMv
        xei42+JQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE2S4-00CD8x-2h;
        Tue, 27 Jun 2023 06:45:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] docs: add more driver-model infrastructure interfaces
Date:   Mon, 26 Jun 2023 23:45:23 -0700
Message-ID: <20230627064523.16618-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bus, class, and device data structures and enum constants to the
Driver-Model Structures section and add function interfaces to the
Device Drivers Base section of the Device drivers infrastructure chapter.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 Documentation/driver-api/infrastructure.rst |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff -- a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
--- a/Documentation/driver-api/infrastructure.rst
+++ b/Documentation/driver-api/infrastructure.rst
@@ -8,12 +8,24 @@ The Basic Device Driver-Model Structures
    :internal:
    :no-identifiers: device_link_state
 
+.. kernel-doc:: include/linux/device/bus.h
+   :identifiers: bus_type bus_notifier_event
+
+.. kernel-doc:: include/linux/device/class.h
+   :identifiers: class
+
+.. kernel-doc:: include/linux/device/driver.h
+   :identifiers: probe_type device_driver
+
 Device Drivers Base
 -------------------
 
 .. kernel-doc:: drivers/base/init.c
    :internal:
 
+.. kernel-doc:: include/linux/device/driver.h
+   :no-identifiers: probe_type device_driver
+
 .. kernel-doc:: drivers/base/driver.c
    :export:
 
@@ -23,6 +35,9 @@ Device Drivers Base
 .. kernel-doc:: drivers/base/syscore.c
    :export:
 
+.. kernel-doc:: include/linux/device/class.h
+   :no-identifiers: class
+
 .. kernel-doc:: drivers/base/class.c
    :export:
 
@@ -41,6 +56,9 @@ Device Drivers Base
 .. kernel-doc:: drivers/base/platform.c
    :export:
 
+.. kernel-doc:: include/linux/device/bus.h
+   :no-identifiers: bus_type bus_notifier_event
+
 .. kernel-doc:: drivers/base/bus.c
    :export:
 
