Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785CC661014
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjAGPrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAGPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:47:46 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838754566D;
        Sat,  7 Jan 2023 07:47:45 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id b192so2183463iof.8;
        Sat, 07 Jan 2023 07:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS/wt6L6+sKVeJ33pXNLZG1jeiP8l4ukfmvRNEs3c0g=;
        b=bNjCf2ZH2LjtawahBGyCv44Yh/i0cOBTB52Sacy3ziVaBnVOBop8D0rhtwCtBQgRVS
         pBJjJnuPI9slPiNuMtoiZM5+dvnIx3p/zZ5Z1HhwK+pwcbSx69ErGi8rgcQeTSprhGKN
         kYzSMRhlAlidH1b+CEzPa6cTHY1D6HyuTDpJ9QPriulz/uBM3hybhqppNNG2j2UMh79f
         XbuKzWQLuORkA+Kqwwl+WTQc3Wju5UJ1Ei9fLnKBKSIq8nn+aaLp7I5jecdeCG0/syyd
         mOC4QIs2JeaaNX8FvvysYkjyf1IEh1rnOIfXOeAJ8NzsJ5j4TkqAkqBZ0MZ4Bn0Kp55f
         K9Pg==
X-Gm-Message-State: AFqh2krLcDqY/V1/XJNaXmvasGbT9zORd6q9RvQSjk90ewWWcNNHa/4V
        E4gl8Z2MhOPzulMW5KbfXQ==
X-Google-Smtp-Source: AMrXdXuhZDB+ld/4pVGjtoYQIVUQThELwYVKcc1CaM+BK9yhG/rlva7N5QnOxwaAV1afyBZCebZgeg==
X-Received: by 2002:a5d:8c8d:0:b0:6df:e3ad:1e1c with SMTP id g13-20020a5d8c8d000000b006dfe3ad1e1cmr35524381ion.12.1673106464762;
        Sat, 07 Jan 2023 07:47:44 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q20-20020a0566022f1400b006ff6e8b3b8csm1409220iow.41.2023.01.07.07.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 07:47:44 -0800 (PST)
Received: (nullmailer pid 1839148 invoked by uid 1000);
        Sat, 07 Jan 2023 15:47:42 -0000
Date:   Sat, 7 Jan 2023 09:47:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.2, take 1
Message-ID: <20230107154742.GA1832142-robh@kernel.org>
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

Please pull a couple of DT fixes for 6.2.

Rob


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-1

for you to fetch changes up to 064e32dc5b03114d0767893fecdaf7b5dfd8c286:

  of: fdt: Honor CONFIG_CMDLINE* even without /chosen node, take 2 (2023-01-04 21:31:59 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.2:

- Fix DT memory scanning for some MIPS boards when memory is not
  specified in DT

- Redo CONFIG_CMDLINE* handling for missing /chosen node. The first
  attempt broke PS3 (and possibly other PPC platforms).

- Fix constraints in QCom Soundwire schema

----------------------------------------------------------------
Andreas Rammhold (1):
      of/fdt: run soc memory setup when early_init_dt_scan_memory fails

Krzysztof Kozlowski (1):
      dt-bindings: soundwire: qcom,soundwire: correct sizes related to number of ports

Rob Herring (2):
      Revert "of: fdt: Honor CONFIG_CMDLINE* even without /chosen node"
      of: fdt: Honor CONFIG_CMDLINE* even without /chosen node, take 2

 .../bindings/soundwire/qcom,soundwire.yaml         | 10 ++--
 arch/mips/ralink/of.c                              |  2 +-
 drivers/of/fdt.c                                   | 60 ++++++++++++----------
 3 files changed, 38 insertions(+), 34 deletions(-)
