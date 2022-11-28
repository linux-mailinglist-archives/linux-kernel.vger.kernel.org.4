Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A102063B2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiK1UJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiK1UJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:09:04 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2681E0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:09:03 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w79so11604635pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef8A7O2qxzSTmhR856PPdqttVXha7QPYjhgtijajRFA=;
        b=SIZ4d1BnQA8JU7BstQ4YLKZaDCIiOstCz6W5e4A3fNCKMrfKTx67tF0CgOS0XSFf7o
         JVwCqSoCtWg64tpkP/2KWQQQ+V69punEUGw2gV0+yqFHjEa/9Lo6xOGJtE4DpU+clX3w
         mWElfuZd7I3QnxVYaBUtlCb6s2iVgEkATfyCc/M6zt8TyKQkCKP3Cn4iI/X9vXA1E0/A
         n1u4Fm79OhrfuV8DPQ+SQ5AhjFDDs032y3/umeyxX4HELHd3Mr/Fx7y6IxxrxYZKswbf
         ZHYhpU+ECRk+OUNIEQSzWuoOnX2v0YwRl/FRIuH3JByKvcJB7np3mEQNp3WBbz07yPoh
         I5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ef8A7O2qxzSTmhR856PPdqttVXha7QPYjhgtijajRFA=;
        b=bsFEn06MvzGFhasqk9VTJDBYEpR7992i0Rjxe8rg4WKraCE3z4jEaCjec8OXcpKBTg
         BXg6LmJqiYkJFxEeYfBHovXNk1lAjZo0nUcz2OUtVXUFL63WoTBSSP2EQx93tgFi5KHu
         0bjMqX4jxx/VUgK77sXHrkulbutdeUDQ8xf/dsoQGpM4DB4ZE/wxNGkLoBMLObfC2oE3
         pWh25kDJkSDdS36H0G5LbaIdxDl5HVRBLCsgiOe9ibLc2psR49V+sbOkIV/NBS/bFhsv
         kLhQrPBOCk/qyFWsFYo7G8ZYlnUUIVHM2pa3w6QnRUJF5hlzf9VaAYZohAVopg9FGOk+
         FWqw==
X-Gm-Message-State: ANoB5pnx/YQAdU+FsB1VmN5NoLVU2sZ86pggjAMRrj3hNUOxw7Nv7u8t
        DP7P/IM9kV4RixXX0aZ7LvS4jQ==
X-Google-Smtp-Source: AA0mqf5GWz2T7utKo5DSWCX6D1NH6Ua6s1PNODl5UGZhNdP31g+TwJcFYAlRAKjU5zfTWyPKoEKmeQ==
X-Received: by 2002:a63:4910:0:b0:478:27a1:8602 with SMTP id w16-20020a634910000000b0047827a18602mr4688389pga.9.1669666143166;
        Mon, 28 Nov 2022 12:09:03 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f3b:2d41:78ce:bf75:900:30f])
        by smtp.gmail.com with ESMTPSA id m16-20020a62a210000000b0057564323987sm473113pff.139.2022.11.28.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 12:09:02 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        will@kernel.org, konrad.dybcio@somainline.org,
        catalin.marinas@arm.com, me@iskren.info,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SM6115 / SM4250 GCC and Pinctrl
Date:   Tue, 29 Nov 2022 01:38:34 +0530
Message-Id: <20221128200834.1776868-1-bhupesh.sharma@linaro.org>
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

Enable the Qualcomm SM6115 / SM4250 TLMM pinctrl and GCC clock drivers.
They need to be builtin to ensure that the UART is allowed to probe
before user space needs a console.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 03b61f846a0e..851e8f9be06d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -560,6 +560,7 @@ CONFIG_PINCTRL_SC7280=y
 CONFIG_PINCTRL_SC8180X=y
 CONFIG_PINCTRL_SC8280XP=y
 CONFIG_PINCTRL_SDM845=y
+CONFIG_PINCTRL_SM6115=y
 CONFIG_PINCTRL_SM8150=y
 CONFIG_PINCTRL_SM8250=y
 CONFIG_PINCTRL_SM8350=y
@@ -1106,6 +1107,7 @@ CONFIG_SDM_GPUCC_845=y
 CONFIG_SDM_VIDEOCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_DISPCC_8250=y
+CONFIG_SM_GCC_6115=y
 CONFIG_SM_GCC_8350=y
 CONFIG_SM_GCC_8450=y
 CONFIG_SM_GPUCC_8150=y
-- 
2.38.1

