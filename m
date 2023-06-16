Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4FD732F84
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344689AbjFPLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjFPLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66BD123;
        Fri, 16 Jun 2023 04:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D85861953;
        Fri, 16 Jun 2023 11:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9017DC433D9;
        Fri, 16 Jun 2023 11:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686913888;
        bh=Ftk0WF86ozAqY4du7Rc1mCnsDAhs3ihEXWlxhT5nDCk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JMPyp1aj9iCRUynI80EGNmIWv+gacTMO/eXGjFaYf2oxt/NNyFIDF9UiyC51ZaCNP
         hbUbdjNuXsjd8RgV12wIt7WobVpKwqOSWEcIlvX2rsil5p9VBEF+2gf24fXhlJxhN7
         IsznWy4XE3yf+LpQmYSIxIXvP7fEVin2cpDA2PaFtPpyHszf+XwDAYGNTdbuHmRsNC
         aA3NF2oNpSoroqgd7zL1KnzVl1XkiJ7kcjSNj2WGrEpiLvOd5685qg2hZgONj4g3y3
         ywpqZOsRhCLiUmae+4ldVRWbXWejzGFpdQkf7Q2w1OuOe8aaP3b/8cppjZt35iz5QW
         TobULJ3yGfhtw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 16 Jun 2023 13:11:21 +0200
Subject: [PATCH 1/2] arm64: defconfig: enable SL28VPD NVMEM layout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-feature-sl28-vpd-dt-v1-1-c5458016ba85@kernel.org>
References: <20230616-feature-sl28-vpd-dt-v1-0-c5458016ba85@kernel.org>
In-Reply-To: <20230616-feature-sl28-vpd-dt-v1-0-c5458016ba85@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kontron sl28 board is supported upstream and also tested in the
KernelCI. Enable support for its VPD EEPROM where the base ethernet
address is stored.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57c6b7bb88d4..6339d081d863 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1405,6 +1405,7 @@ CONFIG_QCOM_L3_PMU=y
 CONFIG_ARM_SPE_PMU=m
 CONFIG_ARM_DMC620_PMU=m
 CONFIG_HISI_PMU=y
+CONFIG_NVMEM_LAYOUT_SL28_VPD=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_NVMEM_LAYERSCAPE_SFP=m

-- 
2.30.2

