Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD31F6C897A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCYABB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYAA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:00:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E8CC0E;
        Fri, 24 Mar 2023 17:00:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h9so3334248ljq.2;
        Fri, 24 Mar 2023 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679702456;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5aTMExcXngxmmpZEuRXYDZceArt1HwWZ2ZD3a0mFpP4=;
        b=qd5RtxxD4nXoKsr+U79VSiO7YPCDHEOj5JVdN98WZ2RXhBn3OZu1vTPYIjKz3Zq64B
         983ukOb9z18QFZPHRcn11CRsOVK5XfU5cTithNphUlpFi/i/punE3Mvu0uLxGa0FZwIK
         g8Ur26oW+v/a9Ooc3/KN2YEFhYF/ZIH/El7OWvSZ3yjzVFuY8E5G7i8ATRyZnyyaSBdc
         UsEnZwTTa9H7XNURuReZjOW5Cg9woonMW5OqCJNwzWreZgu/4gVnp5HnbfHmIzOVIznG
         DnARKOgRLVIycgl0MaFtOWNGSsoaUw4QEKF23Vz+M7sTQOer6zXSOBgb3VIfulSlcqK+
         UHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679702456;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aTMExcXngxmmpZEuRXYDZceArt1HwWZ2ZD3a0mFpP4=;
        b=oaJZJYsDzPuCyJOSoYffAr3ccFvYlzafClFlnbN+vftLW/QOfljT1NsgQnjAwWhSwc
         WQZDyPGdfwDY01GPoAT5u+cBB2VOkUH1/LbqhNRVRUllKj2JnR9CpJIRCzVu35a7Lz7W
         TMjn57/YigTZy/iWBegUPKzw7hOmlZcVMU2/SdGs9sxGu6GJw+ixABdvtR5E+MLc6AGL
         AyGBMpUV5SoKVqZiE/W+NcjO6X1Ldgq/YLwTP9xR7uG85pF/SWgMvDHmNG9zk/g7/FjI
         TTP2R/nifdZGr7GM0LiLcxkqxRrdWWHD9J5sYggIvkq7UBPe72eswtiTeuSKwwaHZFaW
         lx7Q==
X-Gm-Message-State: AAQBX9eVktKOv2O/oyt4JRdvaeewyf76Pifb2Z9NOau8gCWS8lN1iqMM
        v/BHqzN/UXZur0GKEqlKFPCp7n+eq8ZkaJTsUKE=
X-Google-Smtp-Source: AKy350Zz7XpJ32nsSis1/ee52NNJrPop+LsyCLNEwpzSRNkg+M3KCVHJY518bgH9Ioed0Oospd5mv7LLqhQEt3lvw0o=
X-Received: by 2002:a2e:6a12:0:b0:29a:9053:ed22 with SMTP id
 f18-20020a2e6a12000000b0029a9053ed22mr1408153ljc.7.1679702455922; Fri, 24 Mar
 2023 17:00:55 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 24 Mar 2023 19:00:44 -0500
Message-ID: <CAH2r5muJC14LVd3LA2mhZH+zVkyuULm-KQXXxnP8J7LDe4y6bg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.3-rc3-ksmbd-smb3-server-fixes

for you to fetch changes up to 39b291b86b5988bf8753c3874d5c773399d09b96:

  ksmbd: return unsupported error on smb1 mount (2023-03-24 00:23:13 -0500)

----------------------------------------------------------------
eight smb3 server fixes (also for stable)
- two fixes to return less confusing messages on unsupported dialects
(STATUS_NOT_SUPPORTED instead of I/O error)
- fix for overly frequent inactive session termination
- fix refcount leak
- fix two bounds check problems found by static checkers
- fix to advertise named stream support correctly
- Fix AES256 signing bug when connected to from MacOS

(Also FYI I have a slightly larger cifs P/R coming in the next day or
so with various client fixes)
----------------------------------------------------------------
ChenXiaoSong (1):
      ksmbd: fix possible refcount leak in smb2_open()

Namjae Jeon (7):
      ksmbd: fix wrong signingkey creation when encryption is AES256
      ksmbd: set FILE_NAMED_STREAMS attribute in FS_ATTRIBUTE_INFORMATION
      ksmbd: add low bound validation to FSCTL_SET_ZERO_DATA
      ksmbd: add low bound validation to FSCTL_QUERY_ALLOCATED_RANGES
      ksmbd: don't terminate inactive sessions after a few seconds
      ksmbd: return STATUS_NOT_SUPPORTED on unsupported smb2.0 dialect
      ksmbd: return unsupported error on smb1 mount

 fs/ksmbd/auth.c           |  5 +++--
 fs/ksmbd/connection.c     | 11 ++++-------
 fs/ksmbd/connection.h     |  3 ++-
 fs/ksmbd/smb2pdu.c        | 20 +++++++++++++++-----
 fs/ksmbd/smb_common.c     | 27 ++++++++++++++++++++++-----
 fs/ksmbd/smb_common.h     | 30 ++++++++----------------------
 fs/ksmbd/transport_rdma.c |  2 +-
 fs/ksmbd/transport_tcp.c  | 35 +++++++++++++++++++++++------------
 8 files changed, 78 insertions(+), 55 deletions(-)

-- 
Thanks,

Steve
