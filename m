Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB6B69010B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBIHPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBIHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E58341B61;
        Wed,  8 Feb 2023 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=TTmkJjzB/TzFwK04yvO6w8l63tjIRq3L6xbfwHjafmc=; b=yGy1xEGMcpzfokEtQwYZJdxqhH
        eR82M7nyyNdk1Ik5YUa3W70jsXfhJmoic5R1yOK0jtSE8SgGZFhkCQeUYz3TD5xrpiA+zKW+SVVYp
        SF8hMfdW4SYMrVoUJ0asNnemzhQ1dGfWOUDd3M0JEfSOxcJUJwfunNmApwbW6YUbcEpNe5y+zKXwq
        NkF6rKoefOqeL21CdJUTYJwlsg1f0x5DJoXMoO/Zb7pBWLArgVb6RbHCr+uG3dPI/+SPAv3dhkua/
        zUpNLRfKy72qEBmL5wKpH4CN+NFruPSLhGE3n53j5nzOlXQo4S04V29gU/G29sfF5bImtnH7pVjgj
        F58TXoKg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18D-000LPt-8k; Thu, 09 Feb 2023 07:14:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 11/24] Documentation: mm: correct spelling
Date:   Wed,  8 Feb 2023 23:13:47 -0800
Message-Id: <20230209071400.31476-12-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/mm/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/mm/hmm.rst      |    4 ++--
 Documentation/mm/hwpoison.rst |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -416,10 +416,10 @@ can be used to make a memory range inacc
 
 This replaces all mappings for pages in the given range with special swap
 entries. Any attempt to access the swap entry results in a fault which is
-resovled by replacing the entry with the original mapping. A driver gets
+resolved by replacing the entry with the original mapping. A driver gets
 notified that the mapping has been changed by MMU notifiers, after which point
 it will no longer have exclusive access to the page. Exclusive access is
-guranteed to last until the driver drops the page lock and page reference, at
+guaranteed to last until the driver drops the page lock and page reference, at
 which point any CPU faults on the page may proceed as described.
 
 Memory cgroup (memcg) and rss accounting
diff -- a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
--- a/Documentation/mm/hwpoison.rst
+++ b/Documentation/mm/hwpoison.rst
@@ -50,7 +50,7 @@ of applications. KVM support requires a
 For the KVM use there was need for a new signal type so that
 KVM can inject the machine check into the guest with the proper
 address. This in theory allows other applications to handle
-memory failures too. The expection is that near all applications
+memory failures too. The expectation is that near all applications
 won't do that, but some very specialized ones might.
 
 Failure recovery modes
