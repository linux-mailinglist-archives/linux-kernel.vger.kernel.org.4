Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D27719E61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjFANlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjFANlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:41:12 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65B4138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:41:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af2958db45so11961051fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685626869; x=1688218869;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SlU3x5kCipfhlwi3DVH+l4r3C8W1DjSXRVZ9nyNCRRc=;
        b=BlZNDPtGkA4PvC6xzQCbWaT9LLeGl+wIBl8hR27bwTYeOW7hiDpZvI8lVk23FAlMLP
         nuHN48/fzb1Z328/+I8PIZ5fMi7YEV8I4HCKAOjw1Z+8rH2yKGN/9pxYIc8qLmTyz3zb
         CA3sl3JDZ5W+nsfZGxsr5XEn6FgoH8mAraogyrd0/DPCwklt4aS0kJN0x5eMUdUop5EA
         p5XUbZBaFpmPNlYS+6uM38bQBeW/PV9jTKAwUstcL4YEew0KzXtPFR6fn0Eth8kE2KwS
         4sFlbh4ooIFJ7cj3klovF+zLClY49z1h2kB+VuZv29QZzW1L/5D4ue58lRlc+4BhnXto
         2t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626869; x=1688218869;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlU3x5kCipfhlwi3DVH+l4r3C8W1DjSXRVZ9nyNCRRc=;
        b=jcw3LfqQnZRTn6k0wKiAtBpNBK1PmM9qsE4vV70KQKfnb/FJ2shgk9U6Bg+SMzt98R
         gKCPVuyXIQA2trHmJu5DoQ78i0tbUGraci+kvj07EwqjNpPw6HNY38d1D15RQro5WvOY
         IkBFbBml/Noew+Q0/5S/vxZsfvJu+XXQyFORowzLBk0RzwU/vZCDKUAWV8Ed6yUDay37
         Wyw0b91V6lpIsJzxDq6Ca02knNmJehCqMWWuOdjYXg+g7qXXrXWbF7kPLkn9A+HppGlF
         6jlg+zHkdBhpt/nVlBH8z8M15jWZrIPDTp8sER8HA/HCnPIZaAsYX72rYWV1BKiXQBAw
         zdTw==
X-Gm-Message-State: AC+VfDxxgBT+G1/0EjMbfwP8UdmbGASMAgnd7klCzEk5zYqvyby77bTE
        no1VVl1zKrMXsOBSVg2EcUtEsUiP7RCFUNLE7k/9972h
X-Google-Smtp-Source: ACHHUZ7e1v7aCNRtDsC1dztPNfh+UIoW4at+8sK7LU/ttgEiOpnUPImtnqd7FCPZJymdCyPC/vFP0aEeenJz1fo6NNI=
X-Received: by 2002:a2e:84d7:0:b0:2b1:a4f0:8ce5 with SMTP id
 q23-20020a2e84d7000000b002b1a4f08ce5mr1103029ljh.22.1685626868724; Thu, 01
 Jun 2023 06:41:08 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 1 Jun 2023 08:40:57 -0500
Message-ID: <CABb+yY3NTc8+kq43fuQrcDSTC-EKh-ZAij0MLuTrdWodur5Fjw@mail.gmail.com>
Subject: [GIT PULL] Mailbox fixes for v6.4-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Linus,

The following changes since commit 884fe9da1b7ccbea31b118f902fbc78f58366b4a:

  Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2023-05-31
14:13:09 -0400)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-fixes-6.4-rc5

for you to fetch changes up to 8fe72b76db79d694858e872370df49676bc3be8c:

  mailbox: mailbox-test: fix a locking issue in
mbox_test_message_write() (2023-05-31 13:26:44 -0500)

----------------------------------------------------------------
mailbox-test: fix missing mutex unlock

----------------------------------------------------------------
Dan Carpenter (1):
      mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

 drivers/mailbox/mailbox-test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
