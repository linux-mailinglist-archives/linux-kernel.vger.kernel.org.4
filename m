Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269DD6DB420
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDGTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDGTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FEB7D9B;
        Fri,  7 Apr 2023 12:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 427B3612FD;
        Fri,  7 Apr 2023 19:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DD5C433EF;
        Fri,  7 Apr 2023 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680895411;
        bh=T4VZPDMaf3+6YnZBOz2pM6Rn4UXyJHX4JL0AyrpyYto=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sbvBl1b2QI2Q1ihm6MNZ5vtL6BW/xPWZ1rEwqUifaPZLZGiLGsMh7lfQj51M4pEdo
         yeBiBWaAatAUYKytAQXgD5h0J/I1HL1oglbGEVDB3ZawZ0JUqlSN6UwyiQg3mmzytn
         Wm8Fc8Rvol3NPhLjFb5aM5trVy4/MaMAzUNPSt/vvCY5brW8beOAeEDXnBkc54qwZe
         41X9/ZP1+yMNbBMDNO3Mx8E8/A69h9VjXX8ZzgMAGHAw9RFpJxdb+JKkmQnj5aerMn
         tYgpdp5m04xjnTqkgdDWfy4+ZUQaND066oBfeoqDd60FN1mVmFz4U8GamLG+1VSgg3
         K5WCc2iaonxPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/5] arm64: dts: qcom: msm8916-thwc-ufi001c: add function to pin config
Date:   Fri,  7 Apr 2023 12:26:22 -0700
Message-Id: <168089557840.2742951.8556650585979147303.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 21:22:40 +0100, Krzysztof Kozlowski wrote:
> Bindings require pin configuration nodes to have the function, even if
> it is GPIO:
> 
>   msm8916-thwc-ufi001c.dtb: pinctrl@1000000: sim-ctrl-default-state: 'oneOf' conditional failed, one must be fixed:
>     'esim-sel-pins', 'sim-en-pins', 'sim-sel-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: msm8916-thwc-ufi001c: add function to pin config
      commit: d4a7e17f402de8ebdbae4844b011a5b18f93e341

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
