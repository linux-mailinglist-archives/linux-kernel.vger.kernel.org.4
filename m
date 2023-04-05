Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC56D72F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbjDEEG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjDEEGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1753A9D;
        Tue,  4 Apr 2023 21:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58364639A7;
        Wed,  5 Apr 2023 04:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFB5C4339E;
        Wed,  5 Apr 2023 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667578;
        bh=JV8Mouc7S7pJzikGt77wh+4aYyFkSTgqfM8iAAkbwvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1eQQW7UKR+D0ACLxA8b+RNOJJQuF/mE6W/cP2FZf0rlULxRiI0mnpFzOXTJqau/7
         R+lOmXUF5yPs7tLIoANm1rhBP7wTZGgVEUBBDJs8qAK7QZK2Yf66e2tP8ccRvHqNXT
         cdved/lbGFlJCn8MJ/oua+NgQx5x0GDOiaPVc7zXcJeA6kG/FTwdTAbhZRnyYnbaSW
         pCBmYlmF62OKfpzZ0m19mf7yVJZi5C34JCVKlvezg7jC8kJyi/xC+oKRCHKy4x64ZU
         rLCNguKvRYvMGueyalZhtOYjagwwF0NAHMfgWNc4PMV4ohOeh2ahuD+7FXALPgDY7L
         nFZ5gE4WSDnHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/18] arm64: dts: qcom: sa8775p: add basic PMIC support
Date:   Tue,  4 Apr 2023 21:08:50 -0700
Message-Id: <168066774419.443656.435613380071330612.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327125316.210812-1-brgl@bgdev.pl>
References: <20230327125316.210812-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 14:52:58 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This adds support for a number of PMIC functionalities on sa8775p. The PMIC
> used on the reference board is pm8654au which is another variant of the SPMI
> PMIC from Qualcomm with an automotive twist.
> 
> v2 -> v3:
> - add GPIO line names for the PMIC GPIOs on sa8775p-ride
> - add missing GPIO chips to the PMIC .dtsi
> - add missing thermal zones and alerts
> - add regulators (driver support and regulator settings for sa8775p-ride)
> - add missing PDC mappings
> - squash patches 7 and 8 to avoid adding code without users
> - dropped Krzysztof's Ack from patch 3 as it now extends the max number of
>   mappings so most likely needs a second look
> 
> [...]

Applied, thanks!

[01/18] arm64: dts: qcom: sa8775p: pad reg properties to 8 digits
        commit: 3fd7e2eec8f4fedbe3b252cf436be8527f7a5f82
[02/18] arm64: dts: qcom: sa8775p: sort soc nodes by reg property
        commit: f95f988cf7b609157630dd1f2f7e8d297aadbe2b
[04/18] arm64: dts: qcom: sa8775p: add the pdc node
        commit: 8696cd072e955bd6f5df757774e47f0b9dd29920
[05/18] arm64: dts: qcom: sa8775p: add the spmi node
        commit: fdd55b3babedce5abd1c1f90afc3ab2199a772ad
[07/18] arm64: dts: qcom: sa8775p: add support for the on-board PMICs
        commit: 634a3de323fc5c67c144919e298259d8d9d44a4b
[08/18] arm64: dts: qcom: sa8775p: add the Power On device node
        commit: d2d9a592746cd454bd5b8f72193f2d3db2e62a44
[09/18] arm64: dts: qcom: sa8775p: pmic: add the power key
        commit: b3a755ba16e6f61d93c811b827edacc9946b0500
[10/18] arm64: dts: qcom: sa8775p: pmic: add support for the pmm8654 RESIN input
        commit: cecff1f5429d975df9649376e2bd5a2fb004f988
[11/18] arm64: dts: qcom: sa8775p: pmic: add thermal zones
        commit: fa40ca07e943333a14d247988ef5008a59949153
[14/18] arm64: dts: qcom: sa8775p: add PMIC GPIO controller nodes
        commit: e5a893a7cec5776e10c25d7fa80b5ad1edf88c17
[15/18] arm64: dts: qcom: sa8775p-ride: set gpio-line-names for PMIC GPIOs
        commit: 81767c1591dcb711f1f78a80e510b667b1fb5718

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
