Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390CC71266B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbjEZMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjEZMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FC116;
        Fri, 26 May 2023 05:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA7D66152A;
        Fri, 26 May 2023 12:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71F5C433D2;
        Fri, 26 May 2023 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685103423;
        bh=EExZUYFXCjwdEXwlrRa3dU5pBkNO42OY+TPVLVsgBIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPved3RxRsUpHIiJjl5LDQ/3UiIUXnUx0wX0TX3at9JM4URFrkiBc9fTHOE/eWGYd
         AbHpFO52Dxhh32muct+Jacmj1efExFdBb17cyW6OMswWXIK6FRTM9E1hdTJP0IJJmu
         JQmXB2zYIg79yqHbThy1KUHaGblZnOzcE/rYQgkKPkX3rKKOEAbxNDGL6myvwScwvl
         gt/UChj1sb2zCmMtmOWWp/5kdxChr6dQfIVPXXThO1ZdT10cv2aDsphaFU4PcjvNov
         jbEafWmKoda2NAp7AkQZvhR4amFmuHVBlOVp7l4OEmuxL5+l+GUsfDZg4bU7TRvQJK
         Lnk79pbDY5eXg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2WNf-00076e-Pm; Fri, 26 May 2023 14:17:15 +0200
Date:   Fri, 26 May 2023 14:17:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: defconfig: Enable sc828x0xp lpasscc clock
 controller
Message-ID: <ZHCjS2ViVICWCxFP@hovoldconsulting.com>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525122930.17141-7-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:29:30PM +0100, Srinivas Kandagatla wrote:
> Enabled sc828x0xp lpasscc clock controller driver required for X13s laptop.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 57ceb528426d..95ece45fd0cd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1176,6 +1176,7 @@ CONFIG_SC_GCC_7180=y
>  CONFIG_SC_GCC_7280=y
>  CONFIG_SC_GCC_8180X=y
>  CONFIG_SC_GCC_8280XP=y
> +CONFIG_SC_LPASSCC_8280XP=m
>  CONFIG_SDM_CAMCC_845=m
>  CONFIG_SDM_GPUCC_845=y
>  CONFIG_SDM_VIDEOCC_845=y

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
