Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6555BFFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiIUOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:33:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 716AA2714;
        Wed, 21 Sep 2022 07:32:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC90913D5;
        Wed, 21 Sep 2022 07:33:05 -0700 (PDT)
Received: from usa.arm.com (unknown [10.162.46.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8ADC03F73B;
        Wed, 21 Sep 2022 07:32:56 -0700 (PDT)
From:   Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, thomas.abraham@arm.com,
        vijayenthiran.subramaniam@arm.com
Subject: [PATCH v2] ACPI: amba: Add Arm DMA-330 controller to the supported list
Date:   Wed, 21 Sep 2022 20:02:44 +0530
Message-Id: <20220921143244.16282-1-vijayenthiran.subramaniam@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI ID for ARM DMA-330 controller to AMBA id supported list to
allow the probing of the device.

Signed-off-by: Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>
---
 drivers/acpi/acpi_amba.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index ab8a4e0191b1..b89120196af1 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -21,6 +21,7 @@
 
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
+	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
 	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
 	{"ARMHC501", 0}, /* ARM CoreSight ETR */
 	{"ARMHC502", 0}, /* ARM CoreSight STM */
-- 
2.17.1

