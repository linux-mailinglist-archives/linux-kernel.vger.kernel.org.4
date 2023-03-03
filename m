Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37506AA59E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCCX3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCCX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:29:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362025E2D;
        Fri,  3 Mar 2023 15:29:30 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z42so3902310ljq.13;
        Fri, 03 Mar 2023 15:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CJvbt6nvoRaOMGhp2QxmaYvjH1scDwvD9rjxCVXSSvg=;
        b=WX3X7bF9vtnIXD1tCmsKRyZqOvgEVzm7l//WjFqh6WKmh2wnpKLPj9Hpb6obynpu6G
         LZ1TrjDzK7TQo05QjTU8btVq2Eh8yK/EOa4PuBZlrXQ1m2NlWjQpj60mppQ3QQs9Winb
         Vix5b70bDrJ0birlcPbC9aChcQZ+ucIt68mf6AARnhJHKJbpKl9jzR6SAuxLdl3m23ix
         WYUsl+ThD0MqKHCe+l29EmtBpvcOgmKmqns3fv5IWXeCc3/PyCU+yp0Cq5NeySbb8QsU
         BVhLekqvyGfVUYpJFDEflKXp/r/tM3lNL8UXxuPBcFMRl32courZbjX82hKvV1QyDMGs
         98jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJvbt6nvoRaOMGhp2QxmaYvjH1scDwvD9rjxCVXSSvg=;
        b=OrCU3CIQOfp6HcNqiecdW+5hG59sahcaQeoCzYUVnvD3kLg/Kt58P3aXk06hPfhayH
         u+cTUVTnXzRGl6VHtiiU5QhvUv8cbQDRnWHmBcvKvN/EHLq1Y6wBjUg07XGF3ZzKOZf/
         wSpa562UuPzNWYgZS62fL7W4YsjhXBsBfhb4GE/xneMmkJD2GX6TBGDikRleglgSgezt
         M3r904QppkQ7uQm8ovXVNQ3Pre1h7mZjcVSJzyfGrAHj1+DCRPmptIy+TmE+Rc+rqbQ3
         UK/Mj9h0yRdK/IPSsfeM5Ee6ScbRcqHJwrYt3PfPRMBFB08IJP4EZCzfOOBu4wJ4oFNg
         ubaQ==
X-Gm-Message-State: AO0yUKXgQQgYYrM3MpQmjQMP8SKUOL9OntJOQvwvJvG5aSrDQ4bGO2FP
        OI1DIZK9LmlMdNKV291PhCw90HxCCauTYhP4zqLSJMD/FWc=
X-Google-Smtp-Source: AK7set9mx7jwA2tvw4785KczakZTQNQaaBBqRrZbulCJkQblHifn9/KVAokc93Imj+o0knLWKmgXQE8xL2kJtfAXI+g=
X-Received: by 2002:a2e:b548:0:b0:295:c401:2e9d with SMTP id
 a8-20020a2eb548000000b00295c4012e9dmr1076061ljn.5.1677886168341; Fri, 03 Mar
 2023 15:29:28 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 3 Mar 2023 17:29:17 -0600
Message-ID: <CAH2r5mvneK=w-1DFk9A7y=3xgLp=HQtNFQ5Tvee+g2B4qKumeA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
ab7362d04d7c14923420c1e19e889da512a65cd7:

  cifs: Fix cifs_writepages_region() (2023-02-24 11:01:58 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc-smb3-client-fixes-part2

for you to fetch changes up to 71562809e401b2f5ad371d99ce0323e988406fd6:

  cifs: Fix memory leak in direct I/O (2023-03-01 18:18:25 -0600)

----------------------------------------------------------------
9 cifs/smb3 client fixes
- xfstest generic/208 fix (memory leak)
- minor netfs fix (to address smatch warning)
- a DFS fix for stable
- a reconnect race fix
- two multichannel fixes
- RDMA (smbdirect) fix
- two additional writeback fixes from David

----------------------------------------------------------------
David Howells (5):
      cifs: Add some missing xas_retry() calls
      cifs: Fix an uninitialised variable
      cifs: Fix cifs_write_back_from_locked_folio()
      iov: Fix netfs_extract_user_to_sg()
      cifs: Fix memory leak in direct I/O

Paulo Alcantara (2):
      cifs: improve checking of DFS links over STATUS_OBJECT_NAME_INVALID
      cifs: prevent data race in cifs_reconnect_tcon()

Shyam Prasad N (2):
      cifs: match even the scope id for ipv6 addresses
      cifs: reuse cifs_match_ipaddr for comparison of dstaddr too

 fs/cifs/cifsproto.h |  21 +++++++---
 fs/cifs/cifssmb.c   |  43 ++------------------
 fs/cifs/connect.c   |  31 ++-------------
 fs/cifs/file.c      |  11 +++++-
 fs/cifs/misc.c      | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/smb2inode.c |  21 +++++-----
 fs/cifs/smb2ops.c   |  23 ++++++-----
 fs/cifs/smb2pdu.c   |  82 ++++++++++----------------------------
 fs/cifs/smbdirect.c |   2 +-
 fs/netfs/iterator.c |   2 +-
 10 files changed, 190 insertions(+), 157 deletions(-)

-- 
Thanks,

Steve
