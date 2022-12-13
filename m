Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D964B8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiLMPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiLMPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:54:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5015FE2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:54:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3986959pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsDgzCn4vFN9tL0dKRf7uNZgAhW5v4Fahn2kObGUrG8=;
        b=HQYZ9NCh9sO/zqqOv20hG4wsdZ369ovMjM5wTGEubJhHAY58277JBwCKVMQ9zMu1RM
         0UwOH28f2UD4F1Sv6/NekOjSOZGYaX00Dfz8vCLftwQmNIb//5K5nlnC6CMgot/hQt4h
         HN45WKXKX8bOziOLPEG3KoQyD4kFswaDppr9BMK3lu7s5WfDnvDdkZLJFJnQZlnizRyF
         ICFLP0scq7XbVKWrDsAaH63JFCoQ21ENCin0ln0mfiDOyK1sKWboB3HsKfZUtBk6MhGy
         ItHXcW5OVXK9w8kN7YLyzV7vQHhs65l84bGWQA1ko7+Wl+PrZxGZs/k0v13hpNVAkVVN
         3Pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsDgzCn4vFN9tL0dKRf7uNZgAhW5v4Fahn2kObGUrG8=;
        b=d3TvSNkwy/Un7oWclKle8rG88uu26Sddl/0XFbNK1TJ1Zhhn4K+6VXjQrn3aUD+S43
         ZKD0ku9WzXRgXeZcuGtPSvWgmUctwZ4BGDMcceZONtQrSdrHc/9x0Qn0b2ME4orfCdQY
         lIQUwH64gfibINSEsd8I/6+8PJJEdco0Fo3hItWRlRdxHNWTFeLzbVz+LdjH4lpKYARt
         Jn6Ic3PO0GmL5edfr728axzbT7TFqdAW39isU3zojqXbfNavEBS9lRUQQOiZU3fafW3m
         8/vbHbc+2uQ4h8W4t8oqsQrBmqtHH27TrOXUsdFZJ9GezcAx/vAhI+7/R5zfMm4Qfh1K
         9Phg==
X-Gm-Message-State: ANoB5pnBSgEHMIizYu+FFWkC/6QwN1m4Vf8wXaaL/Ni/f+FR4MWKFI9H
        n7+YBgIUCsBKlp67ricQS8Q=
X-Google-Smtp-Source: AA0mqf7VL4ThFxUTSSVk81W36ngj6jrTcJ5TY+w9hmAoz+fnBAQ1SkjrxDqjNfQCF9qW/Dgp1tZAVg==
X-Received: by 2002:a17:90a:77cc:b0:218:b349:6b97 with SMTP id e12-20020a17090a77cc00b00218b3496b97mr20940616pjs.10.1670946893402;
        Tue, 13 Dec 2022 07:54:53 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:e38e:22b3:f0bc:5])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a1b0800b0021937b2118bsm7329992pjq.54.2022.12.13.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:54:53 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL] xtensa updates for v6.2
Date:   Tue, 13 Dec 2022 07:54:43 -0800
Message-Id: <20221213155443.3704527-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following updates for the xtensa architecture.

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20221213

for you to fetch changes up to 8939c58d68f97ce530f02d46c9f2b56c3ec88399:

  xtensa: add __umulsidi3 helper (2022-12-06 16:21:26 -0800)

----------------------------------------------------------------
Xtensa updates for v6.2

- fix kernel build with gcc-13
- various minor fixes

----------------------------------------------------------------
Lukas Bulwahn (1):
      xtensa: update config files

Max Filippov (2):
      MAINTAINERS: update the 'T:' entry for xtensa
      xtensa: add __umulsidi3 helper

 MAINTAINERS                                 |   2 +-
 arch/xtensa/configs/audio_kc705_defconfig   |   1 -
 arch/xtensa/configs/cadence_csp_defconfig   |   4 -
 arch/xtensa/configs/generic_kc705_defconfig |   1 -
 arch/xtensa/configs/nommu_kc705_defconfig   |   1 -
 arch/xtensa/configs/smp_lx200_defconfig     |   1 -
 arch/xtensa/configs/xip_kc705_defconfig     |   1 -
 arch/xtensa/kernel/xtensa_ksyms.c           |   2 +
 arch/xtensa/lib/Makefile                    |   2 +-
 arch/xtensa/lib/umulsidi3.S                 | 230 ++++++++++++++++++++++++++++
 10 files changed, 234 insertions(+), 11 deletions(-)
 create mode 100644 arch/xtensa/lib/umulsidi3.S

-- 
Thanks.
-- Max
