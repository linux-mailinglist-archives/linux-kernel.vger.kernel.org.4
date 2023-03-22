Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B983F6C4C33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCVNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCVNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:47:19 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46AE59E4D;
        Wed, 22 Mar 2023 06:47:17 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 643C82000B;
        Wed, 22 Mar 2023 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679492836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljp6n86BBDdKFokTOsmxWo1ozVvBJ/tB3FyqHD6++5I=;
        b=Fg0PfZiO6+SvqLK60MNzcOq+1GxS7YPXY7RbHleyQcDjfO+4mfXRFQ5RjVk3lAHEk4w0vz
        y26yvErwl2gAtypyh9vX99XJO6N+4vA31L1iLOqTJNi0RClMtzGkjjXsqgC6bifo2lVmVq
        2e7MFaif6wzg4duTy0o7XrVR+3L9LT9pe+FFCsvWBaETE5nZtB5QkduoquvJl9mXFda2cg
        Re+kmXO+g6y208ssvmKuQC2c+Fi7dZDzRBplqZeVXzTqMcVV+CgstImA4j6z/wpqNDHxhm
        cLK9noplyUSuJfDCIcoucBHJZwLZY21DT8b1Dy0snTKpgHD7x+BBXhVM2xjjQg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 3/6] Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
Date:   Wed, 22 Mar 2023 14:46:51 +0100
Message-Id: <20230322134654.219957-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322134654.219957-1-herve.codina@bootlin.com>
References: <20230322134654.219957-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "subordinate" sysfs attribute exposed by the PEF2256
driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../ABI/testing/sysfs-bus-platform-devices-pef2256   | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256 b/Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
new file mode 100644
index 000000000000..95ba1ae55daf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
@@ -0,0 +1,12 @@
+What:		/sys/bus/platform/devices/*.pef2256/subordinate
+KernelVersion:	6.4
+Contact:	Herve Codina <herve.codina@bootlin.com>
+Description:
+		(RW) Controls whether the PEF2256 works as subordinate or main
+		device mode.
+
+		- 0: main device mode
+		- 1: subordinate mode
+
+		In subordinate device mode it synchronizes on line interface
+		clock signals. Otherwise, it synchronizes on internal clocks.
-- 
2.39.2

