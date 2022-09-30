Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD15F0304
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiI3CxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiI3CxC (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:53:02 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64CFE1005C5
        for <Linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:52:59 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6A8121E80CB9;
        Fri, 30 Sep 2022 10:48:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RdOshU7HhtFu; Fri, 30 Sep 2022 10:48:15 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: junming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id F0BAE1E80CB5;
        Fri, 30 Sep 2022 10:48:14 +0800 (CST)
From:   shijm <junming@nfschina.com>
To:     tiwai@suse.com
Cc:     Linux-kernel@vger.kernel.org, Shi junming <junming@nfschina.com>
Subject: [PATCH] sound:remove unnecessary conversions
Date:   Fri, 30 Sep 2022 10:52:44 +0800
Message-Id: <20220930025244.9762-1-junming@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shi junming <junming@nfschina.com>

remove unnecessary conversions

Signed-off-by: Shi junming <junming@nfschina.com>
---
 include/sound/pcm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 6b99310b5b88..0530cfa08892 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1344,7 +1344,7 @@ snd_pcm_sgbuf_get_chunk_size(struct snd_pcm_substream *substream,
  */
 static inline void snd_pcm_mmap_data_open(struct vm_area_struct *area)
 {
-	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)area->vm_private_data;
+	struct snd_pcm_substream *substream = area->vm_private_data;
 	atomic_inc(&substream->mmap_count);
 }
 
@@ -1356,7 +1356,7 @@ static inline void snd_pcm_mmap_data_open(struct vm_area_struct *area)
  */
 static inline void snd_pcm_mmap_data_close(struct vm_area_struct *area)
 {
-	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)area->vm_private_data;
+	struct snd_pcm_substream *substream = area->vm_private_data;
 	atomic_dec(&substream->mmap_count);
 }
 
-- 
2.18.2

