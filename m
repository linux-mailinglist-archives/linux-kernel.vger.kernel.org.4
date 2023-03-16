Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B36BDA49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCPUkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCPUkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:40:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410BD30BA;
        Thu, 16 Mar 2023 13:40:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t11so3974890lfr.1;
        Thu, 16 Mar 2023 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678999205;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X912NVlb9caff3MVD+ScaUV+h9DFxh1zv7cK56BjPMU=;
        b=Sqps0NWn0hUgWyfgUztNseKDyTruDMUqmO3w7epC7UJwX+tbwuaZ0AUmP7XwXiQKLA
         6+IsGShT85swEtl2f5aUEc50A+4NnG/MAMnfmu7ORmsC0PtBkzUAvIFZvoVKKM9PS6BU
         +I+59bilFS6rgqOtoC5bjZI+QnCg6AEE/GmusBLWJEFXIN+Oulau89l4g9zD03iq5rG9
         cdTy9h0tPOIW1siF7TmnXGkv67P/txfLvWzdOrbPIr7ZJrIhErIV5ijL2Z8oj8Gfk5jc
         jujiUW+KZVPqP3ZUF+ytmKTBbMYj4aiAa/b6LzaUIrvzetlFC5iM+EiDYJG5IKVOprtr
         heuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678999205;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X912NVlb9caff3MVD+ScaUV+h9DFxh1zv7cK56BjPMU=;
        b=h/28MDnUZd7mvexvkJ7E2Mh9v37nhcqVEPPCwE5hMYizTsOGYMdGTQf4IAIBahFfYH
         xPdB3NTQRJ+cKL4MYWGP8+Fismvu1LdZFhV26hilXI0+AR2qZc1Yy5TOZJvIyb5bIuV6
         +w2BMR/2stFah0LEwFcATdu8QhmP9HMi0M12IzyL0rbdBkSPqgaV4m0YjEY2ydP2e/qR
         7USdlY2jR9f1yIoVIFivoWO9GuOnyd3xtS1MaAWYWh8cDARB9UfReuUWCRHOezN+Agb1
         YCmlZ2wy816sFs82/oNnAbyz/jSkRhIB+5HBkEkFpzimrAeOgKmrNkBpZw4j1qBpLeqq
         jNpg==
X-Gm-Message-State: AO0yUKU6tiK1AvjyZLbm/RAGYpEfVDyPU22WbU7/czhmfNJrlA9CLI2V
        ds7yuJR/b4Qbdy28BcFRStlz+jK35gpan4nu2NLiKlZNbrg=
X-Google-Smtp-Source: AK7set9qMXrE7MEBbrtCeCW/9va5cA3rn+4yprWmJNjzZY92FGWMNN25HyGLKRVaTg0/uQeyMdCmMdmtidI/Q3/FSqU=
X-Received: by 2002:ac2:5923:0:b0:4db:2554:93a6 with SMTP id
 v3-20020ac25923000000b004db255493a6mr3649422lfi.10.1678999205021; Thu, 16 Mar
 2023 13:40:05 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Mar 2023 15:39:53 -0500
Message-ID: <CAH2r5mvy1og79Zxumu_Bn4NZGpian1Tk2LXpDTQYjCG4nF4Mbw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc2-smb3-client-fixes

for you to fetch changes up to 6284e46bdd47743a064fe6ac834a7ac05b1fd206:

  cifs: use DFS root session instead of tcon ses (2023-03-14 22:48:53 -0500)

----------------------------------------------------------------
seven cifs/smb3 client fixes, all also for stable
- four DFS fixes
- multichannel reconnect fix
- fix smb1 stats for cancel command
- fix for set file size error path
----------------------------------------------------------------
Paulo Alcantara (4):
      cifs: set DFS root session in cifs_get_smb_ses()
      cifs: fix use-after-free bug in refresh_cache_worker()
      cifs: return DFS root session id in DebugData
      cifs: use DFS root session instead of tcon ses

Shyam Prasad N (1):
      cifs: generate signkey for the channel that's reconnecting

Volker Lendecke (1):
      cifs: Fix smb2_set_path_size()

Zhang Xiaoxu (1):
      cifs: Move the in_send statistic to __smb_send_rqst()

 fs/cifs/cifs_debug.c    |   5 +++
 fs/cifs/cifs_dfs_ref.c  |   1 +
 fs/cifs/cifs_fs_sb.h    |   2 -
 fs/cifs/cifsglob.h      |   4 +-
 fs/cifs/connect.c       |  10 ++---
 fs/cifs/dfs.c           |  67 ++++++++++++++++++----------
 fs/cifs/dfs.h           |  19 +++++++-
 fs/cifs/dfs_cache.c     | 140
-----------------------------------------------------------
 fs/cifs/dfs_cache.h     |   2 -
 fs/cifs/fs_context.h    |   1 +
 fs/cifs/misc.c          |   8 ++++
 fs/cifs/smb2inode.c     |  31 ++++++++++---
 fs/cifs/smb2transport.c |   2 +-
 fs/cifs/transport.c     |  21 ++++-----
 14 files changed, 118 insertions(+), 195 deletions(-)


-- 
Thanks,

Steve
