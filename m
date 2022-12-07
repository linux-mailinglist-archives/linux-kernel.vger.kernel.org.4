Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FC6459AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLGMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLGMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:14:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D834A05B;
        Wed,  7 Dec 2022 04:14:22 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8BB16602BCE;
        Wed,  7 Dec 2022 12:14:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670415261;
        bh=UUdJDtnpROO1Wzmzfh8NnTKS+dcQJK6OswvHc3laXi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ude0PZLNDcG/H8/7YFCqujtuQA3Fhi/Y53zhd3Fb77vcxnwiJztdZl1k7vDGsVCQD
         cacGZ/cl8rjMmofPDlC+i/np23NY51sdy6B5/6UXQh+0Xfor378ZJiZ+TOzJ+60ulu
         8KXRlRT8uRCrULPyHaqmFUR03XyjEjVodAdjdtle3r3ylDiDxXHntV9OK5YkCp+Qh1
         6moHxry5llyFn1t+XftDTvqo/c/WAgf37BaP5RWrxESNsCqY9pca8aE8kvp8N88Ybx
         SIRzOsAriKWmrPKuGM1PdM3OTgoWpRmqlsBFVkE+pExp3UzQjqknm6L3XNw3e0RKyt
         lo4kCv9QJ4hJA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org, Nas Chung <nas.chung@chipsnmedia.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-kernel@vger.kernel.org
Subject: [PATCH v11 4/6] media: chips-media: wave5: Add TODO file
Date:   Wed,  7 Dec 2022 13:13:48 +0100
Message-Id: <20221207121350.66217-5-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207121350.66217-1-sebastian.fricke@collabora.com>
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
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
 drivers/media/platform/chips-media/wave5/TODO | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 drivers/media/platform/chips-media/wave5/TODO

diff --git a/drivers/media/platform/chips-media/wave5/TODO b/drivers/media/platform/chips-media/wave5/TODO
new file mode 100644
index 000000000000..2164fd071a56
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/TODO
@@ -0,0 +1,18 @@
+* Handle interrupts better
+
+Currently the interrupt handling uses an unusual design employing a kfifo to
+transfer irq status to irq thread. This was done as a work around for dropped
+interrupts seen with IRQF_ONESHOT based handling.
+
+This needs further investigation and fixing properly, with the aid of
+C&M.
+
+* power management handling - add (runtime_)suspen/resume cb where the clock is enabled
+
+* revise logic of wave5_vpu_(dec/enc)_register_framebuffer
+
+* check if the  normal kernel endianness/__swab32 routines are sufficient. (instead of the ones
+  implemented in the driver)
+
+* Adjust STREAMON routine for the stateful decoder to adhere to the API, which
+  declares that STREAMON can be called before source buffers have been queued.
-- 
2.25.1

