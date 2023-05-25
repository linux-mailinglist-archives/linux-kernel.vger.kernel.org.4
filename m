Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4B7104C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbjEYE4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjEYEyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA91173A;
        Wed, 24 May 2023 21:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2DC36428C;
        Thu, 25 May 2023 04:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3057C43443;
        Thu, 25 May 2023 04:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990298;
        bh=SGDPLpsa4eFNFY+Mpqor59HeE4gd6oUtMpE0SSPmX4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwg2ZxoSzZ4WkTX5XKXZjNCp3Ygprzon7pGpDY5K7JO2vOgb045rENVEWdvmvwSa4
         wmlzAyIfKeJDoLnGSP7o++KJjHVr3aInJ9i6PWP+8iIkwU1a4nROHvV3apMLK62pDL
         umgBpu8OdPQVrhEH1R9+cN69aEOLcS9RvDLV45ibcbWJGrgr4CqHM32UYtGplqemuC
         d6TsAztkqHiaNCVAoJli3Xk5yqx58FcQk4dKowi9vf9hgw1KAQ+teeTH8wLbUUzN5v
         DiKvMXx95dEbvgFmr5OpewrHtQYPIW4Lw+g4sJ+VV5rBZNtsmbK4vbYx/SiRRiNKiQ
         d9D60Wb8271mg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: clock: qcom,gcc-sm8250: add missing bi_tcxo_ao clock
Date:   Wed, 24 May 2023 21:54:17 -0700
Message-Id: <168499048185.3998961.10125805133783449583.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516105241.30091-1-krzysztof.kozlowski@linaro.org>
References: <20230516105241.30091-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 12:52:39 +0200, Krzysztof Kozlowski wrote:
> The initial SM8250 GCC driver added in commit 3e5770921a88 ("clk: qcom:
> gcc: Add global clock controller driver for SM8250") already consumed it
> on the clock.  This fixes warnings like:
> 
>   sm8250-xiaomi-elish-csot.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk'] is too long
> 
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: qcom,gcc-sm8250: add missing bi_tcxo_ao clock
      commit: 2310ab77f1ee2611e34345ca1746c9e8aaa5bc31
[2/3] dt-bindings: clock: qcom,gcc-sc7180: document CX power domain
      commit: 21a95637a3fda45e6d3fd7a57d6ada204e28e484
[3/3] dt-bindings: clock: qcom,gcc-sc7280: document CX power domain
      commit: 7a52084ae14f49582b0ce19106cdad094499e204

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
