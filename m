Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB886CBA92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjC1J1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjC1J07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:26:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F375FC6;
        Tue, 28 Mar 2023 02:26:58 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 090561BF209;
        Tue, 28 Mar 2023 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679995617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljp6n86BBDdKFokTOsmxWo1ozVvBJ/tB3FyqHD6++5I=;
        b=MMe/U0mBt/OXx51JoieXSTGNsCN5fWAzM855VuqKQmzt//FwMUXVjMVMtVzu98EblOGcgf
        M5DG7qWloq4dQCs0iYd8rs0ad1QXYmR498DSFphLPMzb1POFTjqAvdsXzJ5l4qhAJwyke3
        Tp1Yt0e8cdJ9pBdhjqlN4KVdkO7fs8J/iwfbnTERf8+CAiF2PqSkz+aT+fOZ0Eazt7YN5f
        KYq1Yht7GaBCrCm1DuG8a0hqqVaOE9v1mtK/E+1XJkfv+YVIdrp5Drq44R6BwHLdHsNiM2
        TQg9MTdR9QkujKp6x58NDktIXG+UN5qO9HkCmFMAmx6WTyjnbVmGJHhO2l/idg==
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
Subject: [PATCH v5 3/5] Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
Date:   Tue, 28 Mar 2023 11:26:43 +0200
Message-Id: <20230328092645.634375-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328092645.634375-1-herve.codina@bootlin.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

