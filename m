Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DF672D27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjARX4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjARXz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:55:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F938E82;
        Wed, 18 Jan 2023 15:55:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E488B81FA0;
        Wed, 18 Jan 2023 23:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48DDC433EF;
        Wed, 18 Jan 2023 23:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086152;
        bh=8wQGaLqz2e47AtqNYcML/agZ6qTvHtZiOK/rd/h/AJc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IoZWeN32eWOCAUvDJHKM1CkI9reyWwK2PRWqtjCTP+AYGo25ZCUx7AmoBBD9udyf2
         NKy95fddjJweB1cQUFLL5q36zpI6oVdomPLr6aJDNkddx+RnAa/ZwT9bVhfbU91WD8
         AmmTMIbsWSZMIpG0EowhJGaHbme+jC1/FEVGH3Ssna1c1OyVVqjHm4F53pDTntBSJW
         Db0jMC1NnhYiLGdnov9sYKH+j1j7pOruDjLopXyDEOszqoMDhaDCZLlbEcYWBBBcnK
         5icMulIPHZgufnb0iLKVAn1wzGmfCr5bufZrtWQrSxBTwBh4CCwcHm7pjrd68I1muY
         EnUH9aCHcrowA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     stephan@gerhold.net, Rob Herring <robh+dt@kernel.org>,
        shawn.guo@linaro.org, devicetree@vger.kernel.org,
        martin.botka@somainline.org, krzysztof.kozlowski@linaro.org,
        linus.walleij@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        me@iskren.info, mailingradian@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        vkoul@kernel.org, srinivas.kandagatla@linaro.org,
        quic_vamslank@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH 1/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: correct pins pattern
Date:   Wed, 18 Jan 2023 17:55:36 -0600
Message-Id: <167408614056.2989059.509312546963421411.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 30 Dec 2022 14:56:37 +0100, Krzysztof Kozlowski wrote:
> SC8280XP LPASS LPI pin controller has GPIO 0-18:
> 
>   sa8540p-ride.dtb: pinctrl@33c0000: tx-swr-default-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
>     'bias-bus-hold' does not match any of the regexes: 'pinctrl-[0-9]+'
>     'gpio2' does not match '^gpio([0-1]|1[0-8])$'
> 
> [...]

Applied, thanks!

[8/9] arm64: dts: qcom: msm8916-samsung-a2015: correct motor pinctrl node name
      commit: de385ae2aa629a7d3298faa3f3fe9d19bf0b4f6a
[9/9] arm64: dts: qcom: sc7280-idp: add amp pin config function
      commit: bf37b5bc72204a69636c26bb8cd90cfc70ca8056

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
