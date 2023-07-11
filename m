Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4A74E472
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGKCqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKCqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:46:05 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740D188
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:46:02 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0QGt2L7BzBHXkP
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:45:58 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689043558; x=1691635559; bh=yMCbkMYiTyHC8803omIwa+cF847
        f+Xrhh1yZkyU7z/8=; b=o86gB03IoDt9VawXYng14a/StUEWudAL3zo+6d9xiYP
        B8D9se2Nr7rFzLc++MViJlPz2DVjYiW21SJ9+KCugoWbBs7iTm2MMbYshZe6uPv6
        /cqTexnDOb9zTtJvfwp0vuF6RvhodvCmItUynCYeDI21yFBosiYIGrTuql7sMB58
        4PmiaN4i+fXE5rnBulekExwxdguH3Nf/hjhglEQPkZg/XX63SDO1+HNl8E8Vq/mw
        3A27ilU4OAzK7s9XSb67LjrShnBRvV5VKSMroTXrfSg2U/ZCceL6ahU6TkMnkSCD
        yyXqf/vOlSbMhFgJ12lFFgiKc1BoaoX9PLcJDyf0kqg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YCFy2nwXfar2 for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 10:45:58 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0QGs6Z1XzBHXhc;
        Tue, 11 Jul 2023 10:45:57 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 10:45:57 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/devinit: Move assignment outside if condition
In-Reply-To: <20230711024429.78508-1-xujianghui@cdjrlc.com>
References: <20230711024429.78508-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <ccc9e4541dcac0675e578825667b60ad@208suo.com>
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

Fixes the following checkpatch errors:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv05.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv05.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv05.c
index 1410befd2285..8185e10efc49 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv05.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv05.c
@@ -61,7 +61,8 @@ nv05_devinit_meminit(struct nvkm_devinit *init)
      }

      strap = (nvkm_rd32(device, 0x101000) & 0x0000003c) >> 2;
-    if ((data = bmp_mem_init_table(bios))) {
+    data = bmp_mem_init_table(bios);
+    if (data) {
          ramcfg[0] = nvbios_rd08(bios, data + 2 * strap + 0);
          ramcfg[1] = nvbios_rd08(bios, data + 2 * strap + 1);
      } else {
