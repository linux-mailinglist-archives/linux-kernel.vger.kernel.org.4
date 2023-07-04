Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616C74691F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGDFoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGDFoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:44:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B788E49
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4RAeuGYS32ednl6UYNlBuw7BxV1DgaznM7BPLIITrC0=; b=04XcZF9Z2jf8rTzj6xpZ8/XLzI
        GrwCSYzIR2iE4exFO48mjWhdIlNebImOokeinRRZSBIqAp17zjJgxccHpTaAA+NpU69C8422sMrU+
        nteZTa1XAvWQmWILuaOL+Ga0BaEd5WCZefLyErVaQKuU1ULvXroZj/FjCRJ/s8yWubnvqlywiohrL
        c2go9HCFFqu8FTOPlwgTzfdvY8HjggQLww6kaK/2dpakfHrDSsW4Ht71Mwsg6LwXobvjOyryWYyJL
        I5SeIyuksBTeAmmajxbyt/OsD4gDBEqiULctqhuBzJOEg50PMkzuKBzWgJ5vj2PkAZBWhO4n4w+KZ
        +sJsQo+g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGYpf-00CECW-3C;
        Tue, 04 Jul 2023 05:44:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: add linux-next info
Date:   Mon,  3 Jul 2023 22:44:10 -0700
Message-ID: <20230704054410.12527-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux-next info to MAINTAINERS for ease of finding this data.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff -- a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12067,6 +12067,13 @@ F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
 
+LINUX-NEXT TREE
+M:	Stephen Rothwell <sfr@canb.auug.org.au>
+L:	linux-next@vger.kernel.org
+S:	Supported
+B:	mailto:linux-next@vger.kernel.org and the appropriate development tree
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
+
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
