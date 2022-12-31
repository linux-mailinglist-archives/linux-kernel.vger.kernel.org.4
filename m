Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867565A431
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiLaMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiLaMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:49:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B1810540
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:49:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 124so15979857pfy.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8DXWGlRQXwEWsvjY0axdM/4CSvGdmhgjoXDmsx5XAE=;
        b=GKHfIO5/zPApXtAUOUA0aOVIZUwLAURpCXBHgDj1NR1eDpPZ8kJqGc9kYxtnJ8J6n0
         G7VioD9KKPNReKRZffb5YWGKGrwy7MKl3bL1EccIOeRJVGChBnOjTxOTdKusj1dAVoka
         lOL7EYDnoTSZwvhuUp0IvnnoufI2Gr390XZrZpzt8yzHrOuSQG1e2YC56zmxhAYmVTkA
         E3+HowNHFYPE/naF/0ShWsCbZHz2o5P478U7NMHJ17JVORUMQtc0IwnOS0FdMIDjmkQS
         +eFhB5UlvXPh8sHVCVIEuVaWIp38bOx52PZLr62+JWbPvPc/wGIH1Wbbq4N/oAOAGnp4
         csUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8DXWGlRQXwEWsvjY0axdM/4CSvGdmhgjoXDmsx5XAE=;
        b=fxFfszKEcRYniqwaElWaMfbg/9y1fG/5a62CKSdX7FjUuwRj5GmZ5dbaqbWcjD8r23
         GLBTPQ1v2/ByYrBJiSZaRHVlADn+482BjIYv4aHWabjv6yHb2kiXZETcHK3geX+i0s5e
         +1g97fC/hagXZ+RdsE1JP+jeY/ItE4bYs9UrJFiDKc7XmNH9/cR01MhphV7IVW6HLnr1
         WebFO99LVrZOda7m3jQaF3G82WmBpXrEmerTLJ7EumKVimPv2ByobeG99yevJu+MTzuW
         z4KVsPig+j/VvoOdgxL/wieW2zB18HFy4Y19+1TfsqiO5JYkR/N7LpytBAcJP/OB/Ob9
         k5XQ==
X-Gm-Message-State: AFqh2krpIA2M9MWabiXWEJqS4pS27RGBGE9ytnpDx3+0nVgmrz91nNCL
        AtDWUeGLgUr4vNc3GxQ0yzlLuQ==
X-Google-Smtp-Source: AMrXdXt4c0FpjWbTrXvCfeqQQBQwRmV7yv8JVygcOx12CA48lg1ae5I7PrwtSe5VDyzE/rqRXF7cSQ==
X-Received: by 2002:a62:b619:0:b0:574:3cde:385a with SMTP id j25-20020a62b619000000b005743cde385amr32875759pff.32.1672490942302;
        Sat, 31 Dec 2022 04:49:02 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id r29-20020aa7963d000000b005750d6b4761sm10337204pfg.168.2022.12.31.04.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:49:01 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        will@kernel.org, konrad.dybcio@somainline.org,
        catalin.marinas@arm.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm EUD
Date:   Sat, 31 Dec 2022 18:18:52 +0530
Message-Id: <20221231124852.3283597-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Now that the EUD (Embedded USB Debugger) block is supported on
several Qualcomm SoCs upstream, enable the same as a module in
the arm64 defconfig as a module.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06da..c43aeb936d9ad 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -922,6 +922,7 @@ CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_OPTION=m
+CONFIG_USB_QCOM_EUD=m
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
-- 
2.38.1

