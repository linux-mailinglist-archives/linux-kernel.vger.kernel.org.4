Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9475082D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjGLMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjGLMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:25:49 -0400
X-Greylist: delayed 562 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 05:25:45 PDT
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EBE77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:25:44 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1689164175; bh=+zOGmx788boa/WYXZXSHp10404gZAezs3tbSbvOFB78=;
        h=From:To:Cc:Subject:Date;
        b=BF176sWh4JM2x4jua53SLTlTaPARQF0ojuXmYrv9uAmkjpOYD5SEQjqgqBUdRa7k+
         UfVMB8eg56f96s9vLZ8J8Ook3eMiAZ1GbuCV5ENtGFG/ySGPUb5EfePufHvt05BauU
         MTIXM46AYN89Tg6O68FePXWW6Zgmc9R7Q8eRZsYo=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH] MAINTAINERS: Redo addition of ssm3515 to APPLE SOUND
Date:   Wed, 12 Jul 2023 14:15:56 +0200
Message-Id: <20230712121556.93500-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAINTAINERS entries added in commit 4ac690bbae02 ("ASoC: ssm3515:
Add new amp driver") were later erased in a merge commit. Re-add those.

Cc: Mark Brown <broonie@kernel.org>
Fixes: af53b00fa3ac ("Merge tag 'v6.4-rc2' into asoc-6.5 to get fixes for CI")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..be7e662c653b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1865,9 +1865,11 @@ M:	Martin Povišer <povik+lin@cutebit.org>
 L:	asahi@lists.linux.dev
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
 F:	Documentation/devicetree/bindings/sound/apple,*
 F:	sound/soc/apple/*
 F:	sound/soc/codecs/cs42l83-i2c.c
+F:	sound/soc/codecs/ssm3515.c
 
 ARM/APPLE MACHINE SUPPORT
 M:	Hector Martin <marcan@marcan.st>
-- 
2.38.3

