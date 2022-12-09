Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8F648466
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLIO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:59:10 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE655302;
        Fri,  9 Dec 2022 06:59:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 711E57D47B;
        Fri,  9 Dec 2022 17:23:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595839;
        bh=ru7ZhzL3gCpkBa2tYBC7LlIYfyyUWNzdAZhrSEsjuA4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=m58LS9zTxGauhaa8NL92tCBxhjMpRP4/qCHxefFPr3Usv1n8Kw26spAk9Dt+z5k0/
         xV7Gjt3r53EQcv3t+hAqzt8wjRWOkb0G1E3oumqA2hsGmTQshdTOleo2pt4ohSW3fe
         P50xz33AxSFx0/0xLd4goAO8ywGfTdoJFGB/ZuvuSVKYJnHmtpaMdiQyGOnx/MycQF
         xWNMHUmcv8A/O3Iv/HMHZjN/wMqkPOVOwooJW6eN1IuHt2jHKDutm97YYbmJoz5Y/G
         PUn4eXsTPzOatGJmpvvmcjrAS/Zp+Eoh3LA6G1YXyGw3R0olD1NxxKBaobq8E6eDIQ
         uBKlVZfY/Odpw==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:23:56 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 03/21] documentation, capability: fix Generic Block Device Capability
Date:   Fri, 9 Dec 2022 15:23:13 +0100
Message-ID: <20221209142331.26395-4-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding documentation for blkfilter, new lines of documentation
appeared in the file include/linux/blkdev.h. To preserve the appearance
of this document, the required sections and function descriptions were
explicitly specified.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/capability.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/block/capability.rst b/Documentation/block/capability.rst
index 2ae7f064736a..8fad791980bb 100644
--- a/Documentation/block/capability.rst
+++ b/Documentation/block/capability.rst
@@ -8,3 +8,6 @@ This file documents the sysfs file ``block/<disk>/capability``.
 capabilities a specific block device supports:
 
 .. kernel-doc:: include/linux/blkdev.h
+	:DOC: genhd capability flags
+.. kernel-doc:: include/linux/blkdev.h
+	:functions: disk_openers blk_alloc_disk bio_end_io_acct
-- 
2.20.1

