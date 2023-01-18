Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCB672BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjARWur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjARWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71943656FF;
        Wed, 18 Jan 2023 14:50:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0033761A8D;
        Wed, 18 Jan 2023 22:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C20C433F1;
        Wed, 18 Jan 2023 22:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082235;
        bh=x2CPrDH4N8Ln3uLQa0HkDU8iJh2M1bgQmAhx0PE5EV8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WgVNyAQGK17s9FyiF6gIqE9KIXyBSlbtlhM9iRH4rDuU6Kdki6g5NSAGPMnKVcf8/
         uCoQkKMLSTeAe4TwDthrcTeHPf9I+h4HFW3TN9+aif4gcingehBWsRBDDxkjK710D1
         2DbFTBOCS75glHiodMk53eY80/QIzoRJGkVzosGhtT0r9mA6mZLYKchPzN1FAoL19h
         8ap4XemIGuzkkgV29W0EEr4blqjeIZxPPCS92OEsvNjYC+XPpP/nhfcsQF49ZXEkRo
         +xeKaiIKq6fUAW0fNj++JJWEEVGwgn5veRIZ1IaZr7Yv7AWRlfCLjOTzItAG/orchi
         K1KrjQa+NmuBw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org
Subject: Re: (subset) [PATCH v2 1/3] arm64: dts: qcom: sm8250: drop unused clock-frequency from rx-macro
Date:   Wed, 18 Jan 2023 16:50:25 -0600
Message-Id: <167408222414.2952004.17106947349397428240.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230118094224.51704-1-krzysztof.kozlowski@linaro.org>
References: <20230118094224.51704-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 18 Jan 2023 10:42:22 +0100, Krzysztof Kozlowski wrote:
> Neither qcom,sm8250-lpass-rx-macro bindings nor the driver use
> "clock-frequency" property.
> 
>   sm8250-mtp.dtb: rxmacro@3200000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8250: drop unused clock-frequency from rx-macro
      commit: 30186f8573af259ff9928512c3256bf7f66e48e6
[2/3] arm64: dts: qcom: sc8280xp: drop bogus clock-controller property
      commit: c75286fe8968cb0cc4f0cc83caa2b2b38f6f6d4f
[3/3] arm64: dts: qcom: sc8280xp: drop unused properties from tx-macro
      commit: 91238d52fb0730564eec520541ec7bc4e120ae52

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
