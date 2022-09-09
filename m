Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FBB5B31AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiIII1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIII1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:27:45 -0400
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1132129C4B;
        Fri,  9 Sep 2022 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662712058;
        bh=aoLYthYaly+LPb1QY/iuCsxLqqcSPLGYImw3emWr4Tc=;
        h=From:To:Cc:Subject:Date;
        b=eZ4ek7YY5KxzqRFiYPqS07zM6S45dTcXUWy2zC1m7lr/u0DbXN/mptJRQWMwUH8CZ
         GE0Tsw3T1rqkgC2LZy4zy3YpW2FQpY/3NYgLyXXtbipLqmU5hMokXmQt4jsGugAMis
         /LoBwgiB1y82Bav1UHxv/5zzM3esGQwR0zGZgnNM=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id 5DAB6A8D; Fri, 09 Sep 2022 14:23:26 +0800
X-QQ-mid: xmsmtpt1662704606tj9l3mno2
Message-ID: <tencent_404273595E97D42A7BAF59A3318800065908@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPOqZ/kLfFa+J1YW7xUCVDPhrfLVPEiKDvNDW8NxScyADHqL0mKt6
         2g9TyVmW3diPVqfaPulMjssdfKbgu26s63HvRczz4+3aOnjAzeKz1FZ+QdtY2ZZ9vvCBhj8cDmwD
         tGSdPdFhuzl/LUOImUxoz/nPUEDXTvrb2ueNTK3wlknp8RbsI7kv+8mi7yJRUNXVu+pZdQTNFf3D
         B6VSCgclQdO+Fo+nipGtEUz+rbMkFn7dN672JQLi2f+tyjrR7xaJ9vGnjkbn93KSILTC2N1U2Gge
         KjO4bI8UHur9Ju2ufn6Ii8ewz2tRvmDqGLFL2E5+4NjGWNYRIp7mOIODMKX0QsgOJOLp8jhuDvqi
         Q7EltiUBqvcOYLFR/o7qa76Ds/TlKbBr35cUv7O/Zj5r6JnADwvrarNxSpg4Vue27uHf2lMy2/7z
         b8ywu+zS7g9w4FOS6kb0HRdM0ZEDIgm63l1rIglfURjM+RVBYCADDQPQ+w3I+xA1SdUcDRJPl53+
         a7Nmor27hukwM1ruoKWD0bysUnBHe1AiMYH0GwSUxNZtlRGYl30R2Hjl1y9T12QDnR8Xl+4kjvsA
         tV/4b5Nx2Vq6A++oflaLPL255SuOg1INIijE2rr7yPA3uX1gfuDeo2LEO63zcFjvO1ynpe+WsjJz
         jzTT4fM8eG8xLcX3M08JUR43vSM9LX2d4UHAklmSJJ9uMZOWnWiC4sFuyK45yexSTZt3NvPc7r6X
         Vmf7B7jcqqfzmZc8q/QF4rQ4Jpo1Gw9v+PySgDz6AaCVYEFGdGeziPmDHwZCI65wrEs9HDNzmFpr
         CsnOf3pLYexHAWO4ZlHrW2G1opGywLdLYnFbQvHtAvlc/YorGffs6s5PPZ5nklNog6F/EI3eJDhB
         SyxgaphNoHf+f/ZWpfiBrWhRLVLMkuGiuvMyXJ/fBFh9e/mt1tZoLYdSy4HcJ/Q7tkS8w9jVmmqm
         F9e/ne0DSEZBlIkTuhmhshiUH3ztpvaPQq5Pz1gDHkRBlSHyRC1VtfzLVsBpVEz06rWOSKtsNj/O
         nFpIXeig6YR4bi3rFeUCial8zTQ3Dck5cdokVrlw==
From:   Rong Tao <rtoax@foxmail.com>
To:     corbet@lwn.net
Cc:     Rong Tao <rtoax@foxmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Erik Ekman <erik@kryo.se>, Jiri Kosina <jkosina@suse.cz>,
        Miguel Ojeda <ojeda@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: process/submitting-patches: misspelling "mesages"
Date:   Fri,  9 Sep 2022 14:23:03 +0800
X-OQ-MSGID: <20220909062304.5629-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistakes, "mesages" should be spelled "messages".

Signed-off-by: Rong Tao <rtoax@foxmail.com>
---
 Documentation/process/submitting-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be49d8f2601b..0f45e8fd526f 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -715,7 +715,7 @@ references.
 
 .. _backtraces:
 
-Backtraces in commit mesages
+Backtraces in commit messages
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Backtraces help document the call chain leading to a problem. However,
-- 
2.31.1

