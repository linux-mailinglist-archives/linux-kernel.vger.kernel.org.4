Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF1774E51C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGKDHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjGKDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:06:43 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6871D18D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:06:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0QkM2m9gzBHXkP
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:06:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689044779; x=1691636780; bh=QBdEWxSyVtId7m0paN26voaUrdc
        kwm/MDxNS7wzdr8U=; b=mdGdqFnPzD//6oTkoilVK3oKhtYb7KO2o7chsUkv3oU
        Mmk/j06z13AAGnJy/+nv0eARhht87DNulCqabGFew+KUX9lybDIm+9mRacgMJp5b
        H9XNLKqAdLX64EhS0Z27gSa1yOgkOq33EHvJ2BX8QWAN8Xp4S9OysI6E58e3BCdU
        yLL+QvCgN4b5FqsjYDQtd81xotfHVQmUI0WlhbyCz0XD0hn7uut1Y6yYDYygaPpt
        eBFSoqT06Xx1SNtZlkBxQC0dRzHpmxnb6rEf4pf3VLvXyovBTUTr49zFUS32qMfI
        wfr9b0+LNFI9i82vi2710CTLx/IeaUjkAr9W2ReWSug==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gY9HsphLEvUh for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:06:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0QkM07bCzBHXhc;
        Tue, 11 Jul 2023 11:06:18 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 11:06:18 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/clk: add missing spaces after ','
In-Reply-To: <20230711030447.78738-1-xujianghui@cdjrlc.com>
References: <20230711030447.78738-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7d1d072719222e908323deb61cbbc25d@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/clk/seq.h | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/seq.h 
b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/seq.h
index e4b362d3449b..67c7b3e495fb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/seq.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/seq.h
@@ -3,13 +3,13 @@
  #define __NVKM_CLK_SEQ_H__
  #include <subdev/bus/hwsq.h>

-#define clk_init(s,p)       hwsq_init(&(s)->base, (p))
-#define clk_exec(s,e)       hwsq_exec(&(s)->base, (e))
-#define clk_have(s,r)       ((s)->r_##r.addr != 0x000000)
-#define clk_rd32(s,r)       hwsq_rd32(&(s)->base, &(s)->r_##r)
-#define clk_wr32(s,r,d)     hwsq_wr32(&(s)->base, &(s)->r_##r, (d))
-#define clk_mask(s,r,m,d)   hwsq_mask(&(s)->base, &(s)->r_##r, (m), 
(d))
-#define clk_setf(s,f,d)     hwsq_setf(&(s)->base, (f), (d))
-#define clk_wait(s,f,d)     hwsq_wait(&(s)->base, (f), (d))
-#define clk_nsec(s,n)       hwsq_nsec(&(s)->base, (n))
+#define clk_init(s, p)       hwsq_init(&(s)->base, (p))
+#define clk_exec(s, e)       hwsq_exec(&(s)->base, (e))
+#define clk_have(s, r)       ((s)->r_##r.addr != 0x000000)
+#define clk_rd32(s, r)       hwsq_rd32(&(s)->base, &(s)->r_##r)
+#define clk_wr32(s, r, d)     hwsq_wr32(&(s)->base, &(s)->r_##r, (d))
+#define clk_mask(s, r, m, d)   hwsq_mask(&(s)->base, &(s)->r_##r, (m), 
(d))
+#define clk_setf(s, f, d)     hwsq_setf(&(s)->base, (f), (d))
+#define clk_wait(s, f, d)     hwsq_wait(&(s)->base, (f), (d))
+#define clk_nsec(s, n)       hwsq_nsec(&(s)->base, (n))
  #endif
