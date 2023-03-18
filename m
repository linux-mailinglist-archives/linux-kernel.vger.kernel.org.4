Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26636BFC07
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCRRxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCRRw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:52:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB9158A9;
        Sat, 18 Mar 2023 10:52:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so12321502pjv.5;
        Sat, 18 Mar 2023 10:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679161978;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5I26wPYmJo/oU92vbPVh5xMmJlwNRBuQUe5Qw0zvmBk=;
        b=jSG57T5YZEWuLlDcSl/mqLJXWjPe/Rzdw5X+opAZMRPBpD68dP9BjfPNd1ezQNrcd0
         nRRBUMFk7/4jIADtIgkVRsPJoTqEwEMzF2Jv7t6AmzsNiCozY91V2Fr4j+UFK6HCseAA
         dcqFPxOUwM3foq3dsHdeTzDCBZLTt7f7Md+B9yXpqY6VdYikgkzwk1ATq81k+fWMuphA
         lb+hPfakXqHLnMw1C7jsl/BIP6jjezlzuTK2AWKtckqvfi4m8x1JGpKed7t17a1TFuN5
         ZImcKv0m+a6hF0FdLNBp2mBenBLhfgYeP5iQ9xas/apsW8fw7d0U/NvtOky7nQ2S7DJw
         U7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679161978;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5I26wPYmJo/oU92vbPVh5xMmJlwNRBuQUe5Qw0zvmBk=;
        b=yPTKXtLTmIcHsqMAzAzCTZGpBVAKrlVvj303kdvUmKW/RVDGTM8819NWHbKg80LwEs
         G0FzYE8mpS+54xU2MUY/uqcztAgAPCVFEEMNLOjlf9qdByAyyFd5WYQqWc7LtV3WYlzu
         2BGXVk8hqQjhQRxmvLjRNCTEDzh9A3wzt+Pvmmtyfw5J39kPD3vpLB3BNitAj8/n0RHa
         TKIPZHOhndRFSeCxTlFaYEMyJ3lUnAHQFCQHMpsrpIDHYx3Jzz01Gn/s82fVjJojtb0l
         bijHdm5r3sPgtMmSomn5bLBxHC2zbFsTZ2w++ocixdyg4Dy+AWFv40QSvIjUfZr6V/cj
         ZLjA==
X-Gm-Message-State: AO0yUKVOgVy43NZGGbVKtD7AiT41BO4Y4Zwu6B91MA7UPz2B/RqNXNyT
        PrO0JyQvD5PmIkSdvYqTmk0=
X-Google-Smtp-Source: AK7set8jdYiLH1aQ2/GgeOAEtwd9CA0dkiVwaqW09Fb0RZwzNwSJWmFzwcPydo0UOuzKQ1WzAQQ/XA==
X-Received: by 2002:a05:6a20:394e:b0:cb:9fcc:3f37 with SMTP id r14-20020a056a20394e00b000cb9fcc3f37mr15180975pzg.35.1679161978050;
        Sat, 18 Mar 2023 10:52:58 -0700 (PDT)
Received: from sumitra.com ([117.199.163.158])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm3608549pfm.171.2023.03.18.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 10:52:57 -0700 (PDT)
Date:   Sat, 18 Mar 2023 10:52:50 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] Staging: nvec: Convert to_nvec_led from a macro to an
 inline function
Message-ID: <20230318175250.GA49618@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to_nvec_led from a macro to a static inline function, to make the
relevant types apparent in the definition and to benefit from the type
checking performed by the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

v2: Change patch subject and description, noted by 
Julia Lawall <julia.lawall@inria.fr> 

 drivers/staging/nvec/nvec_paz00.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec_paz00.c b/drivers/staging/nvec/nvec_paz00.c
index 8b4da95081c8..9573ba762cdd 100644
--- a/drivers/staging/nvec/nvec_paz00.c
+++ b/drivers/staging/nvec/nvec_paz00.c
@@ -14,8 +14,10 @@
 #include <linux/platform_device.h>
 #include "nvec.h"
 
-#define to_nvec_led(led_cdev) \
-	container_of(led_cdev, struct nvec_led, cdev)
+static inline struct nvec_led *to_nvec_led(struct led_classdev *led_cdev)
+{
+	return container_of(led_cdev, struct nvec_led, cdev);
+}
 
 #define NVEC_LED_REQ {'\x0d', '\x10', '\x45', '\x10', '\x00'}
 
-- 
2.25.1

