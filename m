Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCEB6BC58E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 06:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCPFUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 01:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:19:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925DA8810
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:19:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k2so546847pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678943997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAnoNAg/wEFIyazuIz3SvYiQvbZa3Cm+e5t9iiTafMM=;
        b=ogfWJ1M10cinsLgiOAHKG+R/e+AeY7RLAjxzO5+PTzaZzHnE+duwairY1Zbn2F5c2f
         1iRx3C90ofLuUhJy6e7SLhwesqZn9u29O1m8vus+X8ud4mW605FucHslMCSNT0jh1ByS
         jHrlR/lFjWTBvs9NkjE53WyuNN1sSl2rqamLpNNB1Kv/nkpAcMzOmK3bRcoRgQ7ZyoK5
         15SDbruJxM2MnUTAin4deSVBs9mJpHq9trBSCcDN0SAFUl5QlE2BKIayRzJyimuAkyD0
         s9LCY3bSd5jqRWkk+IkEx/gfDZv58P1UGYlTceiXThtTe8ZV4ERXr5YEFlh4HghHM3SQ
         cIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678943997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAnoNAg/wEFIyazuIz3SvYiQvbZa3Cm+e5t9iiTafMM=;
        b=gr22/yoEsbF/lg23h4XIvsG0F12YFDMPtdJbzoKDsNVQkyVm9o3X2i1YNV96L40uDb
         eoM2H3ySU6c4TaOD0OrIFRdH+1tJNeaQU8F/jTpCw748QbFc1GOCHeiQQMWQwNLvIL0O
         ASVYFKQYjC1Zlrgc9J3BcBcHN17VAlpWrYVYwPGVgDzyslRdwv/C+Gw2NZSSwpVF6APo
         QkEZLT53LoLpU3DMCeFD76LNhfEwzVNFiRY0z/puP0WKrZd3miObp8OhbHUiYK1bFoM5
         ErVuEQIAVWd0f4B2TMXmgLMJ4hUPLVL7CHjEILP9ZlXE4DGlfWMnbH0Rc0ReL/554GeQ
         vC/Q==
X-Gm-Message-State: AO0yUKXBJsjLEZbE3J++iVBI6ojMFpW1sEuEy7LcdG2wuMLL/3dqgWs2
        +ysYCPfDUEk9lFNoHnbUuII=
X-Google-Smtp-Source: AK7set8c84uHAkq4MtaFVRHC3YXK22SqDEUPVWFCrcEGkReUCFOEGDytzQLUpjDl0h1WyuxwlB4GEw==
X-Received: by 2002:a17:903:234a:b0:1a0:51d4:f055 with SMTP id c10-20020a170903234a00b001a051d4f055mr2499980plh.49.1678943997153;
        Wed, 15 Mar 2023 22:19:57 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b0019a593e45f1sm4475708plb.261.2023.03.15.22.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:19:56 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM: hisi: Support Hi3798 SoC
Date:   Thu, 16 Mar 2023 13:19:32 +0800
Message-Id: <20230316051936.1775033-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables booting Hi3798 SoCs.

David Yang (3):
  ARM: hisi: Add S40 IO map
  ARM: hisi: Add S5 IO map
  ARM: hisi: Support Hi3798 SoC

 arch/arm/mach-hisi/Makefile    |   2 +-
 arch/arm/mach-hisi/core.h      |   6 ++
 arch/arm/mach-hisi/headsmp.S   |  36 ++++++++++
 arch/arm/mach-hisi/hisilicon.c |  70 ++++++++++++++++++
 arch/arm/mach-hisi/hotplug.c   | 120 +++++++++++++++++++++++++++++--
 arch/arm/mach-hisi/platsmp.c   | 128 +++++++++++++++++++++++++++++++++
 6 files changed, 357 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-hisi/headsmp.S

-- 
2.39.2

