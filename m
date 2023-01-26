Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17D467CBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjAZNWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjAZNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:22:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3BE72BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:22:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id be8so1778288plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3dBH8Hr78CyF8oj52GV0tBaWYurLJXDOYePGOGPQjUc=;
        b=NzdIhGZxJZOfNb/s0yYVG4d3LMXc3rsUEnU0tzHlFiVyufwJcIlp4I3Gvzhea32RQu
         4xPwl5B6PxEH+kXGV8F8TxJxehDdqfkhVPjixxOQmJ/5gaxvr77R581PeFUB+x+qgg+S
         ZZEr0ma4Q70WILF2OLBLZFAkj3VWhewlvLaKvGv3RM1SZklu9Unp5VMvJWchPl43wYr1
         QLHVCTn7z+okHQd8FYO85XgEXSDHTzycmwSH7qP28ZWIDt960SHs8GVBSqmAgTHFr5o/
         5Cbh1Dg277n8nqtwRofFOqNqgc/iWaDG0xZE9in8qTfZpJ3kajWyirhx0EZmlOupBD9x
         5aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dBH8Hr78CyF8oj52GV0tBaWYurLJXDOYePGOGPQjUc=;
        b=TDzausNgv0sF18euwnRhCpFwp2LvRTTf7Pnlhk6Ps7SERm8s5F55aurJ2E0Kjvh+WH
         tc1SGWsksdnJbynWMLBdt5FcBHUauRsBv/wmFZSWU/5MR+gQpHNpIq9/oUex/W5ro4Rj
         WhfWosMRUmAXNpokmFImJW0tPD4FqcjuoYYnQyYbHuLwqCQEQ8IlHfjWqwSJ3SF/dSH0
         +tup9xIzPjJ8QK4w6IhRz90l60ReHNHFeRKTtCxTAwD1RwL9nOwBbH3Fs8q1t+oOl/QK
         w8issrpOYGzzIXJ4ZktRL4MPxeWsL3mAy/eTAfaqIgj+guEXb3cSO+RpBQjSqXwINhAh
         6mgA==
X-Gm-Message-State: AFqh2kqDvYxQAyQoazRWxJ9lMioy0apbiSQCUWQSE5A5UY6xHA24Ae6N
        98PR95fthGPQo89KfT9e4di3sQ==
X-Google-Smtp-Source: AMrXdXudyuvddmxmVCp4LXbF5v9Xz8F66WD1JHxx3dn9HDalk6YTXZwZwTa4FJqTMF2lAg1z+ApRIw==
X-Received: by 2002:a05:6a20:8b02:b0:b8:3ec5:e11f with SMTP id l2-20020a056a208b0200b000b83ec5e11fmr36381098pzh.16.1674739351100;
        Thu, 26 Jan 2023 05:22:31 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id l6-20020a656806000000b00478dad38eacsm736047pgt.38.2023.01.26.05.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:22:30 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
Date:   Thu, 26 Jan 2023 22:21:17 +0900
Message-Id: <20230126132120.1661-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series introduces the op-tee based EFI Runtime Variable
Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Masahisa Kojima (2):
  efi: expose efivar generic ops register function
  tee: Add op-tee helper functions for variable access

 drivers/firmware/efi/efi.c           |  12 +
 drivers/tee/optee/Kconfig            |  10 +
 drivers/tee/optee/Makefile           |   1 +
 drivers/tee/optee/mm_communication.h | 249 +++++++++++
 drivers/tee/optee/optee_private.h    |   5 +-
 drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
 drivers/tee/tee_core.c               |  23 ++
 include/linux/efi.h                  |   4 +
 include/linux/tee_drv.h              |  23 ++
 9 files changed, 924 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tee/optee/mm_communication.h
 create mode 100644 drivers/tee/optee/optee_stmm_efi.c

-- 
2.30.2

