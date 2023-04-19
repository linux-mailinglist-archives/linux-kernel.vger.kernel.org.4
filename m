Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65256E7462
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjDSHvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDSHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:50:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288C4C667;
        Wed, 19 Apr 2023 00:50:09 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681890606;
        bh=/y/LjHs7yJYnTHvYV6YwR0IapRAaxIiFC3wYOEdmUYA=;
        h=From:Subject:Date:To:Cc:From;
        b=UI/45fznHtjkmIIGwPGvntYD16dwY2IwhdTX3gfQd4nsCv/EaDaqIY3KHPqN9bqud
         2Gzoy6iq+Kai4hHrAGPftDFhClw8UM9OSC8Qb+DCbpuYrjotQ80KCzBuP0Iz4x/ONy
         wyGH9xPos7hE13QhwIRSmS9N18T1vzAA/jGrPIIA=
Subject: [PATCH 0/4] block: constify some structures of partitions/core.c
Date:   Wed, 19 Apr 2023 09:50:00 +0200
Message-Id: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACidP2QC/x2N0QqDMAxFf0XyvECtw+F+Zeyh7dIZkChJHQPx3
 xf2eA73cA8wUiaDe3eA0oeNV3HoLx2UOcmbkF/OEEMcwrWfsKxiDbekjZtvMYUxT/U25lgH8Co
 nI8yapMzeyb4sLjelyt//zeN5nj96zDqDdgAAAA==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681890605; l=685;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/y/LjHs7yJYnTHvYV6YwR0IapRAaxIiFC3wYOEdmUYA=;
 b=nDK5iA952VuF7/ZmqgYxuikOGxAqTHCJ7Ue1XPrHuI6l5AbUTNUytu5TLG8BunVWY4KZz/nIr
 2EMs+QsUWdXBiwnjZy7qNVJ6sBXFJOa10U/Ac9esJh6mVC2i5tBcA53
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

