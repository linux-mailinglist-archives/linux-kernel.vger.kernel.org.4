Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC237453E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 04:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjGCCjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 22:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGCCjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 22:39:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A7188
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 19:39:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991f956fb5aso360857366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 19:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688351990; x=1690943990;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WE1udTrUsT2edChZzv6L+ir7WM7kk7pBFHlxnNJ5nw4=;
        b=O2drzVWGT4tT9QKi4lABi6mRtmuce9/qwRDJH07bqtb4pvh0GG37BPwA15WUeSlPEZ
         eKUdTb/nqN20q0aMvEjyRslgHzK2MhL6RRLXbLvWWzySH+OdiGddItsZa6elbMJMDplc
         zOY/ICzJvTbXe6I5N+CWFrd7o0SecPT0lGQIq7qSrZOXZtXlNdsmKNmLeWnYzx+sfgKm
         tL6fYxpmEYTTfXKzmYhpHfliXUU9tOTFo3xxSHeVhoOIHpPLclfA42sDxgNNq92+ff0r
         9VOc5N1XSSR6O/ZUD47z29oCndQ7MdkMLXsT7d+1XReshW+J+DjDgc08Lpl8pRE2caiV
         QSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688351990; x=1690943990;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WE1udTrUsT2edChZzv6L+ir7WM7kk7pBFHlxnNJ5nw4=;
        b=cjlmdaMIpwDkRS6Qf0MTVrmdLBPsxMBVz3fmwlk/XMqa8j5rL79QMMm/Zr1aIzjF19
         U5DAx5yZLpIA+VQTDc18amOnGrPO36dnlRuCUwKBhVR9/maPraUlNKnN4ramwyug0nrY
         kE0L+RR64Y4JSWdqtk3cuY2frKZxgLeB+8+hJ3RheHjYHHe3DE/S/lMAiakBNFPvMYzH
         8G/NovJ86Th/PwPAzwvMWl6I0SNLtgTGuXJMJUNwJAAD7Hbdun7s635SCm/VBSJNX1Yh
         lpM5x9islh2tejo3fqqDbWPiDFWubeAsfCAMppUhvrYNVtmPfssWOgwQeCOxzSXvEDhH
         YTxQ==
X-Gm-Message-State: ABy/qLbaejZtscYb6N0Z4hvwQDJR605sCdulLxIGJCnSfTVdGcHDxcy0
        lAZ82wsPrctoA4rsWhOKig+Kl/8bBrq1l+WcBZ2lijJjUIA=
X-Google-Smtp-Source: APBJJlG+0aGcX3Gwt8QheWbG8Y2ZjeRkEcpQXDIzFSaVroNN13gX9RKXmhrU6nGFOI8Vzzz0YugTVsEzCf1ybRe8p/Q=
X-Received: by 2002:a17:906:7c50:b0:993:7594:99ae with SMTP id
 g16-20020a1709067c5000b00993759499aemr107280ejp.0.1688351989932; Sun, 02 Jul
 2023 19:39:49 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 2 Jul 2023 21:39:38 -0500
Message-ID: <CABb+yY3x6B+nKXENKGWq4qL0ezEq2=ZwkGJi+p2rSWxyCFG13A@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v6.5

for you to fetch changes up to 1b712f18c461bd75f018033a15cf381e712806b5:

  mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0
(2023-06-30 17:35:45 -0500)

----------------------------------------------------------------
tegra: support for Tegra264
broadcom: convert bcm2835 bindings from txt to yaml bcm2835
qcom: support for IPQ5018
ti: always zero TX data fields

----------------------------------------------------------------
Manikanta Mylavarapu (1):
      dt-bindings: mailbox: qcom: Add IPQ5018 APCS compatible

Nishanth Menon (1):
      mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Peter De Schrijver (1):
      dt-bindings: mailbox: tegra: Document Tegra264 HSP

Stefan Kristiansson (1):
      mailbox: tegra: add support for Tegra264

Stefan Wahren (1):
      dt-bindings: mailbox: convert bcm2835-mbox bindings to YAML

 .../bindings/mailbox/brcm,bcm2835-mbox.txt         | 26 --------------
 .../bindings/mailbox/brcm,bcm2835-mbox.yaml        | 40 ++++++++++++++++++++++
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml      |  1 +
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  1 +
 drivers/mailbox/tegra-hsp.c                        | 16 +++++++--
 drivers/mailbox/ti-msgmgr.c                        | 12 +++++--
 6 files changed, 65 insertions(+), 31 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
 create mode 100644
Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml
