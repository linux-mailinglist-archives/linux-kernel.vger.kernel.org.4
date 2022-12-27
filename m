Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51065692C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiL0Jwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiL0JwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:52:12 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FCA1BA;
        Tue, 27 Dec 2022 01:52:06 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k137so3779150pfd.8;
        Tue, 27 Dec 2022 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLpWFlG8mxCCWcewzRCKKTz15AMme8ZuJhE5IEg3io0=;
        b=TkuNIbW419DCqnsMr8eROaVQRmpRqJUmz8qFDChR3AkvRG2XJwiv9WqKS3cZkR06pM
         m7kx4XFi3Zxf5mM7a76yH8bJsn+EXflGk8c+dFvTjSt35Ap8UegvtHW9JhCzwyEmoFZx
         dU4yrPuiKyI0uFiZpqWjXbdyL7b7LMRjcBWUkympMUPTpT22Or0BLRCoP1nNvFLVNM77
         I8Eh7sj67inMzq/UU3vak5c4+UAKFKuKCpD0DxFwIlgywrW5AmXJAH9DFutP/5nYo/NJ
         U8bhgmhW/YpRvbA19PyUNJjoa5Yf0WPmL932dZzcKZh+yCnxmUpDQnUGGWM1KtjpjHuu
         +SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLpWFlG8mxCCWcewzRCKKTz15AMme8ZuJhE5IEg3io0=;
        b=QXpGLekwp9uTTafHSbIgb4fOEl81wqxKO4Rtivo6I9wjn+GTyJzrP8WcB789Ftt8dG
         /JAoJI+uHpm4DToYT4Q461/a8zgT3CTfvFlsHq/iKiJViI7T1KYh1tmmar3b7VBvisLP
         W4Q7DHUKKdNL6Rr/riZRXRLsz2UY4AEUAoAagijkm6742fO69SUAktxQRmFAO/BPegPp
         EhAF3I4UNVhTeBUj5QXl9brD8/8BlHgUobstpVCTOXaSMK9CHfWXJtiVrNvbo8447cjz
         g/jNJh/4W5+NrR5eD+UYZz7T26oBeLCLIjMCVPrhyzGA0obzsoGKulL7dnDoYJnrOvMJ
         YjUw==
X-Gm-Message-State: AFqh2kq+IsCVYKbe3z6WlUSKvMV5LhjaWAkeOBiFwrc3Z3KhwoHjvlP4
        3Vg7cfIZtCjmb7OkbPHpE0+65ezw0aEClg==
X-Google-Smtp-Source: AMrXdXtH7P1bk4khx+VeL2/j7rwXJlz5kYFRm5DvOOlO25yNuhzpS0JkzL4B3kdOIcFBLflDj4UfRw==
X-Received: by 2002:a62:bd19:0:b0:566:900d:a1de with SMTP id a25-20020a62bd19000000b00566900da1demr23770765pff.26.1672134726050;
        Tue, 27 Dec 2022 01:52:06 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 21-20020a621515000000b005813aec74bdsm2619052pfv.139.2022.12.27.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 01:52:05 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v10 5/7] media: v4l2-ctrls: Reserve user control base for NPCM video controls
Date:   Tue, 27 Dec 2022 17:51:21 +0800
Message-Id: <20221227095123.2447948-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227095123.2447948-1-milkfafa@gmail.com>
References: <20221227095123.2447948-1-milkfafa@gmail.com>
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

Add a control base and reserve 16 controls for Nuvoton NPCM video
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b73a8ba7df6c..aa5c9f64f1d6 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -199,6 +199,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

