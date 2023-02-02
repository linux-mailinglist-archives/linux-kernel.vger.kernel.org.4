Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB95688379
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjBBP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjBBPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719F45CE68;
        Thu,  2 Feb 2023 07:54:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8A14B826F2;
        Thu,  2 Feb 2023 15:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F22AC43616;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353285;
        bh=Vi//U5VEBM3SVbBW52EARl3dF8z9tulSGPpETR9FMoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHtvX4sRJDJsFyBjP3LZJua4BAxkN89xd/tqw0tt/LN+lZTai9x5PVvGh0Vel6rLr
         U50sAXtIMonRs1iBr+IHSPYf+GovMIEHnmIXEUkNNuBjyGgmpJ2XOVUkQbk83E1AH2
         VEintzXCjNnZgJ9kX1+vqI7nZ5IgvUgGt3aD5HoCHCEKVD/0z674OQ3sJs2Y7rU9Ho
         T7o9yZJFqdYT1hEPMmHK/NvlyejmIEagTrM7Q77Pl4bcNMPbaCzpw53M6Qz90/gYcD
         w9fx3V0U7OXFkW9LDnAKgF8MwtjRL4ccwTgcRL5IYLhz35Foj83hniFXKvu6CSS3F7
         BzQOGr5DK6PwA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbva-0001mX-38; Thu, 02 Feb 2023 16:55:10 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 18/22] arm64: defconfig: enable Qualcomm SDAM nvmem driver
Date:   Thu,  2 Feb 2023 16:54:44 +0100
Message-Id: <20230202155448.6715-19-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
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

The SDAM nvmem driver can be used to access the Shared Direct Access
Memory Module registers in some Qualcomm PMICs.

These registers can specifically be used to store a time offset on
platforms where the PMIC RTC time registers are read-only in order to
allow the RTC time to be updated.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a17cbdac1904..b3f714ff4006 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1308,6 +1308,7 @@ CONFIG_NVMEM_MTK_EFUSE=y
 CONFIG_NVMEM_QCOM_QFPROM=y
 CONFIG_NVMEM_ROCKCHIP_EFUSE=y
 CONFIG_NVMEM_SNVS_LPGPR=y
+CONFIG_NVMEM_SPMI_SDAM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_UNIPHIER_EFUSE=y
 CONFIG_NVMEM_MESON_EFUSE=m
-- 
2.39.1

