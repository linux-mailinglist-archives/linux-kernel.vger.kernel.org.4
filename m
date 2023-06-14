Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4C272F5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbjFNHRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjFNHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:28 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955E268C;
        Wed, 14 Jun 2023 00:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726978; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AIvkxxTKI/2j9+oIv30My4CL9ZhJtvqyrM5fyoNpc5JnnzQDnz8/pBOB8QDVbqrZ5N
    biT9thid79/SsI6JVLV+GiaFvB8Eh7E9HiMv3qjUvNjK63XN7ghmauz12StnFO41582n
    L7HCga4ij82j7ViWWdfTUZ+dDz8ahtZJd7a2/QB98eDl6hrf6h5puoROhDUMGf5g2KQn
    wW59C1OO1gF4XcjIY3kIUL51KWOslPuZlturRcaTKgojgp+kbdDppKR7uLUlSjA+VNib
    dxvGpYjExoulhYNv/cHM3xtodKtTdKgTG2vKs1gsQanUpU2rWlTCU1TX/ULTBNCHW6LE
    3GfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JHAPAqFoqpIjl7hLiOzzxkyRcrXXkapQRDWT6x2deJw=;
    b=hp6VOrz1dhztk3jDfI+sVzoztfKNSZpDsc9SheDrmI5jx37nHsBh7SpcE6D0aYYlRI
    i4TF3k4GL6K8HjRaFOJrKX/NegdY47fJB3JSwczKGUJd2rN5/KNjKdbK6Br1aHm47C+l
    IKd2s0J9HtEqEXCqwAYQeoORK5oluR/wTrkvJz2keDfyU5zDD9CkXFvB4oi7cV4tw2KD
    F18zX4mtdVfEUKn4w7rXuDY+G43eAcwR+8pE2hhxbzK4iCWsaJjyXzKs3RKlN5uqNznG
    7UAWXsFOixKAq1X01yXJpDESTHW9k9WoAw33T+qUKhcItvx241Esmg2g1pSEqDvEbzSr
    qPrA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JHAPAqFoqpIjl7hLiOzzxkyRcrXXkapQRDWT6x2deJw=;
    b=WAyrNmymv/JANaByyLnOLugPC6X/cGWDH3HMq3yLN21bOTzgj3MDbuRZy5kbCVEO5D
    DZakz+9+hcrZ+UAHyqvO3UbWiadj9pZ8BBrfoi09qEI6+wExq85Kw0tncl95Ld75g3x9
    QlFCGeyUuJ9t2oLaF8LFxSmwJnbRkHy59LTpb0f0oonOF994JTGpZ5GIleGlYX2x5yOA
    WefE4Z2RZem62lb95638nX8eC5vZLd5Ii3RCI4OCL0qS81+KZAhdDkulnwaNFChDEEC9
    jydCHWb2dbanAFsv0aD3J79zpCYp9r/clNrwVVMZZeVmAzQ3ZV63Do+KhlRQXFB4DlQk
    7mRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JHAPAqFoqpIjl7hLiOzzxkyRcrXXkapQRDWT6x2deJw=;
    b=m5TlfemxBm7lZJcBrnKhIwiIMIT5zotQg7g/1/1+JOZrHwk5n94/mU7l7syN2VbKR7
    qF/mry8hNoXzXVfLmVBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GIb2f
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:18 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:16:02 +0200
Subject: [PATCH 4/8] arm64: dts: qcom: msm8939-sony-tulip: Allow disabling
 pm8916_l6
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-4-a3c3ac833567@gerhold.net>
References: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
In-Reply-To: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor kernel from Sony does not have regulator-always-on for
pm8916_l6, so we should be able to disable it when setting up the
display properly. Since sony-tulip does not have display set up
currently it should be fine to let the regulator disable until then.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index dc5b8cd5b9f4..509abcdad287 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -91,7 +91,6 @@ pm8916_l5: l5 {
 	pm8916_l6: l6 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
 	};
 
 	pm8916_l7: l7 {

-- 
2.40.1

