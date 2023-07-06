Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6177749444
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGFDdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjGFDcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:32:46 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3101BCB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:32:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a3df1b26c7so88447b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688614365; x=1691206365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxTwOa0EQc8HVnTEnAPW/0MSWwIJGSBSzfzkOm95n/4=;
        b=pTo/jZz2asIn2mN4BMuhUQhZx+/Nzya/YDfH9W10BGp968x0CAKUF2McN3MzJQaaK2
         WQSgkciJvDPeQgSBn6eBr4j2c7s6HbHNk3Jt/5jpL1fP3Z9JkpvAhQkL/o+71nJBXyTm
         8p68DcuMsOQECRnEWQtBsn+WvtS8vAl4QnHdsTGCXhNx5gxSquRv3ir46aXdi+wvEG61
         YKZhUN/zhJc6+mRDN5ywdGVwxQ/y2+Kmj6hyt4BJ/Qid4NNR+IbgFL8KrOfXo8T8opAk
         dlS5UkMeN4qkegIs7q2ENd/BFmKYBjBE8jQRKjAa8wmF4LHmzz2fA2Q9II37Itb3bOJu
         DPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614365; x=1691206365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxTwOa0EQc8HVnTEnAPW/0MSWwIJGSBSzfzkOm95n/4=;
        b=LNvdQRP8qlh93GUp8N8ew936BfNMQbRmapy6e88MhiqcHB9lfgxeQ6/gdhj4yxwFtI
         l4cvCysgtUD+mH0v6xvEMPsyEvG5v1mrB0BKRDGE+IIIASAu2Ys51gWhf1MC/7L189ei
         LzAqdX53cIX843iNivHCi4Xc19iYWqsuyYVUc9kKEgMkawKOudUeeKTUdT5fWVALNz5x
         J9BN9En1C7/ecoW3yGwlMAtbqHL52qfNtIznfwiSCEbrZovyEIWlUqanScuPyIsxtO0e
         uhF+w3B+osOzMG0D9IrkaonwBRjnSVG6+/XHMaSdMtG/1eGI1EzKEueyBxOsErJjRpSw
         DA7g==
X-Gm-Message-State: ABy/qLZJdEJtc2/IW788EuJUVS2DKcMDEDWz3EBSOtpNwGGMYxNg16vV
        sOJilwnEXKY+7iwV1ATdA+zvBKbEnvYI653BweA=
X-Google-Smtp-Source: APBJJlHP9M1ZsGfe2ZMFJKx1Re86VXljfxshm/0iSUnfVW+jY4f6zbrqlQcsob+xxdVkFNGI9KOTpA==
X-Received: by 2002:a54:488e:0:b0:39e:d59a:8275 with SMTP id r14-20020a54488e000000b0039ed59a8275mr502807oic.25.1688614365284;
        Wed, 05 Jul 2023 20:32:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id fk13-20020a056a003a8d00b006589cf6d88bsm239785pfb.145.2023.07.05.20.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 20:32:44 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 05 Jul 2023 20:30:19 -0700
Subject: [PATCH 3/3] RISC-V: Include documentation for hwprobe vendor
 extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-thead_vendor_extensions-v1-3-ad6915349c4d@rivosinc.com>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
In-Reply-To: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, charlie@rivosinc.com,
        evan@rivosinc.com, heiko@sntech.de, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document available vendor extensions.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/riscv/hwprobe.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 19165ebd82ba..167fd3e25632 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -97,3 +97,20 @@ The following keys are defined:
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
     not supported at all and will generate a misaligned address fault.
+
+RISC-V Hardware Probing Interface Vendor Extensions
+---------------------------------------------------
+
+All vendor extensions live at and beyond
+:c:macro:`RISCV_HWPROBE_VENDOR_EXTENSION_SPACE`. Each vendor can specify vendor
+extensions at any value above or equal to
+:c:macro:`RISCV_HWPROBE_VENDOR_EXTENSION_SPACE` without worrying about
+conflicting with values from other vendors. Only extensions from the vendor of
+the cpus passed into riscv_hwprobe will be matched.
+
+T-HEAD
+~~~~~~
+
+* :c:macro:`THEAD_ISA_EXT0`: Contains all of the EXT0 extensions
+
+  * :c:macro:`THEAD_ISA_EXT0_V0_7_1`: Vector extension V0.7.1 is supported

-- 
2.41.0

