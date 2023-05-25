Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB927104BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjEYEzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjEYEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADF81730;
        Wed, 24 May 2023 21:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3596428A;
        Thu, 25 May 2023 04:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481E7C433EF;
        Thu, 25 May 2023 04:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990283;
        bh=aEGPrL9Tq+lM9ScDWy5ThIBCZFtHCSCCQWDLGhvrbXQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eFCbthqx2jPqOHN33QfEQlgg6pBotj5dHo1Lo5c+PeExId+96bIO/F92ElMCGPqT/
         6eQHYN5PHAideITfLIcugQ9f45fLcaGFJn4zzm1e5P7wKuNwkI1DNIGh0w+Tyz6fwo
         9QKsV7D9Lr6O7+CSEyv2OWqxPjsWgclU/MCk/+dzbPDo9kZycurZamDvDK89mL7Ret
         tDHCKSZW8tIsgEHTQwdC4Kb+2qSNjJAnYYLsqdE4/hfJcfb6j85Aiey8+oSD/nyqYO
         HxOwsizAL2Iv1I04cEvnO3WTg2w7ZfWXQsQ3acFT/w1MxvFKbyQHRlJUi78hQZAGlQ
         +rhKKXjbZ8UUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 01/10] ARM: dts: qcom: ipq4019: correct syscon unit-address
Date:   Wed, 24 May 2023 21:54:04 -0700
Message-Id: <168499048184.3998961.3769442344863733308.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 09:50:44 +0200, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc/syscon@1fcb000: simple-bus unit address format error, expected "1fc0000"
> 
> 

Applied, thanks!

[01/10] ARM: dts: qcom: ipq4019: correct syscon unit-address
        commit: 2c7a2700bad5f735b76acaaf721752f33e030497
[02/10] ARM: dts: qcom: sdx55: correct rsc unit-address
        commit: 59cf17540e48ab6c37289f0333bdf0b9c639ba80
[03/10] ARM: dts: qcom: msm8974: correct pronto unit-address
        commit: 547c0034b40ee18e5e4b48501b935f0ab8f70a37
[04/10] ARM: dts: qcom: ipq8064: drop leading 0 from unit-address
        commit: 038b8980077bf02c82324aefd6b69e00f5b8a1a2
[05/10] ARM: dts: qcom: ipq8064: drop invalid GCC thermal-sensor unit-address
        commit: 0dd882ae3dd9cfb51d5dc5083da3af7a35db1355
[06/10] ARM: dts: qcom: ipq8064: correct LED node names
        commit: 740e5ecb78d4426526cb2b3f49d0043225a8bed9
[07/10] ARM: dts: qcom: ipq8064: align USB node names with bindings
        commit: c13ba9b148716160a2cbbc7620944a976b6b1491
[08/10] ARM: dts: qcom: apq8060-dragonboard: move regulators out of simple-bus
        commit: f0e401e15d3eab570f92fab2c9ce56a2564fa828
[09/10] ARM: dts: qcom: msm8960-cdp: move regulator out of simple-bus
        commit: 71abfd7a0a100010d32edb28917f437537afbb7f
[10/10] ARM: dts: qcom: apq8084: correct thermal sensor unit-address
        commit: a8311da44f38a2f52cb4cf44710c95c1e6f2f6ec

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
