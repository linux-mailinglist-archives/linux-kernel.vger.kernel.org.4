Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B174CDE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGJHG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJHG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:06:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A84EB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:06:52 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qzw6J2PSlzBHXhD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:06:48 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688972808; x=1691564809; bh=BVbkB5h19AUC2qXDaTRj4Iv4202
        uUhLlZMpa8f2uMTA=; b=Z8qGrsD36Ynz7iCv+V2O2wk50AhLMYQzwSzzdPxZvUp
        2hNn8EZ+RygiqTusv96oNn7B7BjRG0t6x6HEgevU3kP0X1MSn+o1I4Af3aCISYKg
        rFnWQVjUuP6A8DDqeC4IWS0FQXer3af/O618s8vO2YNj6iMmEKtSMgnodVUOhydd
        LomQebCBBc8UCEB4co9CfyrGBKogD01ubhgtEP7I5gCLLJbP+r/Gg9r7T/wd4ZGm
        SZcI5g4YUd1dldpuHgo/6YZlD7S6vLWtd3r5TQtTs2pnfxQ1BLI94+QvFIO8VB6N
        Sk+blS6miJ/2nzp5KBYvHXOFCn760NLyE0wOxXb1Pcg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WYkTQyo7XoXY for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 15:06:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qzw6J0NQhzBHXh3;
        Mon, 10 Jul 2023 15:06:48 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 15:06:47 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/iccsense:
In-Reply-To: <20230710070505.53916-1-xujianghui@cdjrlc.com>
References: <20230710070505.53916-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <1ddf673283e93e83d912066f2241b976@208suo.com>
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

Fixed error: 'do not use assignment in if condition'

This patch fixes error: 'do not use assignment in if condition'
in drm/nouveau/iccsense

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index 8f0ccd3664eb..2428f3d6e477 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -322,7 +322,8 @@ int
  nvkm_iccsense_new_(struct nvkm_device *device, enum nvkm_subdev_type 
type, int inst,
             struct nvkm_iccsense **iccsense)
  {
-    if (!(*iccsense = kzalloc(sizeof(**iccsense), GFP_KERNEL)))
+    *iccsense = kzalloc(sizeof(**iccsense), GFP_KERNEL);
+    if (!*iccsense)
          return -ENOMEM;
      INIT_LIST_HEAD(&(*iccsense)->sensors);
      INIT_LIST_HEAD(&(*iccsense)->rails);
