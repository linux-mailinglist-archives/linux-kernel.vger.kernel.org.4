Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193A06C7CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCXKhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:37:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DF922DD8;
        Fri, 24 Mar 2023 03:37:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so5977578edb.10;
        Fri, 24 Mar 2023 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679654220;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJuO8B0DxhrYpZaK8J9dfLUU2TS1IlGV+FseHR+oA+A=;
        b=OwU3k8S0NtXx+KntpzccsesziTlWKynQGojMY+6Z66r+zDSXcFv6Bl7PL+rwKUeVFd
         8vTaFMQnrWg0tjCYpeGLDpvYB7jT6L3DEwXnkX86E/ieGa/cMGFcQ4DzS5/pSWemIr4w
         DY6VvbbOL4xpzzg2VxcxKvkTfGaiBjcJewt9RggiKlaMhUBzfBqzQbfuHM2GZKSaAIgg
         YK26tNTV3Q0XTpUtJnE/eJILEfM+oh/+RC8MRbE1u3HIOls0picNOEK0M6cCWsE4MauR
         BdjjM10u1oK1zlqFMNDuRmZRBNN3NTfKj5/hYHs2cKkj7XDK6geteVx2tyT84dAEfgPv
         as9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679654220;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJuO8B0DxhrYpZaK8J9dfLUU2TS1IlGV+FseHR+oA+A=;
        b=ycAphv2u/0DepgSN+OgiZjH0SdiusoB1wnnDFetRUvpnMWQcx8PdYibWOnpgo74Jz1
         H7n3+N4aj6qyBI4WDljQih4kB9Drz+2nnwpNHP5e9qO+9Dza2gFPD45FVK1AOVbUjBB0
         2frn3xB45EJjHEVDpTuDz2hynVglx2V7ptgkdtExYqAEE1FfcIPiJSqLvICH0VC6dVgX
         LfpVV3Dcwr5OCx9FAEEGCB9ZN+Wy+FKneVJBpzgUmlvkUpfIEJEypBoaOMX/Z3cV+dYi
         x/LIYyzMvDyVBDcsAhVCRkbkVcHObI6QKcpma7nK2Ur5IT+kEZtDkX/b4yvfMRymolwK
         xN7Q==
X-Gm-Message-State: AAQBX9fEOsb4neaSHjHQVPub1lyZk/ueL2LJd5wXAswoGj/a/psmMJ4U
        Dtqs8HhdgYteCR7jDzK9t+c=
X-Google-Smtp-Source: AKy350a4WTRRlmlRHILMgnhOO7wrd4M/GHmUQbTlujDN09uAZN8/fvTZc3iv2Il82DJBIxT9RrE5RA==
X-Received: by 2002:a17:906:5849:b0:931:4b0b:73e3 with SMTP id h9-20020a170906584900b009314b0b73e3mr2250971ejs.65.1679654219663;
        Fri, 24 Mar 2023 03:36:59 -0700 (PDT)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906250600b009306be6bed7sm9987951ejb.190.2023.03.24.03.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:36:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] sparc: remove obsolete config ARCH_ATU
Date:   Fri, 24 Mar 2023 11:34:38 +0100
Message-Id: <20230324103438.28563-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before consolidation of commit 4965a68780c5 ("arch: define the
ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig"), the config ARCH_ATU
was used to control the state of the config ARCH_DMA_ADDR_T_64BIT. After
this consolidation, the config ARCH_ATU has been without use and effect.

Remove this obsolete config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/sparc/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 84437a4c6545..7749392c9c7f 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -109,10 +109,6 @@ config ARCH_PROC_KCORE_TEXT
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config ARCH_ATU
-	bool
-	default y if SPARC64
-
 config STACKTRACE_SUPPORT
 	bool
 	default y if SPARC64
-- 
2.17.1

