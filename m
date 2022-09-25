Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232695E91FF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIYKJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 06:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiIYKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 06:09:38 -0400
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Sep 2022 03:09:31 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE571F9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664100208;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=cqWUJwis5pcJ2rj05sPjRGLCpe4fJlAQi3NEmXJ/nxE=;
    b=Dz6Pc/7weBsnjm+x3mWX3Rj8X7zmzEs/6nw7t2ZnCgs71bqj5kOP8Tnd5iz8TDTh+u
    2lpjipsS86rxe+TSo0u2yheLWR5T4uvUIOc/P3ol4+U9XzzmE4GMqAF4s7HSrjnPGkD5
    yKzu64i+gUNSAtimYOhX2iPChYjZ1xoLbFJc+wnTUbGawC3CQ1ylYIysjV4dmfmLDIps
    osHArtgnrJAx5K9zs7TChaz7HR3Pz+rK/BomizRfj8eIwhSl2hQeWRRMrfzXPmHqI4sI
    AbbWJHcLGA1yeOTRXaBmN2M4rapl2nvPejeMu3Qe3XQB2A5wenAZ4+W/kcLnNqAgphW7
    sipA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id dde14cy8PA3S57N
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 25 Sep 2022 12:03:28 +0200 (CEST)
Date:   Sun, 25 Sep 2022 12:03:21 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: qcom_defconfig: enable rest of ARMv7 SoCs
 pinctrl drivers
Message-ID: <YzAnaXDqFrZWq9n/@gerhold.net>
References: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 11:19:19AM +0200, Krzysztof Kozlowski wrote:
> Enable rest of ARMv7 SoCs pin controller drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/configs/qcom_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index 7d8b6884fd00..4971de49be36 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -131,14 +131,20 @@ CONFIG_PINCTRL_APQ8064=y
>  CONFIG_PINCTRL_APQ8084=y
>  CONFIG_PINCTRL_IPQ4019=y
>  CONFIG_PINCTRL_IPQ8064=y
> +CONFIG_PINCTRL_MSM8226=y
>  CONFIG_PINCTRL_MSM8660=y
>  CONFIG_PINCTRL_MSM8960=y
> +CONFIG_PINCTRL_MDM9607=y
>  CONFIG_PINCTRL_MDM9615=y
>  CONFIG_PINCTRL_MSM8X74=y
> +CONFIG_PINCTRL_MSM8909=y
> +CONFIG_PINCTRL_MSM8916=y

Thanks for adding MSM8916! (it's used on both ARM32 and ARM64)

> +CONFIG_PINCTRL_MSM8976=y

This one should be added to the ARM64 defconfig, I doubt anyone uses it
with ARM32. :)

Thanks,
Stephan
