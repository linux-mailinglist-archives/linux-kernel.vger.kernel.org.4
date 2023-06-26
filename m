Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D354D73EC43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFZU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFZU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:57:39 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C456125
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:57:35 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5728df0a7d9so42151977b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687813054; x=1690405054;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfxo+qeDQtE6pfqX2pSVRn4Ktm5TmTSx9jMdiyp1OT4=;
        b=XpIIXT1JP95o4USFFOxXJXcoIrgMALNoGaOpjXNUYPtNxL7AVGgjNT6tncC8SlNk8a
         CnOjClmdLziA56k70SuTLjis8gL0y+NTFNoRD/lyp/e1Q6RLilOSBu9xwRv0TKPTFYr3
         P2Cq9DNnieb5kUuX/V+XO8r0C5u4fMJKtAFhl74uh4Ki56mSMca6ZrnGh8B6Z7suZlrA
         Z64D+gn2ajp29P3YJ0aoDE75vvLTMtQz9kNcR8nsqOlRMrt6kcDXERIsIEy986yU/daH
         gPo91Efo56Z73JxuTvfrRwedHJT15lWBCDgcNbNcuTY61aqTSV7eikyJig1lQAluz3ZH
         GfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687813054; x=1690405054;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfxo+qeDQtE6pfqX2pSVRn4Ktm5TmTSx9jMdiyp1OT4=;
        b=MBtuvH9ZXrGh60Gne9KkDtQcRH9LIPbc5SfyMz9etvPC1x429hWcu36XKcrcZlOMfr
         7Q0pv4xI1N7trgnUyhufCYYro7mV78yZTuypD7jyW4CHDevt09flbzmHuoGickV87xoL
         Kj1Yz2DqQhYMGvtMPTMbj5D4S3Wh6szR1XOE0K88/P6sHzc7xGlYNBk21/88e2vOS7jo
         m2Yfl0pr3jfDm6ztQW404YavnVxjvBMn1GnYuTtXQ7X4tT2U0scdQzfZr+QHKZb0kQyT
         t/eNKf7FC+m9YQopdGCYy0vAjr8tbKrsRr73z30+dhCsv355LvuUgLxk2aeIDEhxCQHs
         DUzQ==
X-Gm-Message-State: AC+VfDzRNj0gODJuHFBzrBiQx6e79ugofhB8e7At4DQDmgg+OtLX14j1
        6TSEDYxQXGqnlmK9W2VDgLKXYjik+7gKaNz0ORu/
X-Google-Smtp-Source: ACHHUZ6ZyOU0JoT8cNBcFBcx5J+DrrL8BN+fGLFUQjVOnsFRFC3jsF+bemFQsyMFGAHKSXzDBI4TNpCJZCtTZ1xUNZI=
X-Received: by 2002:a81:e943:0:b0:576:916d:96b with SMTP id
 e3-20020a81e943000000b00576916d096bmr9971637ywm.36.1687813054539; Mon, 26 Jun
 2023 13:57:34 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Jun 2023 16:57:23 -0400
Message-ID: <CAHC9VhTcPVRAoxWn+EpMcGPThgtfhB=z3LM3BkMtxKv6aQYPFw@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A single audit patch for the Linux v6.5 merge window that resolves two
compiler warnings regarding missing function prototypes.  Please
merge.

Thanks,
-Paul

--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

 Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20230626

for you to fetch changes up to e455ca40dbcf2cd50d1e59bf4b2752b300bcdad4:

 audit: avoid missing-prototype warnings (2023-05-17 11:34:55 -0400)

----------------------------------------------------------------
audit/stable-6.5 PR 20230626

----------------------------------------------------------------
Arnd Bergmann (1):
     audit: avoid missing-prototype warnings

include/linux/audit.h      | 2 --
include/linux/audit_arch.h | 2 ++
kernel/audit.h             | 2 +-
3 files changed, 3 insertions(+), 3 deletions(-)

-- 
paul-moore.com
