Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D806FE173
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjEJPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbjEJPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0710C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683731962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+odEb/CddiPanIjP3NENKAtVaPdlZaMZHb/Bt6y5uac=;
        b=MYnDa3mf2/M1v5Ou0RTWOmKzqyZ1MdBc7L67k0fhavrBQ80VnVm56GtnWv/p92MB6L3ImN
        /BFTWYM1MrPYHDuT1YFXWO0Vw3JaJHN2/XmMkF/K162rPfqSUe+sPi6dGkui9o1eGMbDvl
        d1tVycyhQCw/uZVUqopBFyVxZwQelZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-UGKLhEyqPXe04o3PjnKujg-1; Wed, 10 May 2023 11:19:20 -0400
X-MC-Unique: UGKLhEyqPXe04o3PjnKujg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12E4D870820;
        Wed, 10 May 2023 15:19:20 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3836240C2077;
        Wed, 10 May 2023 15:19:19 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2: Don't deref jdesc in evict
Date:   Wed, 10 May 2023 17:19:18 +0200
Message-Id: <20230510151918.280115-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

could you please pull the following gfs2 fix for 6.4?

Thanks,
Andreas

The following changes since commit e0fcc9c68d1147ca33159d57332b02ca8bac6ab9:

  Merge tag 'gfs2-v6.3-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2023-04-26 09:28:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.3-fix

for you to fetch changes up to 504a10d9e46bc37b23d0a1ae2f28973c8516e636:

  gfs2: Don't deref jdesc in evict (2023-05-10 17:15:18 +0200)

----------------------------------------------------------------
gfs2 fix

- Fix a NULL pointer dereference when mounting corrupted filesystems.

----------------------------------------------------------------
Bob Peterson (1):
      gfs2: Don't deref jdesc in evict

 fs/gfs2/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

