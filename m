Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B2731E61
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbjFOQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbjFOQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:13 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1182B295D;
        Thu, 15 Jun 2023 09:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847857; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bqvc4scDPqPTyPzHTlwbvFbNL0chs2E6P/PmmG1VCohYOPsvppN/o296CWjO6MxyR9
    mifjjuVG7mGG1BB1n5UEp8WSdT76RjVD0hcd+gpWPsdN48SJLAxTpJkZJqq8+Sp68kiS
    bLFk9fMTPL4/1fGgxNuv6u8UyCvuTtCvPnzqH3liNU9Ty6uhIDE2jkyZ3napB5FnWwbW
    teRxMtSAjaCSIA+PQz3pk/rIEKArmDO1ENXh/DF5VZoe7Ktso1UKnIaXJvFl+xMzWYkD
    lmtG+RaFDeSZ0EuroFR4u8mxaIcfuxg/qs5vlGpwAPxO3mnxm88uBu7N2DkTvsjN/qgi
    mATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/IK/YL613oCwX1BVM5btJH/g/5FePMBvICB1GubRDSw=;
    b=WUrJrZQ3EpHaN3XxxUqaKZSeenit6UGTT6NeEzm7lwGScXsbwe2l9a6UfK2J2XX5fJ
    OrlS37/TkeEDCkf8ADyako86Ua9jCswaNmn2METs+GKBRkiIhbGQRP28AXs38RKep2Zm
    T7AGNwYAflPGK6+W7RDwP6VtiwXellJ2b8jZ7IRGmvU6WFVGm4yy8B0L8jX7aHh1StcL
    jAZk1WuF0Wg8RJ2CDr4zu8j+k7C5G/G2hygPK/rScxWQPNPj89YGNEe0eIF9UKlSN72z
    ptwUelYBnA/frhRd/6RJHiYhjnLR/wSF8nEAMhEBvHoqGA+BmcUyEsmVn7tbgDESYyrJ
    dGZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/IK/YL613oCwX1BVM5btJH/g/5FePMBvICB1GubRDSw=;
    b=Zt9UE6ueBbFM7VPd9uxsEVLXkGodec6McY/dCfHxzXo/LCfEm777Ey5YU+Pno8Wvz+
    pWyad+CYmPd2yup+ZJze74oxNnQwi1MfOJZHUM7hEgCzHj+5XCEy1TSbRibK7U/M6HCh
    O/u4otwsBPOuA/uZ5B8krFZwEXrb82QPDmecGaeQjHbntpp/uvIP1atDw0X3siGf5y69
    +4w0SRgmv1IVuSWlMUlbbetX3uLJhsV2vjn6laa0Z4FJDMYBdLE2ou87en0x03W1E5Bj
    UXNvaRwbtAQSkAxY2BxgLsMo2fbmweMfU+lqBFWlu0rHzGlVxPJgVxVIKgh+SLgaIsJi
    lkXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847857;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/IK/YL613oCwX1BVM5btJH/g/5FePMBvICB1GubRDSw=;
    b=dwKxbAVnIW41tgY6v+kzrK4GS9/v56sRn6UQ+saMLctS4kRrqnpg+SwHtPnUcUZSYw
    9NonjHIs1Nzv/Ql6dgCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGov42j
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:57 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:41 +0200
Subject: [PATCH v3 08/13] rpmsg: qcom_smd: Use qcom_smem_is_available()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-8-a07dcdefd918@gerhold.net>
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
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than looking up a dummy item from SMEM, use the new
qcom_smem_is_available() function to make the code more clear
(and reduce the overhead slightly).

Add the same check to qcom_smd_register_edge() as well to ensure that
it only succeeds if SMEM is already available - if a driver calls the
function and SMEM is not available yet then the initial state will be
read incorrectly and the RPMSG devices might never become available.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/rpmsg/qcom_smd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 7b9c298aa491..43f601c84b4f 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1479,6 +1479,9 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 	struct qcom_smd_edge *edge;
 	int ret;
 
+	if (!qcom_smem_is_available())
+		return ERR_PTR(-EPROBE_DEFER);
+
 	edge = kzalloc(sizeof(*edge), GFP_KERNEL);
 	if (!edge)
 		return ERR_PTR(-ENOMEM);
@@ -1553,12 +1556,9 @@ EXPORT_SYMBOL(qcom_smd_unregister_edge);
 static int qcom_smd_probe(struct platform_device *pdev)
 {
 	struct device_node *node;
-	void *p;
 
-	/* Wait for smem */
-	p = qcom_smem_get(QCOM_SMEM_HOST_ANY, smem_items[0].alloc_tbl_id, NULL);
-	if (PTR_ERR(p) == -EPROBE_DEFER)
-		return PTR_ERR(p);
+	if (!qcom_smem_is_available())
+		return -EPROBE_DEFER;
 
 	for_each_available_child_of_node(pdev->dev.of_node, node)
 		qcom_smd_register_edge(&pdev->dev, node);

-- 
2.40.1

