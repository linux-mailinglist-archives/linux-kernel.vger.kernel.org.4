Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70AE74CE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGJHWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:22:06 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDCC3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:22:04 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzwRs1DrjzBHXgt
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:22:01 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688973721; x=1691565722; bh=Gh6EO96d1xAiEk2mS1BrOEBqriM
        6TGQNOsWTpVDRBTg=; b=bcXuONgPFCFhEmvNus1glrMHcK66koNeg5ekp7gM+N6
        aZ9x8twCxrYlCoAZorB9cSE99YIec0JNogEP82wX1o+lQ280CpViL8yEEVh2Wdng
        pOKBoOsszwt+zz5XOa8rnNREz+ENXGrFCmZ1ke6twa5kwg/2kleoa4SgIcCP5kFI
        TKJFV/l0jwrIlK6cCEXH+PcsQuzBheqpXnBkhsNsirIolDCHbmg4WITFFrGg39Vu
        dU3H6YkvvmFj+QxE474BnnXTypk/1n77sCPzKv91yDxq6OzZewrQIVIJ0bEmqgF7
        qSkBdqH+4bGUbcm3n0J12bMHRfTpsnS3AGyOW2HOmAQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PQ4EqNxbrqUq for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 15:22:01 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzwRr6QXYzBHXgs;
        Mon, 10 Jul 2023 15:22:00 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 15:22:00 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/pci: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <20230710072012.54076-1-xujianghui@cdjrlc.com>
References: <20230710072012.54076-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <0b4bfadaf22077b14fe579c1935058ff@208suo.com>
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

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
index 6be87ecffc89..bc51987c5f5f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
@@ -147,7 +147,7 @@ gk104_pcie_set_link_speed(struct nvkm_pci *pci, enum 
nvkm_pcie_speed speed)
  }

  static int
-gk104_pcie_init(struct nvkm_pci * pci)
+gk104_pcie_init(struct nvkm_pci *pci)
  {
      enum nvkm_pcie_speed lnkctl_speed, max_speed, cap_speed;
      struct nvkm_subdev *subdev = &pci->subdev;
