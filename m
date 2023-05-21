Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7070AC76
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 07:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjEUFOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 01:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUFOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 01:14:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49999119;
        Sat, 20 May 2023 22:14:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so5604370e87.2;
        Sat, 20 May 2023 22:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684646086; x=1687238086;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OSn+AKVBiBTX7km27zSr9ngaOs21L/I4AitRB9KUSH0=;
        b=N/5x0r/PG2QCg7J1igVQ8z7KErgWMLqVm4/KwAVm2IFInTmU8A0YsQ7D9n8LFruhWi
         q9lcrIM/CRB0GJTvFpLwckDGsdBQlY5b1cSRPP6M+gp8Y2PVEWmFXDwrJcycDke/4Xlo
         iobafj5fC+BYar0ZwvuP19a/0EgQR9Xr0Sl+96D91ZMpPHvTkCKAgfvrPRQp4aJVuKwl
         e+YCM1Qiq5KxqcoMx0+4uWsZSj6TJ+LZUTdfIqbT+NOdPFM3gK/6/GYuDpZAHHV9Z+NS
         f+viBwPRWBivGc6zc6tH9VklDCFkfUrW36z2a0Yquhz1yNxInMYbeFx/Vph3mK38iLC2
         QLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684646086; x=1687238086;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSn+AKVBiBTX7km27zSr9ngaOs21L/I4AitRB9KUSH0=;
        b=ZMPKCGqjN7GI1Z+d0e/2HNB0J0SHG0cjMZ7YeK7yaVYfLvSl7Anc1zygT9wZ+iZ1Tl
         7zosBdmfFkceL4uEbTCapl5aZzL8zy2ZhPCzDLxh5jIap0UeatKQusrp6XsgQw3ofJYk
         psMGcWXoo/OzQbFPiSvPpziD15yMrkX9h/n6nsUZBbuk96JKmg6prWXULxN+EkJ5x3WM
         P6rIobtSGQr159+SxvjN5QsvYtKaO8iqx8eTww5uLSEb/YsyaYRE/bbUgM+4g58i8tjg
         x23o6kxrf15n9gJypprOR0fPIbXEiqLdGHFGn2lvVpsDovmhwBuyqL1zgZfz+SCwwS+Z
         vm+Q==
X-Gm-Message-State: AC+VfDzTM/PfQJ2qABBMq1hOCB3acpRKXxE/rVXa09riDHvroZMrMNW9
        XXCL+SuZT/H0y5V2FXbMdaDPstDpystx816G0GhXzBmj0hPqqwPd
X-Google-Smtp-Source: ACHHUZ4sJ79vDrleTqO4EWZcRom17FT2a5dk9TyR5e7yqK4ioMYJDSeLaRFnyW0AIMGo3VRII7z2R6JqLmBb54Xwhek=
X-Received: by 2002:ac2:41cc:0:b0:4f0:2233:9b9 with SMTP id
 d12-20020ac241cc000000b004f0223309b9mr2281482lfi.62.1684646086257; Sat, 20
 May 2023 22:14:46 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 21 May 2023 00:14:35 -0500
Message-ID: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.4-rc2-ksmbd-server-fixes

for you to fetch changes up to e7b8b8ed9960bf699bf4029f482d9e869c094ed6:

  ksmbd: smb2: Allow messages padded to 8byte boundary (2023-05-16
10:26:14 -0500)

----------------------------------------------------------------
Four ksmbd server fixes:
- two fixes for incorrect SMB3 message validation (one for client
which uses 8 byte padding, and one for empty bcc)
- two fixes for out of bounds bugs: one for username offset checks (in
session setup) and the other for create context name length checks (in
open requests)
----------------------------------------------------------------
Chih-Yen Chang (3):
      ksmbd: fix global-out-of-bounds in smb2_find_context_vals
      ksmbd: fix wrong UserName check in session_user
      ksmbd: allocate one more byte for implied bcc[0]

Gustav Johansson (1):
      ksmbd: smb2: Allow messages padded to 8byte boundary

 fs/ksmbd/connection.c |  3 ++-
 fs/ksmbd/oplock.c     |  5 +++--
 fs/ksmbd/oplock.h     |  2 +-
 fs/ksmbd/smb2misc.c   |  5 ++++-
 fs/ksmbd/smb2pdu.c    | 19 +++++++++----------
 5 files changed, 19 insertions(+), 15 deletions(-)

-- 
Thanks,

Steve
