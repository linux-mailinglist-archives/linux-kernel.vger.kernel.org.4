Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17EC6C8E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCYNoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCYNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:44:32 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AA113C4;
        Sat, 25 Mar 2023 06:44:30 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PkL0W40KBz9sZv;
        Sat, 25 Mar 2023 14:44:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679751867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egp86lPSAVRoHmUI43dTRCeOVXvgb3RGUlpfI0Vk4PA=;
        b=bRbRi8GmlCcub2pA68xfLa+vh5b+s+MRzOsU1UX0hkaBml3By0iR4T5sexKIdmrh9OtZ8+
        enyQVMYOgMy9kHeX7N9v4qJO58Ms8wart++vVDf1O+0IP1A27dOmTq30zlnNesObAyio7a
        IepYHY+w4PR0UGnoLF6K0DvhUgfcce94GeErVd3Vz45EsWyiex+CL1QNarAD9LUl/4JdXG
        yJ0L9EmLngPJk3FGnz8EA0Q8UwdZ5XgohTszdS+ZbdSWU0mxziVikORsnJOFDUPwCO/vZI
        hC2Fk+mFVG8KV1jY8LNfOkbZmvAeTTvw+PaK3DtFzK4U/YZ/Rg23jxqyn236Xw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 1/2] dt-bindings: misc: qcom,fastrpc: add qcom,assign-all-memory property
Date:   Sat, 25 Mar 2023 14:44:09 +0100
Message-Id: <20230325134410.21092-2-me@dylanvanassche.be>
In-Reply-To: <20230325134410.21092-1-me@dylanvanassche.be>
References: <20230325134410.21092-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PkL0W40KBz9sZv
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the added qcom,assign-all-memory in devicetree bindings.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 1ab9588cdd89..fa5b00534b30 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -57,6 +57,12 @@ properties:
       Virtual machine IDs for remote processor.
     $ref: "/schemas/types.yaml#/definitions/uint32-array"
 
+  qcom,assign-all-mem:
+    description:
+      Assign memory to all Virtual machines defined by qcom,vmids.
+    type: boolean
+
+
   "#address-cells":
     const: 1
 
-- 
2.39.2

