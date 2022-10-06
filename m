Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2392E5F7214
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiJFXxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiJFXxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:53:16 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA6760489;
        Thu,  6 Oct 2022 16:53:15 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id p89so1172590uap.12;
        Thu, 06 Oct 2022 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=QaPt7Sx7U2CASqlnTSCIDEhsb4pzTZJD0EMmYjUa7Dw=;
        b=U62SMnXBt3hvhlAz6O+Cjknk8+V4UxaNHZEeWgERgHHGR0G/Q1uleIarOySYsIiQuN
         yGAwgGiqDZQ/YBvH8UHVKtas886qk9pdS72vwsxa85+eA+xHSu2iRKLLdFiyNQSmcbJb
         N869mG2vE6bSsoOnVs0ubwGSJpuVHaL3aGWzaT/KVCf14Xc+LzGxSjl1eTtdBOdFX3rs
         m7w+F6h+z8IC8l0twl5mjFvwU/Tvy6CUigrlpslDm0rmDzaD+Kv6v9FmfTkqoJth61op
         my2eGsY4bgTz1lzvwC/6ccYWex4nNOAuyoITO232fXqVSvRGuG1Z2CWONdwbLdFwZySe
         XXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QaPt7Sx7U2CASqlnTSCIDEhsb4pzTZJD0EMmYjUa7Dw=;
        b=74ZgCN8RnR+9aCZoJoLUi8Xbaz8EMtBovjJDEtnCPLjSKN6ZEC5OvEUm0lvlUmV9LR
         cYbbzON8APdZ1VOwn1RVoI+eZs6KWSX619JM5INGz6lhU9AbdZstS79NSQKZmOfS9PR2
         kxjEao7i0WGau94A5gGXyKlQTFRD9Wu3053UHIsW+7LojPeRaJ4in0N2fp4LSgdw8yFE
         ZwIrHvH6hbhS42gXvoiPkT2FUjR+bnyfMLi9ai/Co9H/4JGXDX0jgeXZpM6yw9/CvSMm
         cbiqerQWUF1lun9G9HkAFkk9CZnjwNjSr+pGGYeKm75eU3L6IKYrZk4jR9HX39HUZNAO
         XQvw==
X-Gm-Message-State: ACrzQf2R7N90WCxm0m2sjdrdqeAQRAMXXxl8AcG6tB3Y00QnMeFtB8OC
        ufUvUxMUwJZs5vFA3RpQqDhkRwPd5IDk6F0tuYW8pNdLgrc=
X-Google-Smtp-Source: AMsMyM4FmuoT7wT3Td6eRFSGGXrT4+p77sxMe8rs6Bc4gIZmGdK8ufUQd6LNtfwm1VlTHUCmF4FmjCXTatTvkhmDq/I=
X-Received: by 2002:ab0:6494:0:b0:3da:7cac:c48d with SMTP id
 p20-20020ab06494000000b003da7cacc48dmr1532942uam.96.1665100393941; Thu, 06
 Oct 2022 16:53:13 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 6 Oct 2022 18:53:02 -0500
Message-ID: <CAH2r5mtx9gsG01JDMWakP0o-76rzyX_YKzbgVdZZwboaVVDF3g@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.1-rc-ksmbd-fixes

for you to fetch changes up to f5ba1cdaf5eb380e148183bda06d4844b457d095:

  ksmbd: validate share name from share config response (2022-10-05
01:15:44 -0500)

----------------------------------------------------------------
24 ksmbd server fixes, including 4 for stable
- RDMA (smbdirect fixes)
- Fixes for SMB3.1.1 POSIX Extensions (especially for id mapping)
- various casemapping fixes for mount and lookup
- UID mapping fixes
- Fix confusing error message
- Negotiate protocol fixes, including NTLMSSP fix
- Two encryption fixes
- directory listing fix
- some cleanup fixes

----------------------------------------------------------------
Al Viro (3):
      ksmbd: don't open-code file_path()
      ksmbd: don't open-code %pD
      ksmbd: constify struct path

Atte Heikkil=C3=A4 (3):
      ksmbd: casefold utf-8 share names and fix ascii lowercase conversion
      ksmbd: make utf-8 file name comparison work in __caseless_lookup()
      ksmbd: validate share name from share config response

Christian Brauner (1):
      ksmbd: port to vfs{g,u}id_t and associated helpers

Hyunchul Lee (1):
      MAINTAINERS: remove Hyunchul Lee from ksmbd maintainers

Micka=C3=ABl Sala=C3=BCn (1):
      ksmbd: Fix user namespace mapping

Namjae Jeon (12):
      ksmbd: remove generic_fillattr use in smb2_open()
      MAINTAINERS: Add Tom Talpey as ksmbd reviewer
      ksmbd: fix incorrect handling of iterate_dir
      ksmbd: update documentation
      ksmbd: change security id to the one samba used for posix extension
      ksmbd: set file permission mode to match Samba server posix
extension behavior
      ksmbd: fill sids in SMB_FIND_FILE_POSIX_INFO response
      ksmbd: fix endless loop when encryption for response fails
      ksmbd: fix encryption failure issue for session logoff response
      ksmbd: set NTLMSSP_NEGOTIATE_SEAL flag to challenge blob
      ksmbd: hide socket error message when ipv6 config is disable
      ksmbd: call ib_drain_qp when disconnected

Tom Talpey (2):
      ksmbd: decrease the number of SMB3 smbdirect server SGEs
      ksmbd: reduce server smbdirect max send/receive segment sizes

Zhang Xiaoxu (1):
      ksmbd: Fix wrong return value and message length check in smb2_ioctl(=
)

 Documentation/filesystems/cifs/ksmbd.rst |  42 +++++++++++++++-------
 MAINTAINERS                              |   2 +-
 fs/ksmbd/auth.c                          |  15 +++++---
 fs/ksmbd/auth.h                          |   3 +-
 fs/ksmbd/connection.c                    |   8 +++++
 fs/ksmbd/connection.h                    |   2 ++
 fs/ksmbd/ksmbd_netlink.h                 |   3 +-
 fs/ksmbd/mgmt/share_config.c             |  36 +++++++++++--------
 fs/ksmbd/mgmt/share_config.h             |   4 ++-
 fs/ksmbd/mgmt/tree_connect.c             |   6 ++--
 fs/ksmbd/mgmt/tree_connect.h             |   2 +-
 fs/ksmbd/misc.c                          |  46 +++++++++++++++++++-----
 fs/ksmbd/misc.h                          |   5 +--
 fs/ksmbd/ndr.c                           |   8 +++--
 fs/ksmbd/oplock.c                        |  27 +++++++++-----
 fs/ksmbd/server.c                        |   4 +--
 fs/ksmbd/smb2pdu.c                       | 126
+++++++++++++++++++++++++++++++++++++---------------------------
 fs/ksmbd/smb2pdu.h                       |   7 ++--
 fs/ksmbd/smb_common.c                    |   6 ++--
 fs/ksmbd/smbacl.c                        |  12 ++++---
 fs/ksmbd/smbacl.h                        |  18 +++++-----
 fs/ksmbd/transport_rdma.c                |   8 +++--
 fs/ksmbd/transport_tcp.c                 |   3 +-
 fs/ksmbd/unicode.h                       |   3 +-
 fs/ksmbd/vfs.c                           |  36 ++++++++++++-------
 fs/ksmbd/vfs.h                           |   4 ++-
 26 files changed, 284 insertions(+), 152 deletions(-)

--=20
Thanks,

Steve
