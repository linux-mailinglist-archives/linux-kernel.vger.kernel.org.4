Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C96A23CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBXV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXV2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:28:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B1125A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:28:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s26so2466803edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRAThVXs60a4Q7LBwPuQkj+PUeZris9Nk8uDTLMgFV8=;
        b=SYbhV4EHJoTxaBzuMvbR0qZyp9NgiQTj3Tm0XrrpGHg/hYXaC/yU6pUxcNpSVac+qN
         GC/ndefXICYdYj0QbNnJilpQwEUBBpIfc+w2MhSPWUIeNu1zG3Jno4E9UYytrRO2u3B8
         4MRP2SSIvTrxpE10pDOmFZccgHtf8zYgZgr3Mzdvr3xl1030cPasGM0gkkv4sa1TicGy
         h3WZ4YYO+/B1fcOaTdEfLQc0TrQzEONFHOeF7i9K5RHE6UMEpz1UGiBlFq8AHPG7smpR
         1xRAEjcbQGPILlJolzHDd259WmWnvQYMMtBYr7rkFBVQfOgHluFhM+jJHN/jk/8smfYB
         iZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRAThVXs60a4Q7LBwPuQkj+PUeZris9Nk8uDTLMgFV8=;
        b=x5QWDpLHE5kBo2Mmt+JcOqCscEs0hqGkUTBI+QMeA81rZDirQrwdJ4JDaUs+cx6/L6
         ozJitKavPJpYfvxvmYfSSNf5K7Yp4KmJmxUDk3Hi7UXtoGF923/DIgJ3WAehGA/sX3VT
         PN+OU4kb2yj2OwWpBM6UeA8BQlzoPICWMXkGO049ZYdjnruqw3NmlG5mHKMLfYSp26oE
         lb0z9rkFuONyYupVmadt16U4Qq7E8qzE0Q6U8fgXHZPb+BR/ATW5hrEOFdsLSL0J71WK
         IRdZERih47Pzs/MthB5u2Cw42sACp0yR41VCvhJS+hNj0aaKayN8RdwIY63C5lYqmkSm
         J51g==
X-Gm-Message-State: AO0yUKUkQo+JLSgsmczao847s3xqF+/fnvrX3CAQhthcoe5px9wTAFvO
        5x1bPRL1ae0R4Gb+p3jQvjlvg5n+tWrwRcovnAc=
X-Google-Smtp-Source: AK7set/MdAgCuWjuNZu26TkNYWSRBcPx/qXK5xgkmyV8GSwygOUUYxKOPqKKxQZwvTOgbLdgNVui5rqhnQBU/7cEjKg=
X-Received: by 2002:a05:6402:4494:b0:4af:6e95:85e9 with SMTP id
 er20-20020a056402449400b004af6e9585e9mr858242edb.4.1677274079172; Fri, 24 Feb
 2023 13:27:59 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 24 Feb 2023 15:27:48 -0600
Message-ID: <CABb+yY3u9hBsHEeJXEYcdohhy-nQy8io1ZN1-MhFjvudUBPZ6w@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.3
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

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v6.3

for you to fetch changes up to 6ccbe33a39523f6d62b22c5ee99c6695993c935e:

  dt-bindings: mailbox: qcom-ipcc: Add compatible for QDU1000/QRU1000
(2023-02-23 14:47:13 -0600)

----------------------------------------------------------------
- qcom: misc changes to bindings for sa8775p, QDU1000/QRU1000,
         IPQ5332, SDX55, msm8976, glink-rpm-edge
- sti: convert to DT schema
- zynq: switch to flexible array to simplify code

----------------------------------------------------------------
Alain Volmat (1):
      dt-bindings: mailbox: sti-mailbox: convert to DT schema

Bartosz Golaszewski (1):
      dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform

Christophe JAILLET (1):
      mailbox: zynq: Switch to flexible array to simplify code

Dmitry Baryshkov (6):
      dt-bindings: mailbox: qcom: add SDX55 compatible
      dt-bindings: mailbox: qcom: enable syscon compatible for msm8976
      dt-bindings: mailbox: qcom: correct the list of platforms using clocks
      dt-bindings: mailbox: qcom: add missing platforms to conditional clauses
      dt-bindings: mailbox: qcom: add #clock-cells to msm8996 example
      mailbox: qcom-apcs-ipc: enable APCS clock device for MSM8996

Kathiravan T (2):
      dt-bindings: mailbox: qcom: add compatible for the IPQ5332 SoC
      mailbox: qcom-apcs-ipc: add IPQ5332 APSS clock support

Krzysztof Kozlowski (1):
      dt-bindings: remoteproc: qcom,glink-rpm-edge: convert to DT schema

Melody Olvera (1):
      dt-bindings: mailbox: qcom-ipcc: Add compatible for QDU1000/QRU1000

 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 53 +++++++++---
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  2 +
 .../bindings/mailbox/st,sti-mailbox.yaml           | 53 ++++++++++++
 .../devicetree/bindings/mailbox/sti-mailbox.txt    | 51 -----------
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   | 99 ++++++++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,glink.txt    | 94 --------------------
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  3 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  6 +-
 8 files changed, 197 insertions(+), 164 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
 create mode 100644
Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
