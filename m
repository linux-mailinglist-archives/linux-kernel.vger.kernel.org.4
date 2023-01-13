Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00FE668B00
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjAMEtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjAMEtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:49:17 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7448282
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:15 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id t7so14162763qvv.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGX3VGymQGp8GLR/8ell86Z6rupR3s1Pq8aI6kKwcEE=;
        b=uF3qGo1TN8n3B6fNlpBQMxkO9ioZdY68UVSs4+j877qiAZxgtnB70ARzy7dGpI+oCU
         ijDatCGMwHrL/cjxYRwdhH6xZPdy80v2jzTFWxcFJe8cpWMDgM6GRwrpNl/1jvLn2jWF
         /I/SSsO6yvxA3iftmgituaoFiU28YHNsUa/ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGX3VGymQGp8GLR/8ell86Z6rupR3s1Pq8aI6kKwcEE=;
        b=pPcMZySgSYW9t6JrCeeAeyO8gMrSNa4VNzAMgTGFMi1S6Zg/A1Cu00ohmGtOvcWtel
         ra1LUHNhRtG9k2S1qtwX2l4nhw7tCMZP9f0neyj+5MIaLVDTiBNTeTSOiWWzTHbfBPzL
         ilZXVFwrL7a14omKij/KUZ47fjRTcQl9jvNDYqhS4+N5aDGi0u8rNnJh3J/Cp7WEQ6v+
         vQdoEtw3VG1rZmMTR7EBH/uDPV6IUXd71+22babFbFCgD28VPCAyprrHLm91hRel5phD
         L706xUfPiH2k1Mlp81JZO5EbaH6ivgDJBSlCl/CAut765hON3Jo11a4AVscWJX0P6cFE
         Pq7g==
X-Gm-Message-State: AFqh2kpNtT//DgkhQptwP7SwDEwZjJHTy4KpOK7oVBk3eLufNbl3c9mH
        ziA/6FA7gPAvn85pfl54msvtLY/RA7IHpzmmqHM=
X-Google-Smtp-Source: AMrXdXsu3oBNYKR2YZHqs31dWkamf6/T9JzfFf4OZZjRB0LIKRdSLgYuAO24BqnHnm+JSVh/NtxbUw==
X-Received: by 2002:a0c:c586:0:b0:532:236d:3340 with SMTP id a6-20020a0cc586000000b00532236d3340mr33594903qvj.51.1673585354708;
        Thu, 12 Jan 2023 20:49:14 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:14 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 0/4] um: Various build fixes for allyesconfig
Date:   Thu, 12 Jan 2023 23:49:07 -0500
Message-Id: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPiwGMC/x2MQQqAIBBFrxKzTlCDFl0lWmhNOQstZioC6e5pf
 /f4j5dBkAkFhiYD401Ceypg2gbm4NKGipbCYLXttDFWXVF1q+698XUaiuidoPLs0hyqGp2cyPU4
 GFd6/vo4ve8HRX1ux20AAAA=
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1042;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=Pj+bhJnt9Vzw44uU8oe3PGVTrfvQfgKSmUU7jQWh2Ko=;
 b=t26ey9F18MEelti8Q2CNfi4eauyJ6tavJeEqsXXNQwwbkNKoBktxXTaXD73uyFNvmuTQVg4iFjez
 ysAQ54D6AkRDZJSsJcQxL7FANZ9UPfB1bHGpr4ZieQP2d7YiAeya
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some build failures I ran across when trying to build an allyesconfig
kernel for ARCH=um.

To: Richard Weinberger <richard@nod.at>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Foley <pefoley2@pefoley.com>

---
Peter Foley (4):
      um: Make the definition of cpu_data more compatible
      um: Avoid pcap multiple definition errors
      um: Prevent building modules incompatible with MODVERSIONS
      um: Use CFLAGS_vmlinux

 arch/um/Makefile                        | 3 +--
 arch/um/drivers/Kconfig                 | 2 ++
 arch/um/drivers/pcap_kern.c             | 4 ++--
 arch/um/include/asm/processor-generic.h | 2 +-
 arch/um/kernel/um_arch.c                | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)
---
base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
change-id: 20230112-um-3f06b1bbbbb0

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
