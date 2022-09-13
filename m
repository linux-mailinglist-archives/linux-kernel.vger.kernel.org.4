Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34935B6657
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiIMEIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIMEIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:08:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C724F39C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:08:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v4so10142993pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uanTL/bnlnJQgtwLSfczwro/TOgawj0bo0VSuHyRExY=;
        b=JU55qWJrfeyP7wqdi4/cRVYzu3Wvwk7795MkaSzl3FdPBVd4tVxZYavpqgmwX8bhOy
         rmI1DHkRI4yVesK6KXj5mtNXZtJ7suOtXoRocMN6YxyyGvtM/WlwWHASMYiJiB4wcuI6
         kuGFw78+7Z//nn8A9PVciWPEdC2xAw3aogApfCGyMd2pEViwmreAfgQcOodbgMBEGnMd
         OmZ9dGg0s8LEtqSrzSnuaNmEgPucpv/2SoE5TA/VjP1ZUEPhQwsnUWKwyZxsEsyuFA75
         vu+zZM8pp8z4/1yv/USZ8qkskdJ35jM28/3Q4d2gYVPYszj7cOtHtA/l4vjZh6pSdCbq
         PScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uanTL/bnlnJQgtwLSfczwro/TOgawj0bo0VSuHyRExY=;
        b=sU7QXD9LwCfr0aFrRPhF/pSbtP4YUzpNevGJ1ZQUsMKje8bef9C6OTjqm6b8h+7HuT
         JY1HwNYKihADdNyY4A5KoxYmzLIoFSTLRIVzGwdRErig0sn2fL0rjOKFiMZGJOvKhXFj
         YEf4Rocia25XQjrFG5hUhswGLUQzB3H0nGLV11Qajy4nYQPhu2DNq7+u4kCHY6BPyc+Z
         uRpYpmHUYEJIrva+xcxNeDHyiVcOtaB+1tk27E1irAig7jZz3W1CK0r/NCk7rvZxrM1j
         Ul1/aAzlOnA4ulp2OSRQSWAMQruj2jSyCjdyrRbpQHIHhnhDKLokR3Qk9ZlY1z3gMDPz
         FSCw==
X-Gm-Message-State: ACgBeo2p3UHUtSRY561rFr61OVecbmP1iyFfTg+Q/eYpr+Y5cSkcLeY7
        ibQnOImGN/8TyBL87ZZC0IA=
X-Google-Smtp-Source: AA6agR4/xMwF86/vhkCVQNrVEoewuWVBH6r7FuJxQXObbFKVigvTNAX2ev/s3+msuPyfEP1b9dxdRA==
X-Received: by 2002:a63:9042:0:b0:438:8ef2:2476 with SMTP id a63-20020a639042000000b004388ef22476mr16382111pge.55.1663042080401;
        Mon, 12 Sep 2022 21:08:00 -0700 (PDT)
Received: from ubuntu-jammy.. ([61.16.102.77])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b0017691eb7e17sm6877641pln.239.2022.09.12.21.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 21:07:59 -0700 (PDT)
From:   yangxingwu <xingwu.yang@gmail.com>
To:     nathan@kernel.org
Cc:     ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, yangxingwu <xingwu.yang@gmail.com>
Subject: [PATCH] scripts/clang-tools: remove unused module
Date:   Tue, 13 Sep 2022 04:07:52 +0000
Message-Id: <20220913040753.2198-1-xingwu.yang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused imported 'os' module

Signed-off-by: yangxingwu <xingwu.yang@gmail.com>
---
 scripts/clang-tools/run-clang-tools.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index 1337cedca..bb78c9bde 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -12,7 +12,6 @@ compile_commands.json.
 import argparse
 import json
 import multiprocessing
-import os
 import subprocess
 import sys

--
2.37.2

