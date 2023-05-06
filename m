Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F3F6F92DE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjEFPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEFPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:53:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942C5132A2
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:53:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso518869566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683388382; x=1685980382;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ck6zJg23D57Mp4MYLJDg7wH0t/crJeayIMTmscm2u10=;
        b=U14AwPLFwKtRFSfnNRLHMzGN0iLfgIF2FTRhrogxGa9X+u7JczSKMml65yNIqgSYjn
         OxEHNzHpHX8GSudqOz2Na4xTUzvUgaZKekAkQtDr/1Qr1W2MANBloXteFDUGpcdQd0a0
         LKDhwBQ4xYIsmVr1sfwQzHAl8KkOmiw3HZpueWv0sHebl7WYR7MOumdOEXH7zJtZz0Ir
         HxS7VecYTQARy4mrkqS7mESYnUt46JfT/p/eF6/r/VL4i87F+XmUoCqorIBx2Yc4TiLt
         x5m+Y4npoWhWnlKde5GGbI4n0W2s04146FiAB07kMgSMKLSL043SfL08xeTSyAP4Pxs5
         OEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683388382; x=1685980382;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ck6zJg23D57Mp4MYLJDg7wH0t/crJeayIMTmscm2u10=;
        b=PVmG6Ph5j7yiUrnOMKTxWxPHf1pWEIztVaZ3+j+AgY+JhS2vi+dsZEFNdXmgTaL2jB
         JcwtAKubc0/W+e/rwPyp1SAgnmoRzjlKxEBxtUoxWhGNNbMYYoM2tVgzkkhr8/loREmz
         kSvV2VslR0ucYkBLAG5X//tQihPY6b49hWhSBqP8YujD/s05jNvAU5X/ZFbb601vlDUl
         meYhD9xt+AMlo2UZe7rSmLzFmz2wxz7VPubT9VWmn6Aa2WQ/KvzJz1m3JVLjpHjYZzJX
         9U7+WXZH72gK49EAHPjEEhv+1pZ4RHsi3BWhoTfWHS0mPBW92lgN/6K5brAlLi7Fwuek
         /YsQ==
X-Gm-Message-State: AC+VfDx9amuT9nwqmmrMEM3rENUH/TCU6rp+vrfOwRpcAvJcN0TcRCLW
        cByix/vLBzXjmRTeFrRE1CkX7H+eaDBltyFYlTgw0ALOu5c=
X-Google-Smtp-Source: ACHHUZ5YenGsxL5hdNeoaLRIYOpG/VSvNFX5UJ2zaz0c0gAg3QINhkRTkqEjMGx5NUZKCuWoWE/Nhe3pIm9aiXAtcVc=
X-Received: by 2002:a17:906:7312:b0:961:800b:3f5e with SMTP id
 di18-20020a170906731200b00961800b3f5emr4116908ejc.72.1683388381773; Sat, 06
 May 2023 08:53:01 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 6 May 2023 10:52:50 -0500
Message-ID: <CABb+yY2CgTjCG-mxdmvkPZPz1XTB8Mm7PW+8WsNx6_dEY5bsnA@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

Hi Linus,

The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v6.4

for you to fetch changes up to d396133dced4cbaa52581d0e9c4aea8e04b8db10:

  dt-bindings: mailbox: qcom: add compatible for IPQ9574 SoC
(2023-05-04 01:08:41 -0500)

----------------------------------------------------------------
- mailbox api: allow direct registration to a channel
   Convert omap and pcc to use mbox_bind_client
- omap and hi6220 : use of_property_read_bool
- test: fix double-free and use spinlock header
- rockchip and bcm-pdc: drop of_match_ptr
- mpfs: change config symbol
- mediatek gce: support MT6795
- qcom apcs: consolidate of_device_id
support IPQ9574

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      dt-bindings: mailbox: mediatek,gce-mailbox: Add support for MT6795

Conor Dooley (1):
      mailbox: mpfs: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE

Devi Priya (1):
      dt-bindings: mailbox: qcom: add compatible for IPQ9574 SoC

Elliot Berman (3):
      mailbox: Allow direct registration to a channel
      mailbox: omap: Use mbox_bind_client
      mailbox: pcc: Use mbox_bind_client

Krzysztof Kozlowski (4):
      mailbox: rockchip: drop of_match_ptr for ID table
      mailbox: bcm-pdc: drop of_match_ptr for ID table
      dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks for
few variants
      mailbox: qcom-apcs-ipc: do not grow the of_device_id

Lee Jones (2):
      mailbox: mailbox-test: Explicitly include header for spinlock support
      mailbox: mailbox-test: Fix potential double-free in
mbox_test_message_write()

Rob Herring (1):
      mailbox: Use of_property_read_bool() for boolean properties

 .../bindings/mailbox/mediatek,gce-mailbox.yaml     |  20 ++--
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  31 +++---
 drivers/mailbox/Kconfig                            |   2 +-
 drivers/mailbox/bcm-pdc-mailbox.c                  |   2 +-
 drivers/mailbox/hi6220-mailbox.c                   |   5 +-
 drivers/mailbox/mailbox-test.c                     |   8 ++
 drivers/mailbox/mailbox.c                          |  96 +++++++++++-----
 drivers/mailbox/omap-mailbox.c                     |  25 +----
 drivers/mailbox/pcc.c                              |  84 +++++++-------
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  11 +-
 drivers/mailbox/rockchip-mailbox.c                 |   2 +-
 include/dt-bindings/gce/mediatek,mt6795-gce.h      | 123 +++++++++++++++++++++
 include/linux/mailbox_client.h                     |   1 +
 13 files changed, 288 insertions(+), 122 deletions(-)
 create mode 100644 include/dt-bindings/gce/mediatek,mt6795-gce.h
