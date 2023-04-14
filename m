Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9616E1C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDNGOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:14:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54240F1;
        Thu, 13 Apr 2023 23:14:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94e8cdbc8ebso118085366b.2;
        Thu, 13 Apr 2023 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681452887; x=1684044887;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSpS3E1S1nYKNPJCN4kTXWUVOYv1fhq7FSwOkeeQFww=;
        b=ISgWTdiyNpFBy7MuqU0pcBtm8u4GyGxkGdFBiXH0rzYJsuDeVevS8CwtN8hvZkOB3d
         Y7P+os7CF/gZfTJ1P1qsefQmWNRdj1rMeK4FKNJQQzW5Zg8ftHX4UsRIDak+AXOAk1/Y
         HHjlfyUAMV0/LCzVMqb0OkNGsqSx7bHhw4KKrMMlqZD/Qyp9xBY4pnYNUTvAnCglnBlr
         iNRgZxK32sILPM+SVdvshzZpiHFSiny5ZonEuOr7IFXgEa/NPn2qvuQU8nnO4WsQwBWm
         q40jA03hKMsgn3AJBQv5alIYN8l2otYMFkRYYhLix10SY9/hUHdW3Xf+OuOgjg1SU3+l
         dfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681452887; x=1684044887;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSpS3E1S1nYKNPJCN4kTXWUVOYv1fhq7FSwOkeeQFww=;
        b=URS6+mQPpht9Rsp0y4NU0a/I6jH8dTFQjoQgB4SyFTwAAj+1XyHH3XhBOfuaSTNdhB
         vMvVRlQ4vEcaSh/FLniaKQBMW6/Sal+wEdfNGQy1GiHXksG2do2NLYWHTFp70scdxJZM
         DbBUTnpG7gSwpht/ggK/nxLrhjgTvTXbxYkNdiVxeIUhiKA8L6UCoJd391xCSdtuS4HJ
         vQjhqQsPv/KSNcJuFFSpflSGk+rBJxCxZBidjYoXGXD7IrPFZuA1pPKplLFSOxp1+GPt
         cHW8Q0ZJoeml0WuhsCrYv75yoUx3NKMgWG6WyAWab/IgqruTIVzesef+v2IspeRsk2vb
         92yw==
X-Gm-Message-State: AAQBX9fRpPF29ij7WejtTHmjyVM0UaR7QseW5dFKPoi69Wc+omyQVi7Q
        3d8DoJr0S/GCcE252Icxc4c=
X-Google-Smtp-Source: AKy350bX9VkTffd+1wd2KOcfBuyy5KFxp45M9mzaVbuj84Ms9sEoq7RAIMJdfCiwdLCF2Y0jk4OEyw==
X-Received: by 2002:aa7:c38a:0:b0:504:8b5c:a961 with SMTP id k10-20020aa7c38a000000b005048b5ca961mr4954397edq.18.1681452886588;
        Thu, 13 Apr 2023 23:14:46 -0700 (PDT)
Received: from felia.fritz.box ([188.193.217.32])
        by smtp.gmail.com with ESMTPSA id j19-20020a508a93000000b00501c2a9e16dsm1751294edj.74.2023.04.13.23.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 23:14:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: kmemleak: adjust to config renaming
Date:   Fri, 14 Apr 2023 08:12:41 +0200
Message-Id: <20230414061241.12754-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c87db8ca0902 ("kmemleak-test: fix kmemleak_test.c build logic")
essentially renames the config DEBUG_KMEMLEAK_TEST to SAMPLE_KMEMLEAK, but
misses to adjust the documentation.

Adjust kmemleak documentation to this config renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/dev-tools/kmemleak.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 5483fd39ef29..2cb00b53339f 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -227,7 +227,7 @@ Testing with kmemleak-test
 --------------------------
 
 To check if you have all set up to use kmemleak, you can use the kmemleak-test
-module, a module that deliberately leaks memory. Set CONFIG_DEBUG_KMEMLEAK_TEST
+module, a module that deliberately leaks memory. Set CONFIG_SAMPLE_KMEMLEAK
 as module (it can't be used as built-in) and boot the kernel with kmemleak
 enabled. Load the module and perform a scan with::
 
-- 
2.17.1

