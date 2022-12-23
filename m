Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE34654C14
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiLWEyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLWExd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:53:33 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B98BC19;
        Thu, 22 Dec 2022 20:53:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NdZZF6Hlbz4f3p1W;
        Fri, 23 Dec 2022 12:53:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXjbFHNKVjpOduAQ--.93S2;
        Fri, 23 Dec 2022 12:53:28 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, shikemeng@huaweicloud.com
Subject: [PATCH 00/13] A few bugfix and cleanup patches for blk-mq
Date:   Fri, 23 Dec 2022 20:52:10 +0800
Message-Id: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXjbFHNKVjpOduAQ--.93S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1xXF4fKry7XFWDAF1DZFb_yoW8Jw4kpF
        43GFnxGa1fJry2qr1fAw47AF9avF4kGrW7JwnxC34rJr4DCryUJrWkWa1fZry0yFZxCanr
        WF18Xw1YkF1Iqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjTRNg
        AwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this series contain several bugfix patches to fix potential io
hung and a few cleanup patches to remove stale codes and unnecessary
check. Most changes are in request issue and dispatch path. Thanks.

Kemeng Shi (13):
  blk-mq: avoid sleep in blk_mq_alloc_request_hctx
  blk-mq: remove stale comment for blk_mq_sched_mark_restart_hctx
  blk-mq: wait on correct sbitmap_queue in blk_mq_mark_tag_wait
  blk-mq: Fix potential io hung for shared sbitmap per tagset
  blk-mq: remove unnecessary list_empty check in
    blk_mq_try_issue_list_directly
  blk-mq: remove unncessary error count and flush in
    blk_mq_plug_issue_direct
  blk-mq: remove error count and unncessary flush in
    blk_mq_try_issue_list_directly
  blk-mq: simplify flush check in blk_mq_dispatch_rq_list
  blk-mq: remove unnecessary error count and check in
    blk_mq_dispatch_rq_list
  blk-mq: remove set bd->last when get driver tag for next request fails
  blk-mq: remove unncessary from_schedule parameter in
    blk_mq_plug_issue_direct
  blk-mq: use switch/case to improve readability in
    blk_mq_try_issue_list_directly
  blk-mq: correct stale comment of .get_budget

 block/blk-mq-sched.c |   7 ++-
 block/blk-mq.c       | 103 ++++++++++++++++++-------------------------
 2 files changed, 46 insertions(+), 64 deletions(-)

-- 
2.30.0

