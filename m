Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53068E348
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBGWLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:11:36 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F091718;
        Tue,  7 Feb 2023 14:11:35 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-15ff0a1f735so20884918fac.5;
        Tue, 07 Feb 2023 14:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2MDYsye2yNDz6FxqXxXb7N38QKmGQYMdarZ9rG6ins=;
        b=NdpBc1D8WsrrkZPV68ouZTC+VoFD7LwWpA8bqGcK0Uk9UEdSdMaT8sD+3XefJ9yMxJ
         i+wV4ipVf5PIZRiBq/6rRvPvHA9uMKxvuJXmsBH/9NaXVN7kzVBeZXh9SqZ7m3bxvREJ
         oVgtf06qmJAZtuYxiY9xRGBDegDj2+LfMfLEIqt+x04CJzPwivrA2JqFIfzp1/sc9eIl
         HvXeXcqQgyr/RDpfelfX/Wufyq+ZiNoTF5HpyOyX47B6+/9MeCnLmDBsrLN3OVWe2MQU
         otO6By6l4xws+lEH1gqE7UMpagWX03zAe88ZNZkqDc9RNB6XtOceAV4w+J+mZJFT3Lfg
         OrwA==
X-Gm-Message-State: AO0yUKUSMqz2drJ6WopIiqoU7ngoOOHR/v74va9rm2f3s5jD+52xOzYu
        QKfZWgj4yc1Mg/ZGa0l4e/Cn77xrtg==
X-Google-Smtp-Source: AK7set8zYS/CHSiKtHRpSC+Q8knsQO9+7+F4nJEb6RQt4qIcuEi+IIZN3IkwwEVxqzbFmP53OQ6/vg==
X-Received: by 2002:a05:6870:b612:b0:150:3588:3359 with SMTP id cm18-20020a056870b61200b0015035883359mr2315703oab.2.1675807894315;
        Tue, 07 Feb 2023 14:11:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a5-20020a05687073c500b001639b1f2f96sm5981691oan.50.2023.02.07.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 14:11:33 -0800 (PST)
Received: (nullmailer pid 55077 invoked by uid 1000);
        Tue, 07 Feb 2023 22:11:33 -0000
Date:   Tue, 7 Feb 2023 16:11:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.2, take 2
Message-ID: <20230207221133.GA50340-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple more DT fixes for 6.2.

Rob


The following changes since commit 064e32dc5b03114d0767893fecdaf7b5dfd8c286:

  of: fdt: Honor CONFIG_CMDLINE* even without /chosen node, take 2 (2023-01-04 21:31:59 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-2

for you to fetch changes up to 707344c8a188bb1d6704d3546229fc7a07c01a63:

  dt-bindings: interrupt-controller: arm,gic-v3: Fix typo in description of msi-controller property (2023-02-02 17:10:58 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.2, part 2:

- Fix handling of multiple OF framebuffer devices

- Fix booting on Socionext Synquacer with bad 'dma-ranges' entries

- Add DT binding .yamllint to .gitignore

----------------------------------------------------------------
Andy Shevchenko (1):
      dt-bindings: Fix .gitignore

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: arm,gic-v3: Fix typo in description of msi-controller property

Mark Brown (1):
      of/address: Return an error when no valid dma-ranges are found

Michal Suchanek (1):
      of: Make OF framebuffer device names unique

 Documentation/devicetree/bindings/.gitignore        |  5 +++++
 .../bindings/interrupt-controller/arm,gic-v3.yaml   |  2 +-
 drivers/of/address.c                                | 21 +++++++++++++++------
 drivers/of/platform.c                               | 12 ++++++++++--
 4 files changed, 31 insertions(+), 9 deletions(-)
