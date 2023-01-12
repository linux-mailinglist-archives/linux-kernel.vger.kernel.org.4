Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C40667A75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjALQOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjALQNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:13:21 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04B122;
        Thu, 12 Jan 2023 08:09:46 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id x10so24579162edd.10;
        Thu, 12 Jan 2023 08:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=to1q6LVKIIJBWMmNguEM+gyWRlt0shFQMt1YdsJOc78=;
        b=OzgqrOGt8YvqTfJupHrGyc6eXiRC8/u/Q8geWR2WhSQNaEP2aBTpBp0jNtmZwV2u91
         /jz3SatKImZa4WB+4BlS9HtPFMsxscxsBqr3R4Lqb9p96oKA1UgREfvPFm8XdX670BgS
         G1GjeuwuaKmZT25rW5NwZhh24pMufEMG/Mg2JxPEdmky3SjR+241RK+3GloPMdF+ZAjK
         7bMJJcDhuh/yYLlsb3Y6wf68Bi5TLYJH8YlIZlATgyhTzo24of6RD2cT1HaZu6iOtHj3
         7yBZxgFhXc9oRh0RMg/CX3fgiZBODqOJy8O8w51HsDGGcbxPJ8eCwiW7d1ajJuvtMsRy
         xEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to1q6LVKIIJBWMmNguEM+gyWRlt0shFQMt1YdsJOc78=;
        b=7Jhb4KIz+vZkAqQhG1po2tag2vjhBItDQWqzX8Owd0AC/cHjc58WMJmv7lxNshUegk
         GwqBdcIVQPMlkAz42z6HtZdnvrdjU/aI0Q0xiFfmWQ0q6Hfok90qUhz4An26HTqDVl/f
         VxueoRZZx2hzQ/JBPuyaDQAK6/0o0mCM7MayUszjbB8k3L7QRnMiKKWCZvNTLv1Xjk8g
         m5MoyUoV3Un8cQcRHIB0GcXs2QIXdk6+0209cYq8+VnXo1+SblTpencOo7Mg2pewBE+Z
         rnntKxTrDjC1DjVI+DdKlKjmGfMet6Yb+52DjwxMHTYzKy3oknFr9GjlK2uYJlmcm9pR
         F8rA==
X-Gm-Message-State: AFqh2koPPda6J1e3YXog7e8Ql3IvPB0E7YutspCFRhsb96Y8zI1Qw0UP
        sKy+GWeoJ4sGZYp7ItyA56/axakKqlU=
X-Google-Smtp-Source: AMrXdXtSUAts7/BcVVwS7YRYnT4Tid5jYPTpnLefyXCec6gLHy8guSA5IFvsx8w2hcRK55ObZhu/yA==
X-Received: by 2002:a05:6402:2949:b0:497:d4ca:457d with SMTP id ed9-20020a056402294900b00497d4ca457dmr21186610edb.34.1673539785211;
        Thu, 12 Jan 2023 08:09:45 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm7333606edt.8.2023.01.12.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:09:44 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Thu, 12 Jan 2023 17:09:25 +0100
Subject: [PATCH] docs/scripts/gdb: add necessary make scripts_gdb step
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-documentation-gdb-v1-1-09ab556e9124@gmail.com>
X-B4-Tracking: v=1; b=H4sIALUwwGMC/x2NQQrDMAwEvxJ0rkB2oId+pfQg2UqiQ5wiu6UQ8
 vc4PQ6zw+5Q1U0rPIYdXL9WbSsdwm2AtHCZFS13hkhxpBAi5i19Vi2NW1/inAV5IspxlCh3gt4J
 V0VxLmm5ypVrU7/E23Wy3//s+TqOExCcYVl8AAAA
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673539784; l=1319;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=ed62LhKrG0qQfPSeu1MSavpReKFjoB5TxmkWq3Z8AcM=;
 b=q+6yF/vN6kdY5wa7H0T/eK4dQ3lsCu7USLMhRzt5CWmoYDkynToiS452xHDFJ5u/ecBOB3fXFVLS
 D+LVQtsKDttNxeEhjjVCkoENPpPbPybhndPq4ivULPVHCJHfse9S
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to debug the kernel successfully with gdb you need to run
'make scripts_gdb' nowadays.

This was changed with the following commit:

Commit 67274c083438340ad16c ("scripts/gdb: delay generation of gdb
constants.py")

In order to have a complete guide for beginners this remark
should be added to the offial documentation.

---


Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 Documentation/dev-tools/gdb-kernel-debugging.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst b/Documentation/dev-tools/gdb-kernel-debugging.rst
index 8e0f1fe8d17a..895285c037c7 100644
--- a/Documentation/dev-tools/gdb-kernel-debugging.rst
+++ b/Documentation/dev-tools/gdb-kernel-debugging.rst
@@ -39,6 +39,10 @@ Setup
   this mode. In this case, you should build the kernel with
   CONFIG_RANDOMIZE_BASE disabled if the architecture supports KASLR.
 
+- Build the gdb scripts (required on kernels v5.1 and above)::
+
+    make scripts_gdb
+
 - Enable the gdb stub of QEMU/KVM, either
 
     - at VM startup time by appending "-s" to the QEMU command line

---
base-commit: c757fc92a3f73734872c7793b97f06434773d65d
change-id: 20230112-documentation-gdb-af00d23b2b60

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>
