Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1C76AC938
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCFRGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCFRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:06:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A482ED70
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:05:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DEEEB80EC2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D6DC433D2;
        Mon,  6 Mar 2023 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678122347;
        bh=Co92hpAVMlgBOmR5hA65uy5h05hdlthpq3qPqXsKyEg=;
        h=From:Date:Subject:To:Cc:From;
        b=XHDcSY6escgseT2VHhy5KBymKxWYu1vh/Swa3Ni53WQVO4NIBl0+FQ8pDVcfDsCeF
         h5nORZX+qmtDHfmJvnAwUwXEGRJxCDaKmazoEQtP4LY07+uIN/qd5QUhkRFR0eAn5n
         GoLhRtkgpJ8KLf3REmXF6iUq8Q8VpN8t6cZ74X05lV1/+kfQ+UyKHHO4kgyql4ldti
         v5h+uugKtnahoQRnAqE7mEduDw5ZJQ1WyN+9jMvVMxhC4KGgFtbmiiIafAWQ3jwHfP
         D0bCQwim3hQVJqRctVFqTdAoBIvi4vWSRVOLeTDXfGmrgwY4oCO4pif6QUR+dd5zGv
         CtvO+ZCzIN+EA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 17:05:35 +0000
Subject: [PATCH] phy: xgene: Depend on ARCH_XGENE rather than plain arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-phy-build-deps-v1-1-7091bcbd16b0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF4dBmQC/x2NywrCQAwAf6XkbCBdi6K/Ih72Ed2gbJeEqqX03
 7v1OAPDLGCswgbXbgHlj5iMpUF/6CBmX56MkhqDI3ck53qsecYwyTth4mp4PhE5SpeB4gAtCt4
 Yg/oS8559R33tuio/5Pf/3O7rugH/ojXIdwAAAA==
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Co92hpAVMlgBOmR5hA65uy5h05hdlthpq3qPqXsKyEg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBh1oUJDveQFe6Wogi93Pxnal4K2K87wkzdDnPgio
 gfPtyrqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAYdaAAKCRAk1otyXVSH0ANCB/
 0QLCg/luyzP39lzGYdJEFAzJLmIoe7sb+FyMPHoM4jtIJVueM2XKMtHEC9WOY8Xslo04d12mRtf95J
 Mb2BadxWKtg8fevAvlRyGcZo8fjMPS6ktXFNgoqUP9ftZsh3JuZaQbtRc7JuCgOUxhzWy2iU/3gLQ+
 Hh7haWz0DJWHYvC0UAKyxUCCs5JB3XE89oF7vgy/q3mVUNtjGuPIQCO3HvByv31y+XqxSoJGJeVvOp
 D8JmQEQ+pN9nGFuFsHmkz84HMFxgMMtwQuJSo2E0UxZeCsxGUMkbojHyt4log5DfOmPi4pH7bwRBbn
 FG7DvD8gp5+7kW5G4+jLXZSqQRkGTz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X-Gene PHY driver is unlikely to be useful on a kernel without general
X-Gene support enabled but currently only depends on arm64 rather than the
specific platform support. Narrow the dependency to ARCH_XGENE like we do
for other X-Gene specific drivers to ensure that users who have configured
down the set of platforms enabled don't see the option.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 7bd00a11d074..f46e3148d286 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -44,7 +44,7 @@ config PHY_PISTACHIO_USB
 
 config PHY_XGENE
 	tristate "APM X-Gene 15Gbps PHY support"
-	depends on HAS_IOMEM && OF && (ARM64 || COMPILE_TEST)
+	depends on HAS_IOMEM && OF && (ARCH_XGENE || COMPILE_TEST)
 	select GENERIC_PHY
 	help
 	  This option enables support for APM X-Gene SoC multi-purpose PHY.

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230221-phy-build-deps-760020d940c4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

