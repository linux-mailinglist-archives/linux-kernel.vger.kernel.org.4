Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0B74C09D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 05:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjGIDjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 23:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIDjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 23:39:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7415E48
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 20:39:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57722942374so41816687b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 20:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20221208.gappssmtp.com; s=20221208; t=1688873977; x=1691465977;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1fU2t9XQczKV/Hvo75uiH0sKLlUKJdf3lezyiHAZB0=;
        b=mP4ws4u7XtIlxU1j3KgNIVYaebpYSC5mz6tHBRkFF1FCSkQNlD5Qo++0Ofbezmw79V
         QgTrO/d7WhnFAXJS1UalPJQCYX+pANQG+lKThTqAbXno30y0gbqSgGOHIWG3AYfvLSc/
         awsP+XxNGHyF/qlYsbrz+wPCG4YBgjuz9Qp+7hcZXcD0rGgmBan8QLD/ieRw1M0COkIB
         ZBwSIB9xGs8HzaZ3Neg46ihZhfTcypB8pZY4HS8WzkzDO0bgyDehgxYPlYeAhFWpYUqq
         zZClhHW5Ve9pZOjzKxomrAul0Shd/odRhPeCAZp8cZfUIW+Z84Uk3g5WIFFOM07pb3Ts
         q2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688873977; x=1691465977;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1fU2t9XQczKV/Hvo75uiH0sKLlUKJdf3lezyiHAZB0=;
        b=BHSM8pkoawb65Jz/i+2QBS6orXPxzo9aB+iwA71XIRhKAJCwBTShWDWYKd4mzC7o/u
         WaMLi7k93yIpiD8GnIPz4qiG6zPF4YymKsQBUer32VlSq0Btof3zqK4KUJrUwHSznAmg
         IJJ/qqghnM1CMyuNuWNBAsMMo6YPpKQ4x5Kvl9O2bK6ng8Ze7frO3S2xY7jVrMPWcxIi
         HqhN8Xf10GL/BnnurKxeHwJyv40FmNLLQuXaAzUvYai4Kmza2ERjTatjbxU8YSSkRgxW
         6KLgGjQqo50FstQjzxB6qOj/erq9/vuBTsF27kNd32WHnjp7w0Mb6Xk+lXCwfmuEQgzI
         XYCA==
X-Gm-Message-State: ABy/qLbJlQ3V4xpCLBTN6u7123Yr0hH78oLNlakqYylA412QlPfKI8oV
        Py68jFxv5TO2Qa6k009pkjiHuw==
X-Google-Smtp-Source: APBJJlE0Al+OcmU4Bk/ZtvYH0kdhTFvOEuqR4jF4SK6TdZ3rZ+4J4p8v+BNiS919/PaiCM6nVwrlmg==
X-Received: by 2002:a0d:eb55:0:b0:56d:330d:86e2 with SMTP id u82-20020a0deb55000000b0056d330d86e2mr9445713ywe.28.1688873977132;
        Sat, 08 Jul 2023 20:39:37 -0700 (PDT)
Received: from localhost ([2605:a601:a600:7900:8ac9:b3ff:febf:a2f8])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a13ea00b0076706e76e75sm3350092qkl.79.2023.07.08.20.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 20:39:36 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Sat, 8 Jul 2023 23:39:36 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for 6.5
Message-ID: <ZKor+IDTZ8OR/Xu9@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes for 6.5.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.5

for you to fetch changes up to bff6efc54bd0e27a332eb733525d7f698fd4a5b7:

  ntb: hw: amd: Fix debugfs_create_dir error checking (2023-07-08 13:55:44 -0400)

----------------------------------------------------------------
Fixes for pci_clean_master, error handling in driver inits, and various
other issues/bugs.

----------------------------------------------------------------
Anup Sharma (1):
      ntb: hw: amd: Fix debugfs_create_dir error checking

Bjorn Helgaas (1):
      ntb: idt: drop redundant pci_enable_pcie_error_reporting()

Cai Huoqing (3):
      ntb_hw_amd: Remove redundant pci_clear_master
      ntb: epf: Remove redundant pci_clear_master
      ntb: intel: Remove redundant pci_clear_master

Geoff Levand (2):
      ntb_netdev: Fix module_init problem
      ntb.rst: Fix copy and paste error

Jiasheng Jiang (1):
      NTB: ntb_tool: Add check for devm_kcalloc

Palmer Dabbelt (1):
      MAINTAINERS: git://github -> https://github.com for jonmason

Yang Yingliang (1):
      NTB: ntb_transport: fix possible memory leak while device_register() fails

Yuan Can (3):
      ntb: idt: Fix error handling in idt_pci_driver_init()
      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

ruanjinjie (1):
      NTB: EPF: fix possible memory leak in pci_vntb_probe()

 Documentation/driver-api/ntb.rst              |  4 ++--
 MAINTAINERS                                   |  2 +-
 drivers/net/ntb_netdev.c                      |  2 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c               | 11 +++++++----
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 12 ++++--------
 drivers/ntb/hw/idt/ntb_hw_idt.c               | 24 +++++++++++-------------
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |  9 ++++++---
 drivers/ntb/ntb_transport.c                   |  2 +-
 drivers/ntb/test/ntb_tool.c                   |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  1 +
 10 files changed, 36 insertions(+), 33 deletions(-)
