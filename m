Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94F721F03
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFEHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFEHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:20 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245F9E47;
        Mon,  5 Jun 2023 00:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948955; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=D7XlZBqJodlO1/trmVZ9E0fJMP+YSpO1UHkUT5t1IQy9gi7MVHiPBN6dhB19NUy6St
    LbsbWO3KDW8qhjVV2jgh9ybTF4kxtKBwi2m32gmnwWKAKcYSfWUcK+uZera7oZuGPStA
    Ys1VXY4TS+VGm82VUI7FkKA+GQrm46Y3D7Ijyesv5Brsvsgv2Nni/vpl6jVC1oJObikp
    mYO2kq0E6tHWl6IPGcIRlqMQ5TOfdyu1lJL3OfCBEnC7xrMplB1de6DLYVN+WvQ8hAX2
    0M0R9y2GFykcKIGYtJMbLDjv31tJuY1vFBSPBuilCh8slZyNQrqCGenAvSttb1ZXmkYa
    VDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948955;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+npGgjzfjdX6BHWaITrIYD9gk4zOqfuT40I/KSZiv44=;
    b=DknVha/VsiJFh7Pp8po0CeJ5A1xmrxy1Ahz/VS+lYPfyQ3f4SPR2X/dE9EGk8BLlyU
    Cc3GkM4R87UP0qQ7SR8kA+27hzjJh3zo/WBBCYfIxqD2DFievwclVBfr7MDaXWt59iPZ
    QOzLhpMw7J754VLKzu0+ULLzeeDuap0CHbh+inFgP5EIOLREbU9zZTKwR41Oa/5goMF+
    SvKHN2VT2aRXYcBm5zxSIFnxaTTO5jhdzA/gH/QpQlNl+B/NSqU6EM8qfAef0NioKspi
    L2janq2WzOpmugKNlav354dWE9SPXQAI4yAG0UFMJ5VZ6q2nuZzeVGnjtXEkI2CfUWB9
    xGqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948955;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+npGgjzfjdX6BHWaITrIYD9gk4zOqfuT40I/KSZiv44=;
    b=O6Xko2UDLApY+us9VBR+bFjaT6Gl4a4qdBnLTZe5WdMf4naIQYdo6WJXgbNO03m8W9
    cKnDavlv5i/SPg9mVsnAjFRTmUtfI2GjoBzAOic2b5VuS+TjZ2dWvpOzOTUz2vw8GdNz
    nSeLyQa6btqg82bsi1bigG2CUX6TZcedJRBpMhpatNGadq1CUEFSfgRcmRBdQ+2mejst
    W/j/LcbgTxrLCRE2eKuYGEAfkjvIKFs1pqGb5tbUuaWiJuyDaOlrGbdOFk2UES3qtaqZ
    fuB9zVugmC4alZFl7IYGVhzjIzH1BNOfgircLEs+xIPW0hmbAa2/Vxo0uU8o1UAIJyMV
    31ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948955;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+npGgjzfjdX6BHWaITrIYD9gk4zOqfuT40I/KSZiv44=;
    b=g8Z+6Z7MCNOKmDPllzkNa/Z/wdZy/DYfEakkoH0VsrCUyL09TAkT8x5sYGN0f8d4Gx
    4srufWDbTWRK/YG1amAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579E8a7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:24 +0200
Subject: [PATCH 08/14] soc: qcom: smem: Add qcom_smem_is_available()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-8-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
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

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/soc/qcom/smem.c       | 9 +++++++++
 include/linux/soc/qcom/smem.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index b0d59e815c3b..3d93a6681494 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -359,6 +359,15 @@ static struct qcom_smem *__smem;
 /* Timeout (ms) for the trylock of remote spinlocks */
 #define HWSPINLOCK_TIMEOUT	1000
 
+/**
+ * qcom_smem_is_available() - Checks if SMEM is available
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

