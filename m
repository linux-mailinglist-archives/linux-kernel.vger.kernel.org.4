Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1D72786A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjFHHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFHHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:23 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4091BF7;
        Thu,  8 Jun 2023 00:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208273; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cHyUcK6Q2piv2uaBXSqbjUXNHJvIKxOfYT2p6T0nyS9t5UtgOG+C0d1ggv6IHGrDng
    dKmuwCBEQc/DNFFwhBJL9FV3K+kMCq+NYWr81bWgZgMf3C2pG6qfxEyNIL85VBlsaj3L
    JsoiJMK/dF1T9S6V/6xJBouKy1pxf9a8L4xlryxqSPyLZDWwvfuCWUGQlIuCF0HPwsaD
    BO/0Q1h6iSV4P6LxiRUwLMSsl2kTHyVGMum7Zlw6bYWiyzgtMA2QRaJyv5wnYRHA7rFv
    77Y1WuVzB/FX7NOtFRMrqpjtFaWWIEtZ4FYsjDwbHWdlSA3DPXWDUAmZfHPzYhZnNLSm
    OQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=K48pbbaDvIU0qCx1fn2eZU+dBmyCQ+5LoqGBbasUvkc=;
    b=CzIK6SuqxcNyL0uaG3pGGQby2vw10zcWivynrDCtzErjBSjL7ybCy0qxai7QTOiYJW
    O9mUknOhHo0hcQ9R64/rq6X8E/XUE0oxuZX3/LV7XI+KBIU7OY+57XH7AMn1BOiaGIfz
    D+HClwzmRI53CSlpSmOlvVxIG6Qy2v4uIsfJWAI0/3kgAYJx7QSUPVGO8UxO4AVFhAlx
    Nk/x3NCYKKyUp7mmfctBjJbQGgxABs2UFvCpRyEbglESKrABia/y4W5AFXNUbNDpS0KB
    0UKo+n7AlGXezBMxNYIPpFLBEGI4y4uZTzqStEDIAOzGslc0rL2EJLnAxWgczsG3E5AK
    FdOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=K48pbbaDvIU0qCx1fn2eZU+dBmyCQ+5LoqGBbasUvkc=;
    b=MHAoi2GR04BgvERD04BLA2SQeze+OCH1wnhsCMomEXGFqNWOXCPmweqHqICXWg4Z6L
    IutTEOXmA+WSFFRE4GeTkwKuGSR9mqIx053lpZ2Hk7Sk1Vj8XhWZ0aOcK8aDt90jiKDe
    tFMADLuF7CtKJnlgmxgdCmf3+eKc/MLhcrFwSdrzAix1S9UrODABmg7FhB5dbaKY4w2c
    F3JOxhkEse6frv4JkZmPxjZ3ECtZ0MNywvPTk9Z5EEhzFAK04VvhAM7/ETzUmlqz8knv
    VCUP6z8HNRz9q0sgIiUdiX0IhYb9CQNWYVj2gfHdExb/sEV3S7211g/EDNkJTgLKClto
    qbpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=K48pbbaDvIU0qCx1fn2eZU+dBmyCQ+5LoqGBbasUvkc=;
    b=rj4Df+27RvIvziV5MOheWc4T9gT8uYZSVMKJsYQACDNQBYHuSuo0/gYVvu9c7pJwj4
    R043Uth+CoSbZKhsa1CQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BDKHz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:13 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:26 +0200
Subject: [PATCH v2 06/12] soc: qcom: smem: Add qcom_smem_is_available()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-6-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
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
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

