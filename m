Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B401F60221C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJRDKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiJRDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F209AF9D;
        Mon, 17 Oct 2022 20:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1821761350;
        Tue, 18 Oct 2022 03:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF98C43145;
        Tue, 18 Oct 2022 03:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062422;
        bh=OYhayJdlSMlvNRm/ZPHMeXnWy/RguZHnO0rCT/oKArY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oQ55c1a5ueo/skyg5Z0n6ZI0QllNhpq9xXL/+kkPyM6DDzdkh3lEMRk9oPgz/ucWD
         fzxfRzr28fmHkUqKFqhk6tAtaqFN/iKWrYQN+IatBv8VEiwquIkukbbqC68wyqWIKT
         eJF/aFj4EW0HA7ilnB0kX7wGAGiWRgwvygTpq62bn0Yv8S1PHTI+9EBtx1wKotj/+1
         +gEPFVcF5qhBfqftT5NWJaoLdw5crH/r+pF0ldoFLccu53YRxDgCawclm6AXo0Lvgb
         JiOi1GPWhawWyA2qV1tK0vwEgLoKMLk6aCxtxy6Xp93qQzY/nzBF5brGQo6XurRCfT
         Zmqv3Ms2axQXw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v2 00/16] pinctrl/arm64: qcom: 4th set of Qualcomm TLMM pinctrl schema warnings
Date:   Mon, 17 Oct 2022 22:05:36 -0500
Message-Id: <166606235840.3553294.16426052412886426024.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 21:29:38 +0200, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Check for function on non-GPIO pins was moved to common TLMM schema, thus
>    new patch #12: dt-bindings: pinctrl: qcom,sm8250: drop checks used in common
>    TLMM
> 
> 2. Above also makes minor context changes in patch #13 "dt-bindings: pinctrl:
>    qcom,sm8250: fix matching pin config"
> 
> [...]

Applied, thanks!

[01/16] arm64: dts: qcom: sm8250: align TLMM pin configuration with DT schema
        commit: f76361749b607d52cb8eb9a7398999ee6cf17767
[02/16] arm64: dts: qcom: sm8250-sony-xperia-edo: fix touchscreen bias-disable
        commit: 7ff4a646fae3697b039c6b684786a1e309e8445c
[03/16] arm64: dts: qcom: sc8280xp: align TLMM pin configuration with DT schema
        commit: 91c4431b0204d720bee3062fa8e6c6ac789100b4
[04/16] arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema (really)
        commit: ec0872a68dcf9fba109fd7ac51843a49984f7586
[05/16] arm64: dts: qcom: sc7280-herobrine: correct number of gpio-line-names
        commit: 442b13a72a20e30b1883e425a49b337e9fa85069
[06/16] arm64: dts: qcom: sc7280-idp-ec-h1: add missing QUP GPIO functions
        commit: d0ca0de64537d129d7f4f7e878a8c20eea751a7c
[07/16] arm64: dts: qcom: msm8953: align TLMM pin configuration with DT schema
        commit: 305dd3f89b492de7672bf53e016e7dcf14ba9e85
[08/16] arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
        commit: 72e69d4d8d3e460806311f2b53b1807e3ca1112a
[09/16] arm64: dts: qcom: sm6125-sony-xperia: add missing SD CD GPIO functions
        commit: f20a687fddf42f7d55a4992b9ecc3a663c34a6b7
[10/16] arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
        commit: 179baddcc6905e6e657c35c3a380afe55b67c98d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
