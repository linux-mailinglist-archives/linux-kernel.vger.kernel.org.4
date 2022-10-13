Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C655FE46B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJMVt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJMVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D671196B62
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f140so3156526pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=X6g2DUxT2GNjgJSb1+fAz78uiyB8qoWs9ZV/F7wTuSc=;
        b=Yc/kJQVfhodH7JJ0z1+p5s722JAC0Kovui9UvRAdZv1AuAQddcjsKvP0c5xJ4eXiTj
         OkV6o+tMZKBkbMP3J8A2rnEzZBqu2Fti1CgZTfkIkwnoar5AH/2cjiH4hZG+Zu/36g+V
         nZxAvvE1T1Nm5GmUF3RyGy65BQC16tRTAcjfdvJphIQi546P6Bf+WbD0fqC9SiXxputB
         Z46Iazmu9SQt/CUOBDkff4QrIa/tMeBWmxRjhuMnZhNI4blhSYZW5fXRDsanWC7oq/ca
         f5XxJMVCr+DaGN5IOci1Q5D/kM9yEFJUmVudYTrgpC16NN09vdKfKF2Lv0npeEFS6JUa
         L8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6g2DUxT2GNjgJSb1+fAz78uiyB8qoWs9ZV/F7wTuSc=;
        b=lIsH9euojnHiMSVWRxitAe6WVEIWBqoKmlyMcldopZqKqPhJKwo0a9SYqmAoWj1Vtl
         yp+4YjkvhE76ymimOes9p9DHkzmtLnRSudl/rmA45LN02NWRtVbxTUg4PpoexP06X5at
         A3S2a7MIHOSaApAf1ZBWTKXDGZkdGALctNnUaQ68GCdqE8h49SClDocuCTXFEvUj8pEy
         i9UcmFNdAPE7OtmkEmA7SAQqRbog8VyMO6QQbbJXKtYmAY/1bY7E1O1v0ZS2aYnKoZ5n
         qHEljMIwkZjZf3jbdZsY4ri2DSTJ2zwoFJIl+mEYvo7VmxnQAYnHJM+cqtzfO1Vfb4rk
         UBqw==
X-Gm-Message-State: ACrzQf08U9GgvHqhUmEYV3U/vLZJvmXEmzPmOuLNV9rJrKzs4Y7ZN4kJ
        cYAw20K3rsI8nfN8em9OwF3RHoMKff94Eega
X-Google-Smtp-Source: AMsMyM6IPVcYa2h1i5pmoYBypDG67/4nbnOAJozkEB4zzfmqhCeqDmDyRhB2rQDtJdks9Mg9RfgsaQ==
X-Received: by 2002:a05:6a00:88f:b0:558:8186:3ec3 with SMTP id q15-20020a056a00088f00b0055881863ec3mr1603895pfj.83.1665697742905;
        Thu, 13 Oct 2022 14:49:02 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a578c00b00202fbd9c21dsm204840pji.48.2022.10.13.14.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:02 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for sifive
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30828-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a028f494fb0..daadd0de77a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18548,7 +18548,7 @@ M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
-T:	git git://github.com/sifive/riscv-linux.git
+T:	git https://github.com/sifive/riscv-linux.git
 N:	sifive
 K:	[^@]sifive
 
-- 
2.38.0

