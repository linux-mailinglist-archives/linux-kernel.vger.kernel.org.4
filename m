Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BFD61873A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiKCSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKCSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:14:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C1E9A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:14:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so4030088wrh.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6hhL5GxIS1yjY3POlwZsM8aoTUAuZ47cuFDJDrJL5Y=;
        b=KpECKZWYr1Pfkjds8bjb14vOksU3z4OFIaWUS0p8CgPz9tnAlQ5u+VaGM4m+hnipXP
         +hWlvVPAHijvGM7YZ6YWBowC+cEvoZNtTSHW+yBNifNaucSY3WsqkL3gqjFIu9usrTyA
         IVUmmuE1XBmCQeLQIUogyiR5jHlRt51TwAMYGIQGE9VTvJzCdqQcxujbYP33uj+qp9rv
         F/DVBc0VUnFLgMYzd9c474MtIuW6+f8ZgLI0BNnJ6Kge2rthtmecwlWRc0+v/9QcCc94
         rBBFoWCw2uxx3OvvG2qHwGCaoBQO1/+Iyq0xOzasKULxm1k4f9BjiqdkS1BShUZBAajI
         AF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6hhL5GxIS1yjY3POlwZsM8aoTUAuZ47cuFDJDrJL5Y=;
        b=3YJZLOHWV35u0lLgb83F+UXBG1u0Knve5wnSLQNZ6W6pk3+35JE54Nb9hkmSqLsyJe
         X0XmYmmIeEnZwSCnogqsQF9ImI6utE4TzCHr3ny1oCRcV6O2hzKSetPqB/tA2tbu+oFH
         lzKoKu8u4pMgwF9NFsiU+Sfi14ObpeaDa0s2DJcs28+H4RCZuXnVsTqy2BNomSDQl5mJ
         LSWpdaUYwRSSbYRWLgxO9yglc69O0m2aAJpWqkU5aoxrnn5aKzgqHgZ8D9pYGLRNSISi
         mJLh6/3m5f0f+li06424TO23Bl7rA2+93iFPiZLdXx4i12W9XrEgDX5HzPZsrOaur4TS
         OZog==
X-Gm-Message-State: ACrzQf0yd76KVLnDqfBsdaTjQ12s+ekxpDMcdtT/pJrZXyiUD1+GqspZ
        uCh0A37DHf1U1y2FDYBhLf30Uw==
X-Google-Smtp-Source: AMsMyM6A59P+5L8H/5onl312fdenxAsd5yNZGji1De+dfUTDdzY/4joKhPo61XSLfkZn6+IZBMhOtw==
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id g12-20020adfd1ec000000b00236880f2adfmr20021410wrd.617.1667499285227;
        Thu, 03 Nov 2022 11:14:45 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (254.31.102.84.rev.sfr.net. [84.102.31.254])
        by smtp.gmail.com with ESMTPSA id h19-20020a1ccc13000000b003b49ab8ff53sm639212wmb.8.2022.11.03.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:14:44 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: mark MCU and WKUP watchdogs as reserved
Date:   Thu,  3 Nov 2022 19:14:40 +0100
Message-Id: <20221103181440.232727-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103181440.232727-1-jpanis@baylibre.com>
References: <20221103181440.232727-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCU wdt is typically used by M4F.
Wake up wdt is typically used by DM (R5) firmware.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 93a5f0817efc..9ade591ef563 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -503,6 +503,16 @@ &main_mcan0 {
 	status = "disabled";
 };
 
+&mcu_rti0 {
+	/* MCU RTI0 is used by M4F firmware */
+	status = "reserved";
+};
+
+&wkup_rti0 {
+	/* WKUP RTI0 is used by DM firmware */
+	status = "reserved";
+};
+
 &epwm0 {
 	status = "disabled";
 };
-- 
2.37.3

