Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BFC6C4248
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCVFlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCVFk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:40:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631FE206A4;
        Tue, 21 Mar 2023 22:40:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c4so10438586pfl.0;
        Tue, 21 Mar 2023 22:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679463657;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbpEc0TShRb+rRNJad+coLk/gTeDzfl9QacMb8n5DBg=;
        b=Bq4urczeX72wjoD4FS2uQMeJuTD3w253bS8qWgHfD+D+14e94gfR8Hr2Tzg6eg9Mw3
         lhFWt/LSdZS+xQdNIPuqcaLdZeQZKPyIrEEoi285Mr4tHsjxxbPotYx1sI3aevj2RWp2
         XopushWam3vNZ3VINzeWPNm8Vl5ZRaFSQiR/sUlrzUEUptZ+RQ/t7bzSGCgMw3NmXMA5
         fCHo7YlryhO6N2wZlXFekuRtU4aug5bFuM4crzVNOap08XjYuzZ2UvUeKpIcCxEwS+Tm
         9eFpErG1sYlPN91JaZI7N2907Bzf5p5YvlY90TxQJUrtOC9R3t9YQH2PcadT1HVB+dMH
         7/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679463657;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbpEc0TShRb+rRNJad+coLk/gTeDzfl9QacMb8n5DBg=;
        b=niGhTnElwi/YGD59Yxn5yqbxDaXLZHI4jcD6fLrX+yh5Ijo6ZdXpySBd5fB+q/ck4X
         Swx/Tl6OblT/ZAuK01xvBqcr81L56zdTSRqbssaAYMe3dnFJVZfjDKDN+U+/P5P+KBSI
         dT0wXHg4ArDhmV2rsmHnAD7JOgHA19x/jvSZbbWX1X+kjngR7vESZf43DxTXcbZrhApK
         KBGN3Zfo4YUGjTpcoUOIGpuzqWaiGvmiQQ970ycoowl7P+NFQLPyRslY7ze9BDWPSnpF
         4bWCbqvDRpD9ldtUNvrxtAA+excT8b3Iv+6ygj4q249KzC5mdAmx4UmaRiBhXoO/90X9
         nVaw==
X-Gm-Message-State: AO0yUKVeYBlTIxJ2dowYHueiUCzeRl8NeI8PnJKFcfMpbLrCLLXUDViP
        peQph9yfT60oIy8MTj9ddgY=
X-Google-Smtp-Source: AK7set+NN53I6/4s45Kw4p+wbRQgS4uqcbyQ9nRR0hb5eWiEBtElyHIO/HgFB+LK8Hac9T4fmnjgpw==
X-Received: by 2002:a62:5255:0:b0:625:e728:4c5f with SMTP id g82-20020a625255000000b00625e7284c5fmr2018209pfb.22.1679463656765;
        Tue, 21 Mar 2023 22:40:56 -0700 (PDT)
Received: from sumitra.com ([117.245.171.219])
        by smtp.gmail.com with ESMTPSA id t10-20020a63f34a000000b0050f6530959bsm5905616pgj.64.2023.03.21.22.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 22:40:56 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:40:51 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v4] Staging: nvec: Remove macro definition to_nvec_led
Message-ID: <20230322054051.GA150453@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove definition 'to_nvec_led' because it is only used once.
Rewrite the code directly in the calling function
'nvec_led_brightness_set'.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

v2: Change patch subject and description, noted by
Julia Lawall <julia.lawall@inria.fr>

v3: Remove macro definition 'to_nvec_led'
    Change subject and description,
    noted by Greg Kroah-Hartman <gregkh@linuxfoundation.org>


 drivers/staging/nvec/nvec_paz00.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/nvec/nvec_paz00.c b/drivers/staging/nvec/nvec_paz00.c
index 8b4da95081c8..55d59840fca4 100644
--- a/drivers/staging/nvec/nvec_paz00.c
+++ b/drivers/staging/nvec/nvec_paz00.c
@@ -14,9 +14,6 @@
 #include <linux/platform_device.h>
 #include "nvec.h"
 
-#define to_nvec_led(led_cdev) \
-	container_of(led_cdev, struct nvec_led, cdev)
-
 #define NVEC_LED_REQ {'\x0d', '\x10', '\x45', '\x10', '\x00'}
 
 #define NVEC_LED_MAX 8
@@ -29,7 +26,7 @@ struct nvec_led {
 static void nvec_led_brightness_set(struct led_classdev *led_cdev,
 				    enum led_brightness value)
 {
-	struct nvec_led *led = to_nvec_led(led_cdev);
+	struct nvec_led *led = container_of(led_cdev, struct nvec_led, cdev);
 	unsigned char buf[] = NVEC_LED_REQ;
 
 	buf[4] = value;
-- 
2.25.1

