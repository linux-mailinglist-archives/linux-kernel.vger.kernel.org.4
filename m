Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4215F4F68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJEFO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJEFOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:14:53 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D62B4AC;
        Tue,  4 Oct 2022 22:14:51 -0700 (PDT)
Date:   Wed, 5 Oct 2022 13:14:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664946889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoNA2Gd94JISVBvKVnRLBjCp4hjbn2DIfYqCzzaFLMY=;
        b=XM0wORCagIM1TjPjV5B2OhReAKRqdUQ2+8rt4nvOAgim+i5WhWQTGDx2wDEBbDtrkvryyV
        SsKmECHh1OU+rzEaNlCiGBQGv7b1yx/F3B7T7nUJSTGYNHZRjYKeF29EIqJnKf9OIqEK4E
        4kzyWA/VvD5DQ9o0HacMReOP56mGZuI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] docs/zh_CN: promote the title of zh_CN/process/index.rst
Message-ID: <b74803bbbd8adc0a99dd152de9bf9c9a707caaec.1664945550.git.bobwxc@email.cn>
References: <cover.1664945550.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1664945550.git.bobwxc@email.cn>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu XiangCheng <bobwxc@email.cn>

update to commit 9d0f5cd16744 ("docs: promote the title of
process/index.rst")

Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
 Documentation/translations/zh_CN/process/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
index a683dbea0c83..a1a35f88f4ae 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -10,6 +10,7 @@
 
 .. _cn_process_index:
 
+========================
 与Linux 内核社区一起工作
 ========================
 
-- 
2.30.2


-- 
Wu XiangCheng	0x32684A40BCA7AEA7

