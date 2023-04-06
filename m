Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4206E6D9ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjDFRdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbjDFRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:33:42 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D458A4A;
        Thu,  6 Apr 2023 10:33:31 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PspWD3hrwz9sT1;
        Thu,  6 Apr 2023 19:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680802408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YF/etNDK2t5HamBKeM3tpf/XvMwanjxDdbNwri/RvTQ=;
        b=fOXVDM/o4o0TKCq7K2t7GPL886FDtwK1mOgG6uTZ6Eof5EiBhR7qblLd6UUmlzbHo0H16A
        XW3Ky4YuU52M79slRO+VmScpuDsg92GvSiiv5M8f6YGwSw/RgjJVLVPaPAg6JhDGPqPPy9
        mqyE4v6TWsWckRFiz1vBZ0TPVqxRSPt+4xAP0oLoZ8bmrYe8S+poy1bCPwWFmtFgEfh6ah
        dWZOVdqNPXNyK5Ndr7bv7D099nmYryRKjlOhpuSGIX7vyheYgQufViMKoy4bf3rlUamClT
        XzvOyKUpUXRq69iDYFsIsDW+H4cGqGqijciEHvIAtKZFgGIAzIiQfYf52hT2kg==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/5] dt-bindings: firmware: qcom: scm: add SSC_Q6 and ADSP_Q6 VMIDs
Date:   Thu,  6 Apr 2023 19:31:45 +0200
Message-Id: <20230406173148.28309-3-me@dylanvanassche.be>
In-Reply-To: <20230406173148.28309-1-me@dylanvanassche.be>
References: <20230406173148.28309-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PspWD3hrwz9sT1
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

