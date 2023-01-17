Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2266E6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjAQTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjAQTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E8C5C0DA;
        Tue, 17 Jan 2023 10:24:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E1E1B819A1;
        Tue, 17 Jan 2023 18:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541F2C433EF;
        Tue, 17 Jan 2023 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979881;
        bh=nzfUs+1A1pevf8jvETmlvd0NaCb8+CcDm6mOkmkO39E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EwPcM+YwQlJqQesodktRNEkTaliGUwliLSeClIJcjSItat6jdcN/q15cxjyZS8lJQ
         lL7Cp04qXwjQ99iDWIHMvb0NTUPZQ9wTyK1pBtcNQ3pyB3be5tp1wwzu0AoyhGuvTZ
         vFWK0arI2eaSVpu5vDcmkutLHHYX0lNefPsMd6Rz5uN5+4/o1uClqgUYXmzqr3IdTH
         bbgO+hYSK4E9GcWavDahuMbXOsKRZGs/8DiVtfJdfc51MTazOye8q3B6/Se8mWHO1u
         99MIFMQF6+8cbU4Pe5fk45vwECdqO6AVhc44A3mdPjKGh4lIlvzXMIu4zu31zmJ5Ts
         hjqIwjND5ZDcA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, sboyd@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, mturquette@baylibre.com,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,camcc-sm8250: extend clocks and power domains
Date:   Tue, 17 Jan 2023 12:24:26 -0600
Message-Id: <167397986255.2832389.5822400891524503974.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221224214404.18280-1-krzysztof.kozlowski@linaro.org>
References: <20221224214404.18280-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Dec 2022 22:44:04 +0100, Krzysztof Kozlowski wrote:
> Add clocks and properties (power-domains, required-opps) already used in
> SM8250 DTS:
> 
>   sm8250-hdk.dtb: clock-controller@ad00000: clocks: [[46, 10], [44, 0], [44, 1], [45]] is too long
>   sm8250-hdk.dtb: clock-controller@ad00000: clock-names:0: 'bi_tcxo' was expected
>   sm8250-hdk.dtb: clock-controller@ad00000: 'power-domains', 'required-opps' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: clock: qcom,camcc-sm8250: extend clocks and power domains
      commit: f6f10b4ae5e5c986f521cc2282721f3c1b158df4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
