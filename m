Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93562060E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiKHB3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiKHB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF62DA80;
        Mon,  7 Nov 2022 17:28:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C9AD61373;
        Tue,  8 Nov 2022 01:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B465BC43144;
        Tue,  8 Nov 2022 01:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870892;
        bh=U85DRq54TH+b0df/abPxixa1UfJG6ZFMZomXBCrdXLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDfpnymLLO6dtcHjuPLZs316twbrd8ji9HHjHC3rzkEyVNSNep7PNvsiM0MYvM6o/
         M6yyExRr220wJoXFoxTqL6nU8czmKcOIV5mEjQ89U7hk/PA7jlK/vQU2oBRV9gIozp
         HgHFDSW0Ys/+N0/LPdl+QlYyygpl5OY1EnWCIPLk+DDkA4A1WAOT+1zfestOIPPp1g
         xvq/JAI3Zvt3zAlkc97aoljRvAUmSTMdvGtBkYQYuLyuCnQdkMiOAGUFiA8tU/XwNt
         7XezW0fwt7kAi3dBD9u/9HUoH06K8/ZJTlEpFL/9X6P4FoSYFqSqCZ36ohq0/I4VD2
         SeA0KtRNAwlEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        sheng-liang.pan@quanta.corp-partner.google.com
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Add LTE SKU for sc7280-evoker family
Date:   Mon,  7 Nov 2022 19:27:41 -0600
Message-Id: <166787084685.599230.17663027600845570716.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

On Mon, 7 Nov 2022 17:43:40 +0800, Sheng-Liang Pan wrote:
> This patch add common dtsi and WIFI/LTE dts for evoker.
> 
> Changes in v11:
> - sort out the "Status" property with sc7280-herobrine-audio-rt5682.dtsi
> - sort out the "Status" property with sc7280-herobrine-audio-rt5682-3mic.dtsi
> 
> Changes in v10:
> - add sc7280-herobrine-audio-rt5682-3mic.dtsi then evoker can include it
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
      commit: f1714f85d40e53645139824d0d903c1e050cdf00
[2/5] arm64: dts: qcom: sc7280: Add LTE SKU for sc7280-evoker family
      commit: ef4fc701d4021eeb2a614fdffb3231560ee43c18
[3/5] arm64: dts: qcom: sc7280: Add touchscreen and touchpad support for evoker
      commit: 928263d17413e406d7bbcd10e585b081f36c4114
[4/5] arm64: dts: qcom: sc7280: add sc7280-herobrine-audio-rt5682-3mic3.dtsi for evoker
      commit: 5977c14285ca9ba933f4d048b0d995b046727788
[5/5] arm64: dts: qcom: sc7280: sort out the "Status" to last property with sc7280-herobrine-audio-rt5682.dtsi
      commit: 3d11e7e120eee29ef837830bee8442195a2c4552

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
