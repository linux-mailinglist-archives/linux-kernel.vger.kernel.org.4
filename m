Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E4B696AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjBNRC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjBNRCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:02:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613D2B0B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qM5rAF9oe+V/nPvIeEGjjcBrXRu3YtL7aZzCIBPGYt8=; b=dtUy07+154ZZm6pAQENNC28z9L
        AOYx9Acu4obpL9oW8jS/dDbu9nuXcHtywtl+fmy79woug2nPCS/UO8jtpNof9mf0qUpCDNen62my1
        0osqXO+Nw9C2bbItln2xKRkbMviQzyQYY1/f7p1ZcFL3nWxp7f4U6IE31dwWmUHNG5sEU92YbqdeZ
        o6mNN0ElBHXl8AB4AuQUqj6UR0Z+H+8SAfvBbHwRu6Fhp9q+KBbfavW9ej0X7CZ4wqF1PM/BzKoU/
        zeakSNMVrv78pco9tyAU9FuqE7ul7c5DSwZqVKKf/SiSVema+/243UuZOXPlkkToWsRLqX9JpfrXb
        YGcNCr6w==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRygy-002vsi-Uk; Tue, 14 Feb 2023 17:02:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [PATCH] MAINTAINERS: update FPU EMULATOR web page
Date:   Tue, 14 Feb 2023 09:02:08 -0800
Message-Id: <20230214170208.17287-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The web page entry for the FPU EMULATOR no longer works.
I notified Bill of this and he asked me to update it to this
new entry.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bill Metzenthen <billm@melbpc.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8067,7 +8067,7 @@ F:	drivers/fpga/microchip-spi.c
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-W:	http://floatingpoint.sourceforge.net/emulator/index.html
+W:	https://floatingpoint.billm.au/
 F:	arch/x86/math-emu/
 
 FRAMEBUFFER CORE
