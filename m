Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D11460D80F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiJYXkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiJYXjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:39:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67A102DCD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id be13so25331279lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbEoGrXusmODeHp59Zc33PMYoCkMrCDJTVhmN+b+I+A=;
        b=M9fqafIZ1Re9mdOIXzPeUQ2SxkiGyfeeov1l/PQhWDPAO7db+ZZK+C9YeB6Ihvuq36
         TpOQ2E4xpDuFYruMg7nZ8mQV16dapSI0/ahxfw7IcHxXZTDfyLlRqncA9cecH94bsura
         11hOYU1vEANCo4P19p7zdHeSituoHVfg3I0NenQo5s1VG19OlW3N6myBlX1YF9kclsK8
         f/osWfHTqIzpGc7awCXeLQpHXvd0k6AjjSUVKSUYIne6CGyEpMjkyylWeovahjTlrm7f
         oJFoxW92ufiwhDuA/ggeImMl2qgXPOckWO3byfwiQ+yD+e8fPAR17npkJcJfnjZPULzG
         UijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbEoGrXusmODeHp59Zc33PMYoCkMrCDJTVhmN+b+I+A=;
        b=c5bQsHjzJET4enpO/mX+5PYCEqgRqWt8Q8VrycAwrcMftENXTwy/phhCCmPkd5nRHz
         yMNl2Knugf3vKg91sg4vTNf/uPv30NlaDp86y/qNzOdYin9v5YukmlJHa7RekGlEks8O
         +Mf8tXZwMqt5SK/xK2K9NxWnMcDN6XiLbDGkjmpKFKgB5urGiLUjY+3ZmBtNGfuq8+Al
         tofTrf++TrTtFNktHXmoa1FzQM+IbjDge9vu3fex6I9BNHbuJJNS1+YdAdvd8KxkAB7g
         uJG5/avUagaZa/9vw8g+jBdGVex4T0qYKdMXOXHlGq/HRS3xVd9bc6Fwftr1Gt0nCc8z
         HDfw==
X-Gm-Message-State: ACrzQf04mPZZX9X8vGmaOTs5+967BX3J8UsXaXVOSfXxMnIcxktT+htk
        kwbOG9rkDdAIykLpJRH4OTk=
X-Google-Smtp-Source: AMsMyM6UhwvO3JUqhW/6sJglO/qyarUK8nliSw1Qw+2cQpPNnVqcEx/ejROPYKKaxEqyAUIAHOK23g==
X-Received: by 2002:a19:9106:0:b0:4ab:a0dc:ac3e with SMTP id t6-20020a199106000000b004aba0dcac3emr4992767lfd.395.1666741155896;
        Tue, 25 Oct 2022 16:39:15 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:39:13 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 15/17] staging: vt6655: changed variable name: psEthHeader
Date:   Tue, 25 Oct 2022 23:37:11 +0000
Message-Id: <a1cb8f6ad881bc6891d5baf22ced852c95e61754.1666740522.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666740522.git.tanjubrunostar0@gmail.com>
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
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

change variable names psEthHeader to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5729798973b4..6a54f234261a 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -104,7 +104,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     unsigned int	cb_frame_size,
 				     bool b_need_ack,
 				     unsigned int	u_dma_idx,
-				     void *psEthHeader,
+				     void *ps_eth_header,
 				     unsigned short wCurrentRate);
 
 static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
@@ -946,7 +946,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     unsigned int cb_frame_size,
 				     bool b_need_ack,
 				     unsigned int u_dma_idx,
-				     void *psEthHeader,
+				     void *ps_eth_header,
 				     unsigned short wCurrentRate)
 {
 	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
@@ -986,7 +986,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 								b_need_ack);
 
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, b_need_ack,
-					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
+					  b_dis_crc, ps_eth_header, wCurrentRate, by_fb_option);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pv_rrv_time;
 
@@ -1015,7 +1015,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 
 			/* Fill RTS */
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, b_need_ack,
-					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
+					  b_dis_crc, ps_eth_header, wCurrentRate, by_fb_option);
 		} else if (!pv_rts) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
@@ -1033,7 +1033,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 
 			/* Fill RTS */
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, b_need_ack,
-					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
+					  b_dis_crc, ps_eth_header, wCurrentRate, by_fb_option);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
-- 
2.34.1

