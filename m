Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFA665FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjAKQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjAKQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:03:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2F140BA;
        Wed, 11 Jan 2023 08:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22F9CB81C66;
        Wed, 11 Jan 2023 16:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B828CC433F1;
        Wed, 11 Jan 2023 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673453019;
        bh=mWy8M5qPl5LMzOqIgk0GZQ4ZdrhSE2SB1XnyEp+Kic8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=McDxVvZEZj/N0cumfDr7dy9mXT6cWFy8ln9OYAhcfAmai7zNYrYIYF3dXgtBeMd5P
         ojomDfBFPpCgnAIlpsW2CE1bDVm6opGs7XYgCp7YnjU0L6V9+NXWy9Xkw43T75vkUy
         wFyGmf2+0OWIeZSFUq1b38ctUEQDZGATV+n+KKYH2MEllZ7XEcsGFWXbfUZVzoQrO0
         fQMOqyCwDMQKF6GPkmVDb4SbG48aAmHDmFEEvR4DSTNfa0+Qv6uDGJqq49hQXhrq7O
         XgX6rFxmXzYDUP5MvbwYIlcAbEkSqmuCk9g5p4SXdKcfA4/7lxzO3uGOAkTJ71TVqC
         4obqbSY0WVeeg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFdZo-0001sS-Es; Wed, 11 Jan 2023 17:03:44 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: qcom: sa8540p-pmics: add missing interrupt include
Date:   Wed, 11 Jan 2023 17:03:34 +0100
Message-Id: <20230111160335.7175-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111160335.7175-1-johan+linaro@kernel.org>
References: <20230111160335.7175-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing interrupt-controller include which is needed by the RTC
node.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Eric Chanudet <echanude@redhat.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
index c9b8da43b237..8c393f0bd6a8 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Limited
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
 &spmi_bus {
-- 
2.38.2

