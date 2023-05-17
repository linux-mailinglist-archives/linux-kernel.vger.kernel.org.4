Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C835B70712C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjEQSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjEQStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:49:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F35FE;
        Wed, 17 May 2023 11:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349338; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SOvaP70EpeiiuJlzCSzsm5LozTmTSI4H3CrgpWGKAJ5xrXTr4CIxBEGbZ7S3Jw1jCI
    suF06UFufdfBLWUEtKTRuNEdwqNW1yu2qUcQ2kVii4HL7QPc5mg6Dvc4wUdPiIG2BscA
    rJUCEB6wYTdas69OCLwt5wyT0AXTfL4NV+dNiDTS6KGyS3hDbQTbcB34+mdHU0suAkbr
    cgW/SXh1TQf3R/zLlNNTM3xAhP/3zgng5aybMv88nMGt9kVEiO5comH46NhAkg0FRXYM
    qEsuP6KtZjlVPpv6t5BxBlXOXa92ft2EBgVAsIPCMRhyDY5v/VjHr7VQUuGWqtVAzjGu
    TLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349338;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=rkE8u4oZLTFlvJ+Zt4904j+4OJtDMcJqCcbkOZiB4ZI=;
    b=l8W3DgW/Oy44vzO2xLsFj9qMkke55RK1R/VV3PxVMMIblGU5KCgrf5V7SQkptlJNDY
    zn66ERxZ2xxhwo+gQfmnSn2dpL37bHZwQiXD0YHgKw+9e2YwtD/ZLr1D7b63tVdDMOg1
    Crpv7S1nZDrDn5GZUanqesr5JC2wFjDC7uO8RlIRo38NpnQEstfS5Ij9B7vU2l86teUU
    LvojZTY7al1B+mPDSgnzDFUChF8JpDcjiQ+VrqOasBOYzAMG4CnD/+3NxIeOTaMeNSyO
    PN8BzuVFPvBKXZ1EMmHDlCQ+jhF8yZSmz26T938Q70MVevoZw4DQGMMBtgydX8nCd0rF
    VcMg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349338;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=rkE8u4oZLTFlvJ+Zt4904j+4OJtDMcJqCcbkOZiB4ZI=;
    b=A/5rOeqweqyklVWe2WutOH3RuZwDaE5UPFZyP/nEfZ91UQfEf/gj+eF20OYBX5LtFf
    wb432uMo3qfxYJSuDzIBzBeFomJNJ/1rvRu0rC/Xt1bVkarokaM+nvfmCJ5DEUm9eLyz
    tNmO77Jn3boRbXfhkdGdG0QaKd1xHlj3n4LZbjK7mVY3OE8YogkmG1cDugbn8vqDI/fp
    p3Nl6dd7lF2hFQtc/Cx9kCl1xUdGxB9mdmJvSBgtc/0gGIA+hMckqVWIbmj0eHoKe1Hy
    TpSZC1FYAu+dfC4EKjMIBwZl1OBUzcyqE4aGqHDlql2eMz46P4n3FjEiUWsRjfE0pCBO
    8hIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349338;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=rkE8u4oZLTFlvJ+Zt4904j+4OJtDMcJqCcbkOZiB4ZI=;
    b=wxemYTJlhedpobpExgquKfr5ICn128VyQyxrOu8VwynAyFG6RH907hNcAwHDla1T0r
    4lpnpYWtc//O21JjyCAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HImwBIF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:48:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/8] arm64: dts: qcom: msm8916: Rework regulator
 constraints
Date:   Wed, 17 May 2023 20:48:39 +0200
Message-Id: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIchZWQC/x2N0QqDMAwAf0XyvEBrcc79ythD1FQDax2JGwPx3
 617PI7jNjBWYYN7tYHyV0yWXMBfKhhmyhOjjIWhdnVwjXeYLN06f0Xl6fOidVHDro0UQhsajgw
 l7MkYe6U8zGeayFbWU7yVo/z+t8dz3w+dAOZafQAAAA==
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the regulator constraints for the MSM8916 device trees to be 
closer to reality. There are several mistakes in there, some of them 
taken over directly from Qualcomm's vendor kernel. Fortunately, none of 
the mistakes is absolutely critical because it turns out that the RPM 
firmware also validates the voltages and silently clamps the requests 
to a proper range. Still, this behavior should be clearly represented 
in the device tree rather than pretending to apply the wrong voltages.

To make the regulator constraints more easily maintainable with a large 
number of similar MSM8916 boards I propose moving the voltages for the 
standard components in the SoC to the shared msm8916-pm8916.dtsi 
include. With this only the actual board-specific regulators are 
described in the board DT.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (8):
      arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
      arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
      arm64: dts: qcom: msm8916: Fix regulator constraints
      arm64: dts: qcom: msm8916: Disable audio codecs by default
      arm64: dts: qcom: pm8916: Move default regulator "-supply"s
      arm64: dts: qcom: msm8916-pm8916: Clarify purpose
      arm64: dts: qcom: msm8916: Define regulator constraints next to usage
      arm64: dts: qcom: msm8916-pm8916: Mark always-on regulators

 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 145 +++++----------------
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   | 115 ++--------------
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 110 +---------------
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     | 110 +---------------
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts | 110 +---------------
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     | 125 ++++--------------
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 110 +---------------
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 110 +---------------
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi       | 121 ++++++++++++++---
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 110 +---------------
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 110 +---------------
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 103 ---------------
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 103 ---------------
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 103 ---------------
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     | 119 +++--------------
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |   4 +-
 17 files changed, 236 insertions(+), 1473 deletions(-)
---
base-commit: 4272e06e19f388ccfe1f04f19060ea84d2a19a8b
change-id: 20230510-msm8916-regulators-97fa33735efe

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

