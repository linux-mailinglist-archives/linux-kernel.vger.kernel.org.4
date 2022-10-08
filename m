Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C380C5F8228
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 03:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJHByS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 21:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJHByQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 21:54:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2709C2DF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 18:54:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y100so9186547ede.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 18:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vNQkh3esU/3yExtlySxGL9U75L+VrhNcWenNvU/qQ2o=;
        b=pDijo744FmzdZsOYwrbipySTj7EHBufxIHIMQis2GyoFaWC3s8XexFYbyE6KWLhhdR
         8lWSMuFjvRKSHTrSQK6ruFn+O3B/gvRg2AP5QmL9Wp6WdTzcISt+zwETL1HqKOB9dFb/
         swUo64lVqAZlBVpRJyc542uGHYTkAEysN36VwWwOAHrtDm8NNEuhNTN7iuTWDywCyvb3
         llzgE/Ql95FxcrGLhthqGWl9Ooi8zxPkVHqgvJ8CxoIpTm/Hal87cPBZ8ho/h0Vxz4H0
         nwdT57Lt8BxblXYB/ErOWsiVXimVynYDvgCSjKkgreVh/IymjBdK4pLXYXNgthDZCWy/
         nnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNQkh3esU/3yExtlySxGL9U75L+VrhNcWenNvU/qQ2o=;
        b=V0okkYXhrUdLTQkrPWqyBJJHOs+ZXKkEbycbPRvqSaKFMRbuE/MOp+eEzlOz80Yhc6
         0IVbe7mfbwm/hBAF7l1ISOv3rsMDAdnb6P+B1RECybdNo6Ah61ypMXaY4gYZdjzY21TT
         CQVzfIz0WoY50xxpmm5yuDqx0bG3B064S8IjtRVpj9TI8fg3eho3yqzJAbqa/gXPgNia
         C79KlCFoLzpkw5y3YNWC/WKscNQwPR0bFdhJWS39UI6T9uwjEI42sWTfZ96sgYvK/502
         d8M2NTXiar9kjDwlFZmn0CiYz9Qp1Xr3amb8zKh+9fDmuHeMAgQBF9s3gEQgftAQpm/4
         LKrg==
X-Gm-Message-State: ACrzQf0QRWGJa9hOUJyYXmaAfs6gHjuPm/QGr0pzz8suM7iMO8ZlC4h2
        YO+kyIED5E/Gq60qCP6AZ9WEevMAODW1Qw2RrkcUzyNOXqQ=
X-Google-Smtp-Source: AMsMyM5OYhVaQjBBq5awKphUF3On/2ev26MG+dNa2IjypoB91hiWTU3xUx71M5gpm3H1BdqfXquc/BZ6MGT2+Rng6+o=
X-Received: by 2002:a05:6402:169a:b0:458:fe61:d3b4 with SMTP id
 a26-20020a056402169a00b00458fe61d3b4mr7030419edv.140.1665194053584; Fri, 07
 Oct 2022 18:54:13 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 7 Oct 2022 20:54:02 -0500
Message-ID: <CABb+yY3b28dTgLNEtUN4OQc6ixmMXrN=9trgRQ9r6NvPXobXfg@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

Hi Linus,

The following changes since commit 3245cb65fd91cd514801bf91f5a3066d562f0ac4:

  Merge tag 'devicetree-fixes-for-6.0-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2022-09-14
10:22:39 +0100)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v6.1

for you to fetch changes up to b8ae88e1e75e5cb7a6df5298ab75334362ed631c:

  mailbox: qcom-ipcc: flag IRQ NO_THREAD (2022-10-05 21:51:58 -0500)

----------------------------------------------------------------
- apple: implement poll and flush callbacks
- qcom: fix clocks for IPQ6018 and IPQ8074
irq handler as not-a-thread
- microchip: split reg-space into two
- imx: RST channel fix
- bcm: fix dma_map_sg error handling
- misc: spellinf fix in pcc driver

----------------------------------------------------------------
Colin Ian King (1):
      mailbox: pcc: Fix spelling mistake "Plaform" -> "Platform"

Conor Dooley (3):
      dt-bindings: mailbox: fix the mpfs' reg property
      mailbox: mpfs: fix handling of the reg property
      mailbox: mpfs: account for mbox offsets while sending

Eric Chanudet (1):
      mailbox: qcom-ipcc: flag IRQ NO_THREAD

Hector Martin (2):
      mailbox: apple: Implement flush() operation
      mailbox: apple: Implement poll_data() operation

Jack Wang (1):
      mailbox: bcm-ferxrm-mailbox: Fix error check for dma_map_sg

Peng Fan (1):
      mailbox: imx: fix RST channel support

Robert Marko (3):
      dt-bindings: mailbox: qcom: set correct #clock-cells
      dt-bindings: mailbox: qcom: correct clocks for IPQ6018 and IPQ8074
      mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock support

 .../bindings/mailbox/microchip,mpfs-mailbox.yaml   | 15 ++++--
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 63 +++++++++++++++++-----
 drivers/mailbox/apple-mailbox.c                    | 63 ++++++++++++++++++++--
 drivers/mailbox/bcm-flexrm-mailbox.c               |  8 +--
 drivers/mailbox/imx-mailbox.c                      | 10 ++--
 drivers/mailbox/mailbox-mpfs.c                     | 25 +++++----
 drivers/mailbox/pcc.c                              |  2 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  2 +-
 drivers/mailbox/qcom-ipcc.c                        |  3 +-
 9 files changed, 148 insertions(+), 43 deletions(-)
