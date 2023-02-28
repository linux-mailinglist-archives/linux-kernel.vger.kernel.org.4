Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8FE6A5D39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjB1Qhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB1Qhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:37:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FC733459;
        Tue, 28 Feb 2023 08:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IBh5/W4S+Ngb5u8xM/zenW6fPzVp/2VTq/NjigF0gLU=; b=mtXCmW9ocOBaET573x/F4JRZLD
        UrzMeHzMxrrGZstuqbKXIxEUaqkKHa1RgKEaslfRW2h1cOFk12yqJXTVHI23dpec1bdAI9KphMG+t
        C9zqQ23/yNpQmm5mOq89DrWwcn0AdehAsL2dCvEUM+1lPdHPvMoLzBMDxuqr1ZuZVrvJANTcclZgQ
        hMnuIOClWkX0pXeHge9FpUQwyBSNpeciRvhBV7rbtfVVW5+x440rFYNTNfhTLUE7zmr+Fzhar/e6t
        V3HG0KwIJ5iUINlVmHgxUsq8CgVP+1OoEoEgsp/UNOmOsyJ1mpDvRcMEmaSyH6hN3RyyFDVQ5mjA/
        QMiwqQIg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX2yo-00DmBF-1K; Tue, 28 Feb 2023 16:37:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH] MAINTAINERS: drop uclinux.org
Date:   Tue, 28 Feb 2023 08:37:26 -0800
Message-Id: <20230228163726.10984-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
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

uclinux.org is dead. Drop it from the MAINTAINERS file.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 MAINTAINERS |    2 --
 1 file changed, 2 deletions(-)

diff -- a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21384,10 +21384,8 @@ F:	include/uapi/linux/ublk_cmd.h
 UCLINUX (M68KNOMMU AND COLDFIRE)
 M:	Greg Ungerer <gerg@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
-L:	uclinux-dev@uclinux.org  (subscribers-only)
 S:	Maintained
 W:	http://www.linux-m68k.org/
-W:	http://www.uclinux.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
 F:	arch/m68k/*/*_no.*
 F:	arch/m68k/68*/
