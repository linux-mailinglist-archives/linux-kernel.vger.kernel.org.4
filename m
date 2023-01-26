Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBC67CDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjAZOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjAZOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199E511677;
        Thu, 26 Jan 2023 06:22:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAB1161847;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A826FC43323;
        Thu, 26 Jan 2023 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742977;
        bh=+e6vabk7nnIxKnRB4DqirjDl+9Kx3GaOJxRWKeLLfb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjJB62qscy8LcgCb/9NniHw+V1AN4aTmdvyP7U3LXDGUv95N47VxOkiaBlK3paSrL
         rcjTE9yYmN/+gOzvz/fyRJy4SIgmc4xh1EZlq8bj3qgVwnW20XROWy6XhIG0zcQmuJ
         fdalaJn7BuTpa3kmdPUmQwpSyxFa5OGXTK76ZSM7njEVbZwr1pN1TRGGIeRd3BbHNr
         DvTLMffxuKc8gfQUuxS2lXQZVf8tH3R9/csZeOh55aSkltKjKsLUyshqKt711fn+RJ
         5FyjhCA3N5VrXQFF9eoPkNjYZGLqdcuPtg7+Z8pOzgRFFXTLHrcfbjXNmWzTnPni3J
         V/aJg0OtUa4Ig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39c-0006iR-Fq; Thu, 26 Jan 2023 15:23:04 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/24] rtc: pm8xxx: drop unused register defines
Date:   Thu, 26 Jan 2023 15:20:39 +0100
Message-Id: <20230126142057.25715-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
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

Drop the original register defines which have been used since commit
c8d523a4b053 ("drivers/rtc/rtc-pm8xxx.c: rework to support pm8941 rtc").

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index dc7e659cbb2a..90027a7cfb12 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -12,12 +12,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-/* RTC Register offsets from RTC CTRL REG */
-#define PM8XXX_ALARM_CTRL_OFFSET	0x01
-#define PM8XXX_RTC_WRITE_OFFSET		0x02
-#define PM8XXX_RTC_READ_OFFSET		0x06
-#define PM8XXX_ALARM_RW_OFFSET		0x0A
-
 /* RTC_CTRL register bit fields */
 #define PM8xxx_RTC_ENABLE		BIT(7)
 #define PM8xxx_RTC_ALARM_CLEAR		BIT(0)
-- 
2.39.1

