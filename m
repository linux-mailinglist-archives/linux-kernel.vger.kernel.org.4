Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA58712777
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbjEZN0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjEZN0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:26:11 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6119D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685107568;
  x=1716643568;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=qs3VDmnWU6hqfo1HF5Y48lix59HfX8Y5haEAbPbx0uA=;
  b=NPcdIDTGZB/ZCyhFWh4Z8Vwxk7eBRGtRphwQiMEfpYaHMzzOWx79UGqE
   clkWUQ178q/kEmCkku7Kv3XdZUjGH2XzXb4Q9NuZZaS6I66a5TqRoLy1a
   wP0wOsGujukqRNmxP2y7BmqZve1wgBnDa7zYluB7bc6D+dUTxDlJ7fcT9
   7if5ZjsdsII4G6CmfDP5dTkRXIMFWoLKVmBVrsUmhm7jjZ5jv2YD1xzgI
   TvugA6siX6+6ThlMY0r3vHO7fWQKXb+1acbU3Euabmb91zkBGRW8OA89N
   y2VCsYuBdBUF3VEHA7RADgd0VBxI4itbrGL91g/F6AxTtGr6Sfy4C7SYd
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH mm-nonmm-unstable 0/2] squashfs: fixups for caching
Date:   Fri, 26 May 2023 15:25:44 +0200
Message-ID: <20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFizcGQC/x2NQQrCMBBFr1Jm7UCTRkGvIi4m6dQE7KRmjIild
 zd18+HxebwVlEtihUu3QuF30pSlgTl0ECLJnTGNjcH2duiP9oT6rKRxUgwUIuOUPnVBc3ZuMCM
 7yx6a6kkZfSEJcZennD1992Mp3Ix/7wrzjJKlbRV9kX8w3LbtBzIjcDmSAAAA
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
Vincent Whitchurch (2):
      squashfs: fix page update race
      squashfs: fix page indices

 fs/squashfs/block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 84cc8b966a3d4cde585761d05cc448dc1da0824f
change-id: 20230526-squashfs-cache-fixup-194431de42eb

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

