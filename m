Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2468C958
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBFW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBFW2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E511EBB;
        Mon,  6 Feb 2023 14:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C31661057;
        Mon,  6 Feb 2023 22:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16C4C433A0;
        Mon,  6 Feb 2023 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722505;
        bh=19z9W9tEqs9ej+0LkD2U7qqxqXr+U+U4fUJmpaY7s5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMI9JETKqF0vNLNbMeVmWeFrX74IP976PXkuQtH4iuVgLOGJVlppR545NCKW8onWr
         9oEmBQ1ILV3qoCIsHQPPUQf8M/+9DW3B+YrQQlheaMEUbjZOIgf0cQTkt1cB7L3RAQ
         i25x9ekFkdx2Zi6VzFPvapz+2wOcEl3TDqRNwSnQOZKWdSnrUomU7VVIzvnXxZ6n3N
         Wu4RyXND4kH8ucgsBsIMpcRT/7ELmCGqR2650y8rYrcgSGrJMZcI8C++/uC5hKhGaf
         yIpAtgLaJIKFt2IXh8Jlt7f8GvCFr6Uz5zGOWDDbX4dvJhoQPGccMW9vCPEEIVWnLo
         H898ymLr7XAEw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] soc: qcom: Introduce PMIC GLINK
Date:   Mon,  6 Feb 2023 14:30:32 -0800
Message-Id: <167572263441.3569822.11639506996276775147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20220818031512.319310-1-bjorn.andersson@linaro.org>
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
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

On Wed, 17 Aug 2022 20:15:08 -0700, Bjorn Andersson wrote:
> This implements the base PMIC GLINK driver, a power_supply driver and a driver
> for the USB Type-C altmode protocol. This has been tested and shown to provide
> battery information, USB Type-C switch and mux requests and DisplayPort
> notifications on SC8180X, SC8280XP and SM8350.
> 
> Bjorn Andersson (4):
>   dt-bindings: soc: qcom: Introduce PMIC GLINK binding
>   soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
>   soc: qcom: pmic_glink: Introduce altmode support
>   power: supply: Introduce Qualcomm PMIC GLINK power supply
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: soc: qcom: Introduce PMIC GLINK binding
      commit: 68d868adc121f68edde0f4c0e16923103b868945
[2/4] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
      commit: 58ef4ece1e41ac525db3e79529909683325d85df
[3/4] soc: qcom: pmic_glink: Introduce altmode support
      commit: 080b4e24852b1d5b66929f69344e6c3eeb963941
[4/4] power: supply: Introduce Qualcomm PMIC GLINK power supply
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
