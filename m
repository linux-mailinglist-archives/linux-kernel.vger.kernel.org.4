Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F574CBCB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGJFG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGJFFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D71734;
        Sun,  9 Jul 2023 22:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F9C60DFE;
        Mon, 10 Jul 2023 05:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A8CC433C9;
        Mon, 10 Jul 2023 05:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965490;
        bh=uYrZinyxjtM3C+Zwi30CqZShpGUZzWaVEMY6wPUrJ7U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c0igG2T6c9FLJ7zx3bMyopS04Re0Aba8iFquIyEHQBUX+hfYoLa3gd8mnOiQ1SoIX
         QoSvnIqkm/NmTazF5z8Sk+hln+6ykO5N2kWh7hZL2uG6R9Izd08S8H5UIAPME3duG5
         +oQVy4t8AJoViqyKNV2gVTJjR7TeqKKI57WOXxIsz6KqiF1WDgtQGP9BL50AMv2W+Q
         SU4SIs5dzaPT0+YpwtpOTV2QFdbh/LoQz3cgUbG24EwGlUJ5CEexKay92uewkwDsAj
         LRN324E25QUhUlp2kBO1Sx/R4N8LdgPWymGlZ+0Fll5N+vh8nWv+2x2XnXH/h9UXdC
         g58AZR3gFm/sw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/4] ARM: dts: qcom: ipq4019: use generic node names for USB
Date:   Sun,  9 Jul 2023 22:07:30 -0700
Message-ID: <168896565961.1376307.8043255655713464820.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
References: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 19 Jun 2023 19:01:48 +0200, Krzysztof Kozlowski wrote:
> Device node names should be generic which is also expected by USB
> bindings:
> 
>   qcom-ipq4018-jalapeno.dtb: dwc3@6000000: $nodename:0: 'dwc3@6000000' does not match '^usb(@.*)?'
> 
> Override also the DWC3 node in qcom-ipq4018-ap120c-ac.dtsi by
> label/phandle, not via node path, because it is less error-prone and
> makes the overriding node-name independent.
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: qcom: ipq4019: use generic node names for USB
      commit: 7caf09215ca32f1020df1559027d77770ca2e901
[2/4] ARM: dts: qcom: sdx55: use generic node names for USB
      commit: 9a3b29c33b5d3d3dd446c1fa314a79f7a905886a
[3/4] ARM: dts: qcom: ipq8064: drop spi-max-frequency from controller
      commit: 1bfeee1aeef0e6070e9ca2f06d310eb1c3058464
[4/4] ARM: dts: qcom: msm8960: drop spi-max-frequency from controller
      commit: 594ccb8d24726c89dd6601b2322b399648da7a8c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
