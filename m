Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701D7715659
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjE3HPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjE3HPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:15:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB195A7;
        Tue, 30 May 2023 00:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685430934; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i/T70Svg8v9O8KBRt9NJEphRYy6Ti1VdltHlhfcNv8vffeuus3VGfmc1WfiCc02OCF
    X6A8w4AA0/jEcTSyQd51bPptCU87UgDC/eCDOETNwDk02tNH93gg3KqNKUfC5JDgVpkJ
    aGuTrST0jND2AMPF5Hcg22KavxjuzuM88tJl1U7S3kuJToRgCF6nZgI+el72IPmuoErb
    hANWlRH4JCUL+TWfNqVPI+u+eLniNQAnKb5FBBF0+gQ2xku3+HP1YPieqWQmJCfr9pX2
    GfYFRWljQIl4eCylZM8lJBRrytY7SRJLmxfi8583l+6er8vlFq4aWz+hYIj8gsd55UvO
    3MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430934;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=zRFnv1DIvL9PImYhItNhRIS9KwFV1gf3iCpQV+9f0lA=;
    b=mRkbu1Z762yPZDoZ8oMgjM3+UeRpLaoE+XEEpteGHnU0Cgw04uJbuLSCj2QpI6QAck
    yh8JHodZ/FeFECPlG3NQA59EdsPMsFcRX6mRCRjzrMONttvkAuLSF7uq5dx3zFSUQ5kJ
    2VoHTCfhkmdmCJ6UwoVdxJdZZKAGdDm7WKkAh5H9XU94FrtBWsyLTzfqjwXwcKWtuUuO
    8kDTXbtrCAaqn40vJ7OygYHs88KnADebSIZzFTjwZ+9g9QwEAuqZ2WJI7B4by8X4+QM8
    RlJDLKNX5CB4c+iWjxBJZkykczgmbK0wmVRd/Qzes2dfIqLdz/IhGvTv18iUxJRcD/db
    I1Zw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430934;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=zRFnv1DIvL9PImYhItNhRIS9KwFV1gf3iCpQV+9f0lA=;
    b=AZ6XrBdLwVtZMqBPpN8u1GPHEl8/DBwL6znAPeVQbNq19qTb61dlK7tyTgTIpsmFGh
    7ghuzNmM1I2vwfkkf+3KfRP3MqwtOfq0oJoJSt4jMG7YuPseAxMC1ABSWIcVaLBMKcIc
    ExLnAoIQtlobPvo98d82JbcdQiwZ1OPxK/Io72DCMgjXEQ04DRVOispaVHRXZbXoNJ7g
    JuaDRPw10Z7lnZ86oFhNxccuqqyB2LymaWwAzmZee6B/WLRqxnaA6HiNQh3Xp05tR7D6
    MCPbRyOqVhdbOw06ZacK7RNh1cEvlTPoYWCdGKagFLN4oK0MBlDFbf0uOeQmtDWvIPjc
    hcbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685430934;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=zRFnv1DIvL9PImYhItNhRIS9KwFV1gf3iCpQV+9f0lA=;
    b=Vp0TmqLaSbbmlnnURcMIhhw0eTweO73cJcHIYKH0w0ZbKLik3Sorx6f59r8hqhILIq
    Dq3+zUdjhYfZ+fiMrKAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4U7FYgXy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 09:15:34 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/6] arm64: dts: qcom: msm8916/39: pinctrl cleanup and
 fixes
Date:   Tue, 30 May 2023 09:15:21 +0200
Message-Id: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqidWQC/x2N0QqDMAwAf0XyvIBWV+d+RXxoazYDNZNkk4H47
 yt7vIPjDjBSJoN7dYDSzsYvKdBcKkhLkCchz4XB1a6tr27A1dbb0HjcWNJbM/q+7WLs/dw5B6W
 KwQijBklL6eSTc5Gb0oO//804necPrjEBy3YAAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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

MSM8916 and MSM8939 are very similar and almost fully "pin-compatible", 
so there are some devices that exist in very similar variants with both 
MSM8916 and MSM8939. To allow sharing definitions for such devices the 
SoCs should be set up as similar as possible, e.g. using the same 
labels. At least for me this will also simplify maintenance and review 
because board DTs do not behave and/or look subtly different.

This series is the second part to clean up some old inconsistencies for 
those SoCs to bring MSM8916 and MSM8939 closer together and also closer 
to newer SoCs. It's focused around cleaning up the pinctrl, mainly SDC
and audio.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (6):
      arm64: dts: qcom: msm8916/39: Fix SD card detect pinctrl
      arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl
      arm64: dts: qcom: apq8016-sbc: Drop unneeded MCLK pinctrl
      arm64: dts: qcom: msm8916/39: Cleanup audio pinctrl
      arm64: dts: qcom: msm8916/39: Rename wcnss pinctrl
      arm64: dts: qcom: msm8916: Drop msm8916-pins.dtsi

 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  19 +-
 arch/arm64/boot/dts/qcom/apq8039-t2.dts            |   7 +-
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   |  15 +-
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  15 +-
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     |  15 +-
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts |  15 +-
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     |  14 +-
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |   9 -
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      |  15 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         | 582 ---------------------
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |  15 +-
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  |  15 +-
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  15 +-
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    |   9 -
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          |   4 -
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |   9 -
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 489 ++++++++++++++++-
 .../dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts  |  14 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 165 +++---
 19 files changed, 659 insertions(+), 782 deletions(-)
---
base-commit: d49f9c76d4aa210e47c92cf80264c714797c583d
change-id: 20230529-msm8916-pinctrl-6734bb76d422

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

