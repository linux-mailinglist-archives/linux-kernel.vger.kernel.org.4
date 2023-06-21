Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE87378FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjFUCRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFUCQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:16:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF967A4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:16:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L2GgW4068718;
        Tue, 20 Jun 2023 21:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687313802;
        bh=dXBe/TODE3wSxxo+LNZlnbm2tKtdfwjvh3g4v/xg8+o=;
        h=From:To:CC:Subject:Date;
        b=nE/2kGn6drjQ19VeMsJLm9X5tNVbtpmJMVMGSHjUXVqUk0jU82pzoPxq4n8EqUFzG
         jHreb18Qe3SQTpX5O04nZL5gMI9E4x7gcjydZoNqpXax1A4peL50alpU7AsT6GqFpY
         YM5KtE0LzqYO1FKi+t4idYS4PD6zW3P76SpMTtPI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L2GgWX028180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 21:16:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 21:16:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 21:16:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L2GfWE078456;
        Tue, 20 Jun 2023 21:16:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] firmware: ti_sci: Fixup documentation errors
Date:   Tue, 20 Jun 2023 21:16:19 -0500
Message-ID: <20230621021619.265162-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up documentation errors, squashes the following warnings:
drivers/firmware/ti_sci.c:1986: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_set_irq'
drivers/firmware/ti_sci.c:2034: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_free_irq'
drivers/firmware/ti_sci.c:2630: warning: Function parameter or member 'bootvector' not described in 'ti_sci_cmd_proc_set_config'
drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'bv' not described in 'ti_sci_cmd_proc_get_status'
drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'cfg_flags' not described in 'ti_sci_cmd_proc_get_status'
drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'ctrl_flags' not described in 'ti_sci_cmd_proc_get_status'
drivers/firmware/ti_sci.c:2746: warning: Function parameter or member 'sts_flags' not described in 'ti_sci_cmd_proc_get_status'
drivers/firmware/ti_sci.c:2746: warning: expecting prototype for ti_sci_cmd_get_boot_status(). Prototype was for ti_sci_cmd_proc_get_status() instead
drivers/firmware/ti_sci.c:3265: warning: Function parameter or member 'sub_type' not described in 'devm_ti_sci_get_resource'
drivers/firmware/ti_sci.c:3265: warning: Excess function parameter 'suub_type' description in 'devm_ti_sci_get_resource'

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/firmware/ti_sci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 91aaa0ca9bde..26a37f47f4ca 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1976,8 +1976,6 @@ static int ti_sci_free_irq(const struct ti_sci_handle *handle, u32 valid_params,
  * @src_index:		IRQ source index within the source device
  * @dst_id:		Device ID of the IRQ destination
  * @dst_host_irq:	IRQ number of the destination device
- * @vint_irq:		Boolean specifying if this interrupt belongs to
- *			Interrupt Aggregator.
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
@@ -2024,8 +2022,6 @@ static int ti_sci_cmd_set_event_map(const struct ti_sci_handle *handle,
  * @src_index:		IRQ source index within the source device
  * @dst_id:		Device ID of the IRQ destination
  * @dst_host_irq:	IRQ number of the destination device
- * @vint_irq:		Boolean specifying if this interrupt belongs to
- *			Interrupt Aggregator.
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
@@ -2618,6 +2614,7 @@ static int ti_sci_cmd_proc_handover(const struct ti_sci_handle *handle,
  *				    configuration flags
  * @handle:		Pointer to TI SCI handle
  * @proc_id:		Processor ID this request is for
+ * @bootvector:		Processor Boot vector (start address)
  * @config_flags_set:	Configuration flags to be set
  * @config_flags_clear:	Configuration flags to be cleared.
  *
@@ -2734,9 +2731,13 @@ static int ti_sci_cmd_proc_set_control(const struct ti_sci_handle *handle,
 }
 
 /**
- * ti_sci_cmd_get_boot_status() - Command to get the processor boot status
+ * ti_sci_cmd_proc_get_status() - Command to get the processor boot status
  * @handle:	Pointer to TI SCI handle
  * @proc_id:	Processor ID this request is for
+ * @bv:		Processor Boot vector (start address)
+ * @cfg_flags:	Processor specific configuration flags
+ * @ctrl_flags:	Processor specific control flags
+ * @sts_flags:	Processor specific status flags
  *
  * Return: 0 if all went well, else returns appropriate error value.
  */
@@ -3254,7 +3255,7 @@ EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
  * @handle:	TISCI handle
  * @dev:	Device pointer to which the resource is assigned
  * @dev_id:	TISCI device id to which the resource is assigned
- * @suub_type:	TISCI resource subytpe representing the resource.
+ * @sub_type:	TISCI resource subytpe representing the resource.
  *
  * Return: Pointer to ti_sci_resource if all went well else appropriate
  *	   error pointer.
-- 
2.40.0

