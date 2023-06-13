Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8072E6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbjFMPSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbjFMPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:18:18 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A710DA;
        Tue, 13 Jun 2023 08:18:17 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77af8476cd4so138365439f.1;
        Tue, 13 Jun 2023 08:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686669496; x=1689261496;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWDvuSYvyO0yT5XAM5g7LXE8j9cOzjQQlkcaunrDQec=;
        b=JcojDTMG4Hgl+0fqpSG+UbOG/igey+m74D4NiHBMKc4VtvxzfZbvVZjzkVbDLv/mbG
         aLYQoZIJrBSAlPm+UMeGSH3oYmKgOk0HU1JiYWEOgo5jBU2DRbIIku00YhS8JL+CCwM9
         rkVQUTFXb9pWEZVRYgozZaxaWseZ2KJ9/HNrRqs3/f12O4UlYVjYlLMLe6nrAWAkkOPY
         osVFSNJmfy/1lMH2iMZcqftDlsCblz9UG+kfxvKs5NyOy+1LShmi7CaluqwVrUA5UOXd
         fLdJfPCkbAbHr41jlBCFo6G4/uklWuMhMnvaWGdJAG98n31hx1e0Se0lHOxfM1Go2yT/
         y7dg==
X-Gm-Message-State: AC+VfDx6qjpkYFEDNsmmX0k0Wc1ddqMraXvKyxkE+UVL5sS9Mtq4+Ei/
        gV6OfSe3yXZhgnUI/zpqLg==
X-Google-Smtp-Source: ACHHUZ52Cxir7VJt6AIP+N64lio1+ph206iUWkcaMQgfylkK4ArSxPjxdBB+C1xvzowTLCXV4c/Wkg==
X-Received: by 2002:a5e:db0d:0:b0:77a:d862:242f with SMTP id q13-20020a5edb0d000000b0077ad862242fmr10727914iop.21.1686669496452;
        Tue, 13 Jun 2023 08:18:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x12-20020a02970c000000b0041f5a0b7f9bsm3524235jai.108.2023.06.13.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:18:15 -0700 (PDT)
Received: (nullmailer pid 2136982 invoked by uid 1000);
        Tue, 13 Jun 2023 15:18:14 -0000
Date:   Tue, 13 Jun 2023 09:18:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.4, part 3
Message-ID: <20230613151814.GA2133279-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few DT fixes for 6.4.

Rob

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.4-3

for you to fetch changes up to c7753ed71c160f75f92ff5679e9fc22526e56fc5:

  dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for "qcom,paired" (2023-06-13 07:58:47 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.4, part 3:

- Fix missing of_node_put() in init_overlay_changeset()

- Fix schema for qcom,pmic-mpp "qcom,paired" property

- Fix 'additionalProperties' in silvaco,i3c-master binding

- usage-model.rst: Use documented "arm,primecell" compatible string

- Update Damien Le Moal's email address

- Fixes in Realtek Bluetooth binding

----------------------------------------------------------------
Baruch Siach (2):
      docs: dt: fix documented Primecell compatible string
      docs: zh_CN/devicetree: sync usage-model fix

Chris Morgan (1):
      dt-bindings: net: realtek-bluetooth: Fix RTL8821CS binding

Damien Le Moal (1):
      dt-bindings: Change Damien Le Moal's contact email

Diederik de Haas (1):
      dt-bindings: net: realtek-bluetooth: Fix double RTL8723CS in desc

Krzysztof Kozlowski (1):
      dt-bindings: i3c: silvaco,i3c-master: fix missing schema restriction

Kunihiko Hayashi (1):
      of: overlay: Fix missing of_node_put() in error case of init_overlay_changeset()

Rob Herring (1):
      dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for "qcom,paired"

 Documentation/devicetree/bindings/ata/ahci-common.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml     | 2 +-
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml    | 2 +-
 Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml    | 2 +-
 Documentation/devicetree/bindings/net/realtek-bluetooth.yaml     | 4 ++--
 Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml     | 5 +++--
 Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml     | 2 +-
 Documentation/devicetree/bindings/riscv/canaan.yaml              | 2 +-
 Documentation/devicetree/usage-model.rst                         | 2 +-
 Documentation/translations/zh_CN/devicetree/usage-model.rst      | 2 +-
 drivers/of/overlay.c                                             | 1 +
 12 files changed, 15 insertions(+), 13 deletions(-)
