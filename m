Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50DE6612FD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 03:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjAHCNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 21:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjAHCMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 21:12:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555A15FE1
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 18:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=n8y8MQVrWNjH6e1zcN2SX7rByEyJkNoM8CrUWsOVDAY=; b=gkJ2fdgsn8WnxrFLKMJNn5o1DN
        TB6pHxuKAdPUBAbvUecqKAu0V13l7uYgRIaqIsZOhuWs2DVcotefEL0s+KRIa7IY7iaPsrpCaILK1
        9laEOh2VFdykkXhrums5Ldd/1u+MsKr67OgjloFv5x6BEMIi9Az0sk0DTrrlT4z0G296AQfE/n1wo
        Ky11QOkTTjEQk6k8WTHDBH4u07WvtjbcvXvyRJKEJoQ+j34Ac4Ry8txS17imo0e02S19GPIIN9AOB
        GY0eM0Y3SVE7PfVZ7IRyF0W5FLbfGs/I3gFB8c/K0taIuRg206D1Y4PCLVaKheOTB6UCROJAnyYI8
        gXU+GDUw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pELAz-00Aq8o-Gw; Sun, 08 Jan 2023 02:12:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] userns: fix a struct's kernel-doc notation
Date:   Sat,  7 Jan 2023 18:12:43 -0800
Message-Id: <20230108021243.16683-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
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

Use the 'struct' keyword for a struct's kernel-doc notation to avoid
a kernel-doc warning:

kernel/user_namespace.c:232: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * idmap_key struct holds the information necessary to find an idmapping in a

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/user_namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/kernel/user_namespace.c b/kernel/user_namespace.c
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -229,7 +229,7 @@ void __put_user_ns(struct user_namespace
 EXPORT_SYMBOL(__put_user_ns);
 
 /**
- * idmap_key struct holds the information necessary to find an idmapping in a
+ * struct idmap_key - holds the information necessary to find an idmapping in a
  * sorted idmap array. It is passed to cmp_map_id() as first argument.
  */
 struct idmap_key {
