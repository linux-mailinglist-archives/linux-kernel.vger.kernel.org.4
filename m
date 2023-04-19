Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03B26E7A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjDSNX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjDSNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:23:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCF414F68;
        Wed, 19 Apr 2023 06:22:57 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681910575;
        bh=klYiuuUb5oXZM4ugTkwBgAm1OjuezMQ2gNNkcO7W7p0=;
        h=From:Subject:Date:To:Cc:From;
        b=HgDJgJi8fgD+JlFI75gNSXnKehGZWZ2VNoNAxFx3g4Wx4ZhsmbhVxiFM8kPc0fRz3
         wwhtzRlWKaFVT0OGBaZEu5EAcA3qU6NHjZL/pNrRzqTER5xIqca+Yk28eOrFenkXkj
         r64sixvyeUFHrIRMaOTk2nBCIZv024wcen/c11nk=
Subject: [PATCH v2 0/4] block: constify some structures of
 partitions/core.c
Date:   Wed, 19 Apr 2023 15:22:52 +0200
Message-Id: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACzrP2QC/3WNwQ6DIBAFf8VwLg1Cg9qT/9F4AFzKJgYNi7aN8
 d9Lvfc4L28yOyNICMTu1c4SbEg4xwLyUjEXTHwCx7Ewk0Iqcas77uZImS8mZczly43QtvONttI
 rVixrCLhNJrpQvLhOUxmXBB7fZ+YxFA5IeU6fs7rVv/V/YKu54HLU2suxVW2j+hcgEbmwhmuEz
 IbjOL7eWLqvyAAAAA==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681910574; l=891;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=klYiuuUb5oXZM4ugTkwBgAm1OjuezMQ2gNNkcO7W7p0=;
 b=4CvKkSO7rwHmSdAiZF8HubO43zK2IGjrUaNIE6Pi98mLkufA3sa+1ac0WCgkpLcRRqesfEq1L
 viZ9p6KVFv1BtFyIpdQggysUAV0yFwB5MfCis7yeYXJ53lVAHEzkH9l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few structures containing function pointers that could and should be
const are not. Change that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Use correct syntax for const array of function pointers.
  Reported by LKP bot.
- Link to v1: https://lore.kernel.org/r/20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net

---
Thomas Weißschuh (4):
      block: constify partition prober array
      block: constify struct part_type part_type
      block: constify struct part_attr_group
      block: constify the whole_disk device_attribute

 block/partitions/core.c | 8 ++++----
 include/linux/blkdev.h  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: af67688dca57999fd848f051eeea1d375ba546b2
change-id: 20230419-const-partition-a06b9f76b2f3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

