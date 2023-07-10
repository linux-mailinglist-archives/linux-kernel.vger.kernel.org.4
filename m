Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C674CBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGJFGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGJFFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709C11702;
        Sun,  9 Jul 2023 22:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FDAC60E07;
        Mon, 10 Jul 2023 05:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C789FC43397;
        Mon, 10 Jul 2023 05:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965487;
        bh=T+B/WN3VrdjmC1KuNLOQ31CQw6YjXZTsYFTjxZT4iAY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dgpRc8aen0BUtNEYeSoipRaS/AQATbpuEWRwXUJkPu6Zx6ulTOEsZl/AbHquhcMVN
         oJGqkZ9wSDg3/brkaIsPFgKzhsbFz1XwIl5u8jHZubtvWLE3dWhibXwuOjHNLVJj/a
         JKPBKfX9B7jQBmhgVlzr5sqcxZGxFh2tvROMM8t+31bsWX0Qw7IO4dgzR0YW7xgQ4G
         pZro90fWUEauBj4WvGbVnBtuDdROfdB8bk2VnSahMO0jO41mCfaQEshHcbCeJZxc89
         B7ZD6VU4wrcQzNregdAje5G0EUcH4vYfZSUd2kvzNhbe+sMBEUWJU1IlViSz2L92kP
         hX7AO5kbzItcw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 01/15] arm64: dts: qcom: msm8916-gt5: drop incorrect accelerometer interrupt-names
Date:   Sun,  9 Jul 2023 22:07:27 -0700
Message-ID: <168896565957.1376307.18062066320799392776.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Jun 2023 19:15:27 +0200, Krzysztof Kozlowski wrote:
> st,lis2hh12 accelerometer binding does not allow interrupt-names:
> 
>   msm8916-samsung-gt58.dtb: accelerometer@1d: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[01/15] arm64: dts: qcom: msm8916-gt5: drop incorrect accelerometer interrupt-names
        commit: c756d233715a899dd1cce4b1db4cbd50b0f55a9e
[02/15] arm64: dts: qcom: msm8916-l8150: correct light sensor VDDIO supply
        commit: 6a541eaa6e8e5283efb993ae7a947bede8d01fa5
[03/15] arm64: dts: qcom: apq8016-sbc: drop label from I2C and SPI
        commit: 031df8e650a8584d24c91fa64465e0660accd339
[04/15] arm64: dts: qcom: apq8096-db820c: drop label from I2C
        commit: d4bbcf50baa9d7f70e97a3fd3b0d5e4f599a6217
[05/15] arm64: dts: qcom: msm8939: drop incorrect smp2p Hexagon properties
        commit: 35cda57217adceee2f6bc738a1d98a2cccab709e
[06/15] arm64: dts: qcom: msm8996-xiaomi: drop label from I2C
        commit: 368f8d196976e691af9cb8e61c9c852d574759fb
[07/15] arm64: dts: qcom: msm8996-xiaomi: use generic node names
        commit: f7eb45427af670e48a9d28e6bbe7c6b8f68c3bfe
[08/15] arm64: dts: qcom: sc7180-aspire1: use generic ADC channel node names
        commit: 0ec3a3e1b84bc27d482a6cab4e7ab7e2dd26ecf6
[10/15] arm64: dts: qcom: sc8180x: use generic ADC channel node names
        commit: 978869867216e669b6bed11aa669317a11e0dc7a
[11/15] arm64: dts: qcom: sc8180x: align thermal node name with bindings
        commit: 9ca4673201cc08df152a4ec054d81ae6a6895938
[12/15] arm64: dts: qcom: sc8180x-flex-5g: correct panel ports
        commit: bee2dea5be813eafc7979c09854b447abd75dfd0
[13/15] arm64: dts: qcom: sc8180x-primus: correct panel ports
        commit: 0f06e8cbd18e7f0e016f21c870f7d7af20ffd47e
[14/15] arm64: dts: qcom: sc8180x-flex-5g: align gpio-keys node name with bindings
        commit: adc2ee325806e805f9d729f28dd1ac77dd82932a
[15/15] arm64: dts: qcom: sm6115-pro1x: fix incorrect gpio-key,wakeup
        commit: c8df0c62cb6a21b98845c44c3539aa727874cd08

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
