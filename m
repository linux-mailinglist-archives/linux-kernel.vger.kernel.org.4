Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313B66641B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjAKTuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjAKTtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:49:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E2F58B;
        Wed, 11 Jan 2023 11:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 828DBB81C86;
        Wed, 11 Jan 2023 19:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A90C433D2;
        Wed, 11 Jan 2023 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466555;
        bh=oEwO7ZXrcpQzrATh5NPAsflmf+OEGsejMP7YJCvVI7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1tgHmzWAuwvGvGWLr8ljkjLJ0s9rPSFKPR7qqtWdV/uw7qOCPZHI2fQ0QWyI2Moj
         K1QBk4OsxyI6AwguHLBpp7NqGtUZUa5YMwUdbEYco0qDoAmycK6s2H7Lb2oAkgr4Kg
         z+Y4p8Iz1WK76phxoNSFKopoBLZsyhhIy1goKoeIi+f7dOwXjsOcpyismBrhELMHMU
         3uG1F9nt0ZHVNR+idJughK208zRPba4O9rrMAuQ/DLcCI4SPlqC3ZK5Z4cA2HRjQNX
         yHD2NDSK1/V13azSu0twALjWxUJsWX+Kefg8otaFk2cXl+jXfh+E4u7I/E6iaYcGfs
         4FcTwtsqUK/Zw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linmengbo0689@protonmail.com, linux-kernel@vger.kernel.org
Cc:     macromorgan@hotmail.com, stephan@gerhold.net,
        krzysztof.kozlowski+dt@linaro.org, stano.jakubek@gmail.com,
        linux-arm-msm@vger.kernel.org, jagan@edgeble.ai, agross@kernel.org,
        miquel.raynal@bootlin.com, nikita@trvn.ru,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        konrad.dybcio@linaro.org, ~postmarketos/upstreaming@lists.sr.ht,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH v6 0/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add initial device tree
Date:   Wed, 11 Jan 2023 13:49:04 -0600
Message-Id: <167346654442.2315924.10894600754984557629.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230107132932.139669-1-linmengbo0689@protonmail.com>
References: <20230107132932.139669-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2023 13:31:30 +0000, Lin, Meng-Bo wrote:
> v6: Sort pinctrl properties and remove stray newlines in pinctrl.
> v5: Reword the flash LEDs patch.
> v4: Fix missing Makefile entry in v3.
> v3: Sort properties in l11 and nodes in touchscreen pinctrl.
> v2: Set property status = "okay"; as the last property.
> Reword the bindings patch.
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add initial device tree
      commit: 662a90c4e72579967cb682fb6b4c6f061cc00ab9
[4/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add touchscreen
      commit: 143b4b845f58380a334cc0b9242567e602233743
[5/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add flash LED
      commit: 599a259a4b3b6c0d4c4b51d9e58408ac6de779f0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
