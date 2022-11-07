Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F061F457
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiKGN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKGN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:29:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C851CB28;
        Mon,  7 Nov 2022 05:29:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id sc25so29998146ejc.12;
        Mon, 07 Nov 2022 05:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDq+dF/YTBWalc8Ldtbu93f8AMlelceS56nsDHxpWFY=;
        b=AN7WfcRNngvJVDPpT0OecabQU542LiG7ZfGJ3aRwjFuTIlK2vHkwGk84ZkAYjHJK5q
         DX+wo9NFVOtMc5YMUfz1m8AmjbFl6mfslo3w57e8nHieYGwLGgIT2N7iaOaQa2IyKVF7
         GLsRQQb6Earm+QlBMfoRoo53azeVbNRR2/p1ntWnVDFbdFSRpvkkxHF/ngKPrdJYRtTa
         A1UutbAtAsWR9/Ro2eYmZ722gRT1rxa5zD5gHMFzDVeEme7idVKxXXiTskr9XQ1+SZxE
         7XbORXZ1/PNFW08JnUNRLH5a3mqtwc8kMsmajR0fgUzODDlD79oLyU+v7efol0d5q2ie
         ihMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDq+dF/YTBWalc8Ldtbu93f8AMlelceS56nsDHxpWFY=;
        b=LhwICmhqW5MoKX272ytSGR5d+mG6m7L0xNvEa8aZZRz8oVjWISDtRn1TEAxgCW/0k3
         uUv1nxbLUh9xnzUvRc9h49G8opkOIK5I1nFQCBJLJ5vJ1rH/C0dK1jxSxICixP0g6BG0
         Fs4qUbzr54JDJji6psjTqp2afTRbAAQytbp+H0UoB7ZSkaTM4WV5Kle7InaxFsxQYk7y
         XmqZT/o4xyOQIXXOjj15+PMu/Z84fZwM7ibtBZqpnhVbpTz8kBL+8SNCKWol/jwyPgwN
         sFnIHBWeZ8o9WSbDXDwZzZC6xLiYRn0UgUc5GQTO0Zryj5LdHw+3DZyHI8AvsUzFbY+f
         oCEw==
X-Gm-Message-State: ACrzQf0g1MV7uNhvSbgSzO8sxyamyVb+pwLLBt6ukZsbWX7EptKmajqJ
        42/G4hJZXtJ16jkQG1dOeCo=
X-Google-Smtp-Source: AMsMyM50xw5FgmSWx6+qGInHwOD7WrjtxwN78sUG7ovQeIJVMTjaYTUU2cS0rRbrUefXygE7Dds4JA==
X-Received: by 2002:a17:907:6a09:b0:7ae:2793:aa23 with SMTP id rf9-20020a1709076a0900b007ae2793aa23mr19134094ejc.184.1667827745265;
        Mon, 07 Nov 2022 05:29:05 -0800 (PST)
Received: from fedora.. (dh207-98-26.xnet.hr. [88.207.98.26])
        by smtp.googlemail.com with ESMTPSA id ky14-20020a170907778e00b0073c8d4c9f38sm3446037ejc.177.2022.11.07.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:29:04 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/3] dt-bindings: clock: qcom: ipq8074: add missing networking resets
Date:   Mon,  7 Nov 2022 14:29:00 +0100
Message-Id: <20221107132901.489240-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107132901.489240-1-robimarko@gmail.com>
References: <20221107132901.489240-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the missing networking resets found in IPQ8074 GCC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq8074.h b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
index e4991d303708..f9ea55811104 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq8074.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
@@ -367,6 +367,20 @@
 #define GCC_PCIE1_AHB_ARES			129
 #define GCC_PCIE1_AXI_MASTER_STICKY_ARES	130
 #define GCC_PCIE0_AXI_SLAVE_STICKY_ARES		131
+#define GCC_PPE_FULL_RESET			132
+#define GCC_UNIPHY0_SOFT_RESET			133
+#define GCC_UNIPHY0_XPCS_RESET			134
+#define GCC_UNIPHY1_SOFT_RESET			135
+#define GCC_UNIPHY1_XPCS_RESET			136
+#define GCC_UNIPHY2_SOFT_RESET			137
+#define GCC_UNIPHY2_XPCS_RESET			138
+#define GCC_EDMA_HW_RESET			139
+#define GCC_NSSPORT1_RESET			140
+#define GCC_NSSPORT2_RESET			141
+#define GCC_NSSPORT3_RESET			142
+#define GCC_NSSPORT4_RESET			143
+#define GCC_NSSPORT5_RESET			144
+#define GCC_NSSPORT6_RESET			145
 
 #define USB0_GDSC				0
 #define USB1_GDSC				1
-- 
2.38.1

