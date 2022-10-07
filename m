Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AB5F7F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJGUnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJGUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:43:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0CA8798;
        Fri,  7 Oct 2022 13:43:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu30so8848790wrb.8;
        Fri, 07 Oct 2022 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6etltRDJaMEsXq7CgGpxh6ihdfKctaGSXtyFke3/FDw=;
        b=TndZ+muxYZ0cI2pBO/BHBtusqwEKHvBzCVDFUTKaC6imQsrzORraDPI9sULCMl2L/w
         N6EbZeAw66GWtUt0LTMLRefgGgQzf7TDnQumotQgYlGFtvOW/32J9p0YI6HnRa4/AJrv
         IpuIpZzMFxT3O48GESXSxbZ/veeMqERQ+feI2Gx7N+019IA7RmGroZxfKC/vEhucCA9d
         ab1fgQ9fbTW0uu8yas1vS9+/Nj6m4NgkRVesu45yUSmUdrzgVat+1vixgtlP0Bnyh4yg
         u2olFX9MmpiNHJiD4vZgdWfouNHmRxvqdNZQVUdCIFCI2zuYdQLp27581SpU5gp1Hoxi
         T7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6etltRDJaMEsXq7CgGpxh6ihdfKctaGSXtyFke3/FDw=;
        b=ERL54xv9UBZ5FmctdrbpkMWym8jfyJGlhQMyEUwTvYZLuHjvyB+vxlJ0oSO8xlbF8x
         nybiI2YqdwxXzSmi9LZkcWjjb5iEv7Yv0IlqRR6+xrq2LY8aritkjsBvdbVuAGOOWWsI
         CqeHPDk6JRnniNobd9dCV7mk+panseLPXaIoASjwU8Or4BN/CShRA8wIRmej6NP7W52I
         RA0aqK71R/wdlvVZcbnrS2BJjUEytHWtgIz735ISS1Fjah2sTwkVv+gPaLQdUebDbHWK
         riGqNqXPZF3DYij/i91aaEVC4W1jXCYePT/GLlmPK4Q/WP+LHTLruM7edClGHvSNpzpL
         z5Tg==
X-Gm-Message-State: ACrzQf3Z0/I6YI6pPOKR86dzZ4lEwW1wK112UAqYssbWqkId6ITzxGfW
        AiSmbqw0zeyTZ7nDRUxdq8k=
X-Google-Smtp-Source: AMsMyM6OWxg7nz4QaZKt8xJN2Wb98XGb7qMQC4ayyZ2d06mFVmFv6hn/YfYezssEsO01kvTnsk0gzQ==
X-Received: by 2002:adf:f58b:0:b0:22e:3c4:cf83 with SMTP id f11-20020adff58b000000b0022e03c4cf83mr4572862wro.379.1665175420392;
        Fri, 07 Oct 2022 13:43:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s10-20020a5d6a8a000000b0022a9246c853sm2841738wru.41.2022.10.07.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:43:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] init: Kconfig: Fix spelling mistake "satify" -> "satisfy"
Date:   Fri,  7 Oct 2022 21:43:39 +0100
Message-Id: <20221007204339.2757753-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index a19314933e54..645e70829441 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -72,7 +72,7 @@ config RUST_IS_AVAILABLE
 	  This shows whether a suitable Rust toolchain is available (found).
 
 	  Please see Documentation/rust/quick-start.rst for instructions on how
-	  to satify the build requirements of Rust support.
+	  to satisfy the build requirements of Rust support.
 
 	  In particular, the Makefile target 'rustavailable' is useful to check
 	  why the Rust toolchain is not being detected.
-- 
2.37.3

