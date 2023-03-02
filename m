Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16EC6A85AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCBPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:53:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494C39285
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:53:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id az36so11018100wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677772437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvbR7fimjAM8g9O+K/rmvPUZlmIz9bdR8QApkkfwSgQ=;
        b=TDHawV3Q4wpN7RPnbGPNZhglQcgSt/NKqlq5JkduYoE7R9xZUsLT2Z2etCOolHSXaE
         PET7TxSASpCm7h0LJGPKk0jSQWq6o+2Y/cRb8xFnbWCui8MUDU9ILPePkb7ZfzTr+Mgh
         0uueWNjouuD72Ts53rBiEkEDq2CnBuwXVNwWAnvOZjyOzmwaZYA0RrevCF8Maf36kmo4
         dAc2p7F0+ZdbArdzU1hqhX/5+yjMAIwV97KNssgOI6fqKZb9tmzdUd0WGh8H+z0ybjV5
         KRxs5vNiKXkRgNvhPGGBx00FtvM9yTinxgvFbvqQvBuriZON1fMrgb4OP50gXrjl5YXF
         sCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677772437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvbR7fimjAM8g9O+K/rmvPUZlmIz9bdR8QApkkfwSgQ=;
        b=hxiDMdDPI6FbXrl0N13uhNPBABQ/XI4ClldT+8j2EYcSCXL1NkoEdxe8t9p5u3ktuk
         xJNOMJQNZOnEL7jslwckaCLFst44zHLeiF9KxvAW+ufQDb+4kwGCRUPiAp5sC/JppZdo
         n3odj2e44YHF5amPl5Ax687ImyhP6VKRar5HC0UPq07Y7Wx/CTR/OCQiIrWw1qkY4EJo
         AXnIIkXbk9iZgH+6LJngPqztPiNPhgji5DurUB8ZBx10XYEQkrMgaLDeL6UgJgpkNPVh
         BgNAZqaTBP1tkbgpJrLgL5KofDhnO1oBNNaGDcV/+pOz+diMkaxachojTGmlDzVD2i2M
         T6tw==
X-Gm-Message-State: AO0yUKXO0UivHRjJ5BlYGiQOsj/VTl/pbELHAXZBC30flTyjEYSyqKEw
        IcMEzcFC3k6ChANGrdcpSOrjJA==
X-Google-Smtp-Source: AK7set/XDrLwnIFM4Y3N+oYIPYZrLqgsI8D4HxoRzq4IsH8ADnOBiODLULXqO4vu1E/sGnoJP3J8Pg==
X-Received: by 2002:a05:600c:1652:b0:3eb:2da4:f32d with SMTP id o18-20020a05600c165200b003eb2da4f32dmr7859147wmn.26.1677772436834;
        Thu, 02 Mar 2023 07:53:56 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b002c6e8cb612fsm15272179wrs.92.2023.03.02.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 07:53:56 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.elder@linaro.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH] MAINTAINERS: Add myself as CAMSS maintainer
Date:   Thu,  2 Mar 2023 15:53:53 +0000
Message-Id: <20230302155353.3361129-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
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

I discussed with Robert a few ago lending a hand with CAMSS. Following up
on that discussion, I'm happy to help.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 409eadfba007a..ebb0228eb4ea1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17156,6 +17156,7 @@ F:	drivers/net/wwan/qcom_bam_dmux.c
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <rfoss@kernel.org>
 M:	Todor Tomov <todor.too@gmail.com>
+M:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/qcom_camss.rst
-- 
2.39.2

