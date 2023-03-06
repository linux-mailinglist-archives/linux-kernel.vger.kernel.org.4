Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021566ACA6C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCFRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCFRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:30:05 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70C52637D3;
        Mon,  6 Mar 2023 09:29:27 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 166227A0381;
        Mon,  6 Mar 2023 18:28:28 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/18] pata_parport: protocol drivers fixes and cleanups
Date:   Mon,  6 Mar 2023 18:27:34 +0100
Message-Id: <20230306172752.7727-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes two bugs and cleans up pata_parport protocol drivers,
making the code simpler with no changes in behavior (except logged messages).

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
Changes in v4:
 - dropped whitespace changes from patch 12/18
Changes in v3:
 - added missing reviewed-by tags
 - added more detailed changelog:
   - patches 04-05 are split from v1 patch 02/12
   - patch 06: comment-out instead of if(1)
   - patches 11-14 are split from v1 patch 08/12
Changes in v2:
 - added two bugfixes (first two patches)
 - addressed Sergey's comments (mostly split patches)

 drivers/ata/pata_parport/aten.c                            |  45 ++++----------
 drivers/ata/pata_parport/bpck.c                            |  86 ++++++++------------------
 drivers/ata/pata_parport/bpck6.c                           | 107 ++++++++-------------------------
 drivers/ata/pata_parport/comm.c                            |  52 +++++-----------
 drivers/ata/pata_parport/dstr.c                            |  45 ++++----------
 drivers/ata/pata_parport/epat.c                            |  48 ++++++---------
 drivers/ata/pata_parport/epia.c                            |  55 +++++------------
 drivers/ata/pata_parport/fit2.c                            |  37 ++++--------
 drivers/ata/pata_parport/fit3.c                            |  39 ++++--------
 drivers/ata/pata_parport/friq.c                            |  56 ++++++-----------
 drivers/ata/pata_parport/frpw.c                            |  71 ++++++----------------
 drivers/ata/pata_parport/kbic.c                            |  66 +++++++++-----------
 drivers/ata/pata_parport/ktti.c                            |  38 ++++--------
 drivers/ata/pata_parport/on20.c                            |  45 ++++----------
 drivers/ata/pata_parport/on26.c                            |  52 ++++------------
 drivers/ata/pata_parport/pata_parport.c                    |  31 +++++-----
 {include/linux => drivers/ata/pata_parport}/pata_parport.h |  41 ++++---------
 17 files changed, 271 insertions(+), 643 deletions(-)


