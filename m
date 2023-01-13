Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B371E668E75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjAMG4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjAMGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:55:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E3B482
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vnMvjX6mTK9eOA3+SOHPFtBjLnF8y8MyzzwcaEP4EU8=; b=bLlTtfcWrMEfGKCfKQJM3csvSn
        8kN2igpQ4nXrr7DaT3tI90kDhpZoNCbtaIY9SW3BVPDE1bZmr9ccfl7PQcG6HqEhjF3WRQ5zSmSpN
        THDVTbLnCnXXT7q8ZYEoPKSM1+/LStLKwJJdG9NXn0EjTp/rlzs00DmvlHoQ10LVeZSRtthBAOvXR
        0c2f7qvrVs0FszyWp/Sc2w9uN+Dg8LVznsH48oy381PDkCkUjLX+/vjqYOcyrcceP0v3CZFGHTr/X
        5BZHpGM6SHAOQqEc1k2t4zsQ73TLtyIDN5W0Z+AyWJuy1EcPiDoPhtMQuUcfA4p5TFrtt6xskxmIw
        fSaqx7Fg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDk1-000qiL-7R; Fri, 13 Jan 2023 06:40:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] spmi: fix W=1 kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:40:40 -0800
Message-Id: <20230113064040.26801-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all W=1 kernel-doc warnings in drivers/spmi/:

drivers/spmi/spmi.c:414: warning: expecting prototype for spmi_controller_alloc(). Prototype was for spmi_device_alloc() instead
drivers/spmi/spmi.c:592: warning: expecting prototype for spmi_driver_register(). Prototype was for __spmi_driver_register() instead
drivers/spmi/spmi.c:592: warning: Function parameter or member 'owner' not described in '__spmi_driver_register'
drivers/spmi/spmi-pmic-arb.c:155: warning: cannot understand function prototype: 'struct spmi_pmic_arb '
drivers/spmi/spmi-pmic-arb.c:203: warning: cannot understand function prototype: 'struct pmic_arb_ver_ops '
drivers/spmi/spmi-pmic-arb.c:219: warning: expecting prototype for struct pmic_arb_ver. Prototype was for struct pmic_arb_ver_ops instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c |    4 ++--
 drivers/spmi/spmi.c          |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff -- a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -404,7 +404,7 @@ struct spmi_device *spmi_device_from_of(
 EXPORT_SYMBOL_GPL(spmi_device_from_of);
 
 /**
- * spmi_controller_alloc() - Allocate a new SPMI device
+ * spmi_device_alloc() - Allocate a new SPMI device
  * @ctrl:	associated controller
  *
  * Caller is responsible for either calling spmi_device_add() to add the
@@ -582,8 +582,9 @@ void spmi_controller_remove(struct spmi_
 EXPORT_SYMBOL_GPL(spmi_controller_remove);
 
 /**
- * spmi_driver_register() - Register client driver with SPMI core
+ * __spmi_driver_register() - Register client driver with SPMI core
  * @sdrv:	client driver to be associated with client-device.
+ * @owner:	module owner
  *
  * This API will register the client driver with the SPMI framework.
  * It is typically called from the driver's module-init function.
diff -- a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -126,7 +126,7 @@ struct apid_data {
 };
 
 /**
- * spmi_pmic_arb - SPMI PMIC Arbiter object
+ * struct spmi_pmic_arb - SPMI PMIC Arbiter object
  *
  * @rd_base:		on v1 "core", on v2 "observer" register base off DT.
  * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
@@ -180,7 +180,7 @@ struct spmi_pmic_arb {
 };
 
 /**
- * pmic_arb_ver: version dependent functionality.
+ * struct pmic_arb_ver_ops - version dependent functionality.
  *
  * @ver_str:		version string.
  * @ppid_to_apid:	finds the apid for a given ppid.
