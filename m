Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815EA74E3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjGKBnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGKBmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:42:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82267DB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:42:48 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0Nsw3ZZ0zBHXhl
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:42:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689039763; x=1691631764; bh=lSZQXAxYJar3o8ZAu0tDXbav933
        mwLp+FmKH8/B8NRk=; b=K1ZC69LGdxsYnBbBxRoYnYfQo2JF8gzVzXPzYlX0bmq
        c7m3oHyTcPQXJhAVEKD9bRqKYHiODZ2MEWsl2kiswkz4HejO0Tf8enHA48NK8lLt
        RMMRyH5EgmlZCrv1LmEfaYvfXX4J5OI7Iwoi56NLvlXR+XKkGVz+Qf+pWsYDM0T+
        gh968rb45p0orS240Yjk24ea93+FkihbFvhr3l3zvRwHNW7fGb3054eGlFWz2UEQ
        6AdjpS0qRxni+yYirKPwGpCIrJK1mCi2kyXs01p7BGUnTTMfY7uKXrmlOxCG/GM1
        I9FzZfD+i3ytOnLh7mRU2Mw9vG04mNCA6q2IwTbQhaA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H-QU6SyRi1OR for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 09:42:43 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0Nsv4xPmzBHXh5;
        Tue, 11 Jul 2023 09:42:43 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 09:42:43 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/pmu: add spaces around '='
In-Reply-To: <20230711013754.77743-1-xujianghui@cdjrlc.com>
References: <20230711013754.77743-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9d43392febad17411b442e39e729ca4b@208suo.com>
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

This fixes the checkpatch.pl errors:

ERROR: spaces required around that '=' (ctx:VxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk20a.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk20a.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk20a.c
index b5e52b35f5d0..d3e67c41560d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk20a.c
@@ -98,7 +98,7 @@ gk20a_pmu_dvfs_get_dev_status(struct gk20a_pmu *pmu,
      struct nvkm_falcon *falcon = &pmu->base.falcon;

      status->busy = nvkm_falcon_rd32(falcon, 0x508 + (BUSY_SLOT * 
0x10));
-    status->total= nvkm_falcon_rd32(falcon, 0x508 + (CLK_SLOT * 0x10));
+    status->total = nvkm_falcon_rd32(falcon, 0x508 + (CLK_SLOT * 
0x10));
  }

  static void
@@ -188,7 +188,7 @@ gk20a_pmu_init(struct nvkm_pmu *pmu)
  }

  static struct gk20a_pmu_dvfs_data
-gk20a_dvfs_data= {
+gk20a_dvfs_data = {
      .p_load_target = 70,
      .p_load_max = 90,
      .p_smooth = 1,
