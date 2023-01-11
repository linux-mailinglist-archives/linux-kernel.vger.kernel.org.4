Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A18665604
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjAKIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjAKIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:25:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C413D1D;
        Wed, 11 Jan 2023 00:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDED4B81B33;
        Wed, 11 Jan 2023 08:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86071C433F0;
        Wed, 11 Jan 2023 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673425484;
        bh=BPljOig+xKy24pgRlRnkd1G+bk5V6isDCXGiuoL0TY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOdJSFKsKlY2dfI9dkvFIv+k+CHMWLwV+5dy07g6cb2moEOiAblx09bNYQlzUuF/l
         1ckzGFbBAJzbO48IjApOCGwfhEy3fUn4rC12QcfZpNXs3iJHtN8zdWo1wzzJSvyk22
         ZfLSGIuMVntAoZ39h1kqVX6tQbETbDYAxU+h70A/H9rXJH8D5VfxRQPri3MYxyaypx
         vy5UtC84k7W0h0oGruHBxfyedt3n8HLqYMQyuK5zLm35VDfhXDLMYquyxozHg899j6
         ISUo/MgBiwZA8sXtE/ZRJWQUaZj2hi9xZmSYhQ7a4gm9jw71IqtGnoN5Nd9tYQq67w
         OkQXmhZ/gBeYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFWPd-0005OY-AW; Wed, 11 Jan 2023 09:24:45 +0100
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
Subject: [PATCH 1/2] arm64: dts: qcom: sa8450p-pmics: add missing interrupt include
Date:   Wed, 11 Jan 2023 09:23:30 +0100
Message-Id: <20230111082331.20641-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111082331.20641-1-johan+linaro@kernel.org>
References: <20230111082331.20641-1-johan+linaro@kernel.org>
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

