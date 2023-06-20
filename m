Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7F7362B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjFTEpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTEpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:45:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8977B10C7;
        Mon, 19 Jun 2023 21:45:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b45b6adffbso54484991fa.3;
        Mon, 19 Jun 2023 21:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687236316; x=1689828316;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LSn6ut/KlRF0j/GAnYc/CKJzMww10Za5lKAV1z62hM=;
        b=ca5TIJd4ZAMVapntSy0xa37I5K+i9yuQihk8WfptSMItYiTtSmcRx/b6t7LzfEmq16
         0IiT/YcFHsxWMop7Z7m1qoFgz6LjTtxOZz0u75WkYZVqQqAxmE/QCRTOOsP77o229Hk0
         SqFwUagC51FsYMAjYREsJ2Zr2tHVTgGZR0Ov2e3qLnsoftLEZuPmxebJxClz4OfUDgpq
         OoiSIfth66UYF1RGCO14GqEvaOu7ajvVncNtkVinxig+WCiiz84/UGWsZXHU75KVBpJ2
         EJWlLvWiyPxVm0eWt8WJcXi0xgGyEr9O1TY8LmRyOmWwLUiHuvn9q6HtSLYGf5b6/m7A
         dtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687236316; x=1689828316;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LSn6ut/KlRF0j/GAnYc/CKJzMww10Za5lKAV1z62hM=;
        b=CxekWNyIySDzr/wBseb8gGO2a19ezRgYweWaMMxvSBCosYuorlZCsvr6qRn2JVoBad
         oMM5uDxMRIcp4K3f873i9TI/c3pfZ2u4/G1sr86JkcTQt76cMmfoS8OONg43ArXzQ7WR
         fjuOfAU2ZjNhswHNAku/fBhz0MZh3yndoErlNVp/O44WgV6+IGQtAOOgAO5UQx86XAmw
         mv3AC9uJwFpv0bvxTj5sNet8jkzsHTMHcyNbtIfh9ypltBJ4dQdt/+G9uRqbH8xt7mnV
         3qbmprcsZbzKFJvY7HVZpWml2BqN7et41xrvwoewi7ltj8KZ1imXyZZtMN3sNB/cl7rg
         voRQ==
X-Gm-Message-State: AC+VfDyhn7Wr7YQJruzqK7MsqLVlrlNPTFBatPYExQ7P8/G/YKDcxmZH
        xGnj6r2GFZo3xEpIp8yPnFuWO4xjG+eFXHLd/kM=
X-Google-Smtp-Source: ACHHUZ6QlHsap+ua1MFgquFTfdBX/ysaBXKsrYgLEYwOPI/fZ3WbkF2BSMRy2Vdq/EYz6Y7GTz+UV0Z2tFeEfuUf448=
X-Received: by 2002:a2e:9789:0:b0:2b4:5b65:c904 with SMTP id
 y9-20020a2e9789000000b002b45b65c904mr6339409lji.52.1687236315517; Mon, 19 Jun
 2023 21:45:15 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 19 Jun 2023 23:45:04 -0500
Message-ID: <CAH2r5mtp7foUpjRP4MDgP=1SjXoTA0RAofYxavNGuAFE3R=y-g@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.4-rc6-smb3-server-fixes

for you to fetch changes up to 5005bcb4219156f1bf7587b185080ec1da08518e:

  ksmbd: validate session id and tree id in the compound request
(2023-06-16 21:04:51 -0500)

----------------------------------------------------------------
Four smb3 server fixes, all also for stable
- fix potential oops in parsing compounded requests
- fix various paths (mkdir, create etc) where mnt_want_write was not
checked first
- fix slab out of bounds in check_message and write
----------------------------------------------------------------
Namjae Jeon (4):
      ksmbd: validate command payload size
      ksmbd: add mnt_want_write to ksmbd vfs functions
      ksmbd: fix out-of-bound read in smb2_write
      ksmbd: validate session id and tree id in the compound request

 fs/smb/server/server.c    |  33 +++++++++++++---------
 fs/smb/server/smb2misc.c  |  33 +++++++++++++---------
 fs/smb/server/smb2pdu.c   |  70 ++++++++++++++++++++++++++++++++-------------
 fs/smb/server/smbacl.c    |  10 +++----
 fs/smb/server/vfs.c       | 117
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 fs/smb/server/vfs.h       |  17 ++++++-----
 fs/smb/server/vfs_cache.c |   2 +-
 7 files changed, 196 insertions(+), 86 deletions(-)

-- 
Thanks,

Steve
