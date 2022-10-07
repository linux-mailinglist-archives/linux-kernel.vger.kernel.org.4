Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77255F74CA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJGHnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJGHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:43:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E8DED00
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:43:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x59so5879091ede.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKTOQNYJli/3LEv9FDmwHDyPgvCgDEVBm94qwQc0UQc=;
        b=GaAyljYL/nJjZF3F1Hi8+RvIBgD2CmbyaVhVhHbfeGUSgG7QH3Ba3d87rvd18Vc7Nd
         UVAg3U/dpFEVbv5GMynCaTDGRDNz0QygpKHy5NqXzPLS/xy0Xf4MOltGM8pYbEz+AlSF
         T/tyE7+uIt+Af+Q/X0+mNUJgAKtLOpAybwxVV4Dc3e6lRfu0JP34DYifayn+sQnCVgFQ
         XzmxjKe9qW+mT0z+UcNBcbHxLI7qFq8/GzpRrEYnD9Ivp2ZTa4J59SJ+NsZ6L43M5bP6
         u77BDdq2DO9B1VTmJ1PJTRhgzkWaBkjN9HPHORfWNWUCPtZM7LKQOVx9bJ0fHtSt4vCo
         NeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LKTOQNYJli/3LEv9FDmwHDyPgvCgDEVBm94qwQc0UQc=;
        b=mMG0TfnJKMlMA8/m+ctCqmHeA98efAB26KLhOdroyp4C3XoPM6E7tu3O3H2r+ZoWxj
         YLD684xLrGEjS+ZJeJwlcIuzOW6xSkhs9hkS8dFV0ELOTQs31qWy9YciUAgNfrjBn5xY
         qo3q9pk+ITBcZDl46idopZOVwSTn1GX2KYmImoeKl4XCbIRQo7G6/idZpNpFEdE8CvTh
         0kGM8iAMdoz32rvphxJ/5fCpk/gGImN/KYwoCvZ6951ewAhBpI6eembFjQDF/VI3Ysu2
         ePgCGA6rn3uvfR1sQvrh86nUVHzX8C7IE+5GPMbxzdNoHOP52B85HJ+o1dwdYXBzbxvn
         qECw==
X-Gm-Message-State: ACrzQf02NORERCYQJQrXnZu4vZUKTknDiP8BSEyCAJYPfBWEwySlD6i+
        jQKeWmooNpm4qpZ1jl4gRp2cFYShUqIN8A==
X-Google-Smtp-Source: AMsMyM7LXI/TlzkljviNGVTQzAPf4VBBK6h77Xy/io6Kjvb4Ts515zq90cG03yNkLvdm84ieNS4JKg==
X-Received: by 2002:a05:6402:50d1:b0:45a:fc:86f4 with SMTP id h17-20020a05640250d100b0045a00fc86f4mr3427471edb.344.1665128613359;
        Fri, 07 Oct 2022 00:43:33 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::648? ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090609c900b0077fc47605b4sm746195eje.217.2022.10.07.00.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:43:32 -0700 (PDT)
Message-ID: <8a07f7df-bb5d-6b9d-e4fd-5c227de2a5aa@monstr.eu>
Date:   Fri, 7 Oct 2022 09:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 6.1-rc1
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these 3 patches to your tree. They are adding architecture support 
for error injection which can be done only via local memory (BRAM) with enabling 
path for recovery after reset. These patches targets Triple Modular Redundacy 
(TMR) configuration where 3 Microblazes are running in parallel with monitoring 
logic.
When an error happens (or is injected) system goes to break handler with full 
CPU reset and system recovery back to origin context.
More information can be found here:
https://www.xilinx.com/content/dam/xilinx/support/documents/ip_documentation/tmr/v1_0/pg268-tmr.pdf

Thanks,
Michal

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.1

for you to fetch changes up to adc4cefae9cfafc1c88b789021266d6f09a0ecef:

   microblaze: Add support for error injection (2022-09-26 14:13:29 +0200)

----------------------------------------------------------------
Microblaze patches for 6.1-rc1

- Add architecture support for Microblaze manager for error
   injection via break handler in BRAM.

----------------------------------------------------------------
Appana Durga Kedareswara rao (3):
       microblaze: Add xmb_manager_register function
       microblaze: Add custom break vector handler for mb manager
       microblaze: Add support for error injection

  arch/microblaze/Kconfig                         |  10 +
  arch/microblaze/include/asm/xilinx_mb_manager.h |  29 ++
  arch/microblaze/kernel/asm-offsets.c            |   7 +
  arch/microblaze/kernel/entry.S                  | 302 +++++++++++++++++++-
  4 files changed, 347 insertions(+), 1 deletion(-)
  create mode 100644 arch/microblaze/include/asm/xilinx_mb_manager.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

