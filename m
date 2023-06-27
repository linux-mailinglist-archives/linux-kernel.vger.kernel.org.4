Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618D73EFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjF0ArS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjF0ArO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:47:14 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC912C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:47:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b5d1498670so3085004a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687826832; x=1690418832;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e88+wboWnpMpH6cRUOXCkMh4VlwTjhZruz0PtShif3w=;
        b=GzpLaR5yt3TFL68xa3HQ1HAbRj9kgRzvQwgzhhGS31MKZMXh5aizRW8zbYtc1Y6ePk
         VVEYy8bHxb3f+XpjoJjs3wE7FWRRdTBYjV3LhwvQKsfvDw2c18q8x8OrkAvI1KOdJrs1
         MWAk3cZeKGHlC7GzZioJ6OfSRk6XkVwXEfBPN1DCb2fTcdlu/adCGMHqf2mWE9KW6SQB
         Tceb4x5YdWqmjCn365rDnNVwOPxhk6fkCi2lN5/x7TN9fnCKMhIy/ypoPqV9HywzNS5P
         hnxJM9zpiqpxdtTq9ZCMo+5MUGFOaRiYpv3AbannClk5H647SivO73AeJ/1pbEId1LST
         kD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687826832; x=1690418832;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e88+wboWnpMpH6cRUOXCkMh4VlwTjhZruz0PtShif3w=;
        b=Zukpg/Qo8VF++gKmptVh65M66nyqJGwej+Jd+PM/kQiv2od4uSojOBA9CEIiZqTM3r
         Bhmx3s2s1YirEcMAT9fIn5i7t3Pk83/thrNpHIsiekL2gVI9tYTk9c6/tNr4GPwdGY89
         reaj0yPZPO7AG9n4KB/g7uthsl3FBer3v9XFxuk46E+GeSQ/PT5thejiyWVPZE+vwttA
         ULawp3q7JVR6oEMN9fWOriNZmxiuf0GbarIsFHm7X3UlRSGRckWQJM0YYDAkndv5S2J8
         r3+EhyMzU46bjuV5DfzhkL1+fSYMYwmCdmaMpRLRAOEjqm8EpL3Qff+bFVlwGERzrfsR
         sHhw==
X-Gm-Message-State: AC+VfDzw5DMm8HZmnuNod0RJWXUSsjIBKpLw1BzIIXYNjGhf92clpWxz
        uvcniXFnkcsFWcfQNHkBhkR712cnUKxx7oFqrkNQ
X-Google-Smtp-Source: ACHHUZ552VbcNwq6Y7vNbyGQaEcaIWiOeq+QEElxaKMvr0iJ0bRsbphcS3QF79Q3bP6EuEt3w9pBrz0iHw/jCq+1Rco=
X-Received: by 2002:a05:6358:cb22:b0:132:d6e6:53ba with SMTP id
 gr34-20020a056358cb2200b00132d6e653bamr7319742rwb.25.1687826831753; Mon, 26
 Jun 2023 17:47:11 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Jun 2023 20:47:01 -0400
Message-ID: <CAHC9VhRdEE58-hOXFGQmO5BV5gCNv0+bLx-GrLogR8uVAhaUqg@mail.gmail.com>
Subject: [GIT PULL] LSM patches for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Seven patches in the LSM pull request for v6.5, all relatively small,
here is a quick summary:

- A SafeSetID patch to correct what appears to be a cut-n-paste typo
in the code causing a UID to be printed where a GID was desired.  This
is coming via the LSM tree because we haven't been able to get a
response from the SafeSetID maintainer (Micah Morton) in several
months.  Hopefully we are able to get in touch with Micah, but until
we do I'm going to pick them up in the LSM tree.

- A small fix to the reiserfs LSM xattr code.  We're continuing to
work through some issues with the reiserfs code as we try to fixup the
LSM xattr handling, but in the process we're uncovering some ugly
problems in reiserfs and we may just end up removing the LSM xattr
support in reiserfs prior to reiserfs' removal.  For better or worse,
this shouldn't impact any of the reiserfs users, as we discovered that
LSM xattrs on reiserfs were completely broken, meaning no one is
currently using the combo of reiserfs and a file labeling LSM.

- A tweak to how the cap_user_data_t struct/typedef is declared in the
header file to appease the Sparse gods.

- In the process of trying to sort out the SafeSetID lost-maintainer
problem I realized that I needed to update the labeled networking
entry to "Supported".

- Minor comment/documentation and spelling fixes.

Thanks,
-Paul

--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

 Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20230626

for you to fetch changes up to 4be22f16a4a1a1667e79b52b56cca2c64b3747e2:

 device_cgroup: Fix kernel-doc warnings in device_cgroup
   (2023-06-21 09:30:49 -0400)

----------------------------------------------------------------
lsm/stable-6.5 PR 20230626

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
     SafeSetID: fix UID printed instead of GID

GONG, Ruiqi (1):
     capability: erase checker warnings about struct __user_cap_data_struct

Gaosheng Cui (2):
     capability: fix kernel-doc warnings in capability.c
     device_cgroup: Fix kernel-doc warnings in device_cgroup

Paul Moore (2):
     lsm: fix a number of misspellings
     MAINTAINERS: move labeled networking to "supported"

Tetsuo Handa (1):
     reiserfs: Initialize sec->length in reiserfs_security_init().

MAINTAINERS                     |  2 +-
fs/reiserfs/xattr_security.c    |  1 +
include/uapi/linux/capability.h |  5 +++--
kernel/capability.c             |  2 ++
security/commoncap.c            | 20 ++++++++++----------
security/device_cgroup.c        |  3 +--
security/lsm_audit.c            |  2 +-
security/safesetid/lsm.c        |  2 +-
security/security.c             |  4 ++--
9 files changed, 22 insertions(+), 19 deletions(-)

-- 
paul-moore.com
