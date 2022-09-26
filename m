Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1555EBD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiI0IUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiI0IUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:20:30 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5AA2855
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:20:23 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id WJW00017;
        Tue, 27 Sep 2022 16:20:17 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.12; Tue, 27 Sep 2022 16:20:18 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtio_ring: make vring_alloc_queue_packed prettier
Date:   Mon, 26 Sep 2022 14:33:06 -0400
Message-ID: <20220926183306.4535-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022927162017e45a92dbb46eb7a3b8f86527eddb35eb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some spaces to vring_alloc_queue(make it look prettier).

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8974c34b40fd..84347e7c52e0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1875,7 +1875,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
 				 &ring_dma_addr,
-				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
+				 GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
 	if (!ring)
 		goto err;
 
@@ -1887,7 +1887,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	driver = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &driver_event_dma_addr,
-				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
+				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
 	if (!driver)
 		goto err;
 
@@ -1897,7 +1897,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
-				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
+				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
 	if (!device)
 		goto err;
 
-- 
2.27.0

