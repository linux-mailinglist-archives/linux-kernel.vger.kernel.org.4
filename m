Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE84637E96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKXRvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKXRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291AC1F77
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g12so3434511wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHd3FytA/femKWEdUMvYef6FMWectBCCK+YzjMDjemI=;
        b=V9bTAl4Xw4U+QYcQYY07x2tfUjk6lRtUoU+gGn7nqddBgYA/ZDwzrxXdB6wlqbYU81
         TCb6yJJUMKcFB3jMT5ahJRV6lFp61tCX9VikYauK05qiHDTesWzCXf8LQhFQId3OhKPf
         e76x3r1opcjFNDS8uNBhtGxe0ogG3CXqiE5VLr3kYljmEUZLcLJDqWC/z70tb179TXJM
         Wg3M2xEM9uVs1VOCdv/yC/rrThnCK1+jYnWZI0zITbAYGHZakwbK6debzRZZEH/xwh9N
         +FvA7RVNprZupUrJzbMhQb+J/ERmZv0eQEKLmU9EuXWAxZhoHp+A/03kG6wNefBND05I
         jPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHd3FytA/femKWEdUMvYef6FMWectBCCK+YzjMDjemI=;
        b=xe+gEmXEE4S1AyeLHhfV24k2dI+bA1l3FxCmvOSVP1uMYDK1LTHZI2lE6KRPWMn5i9
         vaoAYaHuZUJxS3tdR2d5x8XIg6jHAqVXXUu2WOdHFSJ8lGa3+xll5PPzP1b0jxLcpi0a
         hXQ3NVQDKcCtL9NhCmsG1t0MQgPVLcoetK/TAcVOmCD3R80uy2aFB02pq4Whp6ZoU6h4
         xwj2L1CCA2/1aui1jvj7dN9Ph489JdXYY+tFf2c62DOIj3qKiJ3l5Hhexl2rAY6c5UQ3
         TT4ZH6l2WV72fJIQY4dSTtP0edzVyosti/KOe1H2yesA5fFSSBIcpXfUqS8KTpcOs64U
         sdrg==
X-Gm-Message-State: ANoB5plWRdG3piGicmuk8iNTgVluzng4LXMnUIfbXwSmNhi+tVQAPcnR
        FiaTnjeG0DRPWRC9b8cYFNFbt1Zs3D1ZPA==
X-Google-Smtp-Source: AA0mqf70xiOZyMF3AXAgI2fvs8pBe3Qwu5mRd1W/dUsUgAIpSIUO9xMd95vUyCy/ivu1Gzh83kU55w==
X-Received: by 2002:adf:fcd0:0:b0:241:cc8a:7445 with SMTP id f16-20020adffcd0000000b00241cc8a7445mr10879237wrs.521.1669312301030;
        Thu, 24 Nov 2022 09:51:41 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/11] misc: fastrpc: Rename audio protection domain to root
Date:   Thu, 24 Nov 2022 17:51:17 +0000
Message-Id: <20221124175125.418702-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

The AUDIO_PD will be done via static pd, so the proper name here is
actually ROOT_PD.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c6b9ddaa698b..545b7dea68bc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -84,7 +84,7 @@
 #define FASTRPC_RMID_INIT_MEM_UNMAP    11
 
 /* Protection Domain(PD) ids */
-#define AUDIO_PD	(0) /* also GUEST_OS PD? */
+#define ROOT_PD		(0)
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
@@ -1892,7 +1892,7 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		err = fastrpc_invoke(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
-		err = fastrpc_init_attach(fl, AUDIO_PD);
+		err = fastrpc_init_attach(fl, ROOT_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
 		err = fastrpc_init_attach(fl, SENSORS_PD);
-- 
2.25.1

