Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F77018DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbjEMR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjEMR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E992D5A;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1AE061D04;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B327C4331D;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=9d2D3D1eC1/26QEllvQ7nKdRq6JmajOkZGz/mFRHdaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJTWbaG5iZ2gzCJvdquQBhL579HYPCDwB2jbaKsOVkcq0Spu3Q+1POteYbjjJDzov
         OTBqML1disR7BAuR2Eav0D6yd02Gk87LZmDwqYBmZaHAmJK5+h82cVGKopwInIVr+j
         IaMsci9l5i+9J29pZxIM5fceTVZuPs3FVQvKrq24zvKFt+OOAze+Iabfw0BF52Aajn
         qQGSxdY19q+ttzlgoXBUeV8D5W45EexwuD18BF+ZdrQRtfaSA2iD967bE83HTu28EB
         JeJZpFQ47l5Ao+S+7QeojoT2JuYP4GDGPwY8INM/1zSehwdH7PxFfjUtfx8fXNpSE0
         eO1pm4wikV3uw==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tyN-1v;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yu Zhe <yuzhe@nfschina.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 20/24] media: c8sectpfe: dvb: remove unnecessary (void*) conversions
Date:   Sat, 13 May 2023 18:57:37 +0100
Message-Id: <929cc69a6474e14a619b216706aefa8b3876ccaa.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Zhe <yuzhe@nfschina.com>

Pointer variables of void * type do not require type cast.

Link: https://lore.kernel.org/linux-media/20230320070828.13322-1-yuzhe@nfschina.com
Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index 45ade7210d26..120830973d22 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -135,7 +135,7 @@ static void channel_swdemux_tsklet(struct tasklet_struct *t)
 static int c8sectpfe_start_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
 	struct dvb_demux *demux = dvbdmxfeed->demux;
-	struct stdemux *stdemux = (struct stdemux *)demux->priv;
+	struct stdemux *stdemux = demux->priv;
 	struct c8sectpfei *fei = stdemux->c8sectpfei;
 	struct channel_info *channel;
 	u32 tmp;
@@ -256,7 +256,7 @@ static int c8sectpfe_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
 
 	struct dvb_demux *demux = dvbdmxfeed->demux;
-	struct stdemux *stdemux = (struct stdemux *)demux->priv;
+	struct stdemux *stdemux = demux->priv;
 	struct c8sectpfei *fei = stdemux->c8sectpfei;
 	struct channel_info *channel;
 	int idlereq;
-- 
2.40.1

