Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA669EDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjBVEQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBVEQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:16:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1578934C3C;
        Tue, 21 Feb 2023 20:16:12 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m6so8489105lfq.5;
        Tue, 21 Feb 2023 20:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YwNzJLcpDDqs5yIWRlC/s8Am5Np1WdXF71ovyHKPyq4=;
        b=b1uBgXiEuyt1q6UTsjdqezO3613zO5/vEI+bbdAdf4EP8LonKKyVqxd2uVmbtJTvae
         yIdRLFOQSNx12Nbqvr+rdg3W/4n+Q9u+GWZ7e+qpWW67fGjvLfkG5eJ5juNB6m7G2rLD
         0ono6ys2hYv1AZ3GBo3MwvEiEWCWURZXnkAPceokGLHOo6RHZK4iwamC55RdnkF35M6v
         zfgQvDkTZpRCIeKYkelzMT2O/H0BW+5T5Q5oA0s6HHKu3geteWZ2uBEl/LJEG7OlpoE5
         bhy9yreJLJstZbh7HaWHVIlmRUEKlzGkN1hSMHWUtgOQLxPG6p9nAt348cW57KQvOV/5
         2MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YwNzJLcpDDqs5yIWRlC/s8Am5Np1WdXF71ovyHKPyq4=;
        b=obAh7+zvzKBWnaPf+j+a6xPrNw14pV2GNskPGWZQ9TW4L9mfNO/hGqCYslkcHSSfDY
         MplsV/Kfg5puOe9RZQpEPxxfsfggmLMCxDLKFv3X6r96HDKFW+cyjXKaajvXcBV+lgIC
         4SllWvyvZtI40FIk0ApQ3e8be85Kunku+UCfLUYiTlOWOAK2mKb1C6zZYufrkfURChR0
         YzXRYQt71fb58iRIk3/Lp0RIh1NkB1pbmuGuvlxatWKQeHkt8goPWxu0VVjFpe/BE2dI
         RP1A0WSNr0sMsGMbi6uQ1Jh5ztk3j7tRqt8KLE85cG5tjmJD4Rbqv+K+OUISRT3/BtU+
         ItMA==
X-Gm-Message-State: AO0yUKXdkwtIwyjHey+6RoWc5PVst4szzYrzDLMqSdzkbRohKiHZ3nul
        Db4NE3dXnelm8j7EK5viFnE5rtEnx4sqOus/jWeMmSzWtWM=
X-Google-Smtp-Source: AK7set+dElkkM4ktil/I62xZdtW915ZC+8chQdEGaXOcGi41GTLI2s8uO3N9j1w5hK9+ZHeCjJEEH9I5o+V+VZv7D+I=
X-Received: by 2002:ac2:4306:0:b0:4dd:98c6:ee3 with SMTP id
 l6-20020ac24306000000b004dd98c60ee3mr588010lfh.4.1677039370165; Tue, 21 Feb
 2023 20:16:10 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 21 Feb 2023 22:15:59 -0600
Message-ID: <CAH2r5mv+jJK0AhCEo-gx_5cBcyk0RSHvrQv9irWisoVPnbV3jQ@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
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
6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.3-rc-ksmbd-fixes

for you to fetch changes up to d3ca9f7aeba793d74361d88a8800b2f205c9236b:

  ksmbd: fix possible memory leak in smb2_lock() (2023-02-19 17:57:25 -0600)

----------------------------------------------------------------
Ten ksmbd smb3 server fixes, including three for stable
- Fix for memory leak
- Two important fixes for frame length checks (which are also now stricter)
- four minor cleanup fixes
- Fix to clarify ksmbd/Kconfig to indent properl
- Conversion of the channel list and rpc handle list to xarrays
----------------------------------------------------------------
Colin Ian King (1):
      ksmbd: Fix spelling mistake "excceed" -> "exceeded"

Dawei Li (4):
      ksmbd: Implements sess->ksmbd_chann_list as xarray
      ksmbd: Implements sess->rpc_handle_list as xarray
      ksmbd: fix typo, syncronous->synchronous
      ksmbd: Remove duplicated codes

Hangyu Hua (1):
      ksmbd: fix possible memory leak in smb2_lock()

Jiapeng Chong (1):
      ksmbd: Fix parameter name and comment mismatch

Namjae Jeon (2):
      ksmbd: fix wrong data area length for smb2 lock request
      ksmbd: do not allow the actual frame length to be smaller than
the rfc1002 length

Steve French (1):
      ksmbd: update Kconfig to note Kerberos support and fix indentation

 fs/ksmbd/Kconfig             |  8 ++++++--
 fs/ksmbd/asn1.c              | 23 +++++++++++------------
 fs/ksmbd/connection.c        |  6 +++---
 fs/ksmbd/ksmbd_work.h        |  2 +-
 fs/ksmbd/mgmt/user_session.c | 98
++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------
 fs/ksmbd/mgmt/user_session.h |  6 ++----
 fs/ksmbd/smb2misc.c          | 31 +++++++++++++------------------
 fs/ksmbd/smb2pdu.c           | 66
++++++++++++++++++++---------------------------------------------
 fs/ksmbd/vfs.c               |  6 +++---
 fs/ksmbd/vfs_cache.c         |  5 ++---
 10 files changed, 99 insertions(+), 152 deletions(-)

-- 
Thanks,

Steve
