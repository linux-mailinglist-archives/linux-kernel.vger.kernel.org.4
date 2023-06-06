Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390527242FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbjFFMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbjFFMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F561739
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686055683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vBuXSuSPdimIWw9Er+nDNajoR4GFZLeXMeLl/oUym/M=;
        b=Q0vQU2zitcgNR4omm2ijkG24n3xpzAiFDGrLYrz43d02G1r2NLlIbF308s8QOoStGTfCCs
        6Xu6Rwocrp0LGxXunzegsQrObcCpNm7R9bhMSF9sIb0lz41F56I0HbAb9xrAu6LsSnOoCd
        rM3cYTN2VJPvedrUyp4ftLtkUm0oaz4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-YkT4_XVkMEuDXihv90vsXw-1; Tue, 06 Jun 2023 08:48:02 -0400
X-MC-Unique: YkT4_XVkMEuDXihv90vsXw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3A213C0F189;
        Tue,  6 Jun 2023 12:48:01 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.225.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2475492B00;
        Tue,  6 Jun 2023 12:48:00 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fix
Date:   Tue,  6 Jun 2023 14:48:00 +0200
Message-Id: <20230606124800.1151665-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following fix.

Thanks,
Andreas

The following changes since commit 48b1320a674e1ff5de2fad8606bee38f724594dc:

  Merge tag 'for-6.4-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-05-30 17:23:50 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-rc4-fix

for you to fetch changes up to fa58cc888d67e640e354d8b3ceef877ea167b0cf:

  gfs2: Don't get stuck writing page onto itself under direct I/O (2023-06-01 14:55:43 +0200)

----------------------------------------------------------------
gfs2 fix

- Don't get stuck writing page onto itself under direct I/O.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Don't get stuck writing page onto itself under direct I/O

 fs/gfs2/file.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

