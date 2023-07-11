Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD274E6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGKGNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjGKGNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:13:02 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542FBE5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:12:59 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0Vsh1Ty2zBHXhl
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:12:56 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689055976; x=1691647977; bh=HCeXK205aAUdPIW4pevCl7+pDB+
        fom36VtNou9SjZP8=; b=RFMbuN93EVxVTzVy7M3lx0dda62X4rnGOvM2p9m3Xzu
        6VpJ0vBbm3nO04DX2ryGqet9F3Ws8+TCnl2cPqTUmyJTJtUnt8zW3b7BHnZveCII
        HOFtSjNiaT7TnetmlPXWIZgi8GGvtyhtnNaePx9cwzA3tCDk6VAR7pSvFMOF1mt5
        T2PDkdBQT7tTWmR7NlH9Uk+waBsMwK03WJe/9nV30PEfN9aUKqflqc8OsOMpYvpL
        ImFaWzAjOUli8OIcYlLCkKS4HOMNWBdFAxdsBE4Yg2f6BTYKM0Xmu7GZgDvJbB3g
        +i9lU9z8GFOohaVuPwj2lTj2Iom6+IMtC16jINKQ+4A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CM4_WUAk_YGY for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 14:12:56 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0Vsg6BVwzBHXgj;
        Tue, 11 Jul 2023 14:12:55 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 14:12:55 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: ERROR: (foo*) should be (foo *)
In-Reply-To: <20230711061131.79666-1-xujianghui@cdjrlc.com>
References: <20230711061131.79666-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d9e5907b772bde22eefb26cb7e0e65e0@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two occurrences of the checkpatch.pl error:

ERROR: (foo*) should be (foo *)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nouveau_fence.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c 
b/drivers/gpu/drm/nouveau/nouveau_fence.c
index ee5e9d40c166..287885a3a37e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -169,7 +169,7 @@ nouveau_fence_wait_uevent_handler(struct nvif_event 
*event, void *repv, u32 repc
  void
  nouveau_fence_context_new(struct nouveau_channel *chan, struct 
nouveau_fence_chan *fctx)
  {
-    struct nouveau_fence_priv *priv = (void*)chan->drm->fence;
+    struct nouveau_fence_priv *priv = (void *)chan->drm->fence;
      struct nouveau_cli *cli = (void *)chan->user.client;
      struct {
          struct nvif_event_v0 base;
@@ -207,7 +207,7 @@ int
  nouveau_fence_emit(struct nouveau_fence *fence, struct nouveau_channel 
*chan)
  {
      struct nouveau_fence_chan *fctx = chan->fence;
-    struct nouveau_fence_priv *priv = (void*)chan->drm->fence;
+    struct nouveau_fence_priv *priv = (void *)chan->drm->fence;
      int ret;

      fence->channel  = chan;
