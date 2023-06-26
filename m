Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90C973D5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjFZCpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFZCoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:44:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BCFE7;
        Sun, 25 Jun 2023 19:44:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-262e839647eso704604a91.2;
        Sun, 25 Jun 2023 19:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687747494; x=1690339494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QcoEetkUYJEXKBOLQWwPPuBN/feg1Dag8bMvH33Pf/s=;
        b=NUTMwh3INPCVhHlFkUQxtTQ2i0zj8GT0N9HIgPMEu9lQX9MtpNsdqd1k9ARhmLJAnf
         1mj38H0tths6ud0yl9vp/wHJ3w2gxxGOc1d28M+OO98WtTs/3ONFepL23oVd1Q3ISysA
         Vem6zUzO6wAM3q2AYfXHiCTewLHDbRvBX75pyd1W718RIuKB7lc9n/0balpf8BP7X4ds
         IXQ56jC+vxt0/USsYNJHi02K9TDwnp8NhSk3cEEAKtHMqZ8rgOQtsD6VyrseYJdHM4nr
         I8TIvlN6Ed8Gd1DDCLidrGZ2g3amzE3jcoDQpV38zkd1B31cFD8gfExpyGG45Ty0rxVt
         ub3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687747494; x=1690339494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcoEetkUYJEXKBOLQWwPPuBN/feg1Dag8bMvH33Pf/s=;
        b=LQLSebeZUl0kZns1gE0DOmz/mJVRI0swzOE7WUYdL3IHHcx5V62x+KmPdwWXFomsSn
         E3zA0eUZAZHE/8/nTawwPyO73Yz3v+91q2u8pC/fnxAa/gXQWHLVfrQP72AEF82hJ8HA
         SUyGFfgXdGq4z0BDn+gmwBP/Bg0IZqjBMONMaeEGzijeVa/AXnsMqDeeKvJWNW/wbv8o
         uPGBQnsFAnPiqbaktzfoPFgCsa6ez/QT29SML7XR8MvbQzl2L5ck2SoEgkOy5SQWuQi8
         LACZHu5STW/AClZdTx8Nxu7IFlZeM+geCorvhrxGjVHEcNP0i9fS3xdsk74NECBu0+Ak
         TVYQ==
X-Gm-Message-State: AC+VfDwbYXqnvM//fE5s2I0Fezkhal51KrTPTNf/6i2ALTVhGiBEKPiK
        zc2pR3iaUcQ0pzlKD/lmorA=
X-Google-Smtp-Source: ACHHUZ6JiHGb4Um9Iewl0YM9ptygQkUjOcrCWXlGbc6EiLUckuZKPIiBJTA3HDfRpMQtHM07UqDiWw==
X-Received: by 2002:a17:90a:199:b0:25b:d8fe:2c92 with SMTP id 25-20020a17090a019900b0025bd8fe2c92mr24951784pjc.48.1687747493748;
        Sun, 25 Jun 2023 19:44:53 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a284c00b00256799877ffsm3486687pjf.47.2023.06.25.19.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 19:44:53 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mchehab@kernel.org, yongsuyoo0215@gmail.com,
        tommaso.merciai@amarulasolutions.com, colin.i.king@gmail.com,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] media: dvb-core: Fix a possible null-pointer dereference due to data race in dvbdmx_write()
Date:   Mon, 26 Jun 2023 10:44:29 +0800
Message-Id: <20230626024429.994136-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct field dmx_demux.frontend is often protected by the lock 
dvb_demux.mutex when is accessed. Here is an example in 
dvbdmx_connect_frontend():

  mutex_lock(&dvbdemux->mutex);

  demux->frontend = frontend;
  mutex_unlock(&dvbdemux->mutex);

However, the variable demux->frontend is accessed without holding the lock
dvbdemux->mutex in dvbdmx_write():

  if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE))

In my opinion, this may be a harmful race, because if demux->fontend is set
to NULL right after the first condition is checked, a null-pointer 
dereference can occur when accessing the field demux->frontend->source.

To fix this possible null-pointer dereference caused by data race, a lock
and unlock pair is added when accessing the variable demux->frontend.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/media/dvb-core/dvb_demux.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 7c4d86bfdd6c..d26738e3310a 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -1140,9 +1140,13 @@ static int dvbdmx_write(struct dmx_demux *demux, const char __user *buf, size_t
 {
 	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 	void *p;
-
-	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE))
+	
+	mutex_lock(&dvbdemux->mutex);
+	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE)) {
+		mutex_unlock(&dvbdemux->mutex);
 		return -EINVAL;
+	}
+	mutex_unlock(&dvbdemux->mutex);
 
 	p = memdup_user(buf, count);
 	if (IS_ERR(p))
-- 
2.34.1

