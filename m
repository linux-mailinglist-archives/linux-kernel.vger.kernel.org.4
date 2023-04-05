Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59076D7316
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjDEEHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbjDEEGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C046AC;
        Tue,  4 Apr 2023 21:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C48AC639A7;
        Wed,  5 Apr 2023 04:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B395C433EF;
        Wed,  5 Apr 2023 04:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667590;
        bh=UCIJrk5C7tXMIRoKZ9arUPmuUh+SH3JZdi0MA7K4JKM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RI4lLVXTvpDMHLnltzbM+3hLs/3vSuPH8Aq+7rft6bvSqLtkVpokv4Dl/EYExQ21X
         +Wd4dlMPT92gWbLQ0oOgOxUS9sheB1sbdeNVA1NH/BvWizKw+750xgCTatFTlp2L4w
         lBlGdlOWFtUmhrXRjCdE0pB4IJZcKUquxFmxhubq1wb8ZDZA4cmG452y99H6xg+EdP
         gp3CVGpU+50QEYBX4fhMtSdj9yiRW7cD59R0bmpYETZ3/Jl45TeS75x2R2+cdiH+Ty
         QPqdnQHgz3Hu/Qk0uxkDznpU9MvPfHKSdysf5jehaocg97BqxPlRbIRIekci3ieCNp
         DEaqvsIvfLzxA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: (subset) [PATCH 1/8] arm64: dts: qcom: sda660-inforce: correct key node name
Date:   Tue,  4 Apr 2023 21:09:01 -0700
Message-Id: <168066774411.443656.6519713034118640536.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 12 Mar 2023 19:36:15 +0100, Krzysztof Kozlowski wrote:
> gpio-key bindings expect children to be named with generic prefix:
> 
>   sda660-inforce-ifc6560.dtb: gpio-keys: 'volup' does not match any of the regexes: ...
> 
> 

Applied, thanks!

[1/8] arm64: dts: qcom: sda660-inforce: correct key node name
      commit: 0d8d77228aa1efec69f92ef92e1cd9270c1151c4
[2/8] arm64: dts: qcom: sc7280-herobrine-villager: correct trackpad supply
      commit: de88b1759b35086d5e63736fb604ea2d06486b1a
[3/8] arm64: dts: qcom: sc7180-trogdor-lazor: correct trackpad supply
      commit: 52e2996f253d82520011340d40dbc1c76ea79208
[4/8] arm64: dts: qcom: sc7180-trogdor-pazquel: correct trackpad supply
      commit: 24f39eec6a70768e7c2eb2f3d8158f45050ff75a
[5/8] arm64: dts: qcom: msm8998-oneplus-cheeseburger: revert "fix backlight pin function"
      commit: 97b4fdc6b82d6d5cfb92a9b164540278720fb700
[6/8] arm64: dts: qcom: msm8994-kitakami: drop unit address from PMI8994 regulator
      commit: 3555dd528ba9c08d6ccd56239c695dbeac3b63e3
[7/8] arm64: dts: qcom: msm8994-msft-lumia-octagon: drop unit address from PMI8994 regulator
      commit: 7a202df0f3eed006e4a9e7c06d62cf67be56c14c
[8/8] arm64: dts: qcom: apq8096-db820c: drop unit address from PMI8994 regulator
      commit: ec57cbce1a6d9384f8ac1ff966b204dc262f4927

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
