Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D464DA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLOLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiLOLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:31:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A5416496
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:31:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E251FB81B75
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C145AC433EF;
        Thu, 15 Dec 2022 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671103896;
        bh=X2v6sbJyFRIO6ksfpigV6X1MWvpAHT7QZPEinM8yxBw=;
        h=From:To:Cc:Subject:Date:From;
        b=iDLjJD7wReFdUGsRiL3DivBROfEi1WSEyWZ6pdDCKUyhxZwgn02zxVx5Or1J8Pc71
         8utbq4hodZNrQ8/2aGOnjKVlkcn9buQYz7A5i1KMkF7HPbOQ303aQg50BxGFtLKDUh
         D0RiT9UOPKpeGvO0nF9etNGw+ZjUGVxLPhs3QQXYc00T7QyqcJyjDJ2WsFtfYvlLYl
         ykx3/APtRdWKVAByTVzqNLEw0d1L79TK0s/pdJO058jeiu4/3DHi6WfUA6oYnWBy9u
         YgIGmBE9tMI57AAEPq9Z3q9IVVw+rU1VX6MKPhIoGJkboAmGNyQwyJSjXPDHlmEBfB
         K/+DJpj6lUSWg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/3] habanalabs: fix asic-specific functions documentation
Date:   Thu, 15 Dec 2022 13:31:29 +0200
Message-Id: <20221215113131.2276739-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

- Add missing documentation of set DRAM props
- fix typo

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e5443bf7fe12..210dd607e18b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1544,8 +1544,9 @@ struct engines_data {
  * @check_if_razwi_happened: check if there was a razwi due to RR violation.
  * @access_dev_mem: access device memory
  * @set_dram_bar_base: set the base of the DRAM BAR
- * @set_engine_cores: set a config command to enigne cores
+ * @set_engine_cores: set a config command to engine cores
  * @send_device_activity: indication to FW about device availability
+ * @set_dram_properties: set DRAM related properties.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
-- 
2.25.1

