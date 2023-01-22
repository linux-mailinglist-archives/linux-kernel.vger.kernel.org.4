Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F47676BC0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjAVJCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAVJCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE261B572
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674378081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a7i0etABdzzwG0ukyprDvsLxykkelef63qcM2z1SEbk=;
        b=IgvvO5sr+q4kI8LDeVnhljupPrYxWDsZWVsFpZyQlazWVaYwTWSgNz7XOuZQbf8OwZfHF3
        vIPKQCd1bc5bIORaDvnJ5ry7F/JRKHgavXUmnYke6KuJUx8w4CcDPAe/BZo532YjOkhB0/
        /Hslht5ufokP3tVyv3IPMhE7/YrMnJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-_O1Z6BB3OQ6qg8TKid8LZg-1; Sun, 22 Jan 2023 04:01:19 -0500
X-MC-Unique: _O1Z6BB3OQ6qg8TKid8LZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B44FD101A521;
        Sun, 22 Jan 2023 09:01:18 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-72.brq.redhat.com [10.40.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C064614171C0;
        Sun, 22 Jan 2023 09:01:16 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 writepage fix
Date:   Sun, 22 Jan 2023 10:01:15 +0100
Message-Id: <20230122090115.1563753-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

Hi Linus,

please consider pulling the following gfs2 fix.

Thank you very much,
Andreas

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.2-rc4-fix

for you to fetch changes up to 95ecbd0f162fc06ef4c4045a66f653f47b62a2d3:

  Revert "gfs2: stop using generic_writepages in gfs2_ail1_start_one" (2023-01-22 09:46:14 +0100)

----------------------------------------------------------------
gfs2 writepage fix

- Fix a regression introduced by commit "gfs2: stop using
  generic_writepages in gfs2_ail1_start_one".

----------------------------------------------------------------
Andreas Gruenbacher (1):
      Revert "gfs2: stop using generic_writepages in gfs2_ail1_start_one"

 fs/gfs2/log.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

