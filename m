Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24370D8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjEWJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjEWJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:17:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE65119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:17:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f5685f902so741467366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google; t=1684833449; x=1687425449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Evdstnt+fZo+xq0sG6n9jZlSoQpDRSGli1+1+HmpUO8=;
        b=PnYOwJG1++jjnSRLyZ+XXt9gySJkJxjqebKiDUDHBOmCchnmXNB5a+RvVScIuwL967
         bKh6xKW+Q5cvv1H1fQMTZMH1i+o3YXKmFqQqigbN7MomMz631Mm/0jkOceURgFj7rlIO
         jNcaq99VWU2YxZVuFkRhYdQq+bbIX2RXbr6jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833449; x=1687425449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Evdstnt+fZo+xq0sG6n9jZlSoQpDRSGli1+1+HmpUO8=;
        b=hwO30v0cfzUbt5eboS+tHv4tCodnoWBnJMV2ot0WgE4HcxfkcBXYDjnbsLnVBVwrXX
         xGc0U+2djiPEfj9c+NdK5XWlri+H0Np4+Sg0NT9O5q0QspoFTbWXG8X01y/OCHtoVCKM
         4aQYdCDygpAVxMGLdeBmz4ttm8yYg55eCmRjUMkJzivWnDBq2iucym5/0/IZndQPqe1x
         LoQiJIyTJIXQDfirU3IQ0Ku6uIeTGQhOKtvssBJUe3DjUMjQEPXCAC9eEsTik79VOveg
         A2XSziRBq9k087tQVDzonnRp2y3GlRrwkxW4xeSsJ8O6ZCT88Wfcc5YHiR/o6JNvr19m
         8oBQ==
X-Gm-Message-State: AC+VfDwWxAuJXNvhsQI+B9Tzm2mW4KubcTsXJHAfZ2BRffTrMyFkCLNr
        eLKlUbbiNqTbhcJYyaWTOzFoaXX0POTnVmHSPQ==
X-Google-Smtp-Source: ACHHUZ4iT9f9F/0RNORNFfSPrn2dimqu5j+bYxzVynCCaK2bASqNb6PiChUoa5qPNoivkOVDQRPXDA==
X-Received: by 2002:a17:906:da89:b0:94e:70bb:5f8a with SMTP id xh9-20020a170906da8900b0094e70bb5f8amr11721372ejb.66.1684833448729;
        Tue, 23 May 2023 02:17:28 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-93-70-85-51.cust.vodafonedsl.it. [93.70.85.51])
        by smtp.gmail.com with ESMTPSA id w9-20020aa7dcc9000000b0050bc13e5aa9sm3800762edu.63.2023.05.23.02.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2023 02:17:28 -0700 (PDT)
From:   Paolo Valente <paolo.valente@unimore.it>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH] block, bfq: update Paolo's address in maintainer list
Date:   Tue, 23 May 2023 11:17:24 +0200
Message-Id: <20230523091724.26636-1-paolo.valente@unimore.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

Current email address of Paolo Valente is no longer valid, use a good one.

Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebd26b3ca90e..0c8e6537d6e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3542,7 +3542,7 @@ F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
 BFQ I/O SCHEDULER
-M:	Paolo Valente <paolo.valente@linaro.org>
+M:	Paolo Valente <paolo.valente@unimore.it>
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
 S:	Maintained
-- 
2.20.1

