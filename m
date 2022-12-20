Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A303652494
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiLTQXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:23:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07438A7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:23:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so30331359ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vpeOz/atwWaq5P+CzmUvCEmhM3lI80E7mUtcoB02w74=;
        b=H6Xnf+DoOeubjON59vfR3tll2Ze7ycAtog0dv21Ya81ghBJC9fektXMQfA1cStPSN7
         EoAvTghXN+hfj0lthh4Ij34eDAY1+g2sgITyBBD7iwOE2BEskHY1Dr4boqeVnmuGH9yZ
         ZNCN+HQ+8Y46Tz0fkpi1xrFzvMzu3TJHOXMP0Y/yPviDcyQ1ZkGu6EqMs8pOoPEQNzgn
         XuZ4+wudLVbXfCjfGR7djXLa1MUn2DN26epRM7SvhVWAT37tHWzpMj6jrPuzIbUpiWSB
         cchN/TrkD+uloNXMmtC6PVRXcLQiWkkM+h68nq+G3nmPHWG6GkJ0srjvxh02xwYSPUMU
         IkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpeOz/atwWaq5P+CzmUvCEmhM3lI80E7mUtcoB02w74=;
        b=ncMlKvX7XzWjjKL/kFZ3DJmfpyOW5udIxIW9m8E9/ezAbDMWBiCUZyrCad+pBuGhxb
         t96k6dBu37+tm+9vj6D2QJmTEAWjzTPb2xSJsge5lE+TVt9KVDh9l8yzKVU2EydFSuYR
         lfROXZ9BobXs9rEvjhPeie8iTvfZC1sRxXrOd0gzMVUGo3koZmqRrlDMCLyPWQ4OCi4K
         pbLjVGD06GS3BTTiDi5djhDWk9mJ07ebBgslmgI7rTlVb+Mutqf2zehCjaiJ3O8QU69o
         /cdhuL5RP0l/+zU8PGPX3aXACj/pTDPAXEQRauzRA/00jkVXYI7ZTk3kO+NXoNTYetT+
         z78w==
X-Gm-Message-State: ANoB5pmvH8t1YoTTruL0ljcsTfs31ynfZ9SSH6FuiorJscbfukd2Fycx
        H/OqhROMuBAoImTD1dEBhNgAB6bO1Yj7l+y7XCM=
X-Google-Smtp-Source: AA0mqf7RHX17NWI60VxPqknRtjbPtOmXKODWqoZQXgjdLGnZtvU+eamDexaf47D2fnFUX3bRkcSd+f0KIrd9WSEHU5I=
X-Received: by 2002:a17:906:d8a6:b0:7c0:b741:8b61 with SMTP id
 qc6-20020a170906d8a600b007c0b7418b61mr30324621ejb.625.1671553421350; Tue, 20
 Dec 2022 08:23:41 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 20 Dec 2022 10:23:30 -0600
Message-ID: <CABb+yY1_UYa9T7pNc0yPhmx4hy3W=O5xL4mhfSjZx3s-jnRV7A@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v6.2

for you to fetch changes up to 53c60d1004270045d63cdee91aa77c145282d7e4:

  dt-bindings: mailbox: qcom-ipcc: Add compatible for SM8550
(2022-12-18 20:40:31 -0600)

----------------------------------------------------------------
- qcom: enable sc8280xp, sm8550 and sm4250 support
- ti: default to ARCH_K3 for msg manager
- mediatek: add mt8188 and mt8186 support
            request irq only after got ready
- zynq-ipi: fix error handling after device_register
- mpfs: check sys-con status
- rockchip: simplify by using device_get_match_data

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mailbox: qcom-ipcc: Add compatible for SM8550

AngeloGioacchino Del Regno (1):
      mailbox: mtk-cmdq-mailbox: Use platform data directly instead of copying

Bhupesh Sharma (2):
      dt-bindings: mailbox: qcom: Add SM4250 APCS compatible
      mailbox: qcom-apcs-ipc: Add SM4250 APCS IPC support

Conor Dooley (1):
      mailbox: mpfs: read the system controller's status

Elvis Wang (2):
      dt-bindings: mailbox: add GCE header file for mt8188
      dt-bindings: mailbox: mediatek,gce-mailbox: add mt8188 compatible name

Luca Weiss (1):
      dt-bindings: mailbox: qcom-ipcc: Add sc8280xp compatible

Nicolas Frayer (1):
      mailbox: config: ti-msgmgr: Default set to ARCH_K3 for TI msg manager

Ricardo Ribalda (1):
      mailbox: mtk-cmdq: Do not request irq until we are ready

Yang Yingliang (2):
      mailbox: arm_mhuv2: Fix return value check in mhuv2_probe()
      mailbox: zynq-ipi: fix error handling while device_register() fails

Yongqiang Niu (4):
      mailbox: mtk-cmdq: Use GCE_CTRL_BY_SW definition instead of number
      mailbox: mtk-cmdq: add gce software ddr enable private data
      mailbox: mtk-cmdq: add gce ddr enable support flow
      mailbox: mtk-cmdq: add MT8186 support

ye xingchen (1):
      mailbox: rockchip: Use device_get_match_data() to simplify the code

 .../bindings/mailbox/mediatek,gce-mailbox.yaml     |   1 +
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   1 +
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |   4 +-
 drivers/mailbox/Kconfig                            |   1 +
 drivers/mailbox/arm_mhuv2.c                        |   4 +-
 drivers/mailbox/mailbox-mpfs.c                     |  31 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 130 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   1 +
 drivers/mailbox/rockchip-mailbox.c                 |   4 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               |   4 +-
 include/dt-bindings/mailbox/mediatek,mt8188-gce.h  | 967 +++++++++++++++++++++
 11 files changed, 1090 insertions(+), 58 deletions(-)
 create mode 100644 include/dt-bindings/mailbox/mediatek,mt8188-gce.h
