Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE672785C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjFHHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjFHHLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78C2697;
        Thu,  8 Jun 2023 00:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208272; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dDkGWjl/OgKj0iDer7YYdAhKZnc68vcU7w9l1qdF95NPqSlzmx7U2IqIkl2vSfx3Uv
    wxuuwY9uEjgpT5E2NOIycZ3dnvCaxwFaOWwYS1QdYHLqNAfEcuRlvFhcRlL4xUQKGBvQ
    vN0sj4kLE8W9L7hSd1EehrKRZYM5OGUR5bTD7JdQcutuoUCquEeM9oGHXtIiHdBqDLK5
    5Ig0rzqCqPwwjuzVis0dGVbywDtmX0sPZZaP7M+SYLiqwxit7LGqgMZIwRmKBHVDer7+
    yA+hl1rH4e6GUKKzLAYqx3A94iP9XoesJ/zesmD8FaDprWdWY+MFXd+dLYecD1Iug0U2
    5Ewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HwHhKZChtnT5QeLJ51MFqhGAkBh98wtO5B8+zILKtRo=;
    b=fvlwfZXddTpUMtqNQPyJQ0kh8AWiQapy4RnkEhmNSJ/A89rkMBsTwdHKRLmW2aHSp0
    M4ESf+m02Z9uADnHh13oX7eP4iK3mR1Mv30qKLaBomYNPsdR0MK3mgt8EUuGCo6zrvkz
    dVxcupKwotcQJKtxrCFncyEPxtdalhfDiIwkmZJ8/ZpHs5Tt9LobeE4ry8UgqQpU+8AI
    tx6EdzynVNqwOHwmRCWyUAbohAb62pQZxFHdZREf0TNkTMu/OKxIq2Sqp5V5dl8dUrYS
    cK4D7hUFtbc8X9av3WjvLHLVCv4AeGoS8EKgoKyq5bAA/zFpKKbNmTCl6bMOqOLv4jAN
    9MuA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HwHhKZChtnT5QeLJ51MFqhGAkBh98wtO5B8+zILKtRo=;
    b=qPuHVuRriBQexNdIhsWYCNBPUAMBbsGip5bAy9p3z4X5AEuIozcFlRHMFpgexgAOmL
    fca9TCLv5JDJZhJ/XWiqubuovBj8jqjRCn7y0C2j5gxqgCGa9qtW92/0DgpRZR0gW8L7
    3QVAxNPh6R6oPaGiRliqXg522wOJl+xsszB6DroiS2N/ioJ6cn1QnUpPZp707dOo3q/V
    D5w0f5SW6/JEn5NuYnxeATVwsILjTEqLvPyyjvc5Lsh7K9KBt1Iye1pGyOjlu6HfVlAE
    cZHLysx2Av56yrNRchqWQC4R/vPhp51WSetXyO0q5uTrm5OOXAWk6bOhbtCdI2fNdCZI
    ycCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HwHhKZChtnT5QeLJ51MFqhGAkBh98wtO5B8+zILKtRo=;
    b=48tiO+qbK8G37MhzS8C5IXH0adTU00oUpQjY0cdzXtL8QU83EekKc4dAPfRMrNbu0+
    X1gGPiQbex5k1wCmDSDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BCKHx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:24 +0200
Subject: [PATCH v2 04/12] soc: qcom: smd-rpm: Match rpmsg channel instead
 of compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-4-56a4a00c8260@gerhold.net>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM6375 (G-Link)
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

