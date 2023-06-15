Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8B731E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbjFOQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjFOQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:10 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F5295A;
        Thu, 15 Jun 2023 09:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847855; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mhFWwgg9/K2CIRT6uPEyI/Blj3vXcLCeqxqfGYsIHLKWWkck0Hv8rGOqGE4A9uYsua
    EGMfWhJ2mjjVluRb++X/Jl7lxJc71HmzSH5dMl46brXJY0yrmuKAhA+PaQNSh3cXfe2g
    tpa9El2mWcsOUvmOHNnyL1PK/io+3S9nG52Nne0Z51+jJsQwvGINAo6ABl8lyhhYD+hj
    o+k+KxPaTMVtMTKnCAMQlo5wp7IDqD0qPgbANgNaAs2m6KECkczTb4wgYO0tUrZNbr2i
    lInWzNNZeSOmpv3JmT1zN+kvnx1vUt5I6TpPxxoPOSoqCGC/zSNS/9gKG0JPKAWGMS9N
    5B7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zIP6Ad+n6GtTcdAN99toMZU1nMdvUwM/xKmNfiwoI/o=;
    b=ZazKYoS4pIUqBgp5SgGIdGwx2dBU7fB0AmtPw0rGaCRrV7NNeS+1ybe99+qN3WQRiy
    dVZVM+BLsRfqmc4s704B/nLjr6BM+4if7LlDuffWUZsnjuY/ItybtfxhhGJ9fdeQyUqL
    gdzWpdTYYKI4WQ41DR9EeyAsIxEyjSJT/qQ2FS94eqZ7qmR69xn0R5CKMVLVrt646Dpu
    wDn8oj3MdwN/scdrmxbrJogSK22nON79m/pD23mPuN+jMKqLVxi5SLW2mGAraJt5hzzr
    kDZbc8pkqDqWlFnqiBEtPhSHL8GGuysGGPF478HTgcZbw2QEpBACy7pcfBoQxFmdIPpJ
    B1rQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zIP6Ad+n6GtTcdAN99toMZU1nMdvUwM/xKmNfiwoI/o=;
    b=HPtSrxzp37SnCjw6mSC5MPNEwdiABkiYSiu7RyYJD3Hfp4ztm3+Hn3CoAgz/ow+tb6
    JfeZm7OnEKCWk+CgkGCcrUf8EWU8tsB5vL6TzblScS5yG9KP43Xf7BDImgiQyn8sK/sy
    AXgNmq0Qlr2hvjyJ9QTtM5vknX3fHKaWceFAxro4Zsnt6wx5HRyYMheojCRcLPxSaQpo
    1B/isZV+lCgIuEO6VcQqVf85SGCJOHEjeJW0UqS4PN05mELD+TwnanbKVxwY0az4272p
    q3ux3gFcYiN6cIVViuMXnuxy6V7WtSAydkxAMwvcoNqI6QiKJfIY3ZQ1yMGSd9AM7AVn
    Qd8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zIP6Ad+n6GtTcdAN99toMZU1nMdvUwM/xKmNfiwoI/o=;
    b=NZYz6twwo+WsmWVDiBV5rVckt0IBVNvQtTPrxC9DPP1OdhySDYoxND09AkfjPJpOwP
    CBzLxlCYr2ppCYEb70Dg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGot42d
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:55 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:35 +0200
Subject: [PATCH v3 02/13] dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to
 qcom,smd-channels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-2-a07dcdefd918@gerhold.net>
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
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

