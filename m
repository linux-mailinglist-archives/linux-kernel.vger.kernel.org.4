Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BCF606833
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJTSaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJTS3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:29:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BABB50FAD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:29:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so809900lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWh3t522ptergEdRtDg24Vu5gqW3co9XQ8DD7IBqLdo=;
        b=aYGnchK9a2xDJ1retDATpQXkztTjuwN+mKYEt2yPgGw4fdLK2AKdEdJnjt0IfVq9lz
         o9Kdat2oekIuT+8tcrkU24zxe/nMslCR+aF/VzEp1/4Ci3Bwn0Jdm+pc2VuMTc70LRim
         NJJQJ9nCEqaqMS55YdPODP9z7WHbt6u12hhOyZAVf78lf1yLxxA9iqYgJf8NNIHa9h+H
         p6UK1fO8voEXHlOYZGOZJQ4j/Nt+zFll7189p9D58H+Y/c7KMSPozukhX7vjnt7+Mf4u
         Ziqkuv48+9hTxyEZ8zLwMgom6+IPgD7phLtnikFpizk4TZVHPX2pTzJohtNw+uAWj3gX
         V26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWh3t522ptergEdRtDg24Vu5gqW3co9XQ8DD7IBqLdo=;
        b=mJ0HrC6yutJSLJxSsip/8DIhEkvIlWGirSnh4zfiAAIiQmW1ZSep2QZKY6uRD2qmpI
         r8SBfzjJqSUjmtTuTF42vnSLI7hBOT2M4W9oJbU7bEYq75EfRZUGQ31uVmss8QngRRHm
         Jz+ynPxzCqAe4imrE8h/U4DMUO+iudJmOd9B3oK4jlNYRq2G4o8SEAVQisusCE5a+ZuY
         cTIXeUxUB1XI15MM/Um41S8V0y5pxMKBagj4HZAnjy1skx0SDG6dnRBWU/17eB9E6AaG
         K88ZcariN1/OnPley42rXsVKHyxufPb6Zfu7ecF6UcmcyfMvzUKJ+phI6VpcsjkIBEvq
         KpGA==
X-Gm-Message-State: ACrzQf2p6MsMHrDUGxikqUsBBAuryxOTUyummBXvNfWTn2iDrCSJIGgY
        uCvGKLXDRyRAZJTuNnu+ThdSmvt7PoEhnU+4
X-Google-Smtp-Source: AMsMyM7p8zbGowZciMAA4I0/fu751l9NpSzMEqKdwhN1ku4x3a9Xw1lO4NgirZNwEk9OGwkvwl00Hw==
X-Received: by 2002:a05:6512:3b13:b0:4a2:564e:6cea with SMTP id f19-20020a0565123b1300b004a2564e6ceamr5137022lfv.242.1666290588683;
        Thu, 20 Oct 2022 11:29:48 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id h10-20020a0565123c8a00b00497a3e11608sm2797216lfv.303.2022.10.20.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:29:48 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     forest@alittletooquiet.net
Cc:     greg@kroah.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 6/6] staging: vt6655: refactor code to avoid a line ending in '('
Date:   Thu, 20 Oct 2022 18:27:46 +0000
Message-Id: <3df55cf2362694891a311692eb63cc19913abf01.1666288416.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666288416.git.tanjubrunostar0@gmail.com>
References: <cover.1666288416.git.tanjubrunostar0@gmail.com>
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

join unnecessary split lines to avoid them ending in '('

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index b8b21cd39534..d997002ee9ff 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1301,10 +1301,8 @@ static void vnt_fill_txkey(struct ieee80211_hdr *hdr, u8 *key_buffer,
 		ether_addr_copy(mic_hdr->addr2, hdr->addr2);
 		ether_addr_copy(mic_hdr->addr3, hdr->addr3);
 
-		mic_hdr->frame_control = cpu_to_le16(
-			le16_to_cpu(hdr->frame_control) & 0xc78f);
-		mic_hdr->seq_ctrl = cpu_to_le16(
-				le16_to_cpu(hdr->seq_ctrl) & 0xf);
+		mic_hdr->frame_control = cpu_to_le16(le16_to_cpu(hdr->frame_control) & 0xc78f);
+		mic_hdr->seq_ctrl = cpu_to_le16(le16_to_cpu(hdr->seq_ctrl) & 0xf);
 
 		if (ieee80211_has_a4(hdr->frame_control))
 			ether_addr_copy(mic_hdr->addr4, hdr->addr4);
-- 
2.34.1

