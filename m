Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB3867DDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjA0Gk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjA0GkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C169B0A;
        Thu, 26 Jan 2023 22:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WOlMkCDCy8lExYDWc6Zx7In/UvKr77iVceai4v2zQUc=; b=yREXSIUIV0KMN9H5ZkaIyKd563
        3lB4/W0R3xNn2UEXA2m04oQGR77gKuYmlVUjC6DDi4OefqeMCQf9fP12CuwM9YROmrb2umhlh80b8
        bLbRy4wsd8Rfz/Id5LeluVJPBXytotX27WLLh7FoaAI/ToKMfn6540Hm/Gv+TsLeF1ExHzJeCsB4H
        WO914oX+2i5tV24+vSNsbfb4QplCzHi4Cznr6hydoK5gyqZM8KjeMf6x4Xuc7MGAEGzec/8ZkirY2
        emlXXA4m2qIspfBbvlUX9I10zsA4tONNuBiJ1RKzN1DczSmHo2wKjpqEeIXW6Qe9OsiVbCdIGfYE1
        bYOrSuCg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPC-00DM0u-VC; Fri, 27 Jan 2023 06:40:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 03/35] Documentation: block: correct spelling
Date:   Thu, 26 Jan 2023 22:39:33 -0800
Message-Id: <20230127064005.1558-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/block/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/block/data-integrity.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/block/data-integrity.rst b/Documentation/block/data-integrity.rst
--- a/Documentation/block/data-integrity.rst
+++ b/Documentation/block/data-integrity.rst
@@ -209,7 +209,7 @@ will require extra work due to the appli
       sector must be set, and the bio should have all data pages
       added.  It is up to the caller to ensure that the bio does not
       change while I/O is in progress.
-      Complete bio with error if prepare failed for some reson.
+      Complete bio with error if prepare failed for some reason.
 
 
 5.3 Passing Existing Integrity Metadata
