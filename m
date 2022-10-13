Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F565FE484
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJMVvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJMVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:50:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7CFE37
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so2667402pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=+leHWNtrvZcbEhJ9w8JfEw5NmGRLYTx/QcgKDf+LIgc=;
        b=qinYpPJ86tAD0RVFfk+e9LhVqpbFP8zQYVB7A9nG6BPLgD8OQB6JKlMd1sazxwK1sj
         o1tQgyfD8tWbvHUn7eB0AaJALZoODFJfc1W02AUFc1Y0X/aBkNR8KvKybdH+sMJu/meJ
         cNcAsxObQbx8NlxNn943CF75g6eWghesqitRNKu3HKFyxwQX0AgCFiTEBCgEcg0rrzuS
         ljC5coLvDFdNDCl5DCgVlLQT3pPkwRRpMM497XelQeSA2JuMhnBTOPchVHzE+nVUj+yE
         yAIy9a4rEK9PZKisXUDJmHKYRaXYXU1N8VHz6Pz+JM57KLCzAxZhHzy/9Kw1FV3tlIsc
         LGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+leHWNtrvZcbEhJ9w8JfEw5NmGRLYTx/QcgKDf+LIgc=;
        b=n+14JM8opJw+sLHLjUWRKg/I+TaX5vRM0sxWpHsc3oGD5vIytJaVLZLzFmSEVmdYFg
         LKt8VATzA+b6yEeNkgWO8nPHJGKjINTctxWoRcnWTFME7loULKkI4OZThzB6gaQHhOXi
         7ZoTTQm1k8AdP5mLI2/PM/8ewPqT+5CPm27bPk4TaPTHk+kos3kdvG99J9l30+q7fVGS
         irfHUA9xFYOptivmIcN3dej7zSn9QXpOwzOwB5SYPUq6VdtzEc5vIM4B2JRidyLuGA49
         WS5MoICxxXiYxYj1YodxPUJ6MbMgjzPuIZpyJCVqTlMT7ZwoeFDGNtQrptWbn+CkzzxX
         FcaQ==
X-Gm-Message-State: ACrzQf1iNSiS5OdENhaKInxNij5KQ/c/lYT0XOd3Xq7U/V1U0RiT8T2h
        EZVlf27muiGTbrbF2tiP3BPYcSgOw8UMAER1
X-Google-Smtp-Source: AMsMyM7ek/iLi+GvNvwLRZ8eVYqQRtDBX9hk5HlkuNaSLKqsneVIgBM5GEcnxGV+iX7oj24nh2Qh/w==
X-Received: by 2002:a63:5656:0:b0:446:8eb5:a2c5 with SMTP id g22-20020a635656000000b004468eb5a2c5mr1746577pgm.336.1665697768847;
        Thu, 13 Oct 2022 14:49:28 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b00178a8f4d4f2sm319023plg.74.2022.10.13.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:28 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for martinetd
Date:   Thu, 13 Oct 2022 14:46:40 -0700
Message-Id: <20221013214640.31234-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
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
index 8a5012ba6ff9..ef3666ddc73b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -233,7 +233,7 @@ S:	Maintained
 W:	http://swik.net/v9fs
 Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
-T:	git git://github.com/martinetd/linux.git
+T:	git https://github.com/martinetd/linux.git
 F:	Documentation/filesystems/9p.rst
 F:	fs/9p/
 F:	include/net/9p/
-- 
2.38.0

