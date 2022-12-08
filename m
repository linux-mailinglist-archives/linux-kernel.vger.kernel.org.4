Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD076468B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 06:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLHFnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 00:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 00:43:42 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA1E56D60
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:43:34 -0800 (PST)
X-QQ-mid: bizesmtp62t1670478090t8q2wflu
Received: from localhost ( [202.85.220.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Dec 2022 13:41:26 +0800 (CST)
X-QQ-SSF: 0140000000200080B000B00A0000000
X-QQ-FEAT: 3M0okmaRx3gM4+7jki8+3gtus5Iib5lAeL2an5HRZtAr9vdO6JseNtEDerzBc
        XB0hrxR4b/vbucEu+rQrQdqWKQ/h5usG+LLRWHiLKNh7bozJ8n7EaEkmagjTCh853owUECO
        6Lpx6TuBHcg8bejUwoOOT2eFtF5tPF6A3TrKjKGfb7vZ92aCEokMmKtdh0smOWGVhOcjEu8
        BOd00k06ZgsPzH5VS05yYdUWb+R1BhNww9vfYJoZw6HpitBgHZkO7CkU7SOq9Zeqf4OeQzQ
        tu6ldk8jPlGJ7FETRZvR+afTvHMUV+Symulgp0BEAI5wkmyot3cnecKbEqqBcc+rPgefs5c
        lrpPQFUl7cfyZCCFzWLzEwwiDTOj0cXgHLvDunG
X-QQ-GoodBg: 2
Date:   Thu, 8 Dec 2022 13:41:26 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: add to support Phytium SoCs
Message-ID: <98DD627831B718EC+Y5F5BlamuRTaXc/T@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_NONE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a configuration option of ARM64 platform for Phytium SoC family.

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 76580b932e44..7e8b17855eb7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,6 +236,11 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_PHYTIUM
+        bool "Phytium SoC Family"
+        help
+          This enables support for Phytium ARMv8 SoC family.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.34.1

