Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598395FD3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJME4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJME4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:56:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE510D68C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso3915596pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk8RAstGXC8ZbSam0s9PejkQaDuIrmjFAwUR4XuoAmw=;
        b=JT122q9TUGKEWKDZ5Zdx05Xgtl02rc41DhwMWlav7WHLb/zu27l6GM6k4Dhgnsq1VH
         R6fEBYtZ1jqfQhlQlSfggLeIseqknXAhyF887fjd3gIwU0pia2gNmfjQPEVR0OJC7tey
         izv9ZLNJKlBuWF6z5AZJmPoxSTugTBjb6m4ko9LEOeZGdEQF5pNOxv5ftisFfUuJYCwu
         6CJ2rvtEI0Zj/bDGdoDvAlfa7BQJ2Oyjs1TC2x+jOpGdICGgICOQlFaFVnwxOU08Z7jT
         nnH23RliWHwX3gADGztgAW8EOQuhPMlti3KfWk+dBQL7xnwdvjAjIK87RXWMME5RFQI6
         NSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk8RAstGXC8ZbSam0s9PejkQaDuIrmjFAwUR4XuoAmw=;
        b=vauHahjW7dHlwlydUiQixfgYflf61x6Xegv3pQRdE2F4E0+CMuhXZzY48uqozUemPV
         +5yZ4YT4CRzXbrOeB2gAdxHmYYc3uMl7HGk1hQ1QVOj3bkl1HnHeyIDL/Ib/sQu9VVaK
         1i/G/IQ8WXgiJMTmXohAj5vZ53YTrh0Ljs8VGA8ft6w5fsiskHokKR9vbh+2c+hc5rox
         2aj/N/fxugmu9/VJRLZPxVphPtXn+nZ7/wx00ugflE1O0w6/4ADeEiN9Xw8uV+q2Trqe
         kOzyaPcOpoihpyJimG/9HFCjBH9QQkAGZSk0XsibVSNKCwAgrwbgRU+ONUl5ZKYuvZuT
         y5Ow==
X-Gm-Message-State: ACrzQf1wPzZrwawqP4YhyRlcKvLha+Zg+zrJ/cR4rvdBxDI3/m8gMu9B
        JsAjygWO+jWeMhTIba4QfWcFWw==
X-Google-Smtp-Source: AMsMyM5F0h9eYw/8XNXdOTmUVffdoMjJ26ztkg8Ox/kwhAVa7RpNQK84+OVyEjtjoFX/fsFfPmxbkA==
X-Received: by 2002:a17:902:cf11:b0:178:29d7:4fbd with SMTP id i17-20020a170902cf1100b0017829d74fbdmr33482977plg.174.1665636982799;
        Wed, 12 Oct 2022 21:56:22 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a104800b001f319e9b9e5sm2241272pjd.16.2022.10.12.21.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:56:22 -0700 (PDT)
Subject: [PATCH 2/4] Documentation: RISC-V: Allow patches for non-standard behavior
Date:   Wed, 12 Oct 2022 21:56:17 -0700
Message-Id: <20221013045619.18906-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013045619.18906-1-palmer@rivosinc.com>
References: <20221013045619.18906-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, Atish Patra <atishp@rivosinc.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The patch acceptance policy forbids accepting support for non-standard
behavior.  This policy was written in order to both steer implementers
towards the standards and to avoid coupling the upstream kernel too
tightly to vendor-specific features.  Those were good goals, but in
practice the policy just isn't working: every RISC-V system we have
needs vendor-specific behavior in the kernel and we end up taking that
support which violates the policy.  That's confusing for contributors,
which is the main reason we have a written policy in the first place.

So let's just start taking code for vendor-defined behavior.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/riscv/patch-acceptance.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
index 5da6f9b273d6..0a6199233ede 100644
--- a/Documentation/riscv/patch-acceptance.rst
+++ b/Documentation/riscv/patch-acceptance.rst
@@ -29,7 +29,12 @@ their own custom extensions.  These custom extensions aren't required
 to go through any review or ratification process by the RISC-V
 Foundation.  To avoid the maintenance complexity and potential
 performance impact of adding kernel code for implementor-specific
-RISC-V extensions, we'll only accept patches for extensions that
-have been officially frozen or ratified by the RISC-V Foundation.
-(Implementors, may, of course, maintain their own Linux kernel trees
-containing code for any custom extensions that they wish.)
+RISC-V extensions, we'll only accept patches for extensions that either:
+
+- Have been officially frozen or ratified by the RISC-V Foundation, or
+- Have been implemented in hardware that is either widely available or
+  for which a timeline for availability has been made public.
+
+Hardware that does not meet its published timelines may have support
+removed.  (Implementors, may, of course, maintain their own Linux kernel
+trees containing code for any custom extensions that they wish.)
-- 
2.38.0

