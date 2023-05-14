Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA825701C68
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjENJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjENJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:04:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708A1BDD;
        Sun, 14 May 2023 02:04:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6439f186366so7324698b3a.2;
        Sun, 14 May 2023 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684055085; x=1686647085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usTUzbJN3/c9qoBFyD+eiQ3LKf9ePyuHk2BoTbJ/pEs=;
        b=Tw1gGElBkh8bqUaPMfHAAZpRT3Noti9lbtsdwJLRTcytBsUA/i1hG+XMsGkmHnE6NY
         aHyrQhxtHygbXeK/92udiPG55yV8EGkzNaio9qwQplvUx5sEerv5EeH6u1WMhAdb6N/7
         M9P2Vlp5GGdsHBrcjmupaObC0zMFXrMAFACphbX4vQ4STofy+TILK02+2UjFMvrnREmj
         oZ7Yg4pHVIuF5i0TThC/V1EHpb0HqvcLuG6GRJtsj2LflWeJ6PoRT287VJaAgOlCm7Ty
         EFvBddckDp8Cn1pQrKbTbUvZFzRUb5SaRQdnP0uyk2p3U4gLRu3Oi1Ebc2GGBcaxZTw/
         Hqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684055085; x=1686647085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usTUzbJN3/c9qoBFyD+eiQ3LKf9ePyuHk2BoTbJ/pEs=;
        b=llzP2b2bSXgjUICXIjyR8LdnaJuMJKA70y5+HeWqosMt1/V+PCOL4Orbu0mSU653Qw
         CT2KMOdUoCylgNK3Haf+qT8T80YYgloAP0JEcnaRPJ79MUIvU5RMsLm0g2Y4lNXMiPK0
         PtrC4BBweLV0nOBgQyF9WK6GfJPa0MHP98PWXJXCNMl6Qy1qBJlK4+gQICyGx496vmUu
         5ym0Flw+/ZS3aZrdaH0e/Vi6zztsWIRSPZJQc6yo1Y79oitbCp+zNyenUnf9BsJQ5s8h
         f7j7NIfpdEErjdsqE7N1ze7R/MxuEi8RzbTP+glCHXk+QSTD4PL9GZhLaSNsTOB8Eqsi
         nRXA==
X-Gm-Message-State: AC+VfDyIragiTxjxdqZxpseSGsplf+kUsTiQ8qTZUjueGsm+yi+IMwmG
        yojl2zy+4IxygChplJg+xbk=
X-Google-Smtp-Source: ACHHUZ4bUWZYUrifcQ0piB59H0YsIlr7vxuuwgc5h7KVvnAMIt651hXEgbblF0+3MbYFblaVCvxnfA==
X-Received: by 2002:a05:6a20:12ce:b0:104:edde:67b7 with SMTP id v14-20020a056a2012ce00b00104edde67b7mr6862078pzg.27.1684055084819;
        Sun, 14 May 2023 02:04:44 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b00637b0c719c5sm9662227pfp.201.2023.05.14.02.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 02:04:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8522F1061D9; Sun, 14 May 2023 16:04:36 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux RISC-V <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/5] Documentation: riscv: vector: Separate SPDX license identifier and page title
Date:   Sun, 14 May 2023 16:04:28 +0700
Message-Id: <20230514090432.78217-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230514090432.78217-1-bagasdotme@gmail.com>
References: <20230514090432.78217-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=bagasdotme@gmail.com; h=from:subject; bh=6LP5rrObq7wY9XwwQUBOiCWJUloqKCLwe+amTJtxnvQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkJS+RnPnfcu+Hy37mZ1jef+dt2Ptr9+Iufm9XfTywvy 6TDTgtZdpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAizt8YGTrnCWsFTL5asDRN +NDv/0Wavgb1J92MZm1fkWfmHfA3/T8jw8po0UlPrOqmBbyVkvrzZ2W9wJTchw3rW89alujLulb 18QMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reports htmldocs warning:

Documentation/riscv/vector.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

Add a blank line separator between SPDX tag and doc title to fix above warning.

Fixes: 412c68cfeeb178 ("riscv: Add documentation for Vector")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/linux-doc/202305141409.bEBvlSY4-lkp@intel.com/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/riscv/vector.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vector.rst
index d4d626721921aa..acc97508ccb249 100644
--- a/Documentation/riscv/vector.rst
+++ b/Documentation/riscv/vector.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+
 =========================================
 Vector Extension Support for RISC-V Linux
 =========================================
-- 
An old man doll... just what I always wanted! - Clara

