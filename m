Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D637018D2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjEMR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjEMR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114232D55;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F85661CB6;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A15AC4331F;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=eGtNYpD/XyyRkJDa/Og4mUl11WDE9M+dRjzmaPlkuV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuIA5/cO9Tm+H+/t6AZ8omfIsBFLtHlrJWRzUKGbr+bPEFMJ56WP2poDE9Ppj03Dv
         Tydbuyn5mqtIsJuzAESckgd8lfFFnF30RGrh4kIMHoTlvsewGbzt8TyVp7qWyCTmMc
         AexQK9OR6+Sb1IJRCAaDph5QRqtKA4aUxDlF7MJxdjvR2S73lvZzJbsJ+6gcfXef7p
         rgOrvg0hxogtYqAEdAH5xbvEBBJOvP5XqVcKlxuS6cJ3LmWwWHTmtolANovoU6cY1W
         nmDaW4NliCgozrwvjTyDyY8ckBrAvDbQCPm4VSbkLOyA3U++SyaPoa8KIIQs7le3/f
         UKfOeKsNU5Baw==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tya-28;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Athanasios Oikonomou <athoik@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Robert Schlabbach <robert_s@gmx.net>
Subject: [PATCH 24/24] media: dvb: bump DVB API version
Date:   Sat, 13 May 2023 18:57:41 +0100
Message-Id: <1a18c0512de2f4002e8b0084ad28cce662bb57e7.1684000646.git.mchehab@kernel.org>
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

From: Athanasios Oikonomou <athoik@gmail.com>

Bump the DVB API version in order userspace to be aware of the changes
recently implemented in enumerations for DVB-S2(X) and DVB-C2.

Related: commit 6508a50fe84f ("media: dvb: add DVB-C2 and DVB-S2X parameter values")

Link: https://lore.kernel.org/linux-media/20230110071421.31498-1-athoik@gmail.com
Cc: Robert Schlabbach <robert_s@gmx.net>
Signed-off-by: Athanasios Oikonomou <athoik@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/uapi/linux/dvb/version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/dvb/version.h b/include/uapi/linux/dvb/version.h
index 1a8cd038aa0b..20bc874de321 100644
--- a/include/uapi/linux/dvb/version.h
+++ b/include/uapi/linux/dvb/version.h
@@ -10,6 +10,6 @@
 #define _DVBVERSION_H_
 
 #define DVB_API_VERSION 5
-#define DVB_API_VERSION_MINOR 11
+#define DVB_API_VERSION_MINOR 12
 
 #endif /*_DVBVERSION_H_*/
-- 
2.40.1

