Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8838721F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjFEHKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFEHKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3183FE6B;
        Mon,  5 Jun 2023 00:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948953; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LyzN4cit/ESC5mhHOfF1am1m+XQXZOlC8gQNPfSE5qsXk20/XfgAK1aJxh4s+o6BBo
    RvfJ46sE0SQjXMfU3NoKkYLXhxxTgX0I9kxF5OSlHJSzcVyLVnqzYELRNtFVbiMGiikr
    hUcuwSgwNt7PSIfCc5OfkQFCInv7/HgqZeDjL3sKgl00iUCXocaV7SkHcB0oZlX03ur9
    NHIuCTnGdnkF5h4zp6L0+4JwDWkU80yaC17m0H2hlWxsAGb0Wn1Jh/eeiT2MhrgJz5f9
    x/RFxAN29YBZujXTkl36ABWiZ+Nu8Cohzq7X2GQJFAl+u7fAEghhvYtWHfkPqQHXqT+3
    +eGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948953;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=KzxZEXfP9riG5jeIPNdghbmL1RM9PKS5UHG6gZHagac=;
    b=gtssXm+AaYYeYvfwjTYLCbgLb9G2RQB8HVtd9XVFP4Q4xt9yRAvLnlzwI03nANAUIb
    ely6s0rSjyxSKCss4FHqANLZJ2B/5I/p+YRvCS6O6JMHTGEnuZq7uHmXGpxY++h11Dmy
    Xevq1VSD6qTMvkJgsqxFlu6Nv2QtfoU3LEjHkMeyX2n6IajZyAIFcX7NvcAPusDWkXri
    GJ51YyUE8fztonfEg4ZSNf5eNdhCcCzBZZz+29o7RcbH0YUtMQbRJmLJz3DsJsUt5wkn
    JOzFv70JrmxN3Lw4C6HPHNoyDhqA4E5omOuq33MeGTdpJCnr9Th8jOiC3cSE7Xpm6trq
    3gWA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948953;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=KzxZEXfP9riG5jeIPNdghbmL1RM9PKS5UHG6gZHagac=;
    b=pT6e12j3XBct9r2CN3tTiCnk9+mM6ULwxnlMNHmLw/JOVL1KGHEZAdEyNSbKp2k0jw
    nmUcR8Cb6uJcoUi/MNeL6fqQp+phBvad4WxINden0tYCtioUVTBOSknqDfnU8qVmkroL
    sH3t07wJWoguTbt7eE8omOMCuI6T/MVpCe6xeVPHA2Pi1QsBCsEBCx9vNWFYNRuNYF3q
    vkznZmAjlDQu7sPMch6Xpmq7boRHAHkOt4tyNoyxRwM4M2g9xjWjHymxoKScIOXG6gDQ
    jaNEyzzYmmEbb6LXxejYilRkE5kMmM6Fr1CXj1AXV29DsngopTNLaTA5A/Mfgp+cKFhC
    oZgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948953;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=KzxZEXfP9riG5jeIPNdghbmL1RM9PKS5UHG6gZHagac=;
    b=xwx/cpb5xsGzssCM75AmSI9639zVKaa3Fro7ijoNWr7DfZ73kkOXHh6i9w/E80XYbl
    vAF2cVX8lq1XfCChsVDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579D8a3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:13 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:20 +0200
Subject: [PATCH 04/14] soc: qcom: smd-rpm: Match rpmsg channel instead of
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-4-e0a3b6de1f14@gerhold.net>
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

There is an ever growing list of compatibles in the smd-rpm.c driver.
A fallback compatible would help here but would still require keeping
the current list around for backwards compatibility.

As an alternative, let's switch the driver to match the rpmsg_device_id
instead, which is always "rpm_requests" on all platforms. Add a check
to ensure that there is a device tree node defined for the device since
otherwise the of_platform_populate() call will operate on the root node (/).

Similar approaches with matching rpmsg_device_id are already used in
qcom_sysmon, qcom_glink_ssr, qrtr, and rpmsg_wwan_ctrl.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/soc/qcom/smd-rpm.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 0c1aa809cc4e..13d8c52330d0 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -199,6 +199,9 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
 	struct qcom_smd_rpm *rpm;
 	int ret;
 
+	if (!rpdev->dev.of_node)
+		return -EINVAL;
+
 	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
 	if (!rpm)
 		return -ENOMEM;
@@ -230,38 +233,18 @@ static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
 	of_platform_depopulate(&rpdev->dev);
 }
 
-static const struct of_device_id qcom_smd_rpm_of_match[] = {
-	{ .compatible = "qcom,rpm-apq8084" },
-	{ .compatible = "qcom,rpm-ipq6018" },
-	{ .compatible = "qcom,rpm-ipq9574" },
-	{ .compatible = "qcom,rpm-msm8226" },
-	{ .compatible = "qcom,rpm-msm8909" },
-	{ .compatible = "qcom,rpm-msm8916" },
-	{ .compatible = "qcom,rpm-msm8936" },
-	{ .compatible = "qcom,rpm-msm8953" },
-	{ .compatible = "qcom,rpm-msm8974" },
-	{ .compatible = "qcom,rpm-msm8976" },
-	{ .compatible = "qcom,rpm-msm8994" },
-	{ .compatible = "qcom,rpm-msm8996" },
-	{ .compatible = "qcom,rpm-msm8998" },
-	{ .compatible = "qcom,rpm-sdm660" },
-	{ .compatible = "qcom,rpm-sm6115" },
-	{ .compatible = "qcom,rpm-sm6125" },
-	{ .compatible = "qcom,rpm-sm6375" },
-	{ .compatible = "qcom,rpm-qcm2290" },
-	{ .compatible = "qcom,rpm-qcs404" },
-	{}
+static const struct rpmsg_device_id qcom_smd_rpm_id_table[] = {
+	{ .name = "rpm_requests", },
+	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
+MODULE_DEVICE_TABLE(rpmsg, qcom_smd_rpm_id_table);
 
 static struct rpmsg_driver qcom_smd_rpm_driver = {
 	.probe = qcom_smd_rpm_probe,
 	.remove = qcom_smd_rpm_remove,
 	.callback = qcom_smd_rpm_callback,
-	.drv  = {
-		.name  = "qcom_smd_rpm",
-		.of_match_table = qcom_smd_rpm_of_match,
-	},
+	.id_table = qcom_smd_rpm_id_table,
+	.drv.name = "qcom_smd_rpm",
 };
 
 static int __init qcom_smd_rpm_init(void)

-- 
2.40.1

