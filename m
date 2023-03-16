Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403736BCF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCPM2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCPM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:28:06 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF87BDD1D;
        Thu, 16 Mar 2023 05:28:01 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 8EA8D1BF20A;
        Thu, 16 Mar 2023 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678969680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQuTmgHRjRFeVd5utxFMcX2f7ahQxt0Yf7fzkOvSL4U=;
        b=XlvvnEOoGbAQp/kgbsNGLPXN5qwehm78P0izYTPZGX0Lio9E58CEHezAqmbc6e2PLqATIg
        Gx/3dG9uKoM9gYufFLOf5ASyi0aISmYK3WOotEJUhWhUzDoe3zMZm8WKyI5cPy7/D+dmIF
        VoACc0zs5e4mbII0h09LJ8yWevkVcl/zCGNsVwC5qHpqNme/z6HxDZCB8B0GaITpvC+/8a
        HU9FUzCFRfm2BtXWJYejAPzhWjIcCAgU2xSIfC/Oepm9xvrHg767j53In0RJyYgQhQ4DRN
        YfazEGxb1zKOMeSUlnPwB+D/EhhlQrzyvpH011OGu9vdqlmoLDmNOo6CQ7+lSA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 3/7] Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
Date:   Thu, 16 Mar 2023 13:27:37 +0100
Message-Id: <20230316122741.577663-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316122741.577663-1-herve.codina@bootlin.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "subordinate" sysfs attribute exposed by the pef2256
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

