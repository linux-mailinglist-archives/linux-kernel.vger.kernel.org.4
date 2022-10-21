Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B660750C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJUKe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJUKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:34:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D21A040
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:34:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x18so3146199ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWh3t522ptergEdRtDg24Vu5gqW3co9XQ8DD7IBqLdo=;
        b=Ayne00Q/waYSFrW3Y0zxKIZOglh4N8AHXw2NBZq4ILol0bck11j+D2UC31M7jFMS9F
         PbQ0ORyqtasaYwRUEKF2iDl4B4H0cq3AZ22pSDvP254//UZ4ZfeeorpfMqGLfqvQ//AG
         dXn7eEXIFbOubGFqGVW3bwg2zv732/0/5dd5FEi1iJpPx5WVN5WXtKd8GIJhCh5JvjUb
         Wg27zfVib1mPD392i0s3RIzYzRGKnHM/6xlgG648jvC8rWG3gymhYrMgPszyWIxNz5Cn
         NxOALG5wpRpk7s3GVVP31BK3ywtHjw1dfhOfnP8umuA05lyxceEhpiTyORCPd/MVuWvP
         oBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWh3t522ptergEdRtDg24Vu5gqW3co9XQ8DD7IBqLdo=;
        b=aMd+7bP1GhTL4nQdzfLNf3lo61Y7kDTudxbmhVkTFPDph2dCsHdPY8lZuCow1sHaIM
         KBxWfgRQ3AMnGpnwcGbCFNCBnPAAV/+sCIs3DXIRiWaiPTLJfKtq3t90sgUHkI4qWnVT
         +xf6RdbJz7H47xe6nuICbOTrmYikneH1uI5qzEa2xZUw1tApJ3wXZZ1c2HXGCa7tadqd
         6V0cBAXpnEk4oNF7IyP6nlP0O4IWndqrVdY7z4HOe7S862IzNEzRck9NclsE7HK+BOLs
         /zdFJ0tgRT/PbU44mdKxutSRRTLFHeG5hTcFtuTmXeO3W/u4y2f3t+i4TWV2wHmv9ACi
         51FA==
X-Gm-Message-State: ACrzQf3PrBqtGIx1Xle6I//BnjFdeW9bL7cTXk7Kgo38uKsNI3pauGWt
        AmeahsBy61FljVXMyoXvbEo=
X-Google-Smtp-Source: AMsMyM7Wdi6BiRZN8TWzlthZuBTCl0pLZWneFMtYScLZrk7Kd80frvje9gHjn7JIXYjyGB+UAUvNNA==
X-Received: by 2002:a2e:8697:0:b0:26f:b795:8b39 with SMTP id l23-20020a2e8697000000b0026fb7958b39mr6699546lji.218.1666348466460;
        Fri, 21 Oct 2022 03:34:26 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id u12-20020ac258cc000000b00492d7a7b4e3sm3119775lfo.4.2022.10.21.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 03:34:26 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v2 6/6] staging: vt6655: refactor code to avoid a line ending in '('
Date:   Fri, 21 Oct 2022 10:33:10 +0000
Message-Id: <3df55cf2362694891a311692eb63cc19913abf01.1666347511.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666347511.git.tanjubrunostar0@gmail.com>
References: <cover.1666347511.git.tanjubrunostar0@gmail.com>
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

