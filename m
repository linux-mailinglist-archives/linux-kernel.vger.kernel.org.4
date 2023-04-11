Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D196DDD5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDKOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDKOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C01AE5B;
        Tue, 11 Apr 2023 07:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEF86620D2;
        Tue, 11 Apr 2023 14:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A45C433EF;
        Tue, 11 Apr 2023 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681222360;
        bh=l8385xTWalm1dEVmi6a1hSAkjL5k9yeOUJ0NoMRo4x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGjdxCmGMNkS5Dx9s90C2R5/+JINUyYzJugXqXihjY4Shjow39OZcV4H2B9JjQLQP
         Ge+IgDgcPPDin4/tGk6XVjo5kJ/nwaCfQJCfKSUPubFoziiM2vmloFOhQP0mWA9cN0
         of8r6mf+i+FmfZi5BlJLquDEI6B6yl4wMxnVC83MwVs/2ZhBctgATn3AwIOzOyzNQp
         ppePooNC2FqIJFjWMd+12k3C5FcZiYENk3WRMKK1YTxZ6WmD0OoF9ZYRFCQC5neqsK
         J/bsP2KzEU0c6GvR7uu0ekGhvsPGzDrym3xAGK2/QHQPy8YoRpuCdM94hSUpqbsKWA
         tJFFbVrJE9Lww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmEjd-0004Ch-VU; Tue, 11 Apr 2023 16:12:38 +0200
Date:   Tue, 11 Apr 2023 16:12:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] arm64: dts: qcom: sc8280xp: remove superfluous
 "input-enable"
Message-ID: <ZDVq1b0TjXH5LTYx@hovoldconsulting.com>
References: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
 <20230407175807.124394-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407175807.124394-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:58:02PM +0200, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
> input-enable") the property is not accepted anymore.

This description does not seem to match the pin configurations that you
are changing below which use the "qcom,sc8280xp-lpass-lpi-pinctrl"
binding for which 'input-enable' is still accepted AFAICT.

Perhaps you can fix up the lpass bindings (and driver?) to match?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 4c75da1bac2d..5632c3b8e416 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2728,7 +2728,6 @@ data-pins {
>  					pins = "gpio7";
>  					function = "dmic1_data";
>  					drive-strength = <8>;
> -					input-enable;
>  				};
>  			};

Johan
