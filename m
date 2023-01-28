Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3B67F3D1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjA1Bpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjA1Bph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:45:37 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD51728DE;
        Fri, 27 Jan 2023 17:45:36 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id o12so7325490ljp.11;
        Fri, 27 Jan 2023 17:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WaqBvD9dUVWB9VhmkdEu5L7TiNny1zSJVsFjDxeqc6E=;
        b=jYDZw/sm/Q98nQkf/mzZNRq6EjFVMkHhE788lHgkZOheBCYEulukWrQ34VVixCvb2r
         m2LhqS6HDOJpLIU+dTEMwPMbzCNdzQzNMELW4Mi9OMCE7MZY1IQKd1Zwl8vqJgE4EltP
         DjMmgFAvr6IYtUzOPe9ClhYNe4b0vjHkZKi1eIb/ujpV/ZqmOnvXXV9eW9TyM56QFOgS
         eaHMZa3+xKsVGx21KNmw6p9eG+ojiJ3HV94Hj9uYVY2HY2dm1KkwyTq/lOBhT8IOpsaw
         m+HQEk18wRkAN23sg8JiRhePdo9w5u/86lmO4Z8IgthlczzBJYDtVhpCUliZZoVztrQc
         fh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaqBvD9dUVWB9VhmkdEu5L7TiNny1zSJVsFjDxeqc6E=;
        b=Gm+WMJZZeYQchK2aZIwN7Mp4zwjaNyQa+Vf9HecQQaVBWX1JDNtgOznu9L8Lqv7Dli
         jWrOPIvFnPyYdDXZpWGttv38Awn33qO3BwPx0CWw/eHEdQeyQzZPYOteMOgBH8rOf04e
         FMizRhTmGF8kmFLGoo4AIlyI19bClfmt7sJlp2KJDBDe5N6rFa8Qf5P6pq/IZd40gdzk
         01mGbVs276jFCrUMVAe3wANe2vwx9mwB3QT8mxTfKMHXD0cHYpHyW631SOQp+zBibycV
         s8i4uV011rd544bh86AhJ6SIicrgUQ2PowuleRraKBITRU8PwFxOAqTghlYMIknEGHuh
         ySmw==
X-Gm-Message-State: AO0yUKV3Q9rWXDjIdDG5TvDu1ix62bDScrJnBaD6l66sTyWc/jWZ0vnS
        C2/vSCVuYL3hpv5Ygg7Tzonh99d6aDO6t68Wyp1cBNBCirk=
X-Google-Smtp-Source: AK7set/f6NYXV6+LUw/lBD/78ZXQKX0lOjinhE8jaqMyHA1SBFxAOst52nrsNv/jvwq5S7I+JwRPf9m2LMHqv8+1d4E=
X-Received: by 2002:a2e:3013:0:b0:28d:2fce:8b16 with SMTP id
 w19-20020a2e3013000000b0028d2fce8b16mr985384ljw.28.1674870334310; Fri, 27 Jan
 2023 17:45:34 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 27 Jan 2023 19:45:23 -0600
Message-ID: <CAH2r5mtnrm6nSsziYEZs=qyC2n28Vk3=KS1fNbqeWXP+4gu0vw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
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

  git://git.samba.org/ksmbd.git tags/6.2-rc5-ksmbd-server-fixes

for you to fetch changes up to a34dc4a9b9e2fb3a45c179a60bb0b26539c96189:

  ksmbd: downgrade ndr version error message to debug (2023-01-25
18:31:18 -0600)

----------------------------------------------------------------
4 smb3 server fixes, all also for stable
- fix for signing bug
- fix to more strictly check packet length
- add a max connections parm to limit simultaneous connections
- fix error message flood that can occur with newer Samba xattr format
----------------------------------------------------------------
Marios Makassikis (1):
      ksmbd: do not sign response to session request for guest login

Namjae Jeon (3):
      ksmbd: add max connections parameter
      ksmbd: limit pdu length size according to connection status
      ksmbd: downgrade ndr version error message to debug

 fs/ksmbd/connection.c    | 17 +++++++++++++++--
 fs/ksmbd/ksmbd_netlink.h |  3 ++-
 fs/ksmbd/ndr.c           |  8 ++++----
 fs/ksmbd/server.h        |  1 +
 fs/ksmbd/smb2pdu.c       |  2 ++
 fs/ksmbd/smb2pdu.h       |  5 +++--
 fs/ksmbd/transport_ipc.c |  3 +++
 fs/ksmbd/transport_tcp.c | 17 ++++++++++++++++-
 8 files changed, 46 insertions(+), 10 deletions(-)

-- 
Thanks,

Steve
