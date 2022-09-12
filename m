Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F735B52C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiILDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiILDJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:09:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6E19C01
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 20:09:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l65so7303176pfl.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=mdl8XgmiG77dwbon52ItuN/g+RWXx2u1KcfNUTh1b40=;
        b=POOfRvUi7nqTjZF1fOgMGtFeHkQNFiv3fpNyZRz/ZVRqT8i10wB7I6CyVciDERnnqu
         RfWcaWEqNR7f1NbYnRtEKo6CTdyucSr8dyIHXy1Ppi4q8fC82gt/1vrnqnHhrnV9xIP5
         GSXSAyuFzhpJxnbG71M2nU2ZWKZYcmQVF5o3Lm8qBvefhKAeZl5esZlkGAlDjVdDCkMQ
         9n5OGqqpcIIODtl51X3TlmbVSs9mlCETEeoK0KyQ7sfCQqiaeVM753e8PxdI5ZI4KTMH
         edYHL6d8lrGTnXbwilDKOxmwh5f6vWNjostbugiTaQ0pHxcURFURVO3hD2CJ8XE3TEGg
         +0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mdl8XgmiG77dwbon52ItuN/g+RWXx2u1KcfNUTh1b40=;
        b=VsZVZ8w4S3Hp0nOQ8F5FDWxDxskjb0ta/TykwRlwrgGB85O6nl+zP9cJ+KLAEEonQp
         IXefpKLmdYyze65htMrs7h8CuUoHdXHskJRoKbx9wS1WH5Mx/S6oEelEWzyBBw4Pylfk
         NMmxC1k3a6rrwRCPU8fHxgfkB3KFtPi5FlUx1fAwxuboGNgukUO6ZegEv8pbCEaMn32q
         +TwxyztdbrEVEt5Sci/+qPVPgX9nYUPirEtdHkREAHETPKIkPklKL+bkaR9pZsYdxc/H
         23zAflKSvNXQTzqtv8+gRvojYAGJBu4xkcMs9r0VfqpVwjzP/q/vSgL8q8Kz++9YLKhm
         K2/Q==
X-Gm-Message-State: ACgBeo2GuUyoxSf0sQg3jbzPk0/MmNP/+ylN6UxkY8QjqHvTEfV70/kf
        fL4/+WUH1yXhtcLRyxG9lqk=
X-Google-Smtp-Source: AA6agR79kJpkWqBTAP5VZ0kAKihSaghHJzzGJ6m1wn2jGtjehmhPMcam/orZoPkjalMGUKNvNrBhLQ==
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id d15-20020a056a0010cf00b0052848c379e0mr25362009pfu.18.1662952157653;
        Sun, 11 Sep 2022 20:09:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902c45400b0016d72804664sm4580633plm.205.2022.09.11.20.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 20:09:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ARM/footbridge/common: remove duplicate included header files
Date:   Mon, 12 Sep 2022 03:08:52 +0000
Message-Id: <20220912030851.16130-1-xu.panda@zte.com.cn>
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

From: Xu Panda <xu.panda@zte.com.cn>

asm/hardware/dec21285.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 arch/arm/mach-footbridge/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 5020eb96b025..66d21e348e0c 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -30,7 +30,6 @@

 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <asm/hardware/dec21285.h>

 static int dc21285_get_irq(void)
 {
-- 
2.15.2

