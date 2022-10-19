Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1012C604704
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiJSN1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiJSN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:26:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56212D836
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:12:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l1so17176938pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=KVQYSnSwQFUiWWTDWziioJ8nATp3sFAA9sevKxCqCpQA/HkYqlZHsnoYXNx+Yg89JW
         ADG9MTT0eSgkBbdG4uNIHC0BxS6IlVAb0qXbDZVALJfkPpzjOxQ9HZImQWkLXn0lCImH
         B8I/RGkuYTGQ4oHXovOjUyfU12eWG8ApR2HNPlOZM+afMaQZxDgYdv2/eNG8XP0kg1WU
         MlmG+k+QdUIjiFsM8FlM0txbeRzB/ckeVWjS+nO3RKWD5gEtsLHS0uEnD+NYcTru45o/
         48Hwnn0X1r81gKz0TrPhcqp44nRpbh2ehIg6SW3Loxto5vQvZDkyKsNqMD+b3ZxODu76
         9l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TnLW0RVC/l/l6ZpSJGiQ9RS55Sh7Bww2u/zF6eZ2bY=;
        b=0xs6wLbBYCRQ33hOCfsEf6gEcTARCveOdehfZ6Kb5DKVvo9BYxx+YLmlQ5djh3ZHfe
         I1iGc3FkfhcoII0aox6rWTGkZ57sGeBZi0SaHOUDngbOPCQNT3deyF1mZ2dKnyZTemsT
         eBnKVa9iQb8RqoLnrHCrmlMkBu3OVAvjaaVso9A9k4ogP44sIEEOc+iecsT8lyf+ETV0
         Dh7OGGUE3U4/JXvGc/GGN5I3yhnxHXaDbuAAOtVzLoTdPuqfeI3zcvBE28b8McDL9OhQ
         xy29TTxodaoiafiQb/w1JyE3Sp7tAXlszkYFD2QgkanzU9rdnpVLzCNox/yRyZNevlxc
         w6ag==
X-Gm-Message-State: ACrzQf3KtbgpSQBnK1XwLzJlN3tWaX2D3llTobHX6iMxwAamtVdInM8o
        xXUR1AeToFE5IS0tl6w4LQ/5Pw==
X-Google-Smtp-Source: AMsMyM4jEiN+8su71k6+cb/emSNBAIxNnD4Cx9I5sby2nXpdtW41N7UtPPhg792GaGcgy9DpernSOw==
X-Received: by 2002:a17:903:41c3:b0:17f:8def:dc92 with SMTP id u3-20020a17090341c300b0017f8defdc92mr8326965ple.7.1666185112189;
        Wed, 19 Oct 2022 06:11:52 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b00172897952a0sm10934478plc.283.2022.10.19.06.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:11:51 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 4/4] RISC-V: Enable PMEM drivers
Date:   Wed, 19 Oct 2022 18:41:28 +0530
Message-Id: <20221019131128.237026-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019131128.237026-1-apatel@ventanamicro.com>
References: <20221019131128.237026-1-apatel@ventanamicro.com>
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

We now have PMEM arch support available in RISC-V kernel so let us
enable relevant drivers in defconfig.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 05fd5fcf24f9..462da9f7410d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -159,6 +159,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
+CONFIG_LIBNVDIMM=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.34.1

