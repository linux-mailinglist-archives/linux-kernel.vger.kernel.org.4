Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458B36082AE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJVAHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJVAG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:06:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061F46622;
        Fri, 21 Oct 2022 17:06:26 -0700 (PDT)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E8FE660281F;
        Sat, 22 Oct 2022 01:05:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666397125;
        bh=6+DWQ6D12NSOxQM77moNpvxny+57/A+nUvDMCeEUmOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/rbv30ITrs5oQT7ax46mLTvf5Sgmecz9O+jn2vAgvN36IZ1H3be48CwlOc0RnkVb
         xY30UzYmdj2ktoLMB/kJlAM0y49QcMFNMj/Vz/Kfe0Uu/dO5OcFF8dC99R9sL0k59z
         eqt0CRLqE5CshlDmA0l0mUQSOgtSMgQv0FVH/jcqLzb1AcB4OIiQXIPp0G60d5cmzO
         iJEmom3L8L3wtozyYDEx0Io0fglbGthxreV3s+9j0+XkMKgzduvhZPfY0tTN4/M8yy
         zOdRk24WmcVT6zTlpPcwf1hvDguLByUGFt7ABtQr0gjUgyi8/Lbw67WXvDTmOkgYcN
         9t8SqJjXOVOvQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
Subject: [PATCH v10 5/7] media: chips-media: wave5: Add TODO file
Date:   Sat, 22 Oct 2022 02:05:04 +0200
Message-Id: <20221022000506.221933-6-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221022000506.221933-1-sebastian.fricke@collabora.com>
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nas Chung <nas.chung@chipsnmedia.com>

Add a TODO file with remaining elements to be improved/added.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 drivers/staging/media/wave5/TODO | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 drivers/staging/media/wave5/TODO

diff --git a/drivers/staging/media/wave5/TODO b/drivers/staging/media/wave5/TODO
new file mode 100644
index 000000000000..6cc38d4ccbc9
--- /dev/null
+++ b/drivers/staging/media/wave5/TODO
@@ -0,0 +1,25 @@
+* Handle interrupts better
+
+Currently the interrupt handling uses an unusual design employing a kfifo to
+transfer irq status to irq thread. This was done as a work around for dropped
+interrupts seen with IRQF_ONESHOT based handling.
+
+This needs further investigation and fixing properly, with the aid of
+C&M and StarFive engineers.
+
+* remove all struct fields, that are assigned to but not used in the code, add
+  documentation about each removed field at the macro for the register it is
+  related too.
+
+* power management handling - add (runtime_)suspen/resume cb where the clock is enabled
+
+* revise logic of wave5_vpu_(dec/enc)_register_framebuffer
+
+* check if the  normal kernel endianness/__swab32 routines are sufficient. (instead of the ones
+  implemented in the driver)
+
+* Extended Codec Controls for encoder.
+
+implement extended codec control for HEVC/H264 encoder.
+PROFILE/LEVEL/MIN_QP/MAX_QP/LOOP_FILTER/HFLIP/VFIIP/ROTATE/
+GOP_SIZE/RC_ENABLE/I_PERIOD/BITRATE.
-- 
2.25.1

