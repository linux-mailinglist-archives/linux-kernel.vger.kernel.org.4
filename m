Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149EA5FE47B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJMVuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJMVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7378E7B9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e129so2667784pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=ObQO4YlfPrgO44N69wsJk0MaAPFfBNGXQLCefOFiBjQ=;
        b=hZ6XlB/bpaOYoa0tp02VmBZz7C8QYLC9KrX5LewPgMMAh3smdNnvd/BGjOBKUCveiw
         5F1eT7j/9sgqY0QtTv138KC4Fjzob5qTG/cKElMI3GRs+nEhnB89oaI0nMN17jpXJDUc
         xdZ1sK2u99Q+NU30h6f8lICh+kV2UOo//a/xq3waFtVzllxj5iVfuaBgB1/NjRHiba9D
         o0vMUdncJ+0t2S67L50TL0501c9O/0aK6V2Pauq6UybbwZNB6vbVzQ3oBS9vhJb3Exkx
         UeAQkB+RUwSm0veguIowvXk6gPGCH/fuPgKh1oq4Dfji9BZNuYj0VKOoP62HkU0+6BMm
         h58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObQO4YlfPrgO44N69wsJk0MaAPFfBNGXQLCefOFiBjQ=;
        b=VU/hoiSZSELC3oQA76W+iMXVy/6ufsXCDj+jvqtNUolKNLvhaW/3IIqRmvJFTgLPVW
         lhZsWzrm3vabQHnNF3m5NQ3Lkv0KREutGV6qSDouMb1mTxIlIMHv68FFt5g/MZdUW6/4
         ygPOtdGr6LLcLjLnvrNnf3BWtwI7kqE/QHaVA+MdZyAAas87tvMh36LzrZX0fj/4UOkt
         dD9I/Q4+TxcBSm9QhsxHfbvLCWU5tjSE4KaeqZqhg1/8QpQQkeCpYziDckwJYg1BSCIk
         elVb0rVaV8pVT/X7+JWp0z9+j+hnR2pb1Q6qM+9xwNvdOYQdcoTv6PCFZNLE7IbrUXYA
         Yqgw==
X-Gm-Message-State: ACrzQf3zUndTt9NdyoDk85bj9uE3bFAWu67eGTI+CKQuBuglhiNJUBlL
        C3W7fBIj9Np9q2W6CJBC8vB1ewb6uTvAyBxX
X-Google-Smtp-Source: AMsMyM6rmM3m717/HsDOxZ53gl+hm3XU9Jz8gQg0Q0Xt4cs4zsiuQciXFD5HfUQRflXOBHWEeOcpqA==
X-Received: by 2002:a05:6a00:32cb:b0:563:2d3b:5c8d with SMTP id cl11-20020a056a0032cb00b005632d3b5c8dmr1594166pfb.85.1665697755312;
        Thu, 13 Oct 2022 14:49:15 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b0017c19d7c89bsm283980plg.269.2022.10.13.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:14 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for anholt
Date:   Thu, 13 Oct 2022 14:46:38 -0700
Message-Id: <20221013214638.31014-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     emma@anholt.net, mripard@kernel.org
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
index 22a9acc7be07..6a4e8144198b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7003,7 +7003,7 @@ DRM DRIVERS FOR VC4
 M:	Emma Anholt <emma@anholt.net>
 M:	Maxime Ripard <mripard@kernel.org>
 S:	Supported
-T:	git git://github.com/anholt/linux
+T:	git https://github.com/anholt/linux
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/brcm,bcm2835-*.yaml
 F:	drivers/gpu/drm/vc4/
-- 
2.38.0

