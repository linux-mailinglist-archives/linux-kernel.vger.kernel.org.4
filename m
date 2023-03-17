Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C236BF28B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCQU3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCQU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079DCA8E99
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679084883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrOb7zhbNBSA2vEfdnizburgLjEAzsaXpryIF7Glvbk=;
        b=Go3de1f8e9k1pGBJ5nh27kKzsiswOVo1k7PSkqDhEenEPawiY6Krc/BFNWkxG+tXN7mJTe
        fuDNHXOrSpP+Zq36MbVvDqP3xGwy06i4fO8kJVNnJm7FC1XmbpgR2tTpMCL0AyhEFP7Hw6
        UKiYt4FpX1yO3vZSwIDg/ge6tqLOny4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-oN7h2_Q0PUqxhq_LDwb8xg-1; Fri, 17 Mar 2023 16:27:59 -0400
X-MC-Unique: oN7h2_Q0PUqxhq_LDwb8xg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 762FB1011573;
        Fri, 17 Mar 2023 20:27:58 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB66D492B00;
        Fri, 17 Mar 2023 20:27:57 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] docs nbd: userspace NBD now favors github over sourceforge
Date:   Fri, 17 Mar 2023 15:27:49 -0500
Message-Id: <20230317202749.419094-6-eblake@redhat.com>
In-Reply-To: <20230317202749.419094-1-eblake@redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the sourceforge site for userspace NBD still exists, the code
repository moved to github several years ago.  Then with a recent
patch[1], the github landing page contains just as much information as
the sourceforge page, so we might as well point to a single location
that also provides the code.

[1] https://lists.debian.org/nbd/2023/03/msg00051.html

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: split into its own patch
---
 Documentation/admin-guide/blockdev/nbd.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/nbd.rst b/Documentation/admin-guide/blockdev/nbd.rst
index d78dfe559dcf..faf2ac4b1509 100644
--- a/Documentation/admin-guide/blockdev/nbd.rst
+++ b/Documentation/admin-guide/blockdev/nbd.rst
@@ -14,7 +14,7 @@ to borrow disk space from another computer.
 Unlike NFS, it is possible to put any filesystem on it, etc.

 For more information, or to download the nbd-client and nbd-server
-tools, go to http://nbd.sf.net/.
+tools, go to https://github.com/NetworkBlockDevice/nbd.

 The nbd kernel module need only be installed on the client
 system, as the nbd-server is completely in userspace. In fact,
-- 
2.39.2

