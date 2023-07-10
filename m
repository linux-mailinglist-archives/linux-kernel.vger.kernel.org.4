Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EAE74CEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGJHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjGJHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:39:12 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB2E6E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:38:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzwqH25zQzBHXhB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:38:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688974731; x=1691566732; bh=1pv9U2ejg50V6ues3fPMO0Cknci
        SgisMrIyVi0p4I4g=; b=0zDIx8qbSBbLhsZBxHNYyCIARocYe7tUU2eX2z8Ne37
        McN7z6lf6DaK7HoTfG6DGh/5Tqdnk9xDw7VocPVN1c5H+FywlOOl2VRvrIW4k2ob
        n8IOicj11yg9zMt7/kgKd8ByndZTzbSZbWAA8wsaSj8HvuXA9wvrDsb+ygzmHDC+
        2Uvbk89MhdsBw/1mY/r4SGPwTiu/2XBpTSOL9soAM/IvQgTGrBwPKsGqFKiVsAUo
        +hRpibTUWILfpBHy81P/4ZBTu4BjDCHOKIVoqmrK+PSiY8Vsy7JdEr3DHGfEUHGH
        N+bZSQaqHzQ/5uRPNRGqyoJN/EY9hxvTKiHchq2LBQg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M2WvrzPClA7j for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 15:38:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzwqG6ZnlzBHXgs;
        Mon, 10 Jul 2023 15:38:50 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 15:38:50 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <20230710073659.54188-1-xujianghui@cdjrlc.com>
References: <20230710073659.54188-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <656c6d33a676c141ea35fadb519ccfbc@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix nine occurrences of the checkpatch.pl error:
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/atom.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.c 
b/drivers/gpu/drm/radeon/atom.c
index c1bbfbe28bda..11a1940bb26d 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -1156,7 +1156,7 @@ static struct {
      atom_op_shr, ATOM_ARG_MC}, {
  atom_op_debug, 0},};

-static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t * params)
+static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t *params)
  {
      int base = CU16(ctx->cmd_table + 4 + 2 * index);
      int len, ws, ps, ptr;
@@ -1216,7 +1216,7 @@ static int atom_execute_table_locked(struct 
atom_context *ctx, int index, uint32
      return ret;
  }

-int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int 
index, uint32_t * params)
+int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int 
index, uint32_t *params)
  {
      int r;

@@ -1237,7 +1237,7 @@ int atom_execute_table_scratch_unlocked(struct 
atom_context *ctx, int index, uin
      return r;
  }

-int atom_execute_table(struct atom_context *ctx, int index, uint32_t * 
params)
+int atom_execute_table(struct atom_context *ctx, int index, uint32_t 
*params)
  {
      int r;
      mutex_lock(&ctx->scratch_mutex);
@@ -1359,8 +1359,8 @@ void atom_destroy(struct atom_context *ctx)
  }

  bool atom_parse_data_header(struct atom_context *ctx, int index,
-                uint16_t * size, uint8_t * frev, uint8_t * crev,
-                uint16_t * data_start)
+                uint16_t *size, uint8_t *frev, uint8_t *crev,
+                uint16_t *data_start)
  {
      int offset = index * 2 + 4;
      int idx = CU16(ctx->data_table + offset);
@@ -1379,8 +1379,8 @@ bool atom_parse_data_header(struct atom_context 
*ctx, int index,
      return true;
  }

-bool atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t 
* frev,
-               uint8_t * crev)
+bool atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t 
*frev,
+               uint8_t *crev)
  {
      int offset = index * 2 + 4;
      int idx = CU16(ctx->cmd_table + offset);
