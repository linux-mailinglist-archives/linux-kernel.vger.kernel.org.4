Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA01739412
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFVAq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFVAqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:46:55 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92661992
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:46:51 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 15DEA240103
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687394804; bh=VKO5kAlvwT2Tg2zsi0T5+7i3uYFbcdeRVjfmpdaksA0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=a/oEtG0KJ+MdDAU6YvpoP+NjHlFRoZMzls3XOuzZJ+XQ1E/UujAIOUkEiwxLBgUxi
         yuBZMD8dHkENO03ShRf+cCrvF3nyBp9cDORJF29oCaGsFqFXgc8/n4gJi4SD4jhdvI
         ckcitvlwfasYJuKUDn713StJ2qZ10FvM6MuetM8W+4tsEqq301jMozkfY2ZDuEFm9J
         bZyc9NpkiUZy8Ecv5ouiy4uSQSOeoR/jIgRI0fEyjHWlvqe4jYY0gekq6O4foXc8GZ
         6s1KdL4I6ii5aqN34wazqSbDSZSOC1IXijjZGr/Y2kTy/tZHWKZtHACAPswz1MD3kt
         Z6vdyjBOxlBbw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmhX10KDVz9rxL;
        Thu, 22 Jun 2023 02:46:40 +0200 (CEST)
From:   Yueh-Shun Li <shamrocklee@posteo.net>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yueh-Shun Li <shamrocklee@posteo.net>
Subject: [PATCH] drm/amd/display: fix comment typo
Date:   Thu, 22 Jun 2023 00:42:27 +0000
Message-Id: <20230622004226.7177-1-shamrocklee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spell "transmission" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 0278bae50a9d..45143459eedd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -154,7 +154,7 @@ static void dcn31_hpo_dp_stream_enc_dp_blank(
 			VID_STREAM_STATUS, 0,
 			10, 5000);
 
-	/* Disable SDP tranmission */
+	/* Disable SDP transmission */
 	REG_UPDATE(DP_SYM32_ENC_SDP_CONTROL,
 			SDP_STREAM_ENABLE, 0);
 
-- 
2.38.1

