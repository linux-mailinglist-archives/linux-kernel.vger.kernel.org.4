Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3F7127D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbjEZN5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbjEZN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:57:38 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07249DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685109456;
  x=1716645456;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=+pRMtqz9M0MkiP7GC7T1ugAxvsxIHVc59tban5NM8k8=;
  b=AFDqNMM8s6H5YZ1Yh0d/AZfIAp64SbdgH/G5JLYs7xQFSt4rlsBkTe3u
   MgZB/U9/1uIbdPOM2vJmA5tLo4IQo6Ta9pYA+VATJeyZNHYpVgX6iaOax
   +dpEBtc1Vy7N8WOM9yVhEYqAoWjuOIgVC4P7eNP9g7Z/5p4B5NjlDdOFW
   0OVsT8KTCAus9HL80cpLh0BWaPIKH4quIph+q69ZcdreBj5zoPCA1HyLJ
   +ClxrTwQzbvORgtcfq9dsSE2B7/bFdRo3CuV7kXheaURFkmHo0jV6B5Lk
   nYJwqmrkpv7khLgI4k8J4XoE7Tp2jEZ/TyK3RkHsU8ycJxeomp3N813LL
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH mm-nonmm-unstable v2 0/2] squashfs: fixups for caching
Date:   Fri, 26 May 2023 15:57:29 +0200
Message-ID: <20230526-squashfs-cache-fixup-v2-0-6fb7723c3647@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMm6cGQC/32OwQ6CMBBEf4Xs2TVQUKIn/8Nw2JbFNpEWu0BQw
 r9b+QAvk0xmXmZWEI6OBa7ZCpFnJy74ZNQhA2PJPxhdmzyoXJX5SZ1RXhOJ7QQNGcvYuWUasLh
 UVVm0XCnWkFBNwqgjeWN/cBeCps8vGCInYt+7Q9+jDz7p5GUk/WRoUsU6GUN874/mYi/+H58Lz
 LE9VVR3pEqu9Y0WJ0cTemi2bfsCst+lLeMAAAA=
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <hch@lst.de>, <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        "Vincent Whitchurch" <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a couple of fixups for
squashfs-cache-partial-compressed-blocks.patch which is currently in
mm-nonmm-unstable.

---
Changes in v2:
- Add Christoph's Reviewed-by in 1/2
- Restrict line lengths to 80 columns in 2/2
- Link to v1: https://lore.kernel.org/r/20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com

---
Vincent Whitchurch (2):
      squashfs: fix page update race
      squashfs: fix page indices

 fs/squashfs/block.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
---
base-commit: 84cc8b966a3d4cde585761d05cc448dc1da0824f
change-id: 20230526-squashfs-cache-fixup-194431de42eb

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

