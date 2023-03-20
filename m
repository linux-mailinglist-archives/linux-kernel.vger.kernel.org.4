Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF526C0EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCTKfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCTKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED318B1E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:34:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o12so44676634edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyXaHvh3PY8IHwl5GxLGbu71tlZc+pch1b8iVrCo6DE=;
        b=Jwy+0qPwMydtrSsA7hiXPSIDqNMOpvtGOOAhgqiSO9moHO6Q4QiCGhpMhaC/9Y5Kk3
         KQYALgaF5uky7GpG5hCJwlrJ9TRX+hJsTbkl+vOuDmguRD/HrjjT5fI1yMRcfclWfMkt
         ZNLlgVfWvZO/zDb3NUWLSHZ0a91vvdvhhGsm0QQYdEWiTuehI5jRqepQb7guqwi+29RI
         LHW9jdCeQpvvaFZnu3zhGPG/fs4Bw3Ag3wxkRvD9c0+pCx5TMdkM/YYNkn1o1iTf2BGk
         uOMohOBXd9qC3kHT7CY8lR0rErVqsG82eBYEU0dVRzK59FsZo2MJMkx1ZKKXTF2JW0VJ
         KtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyXaHvh3PY8IHwl5GxLGbu71tlZc+pch1b8iVrCo6DE=;
        b=MunU2/nkBfnMk1k4WpQ5YvVbFDdZpTH7tvc+EuKSbrx1/YXyKE2aAZJjTjyx3fL5ut
         AGmRbMFZWpcLkCKNduh5OuHVgZo28WNvKI3S8wEyqZTNVqubTn7yYQ3tqhrXBmnqceTP
         f/E9HxOSmbhnCRrKgbis9HV46twHJSlMLrnB/xJynIOA3sE0Nzwe1JCVfmK0jVoBERud
         EoN6bqLCg2mpyn9mqIIBGGRxmA3QiKgp4xZMoOVzViAmjEoQzmEymFC3K7whJ9tH7eQ9
         nh02wOl5kN7/sjZnVfCwhRJaOXFzKwZxwqShyHvARI4bgSQqLd+cN7YBQphkylkCAmrS
         gqhA==
X-Gm-Message-State: AO0yUKXJySs5DxUxaCWfavcCkyatkOmsrtcGB2ZBEg+jvLXazMXRdX7o
        fKCFSHiPDTvBxB+mR/LDG/Y=
X-Google-Smtp-Source: AK7set8VMIexuzwTt80bCQk0xyZfFdxp5dI3+Y+2HxYnpIV3weV+kd53E+ilO7xsF5pYTfGV/pcoiA==
X-Received: by 2002:a17:906:a415:b0:932:e6d5:bd7c with SMTP id l21-20020a170906a41500b00932e6d5bd7cmr8915480ejz.20.1679308442507;
        Mon, 20 Mar 2023 03:34:02 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id v14-20020a1709063bce00b0093344ef3764sm2340213ejf.57.2023.03.20.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:34:02 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, parthiban.veerasooran@microchip.com,
        christian.gromm@microchip.com, u.kleine-koenig@pengutronix.de,
        peda@axentia.se, srinivas.pandruvada@linux.intel.com,
        sebastian.reichel@collabora.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] staging: most: use inline functions for to_hdm
Date:   Mon, 20 Mar 2023 12:33:56 +0200
Message-Id: <20230320103356.6498-1-eng.mennamahmoud.mm@gmail.com>
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

Convert `to_hdm` macro into a static inline function.
it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell
what type it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/most/i2c/i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
index df53a4c4f850..4e85e681922f 100644
--- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -44,7 +44,10 @@ struct hdm_i2c {
 	char name[64];
 };
 
-#define to_hdm(iface) container_of(iface, struct hdm_i2c, most_iface)
+static inline struct hdm_i2c *to_hdm(struct most_interface *iface)
+{
+	return container_of(iface, struct hdm_i2c, most_iface);
+}
 
 static irqreturn_t most_irq_handler(int, void *);
 static void pending_rx_work(struct work_struct *);
-- 
2.34.1

