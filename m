Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592D16C01F2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCSNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCSNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:11:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523CF1E1EE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:11:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t5so303384edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679231489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDHj4DvxjjAkmG31dhlk4CsUuKafohdFgFwjCU3khL8=;
        b=SpupAaCobj8+gF0IB38Y8jJXFWQpYJHi6h8rsvEHgRv9jc0yQCSGes9EzeHfkZmGLH
         lSmiO2eAe43u9x+2WkGIsgmYP+F/tXpiZ5eJxB+Gq01YaoqRvGRpAtyObMTvSGvFwQuI
         dOaCgP7pyz16CYK8kFvXtkUbnahZyk2Iwzj2rRyE6WrWrE+ug92Ez0hCL1WAB1/QmDqP
         skdyJ15G+eXiDuyXHFP1/9Xt0Iywk11PmNlw26JPOz2SNLrRm708c3cXedF9/zy7GfVN
         812EaDXXOFW3mfq2tRr83Ld1SMWPk0XWzl/CfI/oPUpGesUSFMKNN5ABCGYrJi9hCfP8
         TbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679231489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDHj4DvxjjAkmG31dhlk4CsUuKafohdFgFwjCU3khL8=;
        b=BcHuga89OLuOC0Ygsrabl0h9svI/m8Ul+5n3Xwia3HKr/mzRP6rGteaHx0op+FQG9u
         7Dou5wsO2hX+ZdfGaZtKzGO2KY5yPvkUhMz9bErDaa7yIy20Oruvi9B2FoD1eL6RRQ/z
         n8pYF8OxE92/pnw6k/kISDlwrn0EbBRKhlgsGV/RglVrfHg1qIcNq7DIR7A+l1Z5QqqU
         OIcXB1ugpSoUsT0gibncloeoxD73UJEVMUNEXNk8eTrLDR17uEeem3/25pIdtrfBSsLc
         Pf8XKC8+CKSyrLwAVynskshUS1XWfp7lzyhikEncog1Cdouek1HrZIFW0DE+DAwWxRo4
         zYYw==
X-Gm-Message-State: AO0yUKUMAjl7dNmyLwosdx69JXbIiJsZb++KFUk1zyB0P1sgPur91rYS
        V/FD/sXCyF215qoj2GyedWg=
X-Google-Smtp-Source: AK7set/nr96keMgLA/H/r8hXyMIVmxQUuqdUMsdY+x/AB+4XhEY9KeBsPx3GVRDwdUluz9L/4hBoAw==
X-Received: by 2002:aa7:d782:0:b0:4fd:1cf1:b7b0 with SMTP id s2-20020aa7d782000000b004fd1cf1b7b0mr8581529edq.7.1679231488796;
        Sun, 19 Mar 2023 06:11:28 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004af6c5f1805sm3497671edb.52.2023.03.19.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:11:28 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, namcaov@gmail.com,
        straube.linux@gmail.com, hdegoede@redhat.com,
        julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: rtl8723bs: include: use inline functions for dvobj_to_dev
Date:   Sun, 19 Mar 2023 15:10:30 +0200
Message-Id: <20230319131030.151170-3-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Convert `dvobj_to_dev` macro into static inline function,
because it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell what type it applies to.

One can get the same benefit from an efficiency point of view by making an
inline function (concretely, typically a static inline function, because
the definition only needs to be visible in the current file, or in the
case of a header file in the file that includes the header file).

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 82159e1c7f9b..ea6bb44c5e1d 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -305,7 +305,11 @@ struct sdio_data intf_data;
 };
 
 #define dvobj_to_pwrctl(dvobj) (&(dvobj->pwrctl_priv))
-#define pwrctl_to_dvobj(pwrctl) container_of(pwrctl, struct dvobj_priv, pwrctl_priv)
+
+static inline struct dvobj_priv *pwrctl_to_dvobj(struct pwrctrl_priv *pwrctl_priv)
+{
+	return container_of(pwrctl_priv, struct dvobj_priv, pwrctl_priv);
+}
 
 static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 {
-- 
2.34.1

