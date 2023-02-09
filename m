Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A975168FEAF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBIE0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjBIE02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:26:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F53B3C0;
        Wed,  8 Feb 2023 20:25:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B84618BC;
        Thu,  9 Feb 2023 04:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E1AC433A4;
        Thu,  9 Feb 2023 04:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916506;
        bh=sXPmE1NwV0AQh6XnndllhRLAppGtDi+0TYh9xHQh7bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/3rgZYCxqKC96r/jMPm0IhdJwbV4zwyOO14MBMSQENnA5/mKc9ODY/x6GmiRalzV
         mX/4RCjDzk+qVcSiilT8stfWegkIHNJGQ0EQa8XFo+cuLTyUULq8g8QZ1h1AKMSSuo
         FYKkriQKKtV2jELgeJNnILC6bq+/aMYjcUvAoIsozQWDTC4aM5PVZJNra6wgnpRbq9
         t246TLmiBwmGHhZUzCspuHFAkRItKp1+5o/bVd0X5HvO+pH9n7jSWSHpulrE0a0gcU
         RulwyYMhUyVehVGoLBEiOmSILmaymkTNq1IKa78Nq//NdgKDMtSltLasKKsuuAnziv
         GKDM4ncgTwZXw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sc7280-herobrine-audio-wcd9385: drop incorrect properties
Date:   Wed,  8 Feb 2023 20:23:02 -0800
Message-Id: <167591660365.1230100.1264290412808838476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119122205.73372-1-krzysztof.kozlowski@linaro.org>
References: <20230119122205.73372-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 19 Jan 2023 13:22:04 +0100, Krzysztof Kozlowski wrote:
> The sound card does not expose DAIs and does not use custom qcom
> properties, so drop '#sound-dai-cells', 'qcom,msm-mbhc-gnd-swh' and
> 'qcom,msm-mbhc-hphl-swh':
> 
>   sc7280-herobrine-crd.dtb: sound: '#sound-dai-cells', 'qcom,msm-mbhc-gnd-swh', 'qcom,msm-mbhc-hphl-swh' do not match any of the regexes: '^dai-link@[0-9a-f]$', 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc7280-herobrine-audio-wcd9385: drop incorrect properties
      commit: a1efba3362fe8acfc3dbd79f0903968186e249b0
[2/2] arm64: dts: qcom: sc7280-idp: drop incorrect properties
      commit: a8ce63441a2ea49606f3b0239df98c5fb0a3b4d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
