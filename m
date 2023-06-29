Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F4A742D24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjF2TGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjF2TDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DBB3C2B;
        Thu, 29 Jun 2023 12:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91651615FF;
        Thu, 29 Jun 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9A4C433CB;
        Thu, 29 Jun 2023 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065322;
        bh=qOWJR5B/v04A70X7Ke3al4vL7mXxqeyOb4QdNArum5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICEzBwwJ337bKFKkuSPegSxdqlpm7yMXqJNlMw/d2wHv9LF+wNZeu/D/FUzFyqQ4U
         XeoDcuMd8dBDj6XW1tuAh4+bnKz0RubG/h8desWdJ7jGV5KuChy0rPn/z1Jou1vLf6
         uh8g5CmePCk79tnSMA8w9spPjhYVAEgoPvWx5KzZCvq0m3YBgqHFnT54i4+eOB7SXd
         TyT1j4OYHTjW/ri/sMdCjd+VyN2U1gYXCwqtjF+ezDjWFrGJ4jwAgBJ+TpGe3ahGu0
         2dOugN/bYyp5poyL8LKNr/bn/4fD9eMUIz5BBqlfHVJRgNTZYaKV9XtxLIILImUaFH
         8eKa8aYAijilQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, shangxiaojing@huawei.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/5] nfc: fdp: Add MODULE_FIRMWARE macros
Date:   Thu, 29 Jun 2023 15:01:54 -0400
Message-Id: <20230629190158.908169-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190158.908169-1-sashal@kernel.org>
References: <20230629190158.908169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.118
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juerg Haefliger <juerg.haefliger@canonical.com>

[ Upstream commit eb09fc2d14163c0c217846cfabec3d0cce7c8f8c ]

The module loads firmware so add MODULE_FIRMWARE macros to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/fdp/fdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index f12f903a9dd13..da3e2dce8e70a 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -762,3 +762,6 @@ EXPORT_SYMBOL(fdp_nci_remove);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("NFC NCI driver for Intel Fields Peak NFC controller");
 MODULE_AUTHOR("Robert Dolca <robert.dolca@intel.com>");
+
+MODULE_FIRMWARE(FDP_OTP_PATCH_NAME);
+MODULE_FIRMWARE(FDP_RAM_PATCH_NAME);
-- 
2.39.2

