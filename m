Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FDA65A970
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 10:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjAAJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 04:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAAJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 04:15:03 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD095F7B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 01:15:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VYU.DIn_1672564497;
Received: from localhost(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VYU.DIn_1672564497)
          by smtp.aliyun-inc.com;
          Sun, 01 Jan 2023 17:14:58 +0800
From:   Yang Su <yang.su@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     alex.williamson@redhat.com, matthew@wil.cx,
        jbarnes@virtuousgeek.org, rjw@sisk.pl, greg@kroah.com,
        patchwork-bot@kernel.org, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org
Subject: [tune sbr time 0/1] Tune pci sbr time
Date:   Sun,  1 Jan 2023 17:14:56 +0800
Message-Id: <cover.1672563632.git.yang.su@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pci_reset_secondary_bus, the waiting time is so long for PCIe devies.
As reference PCIe spec, this patch can handle different cases for PCI/PCIe devices
in pci_reset_secondary_bus.

Yang Su (1):
  PCI: Tune secondary bus reset time for PCIe

 drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

-- 
2.19.1.6.gb485710b

