Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACFB712666
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbjEZMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjEZMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:16:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7B7A4;
        Fri, 26 May 2023 05:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD1D6152A;
        Fri, 26 May 2023 12:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FC1C433EF;
        Fri, 26 May 2023 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685103381;
        bh=0EjqTwDKn9URlVsC5ij1diJfzXEDKXKZqVSkYeBYoBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzk0NU4F5JU13UnTbSDTDTKT52SpPaPSZZsmcQ0MRSr8iZ2t3uBfRA2JFWqInSviz
         nALXt1vUtp4iibG8Nqwde4+j2zcMspn2yL7Vx/tTVmNorRR3rNRtIDaJIjPkXlJ0KV
         C3SdIkQKy7+tC6l4vbv2YaghfEuKNgnbgdaNlsMdmLcg+6/iPi4Il+kSYMMmEDwFDp
         xgBNR2TSGcZDRyzm15tvmSZIp6+cO49aIk0HJ+x/IqKsSydajebJZ6zO6uen3XLU39
         zx8wFqbSlfAq2hbuIo4+GzmNsERXEK2ttjNYOtPHkZBzsc0Ti2SMmK4FTWVKI36iPq
         /ALaJJxYoZfmA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2WMz-00075t-H3; Fri, 26 May 2023 14:16:33 +0200
Date:   Fri, 26 May 2023 14:16:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sc8280xp: add resets for
 soundwire controllers
Message-ID: <ZHCjIXdVON0h1mer@hovoldconsulting.com>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525122930.17141-6-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:29:29PM +0100, Srinivas Kandagatla wrote:
> Soundwire controllers on sc8280xp needs an explicit reset, add
> support for this.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 6730349e34f4..39be2e89ce05 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi

> @@ -2901,6 +2916,14 @@
>  			};
>  		};
>  
> +		lpasscc: clock-controller@33e0000 {
> +			compatible = "qcom,sc8280xp-lpasscc";
> +			reg = <0 0x033e0000 0 0x12000>;
> +			qcom,adsp-pil-mode;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
>  		usb_0_qmpphy: phy@88eb000 {
>  			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
>  			reg = <0 0x088eb000 0 0x4000>;

This one needs to be rebased on linux-next as the lpasscc node should go
before the new:

	sdc2: mmc@8804000 {

node.

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
