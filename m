Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E13693E40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBMG1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMG1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:27:03 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E09B476;
        Sun, 12 Feb 2023 22:27:02 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so4941036pjd.1;
        Sun, 12 Feb 2023 22:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5ZtF2KqwWRhAKLuTZEMSSTu2+eVtRmd9Zd1nxNogWI=;
        b=ljzjL29mBMyAM3qrAdg8Bl0nAlOaIyy3rfXCgoA7S6PLtniN+7gW3TsXNSD8A5E92C
         GgWfsabQmZMAC6rAbN/MTa6iClJ/4a/2U+88wesTVK9wRoTwu1CtsDKwYfyZheBZY2pU
         m18RL1alkG1zrzPpf3JXQVlxv4djGO2vQgk8SpR9fb7UmSJBjPbu5mK7xkKslG4i90TD
         9btIkTBJv6eXBRjMphTTrzP8zoUl3CvmcIuI8ChwWaq/qKT1DUhnUqi43bQmCO4nWjLK
         pGjy0m4RdXShnNjBBqWDjVcPPMz+Gw+dIwSKH5O2taMMIogNLBMWdA9n48zLhEMBtqLQ
         xeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5ZtF2KqwWRhAKLuTZEMSSTu2+eVtRmd9Zd1nxNogWI=;
        b=6HMmmNRnJEU6VkAlXxxjdxcE5+xOr9kARoRDZB0K+Qnv9UHGO0ij+jV+wI/DBItdRh
         utIRd2yrwMJYNh3pX4PPUzNMsP7IuxUfuy+6qLpH4Z15ldw3xGHHC4FuDpdSz9qJqD7w
         Frr/izGjYqU5liKIQ2aCPkhQ3BDpr274RhNXO0/ObkNZhWQiRU7fjoVjWOhrvOSGnZfo
         Fv6w0m1cGlAGLi70dMb1RUOVNX6jj2ZimjsPH51xiU9Ao1DQFyJ8yJqZgA8nEu7B/QuS
         5o5kR1SBtgPoEAFwZnPlKgUWMy7lFeuEnHUZMLnlpNPnMVtFikn5kuKLiJAq8RCUf4R0
         qP6Q==
X-Gm-Message-State: AO0yUKXIgpP7wTlWbHItd17waTGlohz+ffZbHRyeY371kZPJc/5nZRLP
        ODbycaDyK5u6/ErAphtKYXx3Kdq/A7B0ng==
X-Google-Smtp-Source: AK7set/EgU3fIuA4nWHFdGB8/cgKYXFkQWSE//uU+pD1VoQqOnX6Htxy2o+EkwbE7Lk1Uvr5oFuP7g==
X-Received: by 2002:a17:902:ecc2:b0:19a:968d:2713 with SMTP id a2-20020a170902ecc200b0019a968d2713mr4842072plh.48.1676269622404;
        Sun, 12 Feb 2023 22:27:02 -0800 (PST)
Received: from localhost.localdomain ([103.135.103.93])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c15100b0019a70a85e8fsm5407466plj.220.2023.02.12.22.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 22:27:02 -0800 (PST)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     paulburton@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] MIPS: dts: Boston: Fix dtc 'pci_device_reg' warning
Date:   Mon, 13 Feb 2023 14:24:51 +0800
Message-Id: <20230213062451.1688755-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

dtbs_check currently complains that:
arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg):
/pci@14000000/pci2_root@0,0,0: PCI unit address format error,
expected "0,0"
The unit-address format should be '<device>,<function>'.
Fix the unit-address accordingly.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/mips/boot/dts/img/boston.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
index 84328afa3a55..72f7605d2e31 100644
--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -125,7 +125,7 @@ pci2_intc: interrupt-controller {
 			#interrupt-cells = <1>;
 		};
 
-		pci2_root@0,0,0 {
+		pci2_root@0,0 {
 			compatible = "pci10ee,7021";
 			reg = <0x00000000 0 0 0 0>;
 
-- 
2.25.1

