Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31F6BB4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjCONnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCONmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:42:45 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770D89F0B;
        Wed, 15 Mar 2023 06:42:44 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 7CE0240016;
        Wed, 15 Mar 2023 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678887762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErIeGZOdBC0SggTn7/aNvCYajOT8ftQ+YUi6Mg1r8hk=;
        b=Z5VllREub8q03kyXMToln2CZgjEQsHhknoySCVz3SVeEJlubW9XbLJgNKsShbjLXTygxUz
        gLMo5OgIh8LdLY5f/ybH7ELQ+tJRPU+JEmegMOpgqKYy+PnrR5Yk46HZ531k0BUug+QsaN
        B68pZdiG/sh0KyYxn3bobQe6yvFFaQqoPBj+Q9uzDCiPbpDqveXrwv1iLLwkXeDU7Ofxuq
        BMsO0KQVgzyYOGbnwwUnmta60ycSNFLAPp1qqFd2/kR0EvFc4cC1oEht8U0O46azIAsgbn
        y8ty+tCryuEVuhSZMnXAnraiE1YVKnfimGW3/lvWfBBotXFCB4mBl58npwoPrw==
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
Subject: [PATCH 3/7] Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
Date:   Wed, 15 Mar 2023 14:42:27 +0100
Message-Id: <20230315134231.233193-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315134231.233193-1-herve.codina@bootlin.com>
References: <20230315134231.233193-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "subordinate" sysfs attribute exposed by the pef2256
driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../ABI/testing/sysfs-bus-platform-devices-pef2256     | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256 b/Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
new file mode 100644
index 000000000000..b2343b3b6e84
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
@@ -0,0 +1,10 @@
+What:		/sys/bus/platform/devices/*.pef2256/subordinate
+KernelVersion:	6.4
+Contact:	Herve Codina <herve.codina@bootlin.com>
+Description:
+		(RW) Controls whether the PEF2256 works as subordinate or main
+		device mode.
+		  - 0 : main device mode
+		  - 1 : subordinate mode
+		In subordinate device mode it synchronizes on line interface
+		clock signals. Otherwise, it synchronizes on internal clocks.
-- 
2.39.2

