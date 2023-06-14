Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741672F5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbjFNHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbjFNHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:26 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3E1FDB;
        Wed, 14 Jun 2023 00:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726977; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mdTkdsPTRusY1VP3SYlgfwbZRAW7aMB4DfTJI7NQHCoQsaJ5MUirrDfB1n4d2lDl1n
    FLsIvHO+nTVkJT05N3ckrBbeUDhEHNgTFR04JhFr7nDcW6gZ5q1DyLFJ2SLjQgyv4nps
    DkEpRWckYoWZ4wuIqS6MCrdjKdT2UdHoAaCSKeLSS3KOYTqqYaU2R7c1r0ES7kMus1lA
    u3L4T6jMtTy0MmEG9fWhG4OUND2qavWx4yZHnLfMWFW0ub878UgeFKSyq4SkrUR5btG2
    WTR8T69e2s5FM+/SdqcmVbGTU9yaNXxx0fD5tAfAaD9B4HldFc8b9207EAcgvwKPAsF7
    Jieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=i8YC6tp8nBn/Qy4GjguWpkkfo/DEZjrAMvoC2diYw24=;
    b=OajH/yExRE7qXRfaCs3mzZcv2X0IY3SoBrWo+1zh6fSLC6plLmY42AsHePbZvdU6gr
    dRR9PwKnd5NPKhDCN1AOF97AYDEJWvtC7n45PMHyIijPG9eXHclY4ODkmEmfDGfaym6K
    a100uKCPeQRvJoOMjaxR+LWL7ig+fTjyCvnL/ExZDYKaw+WPHy2A9tZeDnx0NUV2ijmK
    vSnu1RM08mTIb3jPHGa3zigS6GirzZa5Cuk76WsrkKJFieGjkPWiTGsKetF15bv/gcvs
    Y+OcJDBB8BYcJuwKG0xTgasqDBfLQk8AiNbSportXglU1GGSP4eILAIDLejBlyuz75n+
    o5CQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=i8YC6tp8nBn/Qy4GjguWpkkfo/DEZjrAMvoC2diYw24=;
    b=itVWlsD6wwY339UaD3QnyoWjU0Px20tsaYvBDKtz61XjbRL+8Z7oscsNt1xNFH1l8C
    CSKGQ/nUiQiB4rIk/LRKrAiMgh/1gBzBXM+TnnHsXEg6PwSqK0OxbW5Wlnsvpsi6bEvq
    0dMy5gI+uDxqxkVDrHSe7chbfxxpZFsqNJCcdr6xtqdSvn0W+0PikHcSayazquvWLlbS
    8TR+nStPLDstVtTmYNU88V+r8LYBian+eO7k0umQspVk65Pg/PriwYKROHeYC4k7OcUs
    bsi6w+0y5GBDoBNvJp+U8IqGpSpoH871hasM9SEcObW+jyujXXcvvzx3IS1NllJOVigk
    zLvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=i8YC6tp8nBn/Qy4GjguWpkkfo/DEZjrAMvoC2diYw24=;
    b=kn/agUoirTdA84+Kx1/UQGhuc4D0Avp4DsBmxviWo3ypdtwBo9Ut13vYVP57++ayKq
    iZv/ecbkPPtAKZdGKZAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GHb2b
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:17 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/8] arm64: dts: qcom: msm8939: Rework regulator
 constraints
Date:   Wed, 14 Jun 2023 09:15:58 +0200
Message-Id: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC5piWQC/x2NQQqDMBAAvyJ77kI0to39SukhJhtdiLHs1iKIf
 2/ocQaGOUBJmBQezQFCX1ZeS4X20kCYfZkIOVaGznTWXK3BRRc32AGFpi37zyqKMd5s69w9pT5
 ADUevhKP4Euaali3nKt9Ciff/6fk6zx/rEFGHeQAAAA==
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the regulator constraints for the MSM8939 device trees to be 
closer to reality. There are several mistakes in there, some of them 
taken over directly from Qualcomm's vendor kernel. Fortunately, none of 
the mistakes is absolutely critical because it turns out that the RPM 
firmware also validates the voltages and silently clamps the requests 
to a proper range. Still, this behavior should be clearly represented 
in the device tree rather than pretending to apply the wrong voltages.

Apply the same changes as previously for MSM8916 [1] and move the 
voltages for the standard components in the SoC to the shared 
msm8916-pm8939.dtsi. With this only the actual board-specific 
regulators are described in the board DT.

[1]: https://lore.kernel.org/linux-arm-msm/20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net/

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (8):
      arm64: dts: qcom: msm8939-pm8916: Add missing pm8916_codec supplies
      arm64: dts: qcom: msm8939: Disable lpass_codec by default
      arm64: dts: qcom: msm8939-sony-tulip: Fix l10-l12 regulator voltages
      arm64: dts: qcom: msm8939-sony-tulip: Allow disabling pm8916_l6
      arm64: dts: qcom: msm8939: Fix regulator constraints
      arm64: dts: qcom: msm8939-pm8916: Clarify purpose
      arm64: dts: qcom: msm8939: Define regulator constraints next to usage
      arm64: dts: qcom: msm8939-pm8916: Mark always-on regulators

 arch/arm64/boot/dts/qcom/apq8039-t2.dts            | 102 +-----------------
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi       | 119 +++++++++++++++++----
 .../dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts  |  99 -----------------
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |   1 +
 4 files changed, 104 insertions(+), 217 deletions(-)
---
base-commit: 818e1fca81bfd773144d42f4fbe52b287235e8b4
change-id: 20230530-msm8939-regulators-dd631887ff4c

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

