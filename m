Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5395FE45E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJMVs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJMVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:48:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDFF17C54B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:48:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m6so3185215pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=b1XYeyGTNJN3qIh07qU6q0EJWggKUkP1oRUyRbAR2H8=;
        b=fOjjYk751S+BTh4xYtHjJLQVIZlytrafEHObrPf7zNZjgdWcl90AMg54MVROaN6Txg
         PX+a23fSq3YH88JaCLwR+vmkWWhqDBAqeLt8iXqImeilpBmGLQWwh4s7vnt4yp2+9n+m
         HDL/CyGCmosTROL7OLsZzrirEzxzs0nvZewEgCbcidlW252S+FcNbJTt/T2HjWmP1JKz
         l4HuwthzaMd2hJPF/98qWkxatl5RFxemMf34niHUpnQ9A8KxSmYlfrZbDk6cDCoqWggK
         h2hX3BtbB7wljQTRRdjptTG5YtpM4d6vHVrjD+RH1h1W6kM4Q5b/z7wRaO47hSf0c3Bo
         5D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1XYeyGTNJN3qIh07qU6q0EJWggKUkP1oRUyRbAR2H8=;
        b=GE4iP3RfFpRgWrNvVfMcUgK1XkBHd2++y3nSvIUcyuyAHVgQHK4eEWt0OaHb8g5GSs
         2YAukix7zRxwIgFPGw6mySML8W2u4ElEB+NqKdi8ZsAH8h7HL4kDr29aqSSakG3OiDai
         PuJYn5kZS58ntfzx3JLfd76GbTT3HxHZnZKkKSstXVvXHzZHZO2uHp3XUIc6HUw4XFs6
         Cp2CBDvfD3Av7A94fFjdZXB7Ma38FjCHewnFf2v4+Yk8i+bRI71KbPgHILuEHTs9khId
         ubD1pqRHSmhWizFb9CFBPab4cFAo2ZsDakq2zoSj/t4NQXsqaSwdmUPlXN+NCcL+J47v
         N+fg==
X-Gm-Message-State: ACrzQf2wzYD66dkxLFMdmVIaPIX8XGeKSl9Q8T5TnxewboDSV5wV+J8+
        GKxgxr0gMM8ABafwe2io0J6k4oS6mKLA4A==
X-Google-Smtp-Source: AMsMyM5dlekhqku2hsIGY9X/o0ZiJHMYcP99z2hMdjly9aMR3sZBp0WrhMbXLTzVBpKP7AuC4t+/HA==
X-Received: by 2002:a63:6c01:0:b0:429:ea6e:486d with SMTP id h1-20020a636c01000000b00429ea6e486dmr1643771pgc.247.1665697735392;
        Thu, 13 Oct 2022 14:48:55 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a118f00b0020a61d0e4eesm3705240pja.30.2022.10.13.14.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:48:54 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for terrelln
Date:   Thu, 13 Oct 2022 14:46:36 -0700
Message-Id: <20221013214636.30701-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     terrelln@fb.com
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
index 41a925931cc3..748f9aaffdf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22528,7 +22528,7 @@ ZSTD
 M:	Nick Terrell <terrelln@fb.com>
 S:	Maintained
 B:	https://github.com/facebook/zstd/issues
-T:	git git://github.com/terrelln/linux.git
+T:	git https://github.com/terrelln/linux.git
 F:	include/linux/zstd*
 F:	lib/zstd/
 F:	lib/decompress_unzstd.c
-- 
2.38.0

