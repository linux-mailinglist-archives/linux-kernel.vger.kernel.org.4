Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B8749B00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjGFLm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjGFLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:42:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72951FF3;
        Thu,  6 Jul 2023 04:42:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7589b187so791432e87.1;
        Thu, 06 Jul 2023 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688643735; x=1691235735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNCwgZUu4Delwp2nUIpxBhXSUKUs44wAO4Evja3ZnCw=;
        b=eoSVqbkaMB1L7ipeMs1OQwP7XqcCxrx/hsXNLfkMgGfCXE9NvdZhJP/ytUO1fay563
         op6mbMpkL0OkjiKTtOyCFXTJiuIaxpGy/ciV+E15YBWoFEprMLJU8vlCf4CmgVvHTB7+
         r5iGKP7VUAkaZT3/CzN9NBlAUnPTJwqN4r4hkvAnGgRAPlL8N9ESnSuwj7mAHVlA/2iD
         NeCizejI9Aa0NTyfNeJrk+teSZ3SlsCWMbSx4v4Xdp5sidKJZmMM/k5O/Rcn5ERf1NMg
         tlcShqg0HeMwARpR9Xcff6l9QH6c8AtynluT9dJHP/0EcyunlbYxDPzxAxmlTh58D4nA
         mhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643735; x=1691235735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNCwgZUu4Delwp2nUIpxBhXSUKUs44wAO4Evja3ZnCw=;
        b=UfMWvACOzMOOmlzJg/z6OXLzd2GuwbK+4Hw3lIVhnsPqqd1U+mJJEGMI2xkETIEThR
         J1VEgd4/e1V20XgfVKLpThEQ4Y8B4/0kEAjY5oz/ofjNGWkR+121PMM+Uxf6ws8TT+kS
         tyr798Xm+TAzl5ELUMWEqYiB4szk/T27OulBabORd3vgpo5UWkDc9ClNC9m4+kYygbKC
         ASqcjfgX0EiFWV7b6U0B2RViRza8Ava6govhyyjbUzwAQETwU77pceFbiuYKOUYtSrAw
         lYNUaYC27vDmpCOMwZ+e8cuj9dgA3wNWESAq0mF/hE0Df1Y0x9wDrpzGNe7v76xGjw5g
         txig==
X-Gm-Message-State: ABy/qLZ1rsrR/6A+xo26NFH4kc6WfmLTH4bQCYcLQ2EFJWMHMZdvYwWE
        Pb+U53C1i59h11N9/K0dIgI=
X-Google-Smtp-Source: APBJJlEY6eYOELnrXhncdll93nlEbpE2DtTpvBUrGJjG/CXky2xw3UGZaTembhyzTs/xMonxpIdBDw==
X-Received: by 2002:a05:6512:12c7:b0:4fb:8bcd:acd4 with SMTP id p7-20020a05651212c700b004fb8bcdacd4mr1425555lfg.37.1688643734919;
        Thu, 06 Jul 2023 04:42:14 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id r6-20020aa7d146000000b0051df54c6a27sm678715edo.56.2023.07.06.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:42:14 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     rick.wertenbroek@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: scheduler: completion: Fix minor error in pseudo-code
Date:   Thu,  6 Jul 2023 13:40:55 +0200
Message-Id: <20230706114057.1120335-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing address-of (&) operator in pseudo-code.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 Documentation/scheduler/completion.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
index 9f039b4f4b09..f19aca2062bd 100644
--- a/Documentation/scheduler/completion.rst
+++ b/Documentation/scheduler/completion.rst
@@ -157,7 +157,7 @@ A typical usage scenario is::
 
 	/* run non-dependent code */		/* do setup */
 
-	wait_for_completion(&setup_done);	complete(setup_done);
+	wait_for_completion(&setup_done);	complete(&setup_done);
 
 This is not implying any particular order between wait_for_completion() and
 the call to complete() - if the call to complete() happened before the call
-- 
2.25.1

