Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C5638454
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiKYHPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKYHOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C22C676
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x17so5429533wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBHvqytCrBtvivGhRYRRloCxhmUV+fHQ0zki4mIHCpI=;
        b=EBGXpZ9QyUhu0bhSjg8t7PSJ+irJyOjBB05399ETElZxXwFDi1t6Lo3xt8OWwdp1DE
         zzn4wrcWclIKa42B27M8XnIoav9VOIc1l43PLHz+SHI5KeQsVIkaJmrfj/U+c331FE2c
         /c+SPyICJK3LWD3h01GvRhN4md21yvs43fe0BiE3AVrWDk8UqDa/NdDLCbY/vzOntFLB
         bQ4zR/Mh74/335FaBCwA+E48bmcOGxzG1d8kAFtPSv8Kpm/s3CrmlHeVTC3Y6alrBpq+
         qnZ3YKXRzGddGNLzLqxqfS+Gh/+P7O6CUp3Is+k9KFJfImrx4V/75JVvYpZtEGFYiWrW
         cl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBHvqytCrBtvivGhRYRRloCxhmUV+fHQ0zki4mIHCpI=;
        b=IzXTMwfKKFfXtdG7pdfmqR2sX93gSx8WFWxwfNpHwe87oayU6F9CrIY1At++Pk/k8A
         ItG0wblaeFUyrLpJ50VIvMoLfRaJip8D0d9IlD+J1SCDK/Vxdmz4a6t6D1uSv/oKBG+c
         ZozAeOi5kLunK1iq2VfHE5abgObv4Dy/x54VOuWFvc1KfVsVrtNjjlTBhCRaHHVB83vE
         0ABmMoca6/mWgpjYlOODLXSJ9zdgiI9nFC219gNF3Pqbpcu5/VA+xiR8+1OruAq+xiD6
         gqrYSE2uPD8I+6SIVkjj0xH+TT34LWR7uQvY+EyriUvESHKKjcWNfaEEq3GmqeHLdMwl
         5eIg==
X-Gm-Message-State: ANoB5pmkOXZOGKKvWU2OLinefXlOheohgmezeV46xqvRCNjXZFW0azjp
        GHrV9NuuWicPAHV4r1YLe9/ytw==
X-Google-Smtp-Source: AA0mqf5vBhKIIAzELnOoLwOeaxzXbQnwCGhFvAAT4o+1Xk90SpX+hP/kcg44E6CTeojc7/C+EUAOhg==
X-Received: by 2002:a5d:4006:0:b0:241:ed02:19a3 with SMTP id n6-20020a5d4006000000b00241ed0219a3mr6630833wrp.490.1669360485264;
        Thu, 24 Nov 2022 23:14:45 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 02/10] misc: fastrpc: Rename audio protection domain to root
Date:   Fri, 25 Nov 2022 07:13:57 +0000
Message-Id: <20221125071405.148786-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
References: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
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
index 80811e852d8f..f80a00e9f508 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -83,7 +83,7 @@
 #define FASTRPC_RMID_INIT_MEM_UNMAP    11
 
 /* Protection Domain(PD) ids */
-#define AUDIO_PD	(0) /* also GUEST_OS PD? */
+#define ROOT_PD		(0)
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
@@ -1889,7 +1889,7 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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

