Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DB6BC14C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjCOXeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjCOXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24041A6141;
        Wed, 15 Mar 2023 16:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F272461EBD;
        Wed, 15 Mar 2023 23:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B285C433D2;
        Wed, 15 Mar 2023 23:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923158;
        bh=JO+n2UjebySfWy/FriCixlRx6TR0n6mTB8k14bItIIc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ADEDf7vDHa6HCEdEg/XFXD50W1EhX+rv2pCUlZQyp6GWi2JzpbZFSzFyxcZE4oHhS
         vMXVNDdF+dgZQ1MhNtZC2shdzaU1D89XWOj/jwNEXkMQrG0Xy50iXdUsR4yImVEiFJ
         MnpuAd2uxOGOUHV3WJjhH2Vr9lGx2lu+TupJUNb0/QnixYscC/Ak/FhtMx1MUnBRwI
         3K/lj5rX7QsJJAFjwhtGdzo2XMTZtj4+TxiCU/Okvz5e3EznFVzoZYQF551xCus0Vi
         eRlr7vOuyrvgppm2XjzKhnoKAsHHKxaFMR98TvjeYrIzYHQ1M85XIkYzpfe6gGLLqB
         E7mKN4EEOa8tg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v2 01/11] arm64: dts: qcom: drop incorrect cell-index from SPMI
Date:   Wed, 15 Mar 2023 16:35:10 -0700
Message-Id: <167892332568.4030021.8736562994491042412.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
References: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 8 Mar 2023 13:58:56 +0100, Krzysztof Kozlowski wrote:
> The SPMI controller (PMIC Arbiter)) does not use nor allow 'cell-index'
> property:
> 
>   sm8150-microsoft-surface-duo.dtb: spmi@c440000: Unevaluated properties are not allowed ('cell-index' was unexpected)
> 
> 

Applied, thanks!

[02/11] arm64: dts: qcom: sm8250: drop incorrect Coresight funnel properties
        commit: d24539a6a98c19c81deb4004ec5023b3ee6e7bb8
[03/11] arm64: dts: qcom: qdu1000: drop incorrect serial properties
        commit: 9b8bfc443349c0c220438c6ac8839774210c9ba2
[04/11] arm64: dts: qcom: sdm845-db845c: drop SPI label
        commit: 9135ab4a53f7e967456b792ec6fc21ecaf06032b
[05/11] arm64: dts: qcom: apq8096-db820c: drop SPI label
        commit: 9b0ff841f0724fb4bf0218e33afba46a097b258c
[06/11] arm64: dts: qcom: ipq6018-cp01-c1: drop SPI cs-select
        commit: afa8eb675fc6dd606783ed2350de90927d6fb9d3
[07/11] arm64: dts: qcom: msm8953: correct RPMCC node name
        commit: 35343312a4399074e7a20ab086d29273bb5f1ad2
[08/11] arm64: dts: qcom: msm8953: drop clocks from RPMPD
        commit: 9bc3dc3c9dc1b9e594a6d56210b857f9ffca5853
[09/11] arm64: dts: qcom: msm8994: correct RPMCC node name
        commit: e96d20585c84aca49771609b6bca3a7c30f7d397
[10/11] arm64: dts: qcom: sc7280: fix EUD port properties
        commit: a369c74243ca4ad60b9de0ac5c2207fb4c4117b8
[11/11] arm64: dts: qcom: msm8996-oneplus: do not enable incomplete nodes
        commit: 5ff9e238a17733669d6dd1992cae19e1684fe5ae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
