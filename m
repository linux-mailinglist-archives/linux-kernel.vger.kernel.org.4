Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5844F73B507
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjFWKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjFWKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:17:16 -0400
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [IPv6:2001:41d0:1004:224b::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E76E75
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:17:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687514907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WQvQ1/8ew72J0lPd28yNsu5tnN3fJmOWFY9fr+RpJdw=;
        b=jwmZ6pTywJ2krzZsDq3HjK7YXRqLJREJOP/aKd1VPXwi8EHrGBlxcFsG7bmb3VuYIYDIqX
        H68rmmEGjFLohzjNfmCSXXweAjP17iBHfkqsmnTfWZbPRNe1kS2wZ3rw5cZ32sHeIFoSQX
        9m5BB/xHZe/63cSH3icuf4ux1cjMN0k=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v1 0/8] drm/etnaviv: Various cleanup
Date:   Fri, 23 Jun 2023 18:08:14 +0800
Message-Id: <20230623100822.274706-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

No functional change.

Sui Jingfeng (8):
  drm/etnaviv: Using the size_t variable to store the number of pages
  drm/etnaviv: Using the unsigned int type to count the number of pages
  drm/etnaviv: Drop the second argument of the etnaviv_gem_new_impl()
  drm/etnaviv: Remove surplus else after return
  drm/etnaviv: Keep the curly brace aligned
  drm/etnaviv: No indentation by double tabs
  drm/etnaviv: Add dedicated functions to create and destroy platform
    device
  drm/etnaviv: Add a helper to get a pointer to the first available node

 drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 100 +++++++++++++-------
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  14 +--
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   7 +-
 3 files changed, 77 insertions(+), 44 deletions(-)

-- 
2.25.1

