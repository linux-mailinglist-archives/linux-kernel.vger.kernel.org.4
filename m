Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519CF673129
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjASF0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjASF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:26:47 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D1A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:26:45 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d16so789175qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsB+ZAHP0UyJS+bDbLK2xtr95teDUp0qaZq/1qRa2dk=;
        b=k8nvF0Wqyi+Gza6qaaqQmNjZC11DVCO+D8huJe7wIcHQip3kHeQTBh+/rpIJclS+qP
         Pgkmgk4HEnAqqpD3GFG22fLpbxPWgT0+RPImCXM0XhRZNONSo8A7HplGRAJ7KePm0X3t
         h7xcxYv+e1H5SWFcO7rH+/qEcpj59m8eGAIvjjapYOExptWEKvlF0C9E2DGRWBRhCVY8
         zn77yhBdxCYTFYnQFuMYyZX8ZPEAwniL4nn1BXLh3jndqDy2tHe2VPWXPiqubZGKvK7o
         VWkuf/mBaV1sG5gySWDnAONo/3j1qqJDAPP+rYdh3FII5av2ESMQ8Mg2Q6HAL/kkSri0
         86tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsB+ZAHP0UyJS+bDbLK2xtr95teDUp0qaZq/1qRa2dk=;
        b=GGfN/mYYolURD0yRDuQvof54dHhM8+wTrU5ht1a8qGWxVfPQLf0aLZz5iRrXX3q5GO
         jMS9V0Siuygl9Lugf0E8SC7tU4rpKZWzvdENhlvIWajbJra3avOqPwGeMq6lnCZJFpEI
         LbGVxsAjuT1w58MAcIdXt6kqGhz907zqEKQf/mDltmqE7laZ0GcId3cEkk0c1gXSzSVB
         EwlLMVpTwDUhiiQSijplTWOCT2B8jgHLrcwRMBHPcRd7bsMuhSwHsUTuKTvJ6e3h+ldP
         ivZ/F1V8hK/VbGFl1i4dXpMSm0PX361AlqiuVBJyDAF3/PJAzosQhqfZpxOxnl+HT2t8
         8iuQ==
X-Gm-Message-State: AFqh2krIu+I7khpBo46zWb2A7FOV81WRgdKjvnagr9n2XBp2989M2HxT
        iDhEQZHje5yS3exnUmBNw04=
X-Google-Smtp-Source: AMrXdXt4YenaJqPXzMy5Lk1pmM9H273b2GNx/2gZB5XvTELWHefqkI7+CsRcyyl0aI8AOb/bDNd+AA==
X-Received: by 2002:ac8:13c5:0:b0:3b6:3044:4cbf with SMTP id i5-20020ac813c5000000b003b630444cbfmr13849110qtj.23.1674106004284;
        Wed, 18 Jan 2023 21:26:44 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id v21-20020ac87295000000b003a5430ee366sm507330qto.60.2023.01.18.21.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:26:43 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v1 0/2] Add RISC-V 32 NOMMU support
Date:   Thu, 19 Jan 2023 00:26:40 -0500
Message-Id: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set aims to add NOMMU support to RV32.
Many people want to build simple emulators or HDL
models of RISC-V this patch makes it posible to
run linux on them.

Yimin Gu is the original author of this set.
Submitted here:
https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html

Though Jesse T rewrote the Dconf.

The new set:
https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html


Jesse Taube (1):
  riscv: configs: Add nommu decfconfig for RV32

Yimin Gu (1):
  riscv: Kconfig: Allow RV32 to build with no MMU

 arch/riscv/Kconfig                           |  5 ++---
 arch/riscv/configs/rv32_nommu_virt_defconfig | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/configs/rv32_nommu_virt_defconfig

-- 
2.39.0
