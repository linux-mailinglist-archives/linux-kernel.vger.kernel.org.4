Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014DC5EECC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiI2E3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiI2E3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1201C2F018
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664425788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M1eGJAy9JUkESfaO/ZbKwDLtqZLkZ000Az8C4hJ30SA=;
        b=W26Uvkipjvor+94co9l3tIBRVMMm/0pWWPU4Vfn3zcXIQqMJLPk26PoRC907w2qspwwB9l
        UJ1J292NSR9HgD2OgMNHsLW8p7dyFLtKdOPXApIZft+D3jNoGfImibQ9pcTltF0Mdw4vB0
        bhNdEdKRxt/5q5d0PfJKlRwcVlIwxWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-JvxKXV_XOnaIq5hBsAQyEw-1; Thu, 29 Sep 2022 00:29:44 -0400
X-MC-Unique: JvxKXV_XOnaIq5hBsAQyEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C20F85A583;
        Thu, 29 Sep 2022 04:29:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-179.pek2.redhat.com [10.72.13.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63AF07AE5;
        Thu, 29 Sep 2022 04:29:39 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     kexec@lists.infradead.org, ebiederm@xmission.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 0/4] Some minor cleanup patches resent
Date:   Thu, 29 Sep 2022 12:29:32 +0800
Message-Id: <20220929042936.22012-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches are reviewed and acked, are all trivial clean up
patches.

And for the patch "kexec: replace crash_mem_range with range", I got a
ibm-p9wr ppc64le system to test, it works well.

Hi Andrew,

Please help pick them into mm-nonmm-unstable branch.


Chen Lifu (1):
  ARM: kexec: Make machine_crash_nonpanic_core() static

Jianglei Nie (1):
  proc/vmcore: fix potential memory leak in vmcore_init()

Li Chen (1):
  kexec: replace crash_mem_range with range

ye xingchen (1):
  kexec: Remove the unneeded result variable

 arch/arm/kernel/machine_kexec.c   |  2 +-
 arch/powerpc/kexec/file_load_64.c |  2 +-
 arch/powerpc/kexec/ranges.c       |  8 ++++----
 fs/proc/vmcore.c                  |  1 +
 include/linux/kexec.h             |  7 ++-----
 kernel/kexec_core.c               | 10 ++--------
 kernel/kexec_file.c               |  2 +-
 7 files changed, 12 insertions(+), 20 deletions(-)

-- 
2.34.1

