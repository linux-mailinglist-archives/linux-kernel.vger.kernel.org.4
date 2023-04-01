Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E46D32E2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjDARfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDARfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:35:45 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B18AE192;
        Sat,  1 Apr 2023 10:35:44 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ppkp52RBnz9smY;
        Sat,  1 Apr 2023 19:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680370541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZhIwR0pdPe/UTS9MWWLjnRfXYvEHH8+DAyaIYA4HTw=;
        b=BRcZH3lbbT9yZT4YFUG6W5dXNXkKYVbvERdY04iv80/Iz80tM+5eWd8LasyJRd5SQaT6M2
        I21W/56EBu/ouMDON+nPhB+/Inbtb2LePNbzV6aOd/SP+yvB7iDBuNIa2FWHetK6QeDrNy
        X0hw/EPwA3gOP2v2193kHWuDzuyIKSchDGFvjAlkSFP5hi66kejE5EJb1ALtVrBFdl6Gjp
        52ByT5gI9rvPSDFj6EZv6GRolILh7qRuQFWDDqjntUi64/ifbvWyTo52kOobhrv+HQ4AFo
        nLy6dBLBHnppQ1AO82qtDUsQpswSa/bN/36Fivb8Tdv320kP3Ys+QsjtepIeFg==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v4 3/6] dt-bindings: firmware: qcom: scm: add SSC_Q6 and ADSP_Q6 VMIDs
Date:   Sat,  1 Apr 2023 19:35:20 +0200
Message-Id: <20230401173523.15244-4-me@dylanvanassche.be>
In-Reply-To: <20230401173523.15244-1-me@dylanvanassche.be>
References: <20230401173523.15244-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Ppkp52RBnz9smY
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSC_Q6 and ADSP_Q6 are used in the FastRPC driver for accessing
the secure world.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 include/dt-bindings/firmware/qcom,scm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/firmware/qcom,scm.h b/include/dt-bindings/firmware/qcom,scm.h
index 1a4e68fa0744..d1dc09e72923 100644
--- a/include/dt-bindings/firmware/qcom,scm.h
+++ b/include/dt-bindings/firmware/qcom,scm.h
@@ -8,6 +8,8 @@
 #define _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
 
 #define QCOM_SCM_VMID_HLOS		0x3
+#define QCOM_SCM_VMID_SSC_Q6		0x5
+#define QCOM_SCM_VMID_ADSP_Q6		0x6
 #define QCOM_SCM_VMID_MSS_MSA		0xF
 #define QCOM_SCM_VMID_WLAN		0x18
 #define QCOM_SCM_VMID_WLAN_CE		0x19
-- 
2.39.2

