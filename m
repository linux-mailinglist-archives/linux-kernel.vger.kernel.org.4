Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99816721F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjFEHKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFEHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FEBE62;
        Mon,  5 Jun 2023 00:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948952; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LsCD8fmnGUxD9W+CxO54j1Ryb7SxFPu890xEj+IR+Dlz+9vJD9UPWbQzmtkrrd2+hx
    ugGQY6IEKPSZE0e7fYo7/8+is563JNFDiuJgypnRPjEpuJB32InlukJoBNpg48ogcn8i
    kv0NPBh5F4Fir4nJ4Cf6rXZw+SRwJSG9s4zKuOSkSYTpyJm7we5CE2IpMUTAdh5FUWzw
    cLvBB3V1TiVtl4maLJJlbZt8FvubKZTI+l1C2V7/1UlJkfV9gOIrANbf8zds4+xbpjgu
    YGqKXk/aLXPQqyVMkXeHqr0oRoZGHq+qX4btUp1jmYRFph9a5PFpmXWmKJdSpuw0oBe1
    CUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=k1/3Z0rEwHpxiC8G+AzBtlaWelViTxGcX3M5pSfKxIw=;
    b=NPHaIfJ9PY8YyLdc9DVoGXgNSfp+H4M+qKtoBbK86DEJc+gmSsbjM0xPPnSu4z459N
    dNcWiRDw0AF/aBCPNwMD9+uwOePSD2GwDBsDtOwosIpTxDwAstMKC+QnHl4KcGBImA1B
    zbVj9ANYFKqFoquy/U2TD9Cci4b6gMeX+Q22ajspQn7xsYeFmpxEfDXks4Xf5gYyZeCj
    J6loZb2KJFbSC/OjWA6154aOvssyKIjjZhbIIZE4BPj+uS0Z3rqMQzMP2tDAWqkcysnB
    Z35VbGybBW9MAOZwzHXSAP1PaXIHKH8e84+R2ECf1XjKSIJpaXjB3mupVqyyR36nwazQ
    9qMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=k1/3Z0rEwHpxiC8G+AzBtlaWelViTxGcX3M5pSfKxIw=;
    b=TUCVbwDOMeNqcADgalx/KhtBNe23oL1J+5C3kDCxKtRqXno5BUYkjnXzfgll6rF5JG
    0hWnANQQ3yhgyk6Z4ody2IPVO++WL1lmGql68ECXuZj7vQSAuangSYOKYnqsI0zH9Wyr
    /WkfPTtl9+FijYTmsFsr7Iv7s6sBckTt6UU2CD+V9V9CB58klxYYB1sguJ5r6x21bxHh
    SejDvPAhsJA+Nefji9ZKh4wXp/nvNcCaHrL55BF8MAVr0wxPv3bciUK90CN48cE5XiX9
    nrkf7XfEmxcSNeD5l3mvNBXSx82fc8mQjJY6wAYF3Ut/uar+bqsnLlU3AaSyDUKxHjzk
    uvrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=k1/3Z0rEwHpxiC8G+AzBtlaWelViTxGcX3M5pSfKxIw=;
    b=HXvHRHr7uPcFCEHCOipufQq81mF5gXmyXMJYLUKUQGVKI5wI9wgLF60zsRDuKExCrE
    OM79QJY+XFskrdcbHGBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579C8a0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:18 +0200
Subject: [PATCH 02/14] dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to
 qcom,smd-channels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-2-e0a3b6de1f14@gerhold.net>
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

MSM8909 is using qcom,smd-channels but is missing in the list, add it
there as well.

Fixes: 709d473dd5e1 ("dt-bindings: soc: qcom: smd-rpm: Add MSM8909")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index fe814b991559..78822315edeb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -82,6 +82,7 @@ if:
         enum:
           - qcom,rpm-apq8084
           - qcom,rpm-msm8226
+          - qcom,rpm-msm8909
           - qcom,rpm-msm8916
           - qcom,rpm-msm8936
           - qcom,rpm-msm8953

-- 
2.40.1

