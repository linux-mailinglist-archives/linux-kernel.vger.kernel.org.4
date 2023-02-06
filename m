Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2615B68C95F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBFW2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBFW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D7F12875;
        Mon,  6 Feb 2023 14:28:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C43E61050;
        Mon,  6 Feb 2023 22:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D315C433D2;
        Mon,  6 Feb 2023 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722507;
        bh=pk8ds+WOqWCtZmkphDQqfjXHCVD9+oDrqLXduRq0AEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pILWi1IE1eqNCxZkfGHP9hRqLMM/LbEHTHYwfRUfheKvj5KjPnAxrlu4Susad6Wxp
         +NNJmy+2WVTummsfGfG1utbpNN2OEOkEHlM74E24X7Oxzay0hSTd5Sb7oOvV2uXZHL
         9Eq5yQDyk95t7Z6pP5V/WlFHSa5z2B4RfT3B8OzEKluYsuYCMa+5V5mQqmJ99Aq2fa
         fACnVUJ5zzHEgDNEGzz9/IWI2ywl1oW0RSrz6fgUEw51HxZ5UkIUAVLEorE5zombiZ
         cCVx6e5VumE8IXujZNfdTGLa47f6Yj0AZUWORvfgrHJJMSFI7ktSl+wSkKl+ZR60Ud
         bOmgbLEzlayMw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/4] soc: qcom: Introduce PMIC GLINK
Date:   Mon,  6 Feb 2023 14:30:34 -0800
Message-Id: <167572263441.3569822.8165959497180624558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
References: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
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

On Tue, 31 Jan 2023 20:18:49 -0800, Bjorn Andersson wrote:
> This implements the base PMIC GLINK driver, a power_supply driver and a
> driver for the USB Type-C altmode protocol. This has been tested and
> shown to provide battery information, USB Type-C switch and mux requests
> and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
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

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
