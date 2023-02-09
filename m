Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947C268FEFF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBIEcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBIEb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5DB30FA;
        Wed,  8 Feb 2023 20:30:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A77D1B82000;
        Thu,  9 Feb 2023 04:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6344C433A7;
        Thu,  9 Feb 2023 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916505;
        bh=85sbLeGxPzV8mo+ZBBwSG/kEN7nGGDAUiAU31Ao2L8o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dlmYQyCpnP6W+QuHrKlvGz+2Br2qEE5NBORsIlK5YdX0a7uOWM8DiCdFxBk5o5E/q
         +3GcLG3vzBE5aduxncAfmFigIJfZIY3tyKGy+HEPggPzmR22afd51hCf6yowE1TCqx
         pzKTmcCFAuRT6IEcUdPrOUKAC9YhY3HagwLilGbcwPjavrqkf2oah2itBhyYnqrlp7
         3EEc7AMUGg+cLphNM3jsQw27OwFBI6f33wTDwSEXF3yLraSATqrHqEJRySUUl3N1cn
         Lvp+Pmf6Q9F8PUm7wevaxpVxpZc3g364DZ+V0dNB1pUx4aZgUPUBnF6Q6tkxlBHYGH
         OjJHhWQJUb1mA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 01/11] ARM: dts: qcom-sdx55: align RPMh regulator nodes with bindings
Date:   Wed,  8 Feb 2023 20:23:01 -0800
Message-Id: <167591660368.1230100.7808110438191549688.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 12:43:37 +0100, Krzysztof Kozlowski wrote:
> Device node names should be generic and bindings expect certain pattern
> for RPMh regulator nodes.
> 
> 

Applied, thanks!

[03/11] arm64: dts: qcom: sa8295p-adp: align RPMh regulator nodes with bindings
        commit: f8e749dc7193a4b727659a69f5760a6a94ffcb1e
[04/11] arm64: dts: qcom: sc7180: align RPMh regulator nodes with bindings
        commit: adfb9d68e976c79e07cb64a87f58ea5f4d243a6d
[05/11] arm64: dts: qcom: sc8280xp: align RPMh regulator nodes with bindings
        commit: 4275d2802b4bfbf06780be778538d0872e657dfd
[06/11] arm64: dts: qcom: sdm845: align RPMh regulator nodes with bindings
        commit: 86dd19bbdea2b7d3feb69c0c39f141de30a18ec9
[07/11] arm64: dts: qcom: sm7225: align RPMh regulator nodes with bindings
        commit: 45e9251bdd1118cd97061aec502a5747a1cf1bd6
[08/11] arm64: dts: qcom: sm8150: align RPMh regulator nodes with bindings
        commit: 5a88bb6146b39773534b627d3431bf7d49115abd
[09/11] arm64: dts: qcom: sm8250: align RPMh regulator nodes with bindings
        commit: 537f572b2f681f48e58a26bef46611f03b33681e
[10/11] arm64: dts: qcom: sm8350: align RPMh regulator nodes with bindings
        commit: 0223fe2b3f46e6cfe644563ec7217d2dc7d603b6
[11/11] arm64: dts: qcom: sm8450: align RPMh regulator nodes with bindings
        commit: 6216007a3bcd0deab1a5695c32a141e8a4493ad9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
