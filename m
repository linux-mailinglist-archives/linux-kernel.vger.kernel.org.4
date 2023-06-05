Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC9721F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFEHNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFEHNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:13:39 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA2F0;
        Mon,  5 Jun 2023 00:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948955; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cwqBvPNM+VvqUjLiWgVckJS195JahM1GQX9x3EycAlVQp9XQimx387YIzTVNi/YCPw
    VKBv5yhD1UuHwXH8gx27bC4r+bgzsyoHoM22Bm/QVrsDgET0VTaRtSCScCPME6ckh/vS
    LQYRixDFrCrf0MOT5zrE6pM2Rp6mGsHUcXu5R0aQlYGVSOR2k3EDQzQMfsc/bHvY+cdP
    1f91eMmkb1BaRULdRXMJYbI2oN53wGxDx6heWCyvSVvJD+3pKJTChS9PX7zkc2EuEBW8
    N4mSo4AM1w95WET1sjqV6fFdBkJAP2S4hbjego2OHmG8B4xJo7Zj3bWgs2tHRj0HxXGK
    WbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948955;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=l/8mcRN+TlGYtBCi00HTVZhrkyxZgFaeeP1BtcLCr2U=;
    b=Kgk43ALbbJRRB/4dAMVCA27IfUzmALJO580LB/2wK9CnvP1iQjip3KTRSJ4xuL9/Ff
    uaxTwPOts8fcgWX42J4ZrZaGbzYYD1XKv43IiBQsHxVR6/SFs9vPMl/cg63CtjmLlsfX
    ks/2dAOtPJ//lNvjGmWdd01zQxwPZYojpZ2B/gkdvcGYsrjg3GWgf/PytfywE82GrkUm
    9Yg7QbgQFalkIA5AD+hid/9fOY+PeP6Rop6+0NKQifN+uAoZypGZLmLMLkijIOd1ncqW
    //LQiTwoWF0Qm0BEBR42e8tX3n0e5KgPFNiwegNWqJBXLVzFHY1J9DhVOhcjCjwkpkp2
    WY2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948955;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=l/8mcRN+TlGYtBCi00HTVZhrkyxZgFaeeP1BtcLCr2U=;
    b=OS1qsySklIX77dE17tXfnCaHnboXobLaTvon+gR49pqZv5DbmEHwREeK//sG7VIROd
    UfiOXE95Q7umwnnIwt5q1tKJa1SkuswTukAfIuQxz6yOmrJPdgTAX8KfJdszB28C3LHZ
    phS8h9zEjyiapZXWo0tVfK0PmCSoL8UXOAGQmLjaejsMUCcSHYuAHgpWNMXisVQR1kLQ
    LipXj/ncsuyt/Xgi74klTcc9SrCq9PgzJ+QVJ3HeJT5/wPFSHO8ZWZNTU/O1ht/YUerF
    nfao0Y1QaHLhFbNV+AFdgOcFcRz6aY5scsce58EZ/wwXIkfxI6DP+o8ix9QSYZS3/Qa4
    o8LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948955;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=l/8mcRN+TlGYtBCi00HTVZhrkyxZgFaeeP1BtcLCr2U=;
    b=uil1PyV8cxT/FRkWdYTQBkGVZO4FN77Ojzp/pl8jFjdIRsLcHnpiJiVRGlf4IfFHJJ
    8HaSurreoGfQQD+lNHAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579F8a8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:15 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:25 +0200
Subject: [PATCH 09/14] rpmsg: qcom_smd: Use qcom_smem_is_available()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-9-e0a3b6de1f14@gerhold.net>
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

Rather than looking up a dummy item from SMEM, use the new
qcom_smem_is_available() function to make the code more clear
(and reduce the overhead slightly).

Add the same check to qcom_smd_register_edge() as well to ensure that
it only succeeds if SMEM is already available - if a driver calls the
function and SMEM is not available yet then the initial state will be
read incorrectly and the RPMSG devices might never become available.

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

