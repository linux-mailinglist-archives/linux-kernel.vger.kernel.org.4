Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA271499D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjE2MrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjE2MrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:47:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC1C2;
        Mon, 29 May 2023 05:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685364423; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fqiCkOScz2HzcLNBtqbQ7lIAugqiBn6iDk5K5uUE/lXRHcbo9AcQUNKziaECp28Pnt
    OITpk3uVpfOj1RVjQlZAllke1kM+JB6/k6Lai1A4te0+92VmBMwM2ig0Cfui4liOdDvV
    T/VZ+pA1qVO+wgl5wPFdCDqcLQ7Jfft7Lk8BpE2+imiS+rEtQBhi/e6Bq8FyvtOOieVx
    9KCc4KaIFM1Vu7RWWGu92nn2YO6v0F8XQw6BaQMdlPFIw+4AJ8b5hxB0b9M9FQ9QuHmH
    khEWmgsm9YZQQ12Ar7NyZq89Ozxgiqa8xQ2DOYkdHrotsXOfcNmZJg6mmjv/8HO/VaLy
    VFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364423;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FvNg423XJX5/5KqCCrdhSZUVHULUPO4gJXgiusIpNu4=;
    b=ZvHl+Yek93MqLQctTs7D7RAoAIeGmwqzYkriuaQ3SsrMAKNuKEg8sG7g0VUojWV+VG
    r2oAHbrVudD1ly1b5nFKwV3Lo0lfVGaZfYaNOJSdidIyXB6XJ1mw5rvbP2qNzXf3Z2+C
    7YlvmWToO98jThgiq1zQQ+LhaWao8J5n2HXNaPi0pRIgFbk1Z+Sy+DvNXUw02SNRq8TS
    XXYwipCt/bsDtziXlJ0OI23Amo5ROne3KQPW7/I+N3IPM1ucvTefsWK8NTgMquR2ZgKV
    RQQxZvsv6h22aLlBtTMrFS+QrIfTRROYodQldiMv5tEuJ7VEklVv29MeKK0Ihkx4zxlV
    sWRA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364423;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FvNg423XJX5/5KqCCrdhSZUVHULUPO4gJXgiusIpNu4=;
    b=Gg/7yNx9aiE1kYdn8uTKT98rXQy6Z/Mdd/B434GMxTBHLxfD9I+z40Tiz0PdbF+PEh
    aUcCFd1bA/wRONviBT38HjBDuSXauB2rk9HwdwS3+xGkOJaVObGaqgTfmbEux/pPedRI
    5Zx2SaAtIRWudEfXPRwy2nTV77qr/1JEgAK8o/iD5UVUH9pvLkRQLZFjaS7n+Lu4gYZX
    YJv2sm6LFkZ2K1FqNaLwHJt44X6IFdICAZPu2f+ooPx7/NSbCNL85p9pd1EuumgQyRYS
    X3gNW+8ww3K/9AO682DPpeQyFuUwqnhi1Kdpj7RGjbM2eJWi/CrEmlc6gfCtUglNE8i8
    IDMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685364423;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FvNg423XJX5/5KqCCrdhSZUVHULUPO4gJXgiusIpNu4=;
    b=Jw6IA+oohFmOtOU9dc75sbYlF7+C4cHVVZQx2Bype2BLNiOMMolzGEvMI61pFNg0UT
    qwoO1DGHaJ4VQ6yjGHDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TCl3f8T
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 14:47:03 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/6] arm64: dts: qcom: msm8916/39: Clean up labels
Date:   Mon, 29 May 2023 14:46:57 +0200
Message-Id: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKedGQC/x2N0QqDMAwAf0XyvEDt7Nz2K7KHtEYN1CoNGwPx3
 xf2eAfHHaBchRWezQGVP6KyFYP20kBaqMyMMhqDd/7qgg+46np/tDfMFDkreopTGDvXd4nBokj
 KGCuVtFhW3jmb3CtP8v1fhtd5/gBddMRGdQAAAA==
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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

MSM8916 and MSM8939 are very similar and almost fully "pin-compatible", 
so there are some devices that exist in very similar variants with both 
MSM8916 and MSM8939. To allow sharing definitions for such devices the 
SoCs should be set up as similar as possible, e.g. using the same 
labels. At least for me this will also simplify maintenance and review 
because board DTs do not behave and/or look subtly different.

This series is the first part to clean up some old inconsistencies for 
those SoCs to bring MSM8916 and MSM8939 closer together and also closer 
to newer SoCs. The changes here are very minor and just focused on 
labels. I'll have some more interesting changes (including fixes) later 
but the series would have become too large.

There is no functional changes in any patch of this series.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (6):
      arm64: dts: qcom: msm8916: Rename &msmgpio -> &tlmm
      arm64: dts: qcom: msm8916/39: Rename &blsp1_uartN -> &blsp_uartN
      arm64: dts: qcom: msm8916/39: Use consistent name for I2C/SPI pinctrl
      arm64: dts: qcom: msm8916/39: Clean up MDSS labels
      arm64: dts: qcom: pm8916: Rename &wcd_codec -> &pm8916_codec
      arm64: dts: qcom: msm8916: Move aliases to boards

 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  72 +--
 arch/arm64/boot/dts/qcom/apq8039-t2.dts            |  30 +-
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   |  20 +-
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  30 +-
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     |  26 +-
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts |  26 +-
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     |  60 +--
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |  26 +-
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      |  22 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts           |   4 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |  58 +--
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi       |  16 +-
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |  56 +-
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      |  18 +-
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts      |   6 +-
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |   6 +-
 .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |   6 +-
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  |  20 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts |  12 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  |   8 +-
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  22 +-
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    |  48 +-
 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts    |   8 +-
 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts  |  10 +-
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          |   9 +-
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |  22 +-
 .../arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts |   8 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  95 ++--
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi       |  10 +-
 .../dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts  |   2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 570 ++++++++++-----------
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |   2 +-
 32 files changed, 675 insertions(+), 653 deletions(-)
---
base-commit: 048ca08c07e7be8b8df79af2d49a621fc69f7c3b
change-id: 20230525-msm8916-labels-2abf5d4074ce

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

