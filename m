Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7566731E57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbjFOQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjFOQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:13 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11726295C;
        Thu, 15 Jun 2023 09:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847857; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HII6CaEfPfY9I8npVL+uNhpzkGgJxJILSDFzzhD6gX1YuhRuzAX4bkjL728hK/umiT
    bvUpg+R6R9IFQpbQyGzvaKtR5TV+mU83J22I4ekkCg5iYkbW32/1DdiMS2v5w4mLZF7h
    J2SclRSdBW1/0DiDIbtXx8vCKgA04bTESF6o8vjWaVL4rODRX5zyeWagMUIitaOo6PvN
    csTDq0tNtenehr9zmy+Yvb4FZj0deo38k6CN/t8dVG0v3n3F0yHfTmwgykJqRWPQOfEI
    EAPETpEypVB7ov47ReQ4V6wBti1wD/sWkNmBuOr0ZLpzNJJCSZpNxo5R5arCfKpWoDGb
    PaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=K48pbbaDvIU0qCx1fn2eZU+dBmyCQ+5LoqGBbasUvkc=;
    b=ZGTsCH8BU0+apnkqv1swsoM7HKPMLV5PZqnOuediPDM+4AyGcmlqZvp4xc2Dr4/HoX
    +/xJUOKZNhTMM6U92TZiw1UVlCB1Dw6+i3h8cZBm9MZNXyqBn7Fb4sIe2oWUpFs9fXrc
    v1OZqvrneP7H2ex3o1mi+KaIOfrR+bwz//hdIXACFXWSdhmmGQCjk5DPEZtsExALu07d
    KBzwb2p2o0bCNIuc63r0/Xm5pPmLkw4LtzQ3FtSj3CIP4rFLjqBNwsOnobn6rafw3RpY
    QRWuGqpoPPXoBqbm8TGAUrAO5m7cZmqdxqra6IPYbwiUJV+bhxiJ/2+m3KINIl6dGZTZ
    5DfA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=K48pbbaDvIU0qCx1fn2eZU+dBmyCQ+5LoqGBbasUvkc=;
    b=TCjUsfHDl+S9wgWEKYJ9omBYUgBagteqCuCxYTwX2EI9iY0OkGra18QCrB/dwceo5b
    L1J+dVRhjo9QbC3mPSfbrwPEoQMwiqGtqfwP6GG+kGoP21PnD+i81EFcYUVDHVC/6CXo
    4hX7GPgs3OdGPgUL/L02RpOa2ek6KLm+8TbyMwM0kek7mz3E7DDVzk3zjsFCnZCSGJBA
    EC8kfXxescGtlum1UINyvcNuy6KznFUYuTe1IqNI7g2zWaC10IL4w5qWugn0bTNXxNzI
    BUlPgFftRxvIgXqPWC1qtM5gCqty7rScmt9/3BHj/2/Is8wun0xmXboE5dMv1VgbnLrE
    a4rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=K48pbbaDvIU0qCx1fn2eZU+dBmyCQ+5LoqGBbasUvkc=;
    b=BOh5kB2C6FmxeBUbyxxpXFGfUftRHVBQhnq7FzCodRGvpC+9uZCQYbM+XM5nss7a/A
    nKgnqAROusBaMrOegvAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGou42i
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:56 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:40 +0200
Subject: [PATCH v3 07/13] soc: qcom: smem: Add qcom_smem_is_available()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-7-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid having to look up a dummy item from SMEM to detect if it is
already available or if we need to defer probing.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/soc/qcom/smem.c       | 11 +++++++++++
 include/linux/soc/qcom/smem.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index b0d59e815c3b..29193151cf4c 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -359,6 +359,17 @@ static struct qcom_smem *__smem;
 /* Timeout (ms) for the trylock of remote spinlocks */
 #define HWSPINLOCK_TIMEOUT	1000
 
+/**
+ * qcom_smem_is_available() - Check if SMEM is available
+ *
+ * Return: true if SMEM is available, false otherwise.
+ */
+bool qcom_smem_is_available(void)
+{
+	return !!__smem;
+}
+EXPORT_SYMBOL(qcom_smem_is_available);
+
 static int qcom_smem_alloc_private(struct qcom_smem *smem,
 				   struct smem_partition *part,
 				   unsigned item,
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index 223db6a9c733..a36a3b9d4929 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -4,6 +4,7 @@
 
 #define QCOM_SMEM_HOST_ANY -1
 
+bool qcom_smem_is_available(void);
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
 

-- 
2.40.1

