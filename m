Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950F745FC2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGCPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjGCPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1CDE5C;
        Mon,  3 Jul 2023 08:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7214860F8C;
        Mon,  3 Jul 2023 15:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2844C433B7;
        Mon,  3 Jul 2023 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688397851;
        bh=1Iqjr61mr/AnFBGY7m47BBfpZlzN54BFOtKi03PDeUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9jD3NyIfQqXnMLXSWZHxOrtjwhMxS65SI6hzFMhWvleDYViS5XDM6fdFz0iubYms
         rzlkdpHt3JJ/KMH6dDPTEco5T4lDiYYBRS/93Ht8Kn319fnIPdnWOqIOMb8ub+QZT1
         DUEVw2lWkjMVZI4qRwd64HFgoLk8HPUfnvHV7gfH0XqLjiauDFfohS3nCWZB/cy5eY
         JAI6iz0nZV6p1V94nrW/UhhOQevbP/mbjnc28VSyskxTVQOcGcnq5JuSrrLiG9PMZq
         8GVbHJ+jUuWJ1lyPzIta5dXimpihW28AmPb4VJZo1zL2YkDjwEs47ESwJ8Zomrw86e
         o52/SYMbV822Q==
Date:   Mon, 3 Jul 2023 08:27:56 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 00/10] Add Power Domains and Regulators in SDX75
Message-ID: <3ohkrnirp4fiuru432drwgd6nowjpvf4unpstdhlz3dpcamomm@pb2uyywcaov5>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 08:12:16PM +0530, Rohit Agarwal wrote:
> Hello,
> 
> This series adds driver and dt-bindings related changes
> in SDX75 to add power domains and regulators.
> 

Thanks for your patches, Rohit. Really nice to see the SDX75 support
being upstreamed.

This series is to be merged by five (5) different maintainers, with no
dependencies between them, afaict. The likely outcome is confusion and
some of the patches being left behind on the list.

To reduce this risk of confusion and to get your patches looked at, and
merged, faster, please send independent series/patches separately in the
future.

Regards,
Bjorn

> Thanks,
> Rohit.
> 
> Rohit Agarwal (10):
>   dt-bindings: regulator: Add PMX75 compatibles
>   dt-bindings: power: Add rpm power domains for SDX75
>   dt-bindings: mfd: Add compatible for pm7550ba
>   dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
>   dt-bindings: mfd: Add compatible for pmx75
>   dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
>   soc: qcom: rpmhpd: Add SDX75 power domains
>   regulator: qcom-rpmh: Add support for SDX75
>   pinctrl: qcom-pmic-gpio: Add support for pm7550ba
>   pinctrl: qcom-pmic-gpio: Add support for pmx75
> 
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  2 ++
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml           |  6 ++++
>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
>  .../bindings/regulator/qcom,rpmh-regulator.yaml    |  2 ++
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  2 ++
>  drivers/regulator/qcom-rpmh-regulator.c            | 38 ++++++++++++++++++++++
>  drivers/soc/qcom/rpmhpd.c                          | 16 +++++++++
>  include/dt-bindings/power/qcom-rpmpd.h             |  8 +++++
>  8 files changed, 75 insertions(+)
> 
> -- 
> 2.7.4
> 
