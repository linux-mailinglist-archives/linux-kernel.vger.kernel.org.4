Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1B6E1796
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDMWi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDMWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC39F4493
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030286421D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C82C433A1;
        Thu, 13 Apr 2023 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681425517;
        bh=cJugASXn8GtyYPZx6Snaqubv3f6wqo6+B4Dp/xetSzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pySViAV4ADvnhaXtB6RJeOBr0xnTNNsj//jOhEoXq0KWG53EpkKSF3ZsZqAVkuWfP
         5vrW+3oRtuWzhzb0vTgHyWpz8jaEMy4HVNxZjVfmGdBKz9G3icd1o5V+n+gRdcDGEq
         3+o7bSoSDj67tqW1j4wSGeljXiSsncaaYEoZ+8kxtd7teThMqdJWan1mLDkAlmzJ5y
         PZzAtBXIvbC4zBWnzR0mFe26VO3WnJ/lnT1XFZHK0PlHzYou5F8kaoE3aJ7Q/HW/p5
         QMmbQ6eCuVwVrBXUcweRzSiFFpf3TfX/pbnZgHRMc3gNAwI89t6WYX+tJzHN+TTrkz
         MrIVdZTQEfiiw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 5/6] spmi: fix W=1 kernel-doc warnings
Date:   Thu, 13 Apr 2023 15:38:33 -0700
Message-ID: <20230413223834.4084793-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230413223834.4084793-1-sboyd@kernel.org>
References: <20230413223834.4084793-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix all W=1 kernel-doc warnings in drivers/spmi/:

drivers/spmi/spmi.c:414: warning: expecting prototype for spmi_controller_alloc(). Prototype was for spmi_device_alloc() instead
drivers/spmi/spmi.c:592: warning: expecting prototype for spmi_driver_register(). Prototype was for __spmi_driver_register() instead
drivers/spmi/spmi.c:592: warning: Function parameter or member 'owner' not described in '__spmi_driver_register'
drivers/spmi/spmi-pmic-arb.c:155: warning: cannot understand function prototype: 'struct spmi_pmic_arb '
drivers/spmi/spmi-pmic-arb.c:203: warning: cannot understand function prototype: 'struct pmic_arb_ver_ops '
drivers/spmi/spmi-pmic-arb.c:219: warning: expecting prototype for struct pmic_arb_ver. Prototype was for struct pmic_arb_ver_ops instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20230113064040.26801-1-rdunlap@infradead.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 4 ++--
 drivers/spmi/spmi.c          | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 42a593418aad..dcb675d980d4 100644
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
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 73551531ed43..5705151013b3 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -404,7 +404,7 @@ struct spmi_device *spmi_device_from_of(struct device_node *np)
 EXPORT_SYMBOL_GPL(spmi_device_from_of);
 
 /**
- * spmi_controller_alloc() - Allocate a new SPMI device
+ * spmi_device_alloc() - Allocate a new SPMI device
  * @ctrl:	associated controller
  *
  * Caller is responsible for either calling spmi_device_add() to add the
@@ -582,8 +582,9 @@ void spmi_controller_remove(struct spmi_controller *ctrl)
 EXPORT_SYMBOL_GPL(spmi_controller_remove);
 
 /**
- * spmi_driver_register() - Register client driver with SPMI core
+ * __spmi_driver_register() - Register client driver with SPMI core
  * @sdrv:	client driver to be associated with client-device.
+ * @owner:	module owner
  *
  * This API will register the client driver with the SPMI framework.
  * It is typically called from the driver's module-init function.
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

