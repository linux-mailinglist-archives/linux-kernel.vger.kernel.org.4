Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B773A675F99
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjATVXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjATVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:23:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9203D6A300;
        Fri, 20 Jan 2023 13:23:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so9959566lfb.1;
        Fri, 20 Jan 2023 13:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YQSow/XXJue1Hfuq2P+XDRAvjPVOFPOHzpi4+mYE10Q=;
        b=LZyQ6jiCUeSUvXBqySwUnKy9InloWWFUsgD2XzfMP1Siz7Ah5XPmlmCXGEMcXnclL7
         0ZBalY5dIBRvrDQvVfMFQ398JUMY3WsfaFrLwf5ZUdSAgST4XVTbrMl3CvHrI3fwSc5C
         G3EcFT/TPL8czzD1GR2YMCo2Urn6qjFwplU6F2+pHhPWXOjVhfjaXpr7oIVOIUQRJRvs
         tZfoyGDZf+xriMss6XAsg5BEz+FdEtM4JJWztfopzOQcAy3Gr+xsRWlhKLaUsasDUdcF
         5T17a1Mll6h8tehqfZI/dP5Wp0qa9CQYPwaBVc9zmah52RkkjTedWrUtnrrAP7LMdhC4
         SIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQSow/XXJue1Hfuq2P+XDRAvjPVOFPOHzpi4+mYE10Q=;
        b=jDDgNPSYpbWNwOXRXQFbBzbhEakO2NwhkldKTCItyRQl2cvulGkar/VZylO4HiEsGa
         XQQ3Ue7BLGlVZwVt9BVttqgELk7Pc1A5D+lXRYzSwTNm1PdwD1x0DnBY69ASmgevy5Wd
         q7fiKOD5H6mxMr5jY45V3JpSw6TvAqjMOiEvCCl3zB4CXNPyA+kCm+XA5M9tQEfNUKlk
         CHqlxZZ7yvnkV6CHQxeChL0nc7w2/uoQYJ+3M1Gnu/ANmvYMhAIxJood/sC6Qv10vBlo
         F6YoJF+or3vJWcQC7hqOd0LHw0uZO9wmLlUB8pJP2TrNpHS/XSvSdh2RCPeOB6OqKkse
         f/6w==
X-Gm-Message-State: AFqh2kqLnW11QGf8TglLic8FMqhnihT0UD7oZVohuxf95YFX8HriXNKr
        ikV5S3p6QNfXGf08+qio0ENK/ouwUY7uuW0qtQogE6QvYuo=
X-Google-Smtp-Source: AMrXdXuajlowEGNe7JcbD8+0+9w+GeZwp66vF9oB3Y070H1+7Nkf25YT4X2PBFuC26bSs9l8iVWgh7WUQfTGITbADik=
X-Received: by 2002:a05:6512:3996:b0:4a2:67ea:a06 with SMTP id
 j22-20020a056512399600b004a267ea0a06mr901370lfu.580.1674249824458; Fri, 20
 Jan 2023 13:23:44 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 20 Jan 2023 15:23:33 -0600
Message-ID: <CAH2r5mtJDpG9COgrDSrytNvcsCruxe1svD5CtjeYnakQDjrVCQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
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
5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc4-smb3-client-fixes

for you to fetch changes up to a1b7c8457ecc062f612a1aca174c2e1c21f9ac10:

  cifs: remove unused function (2023-01-18 14:49:51 -0600)

----------------------------------------------------------------
8 smb3 client fixes
- important fix for packet signature calculation error
- three fixes to correct DFS deadlock, and DFS refresh problem
- remove an unused DFS function, and duplicate tcon refresh code
- DFS cache lookup fix
- uninitialized rc fix
----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: do not include page data when checking signature

Paulo Alcantara (7):
      cifs: fix potential deadlock in cache_refresh_path()
      cifs: avoid re-lookups in dfs_cache_find()
      cifs: don't take exclusive lock for updating target hints
      cifs: remove duplicate code in __refresh_tcon()
      cifs: handle cache lookup errors different than -ENOENT
      cifs: fix return of uninitialized rc in dfs_cache_update_tgthint()
      cifs: remove unused function

 fs/cifs/dfs_cache.c | 243
+++++++++++++++++++++++++++++++-----------------------------------------------
 fs/cifs/dfs_cache.h |   3 -
 fs/cifs/smb2pdu.c   |  15 +++--
 3 files changed, 105 insertions(+), 156 deletions(-)


-- 
Thanks,

Steve
