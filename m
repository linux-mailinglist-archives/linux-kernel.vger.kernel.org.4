Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D433D71264A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242988AbjEZMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbjEZMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C18128;
        Fri, 26 May 2023 05:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C076153D;
        Fri, 26 May 2023 12:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A58C433EF;
        Fri, 26 May 2023 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685102904;
        bh=JZYUy+FtgSioe7LSnTpyinDPirEuwcy8sNuqosrxL0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OD21dzRpCBMdXwujB4xwFKfHD5XA6NQx2qlY5xlSH12IjBEgXMId9aY7BxS9Jovph
         2hxVKTrmIi0heaBjiwNAjJF9hzp4fN3d3hhxJDfmBUzIV53iiSEd0CULxPNNcpK8qa
         F8+uw1wrb4YzS+y4/Lsi6nsFcF1NKxwEU37GmITRh6YrYsK4JV3xNHLehiysrgEx5f
         2W+QyAP2HZFMDkZMh1VQjce2FgqBpHUUOBAXcXCXSTsHxAGweHopCqUr2DjTIQTwyJ
         39GeyHSms+39cypLmu8dyUnNBsKYW4jpPTEWEbbeQaYPHBR97GF3HGp0Uu+GgPp9Dz
         G3YzYALhLe8uA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2WFI-00072l-21; Fri, 26 May 2023 14:08:36 +0200
Date:   Fri, 26 May 2023 14:08:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: Add YAML schemas for LPASS
 AUDIOCC and reset on SC8280XP
Message-ID: <ZHChRDuLrnQ-GwEK@hovoldconsulting.com>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525122930.17141-3-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:29:26PM +0100, Srinivas Kandagatla wrote:
> The LPASS (Low Power Audio Subsystem) Audio clock controller provides reset
> support when it is under the control of Q6DSP.
> 
> Add support for those resets and adds IDs for clients to request the reset.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/clock/qcom,sc8280xp-lpasscc.yaml         | 11 +++++++++++
>  include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h     |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> index 08a9ae60a365..0557e74d3c3b 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> @@ -21,6 +21,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - qcom,sc8280xp-lpassaudiocc
>        - qcom,sc8280xp-lpasscc
>  
>    qcom,adsp-pil-mode:
> @@ -45,6 +46,16 @@ required:
>  additionalProperties: false
>  
>  examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
> +    lpass_audiocc: clock-controller@32a9000 {
> +        compatible = "qcom,sc8280xp-lpassaudiocc";
> +        reg = <0x032a9000 0x1000>;
> +        qcom,adsp-pil-mode;
> +        #reset-cells = <1>;
> +        #clock-cells = <1>;

Nit: #clock before #reset

> +    };
> +
>    - |
>      #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
>      lpasscc: clock-controller@33e0000 {
> diff --git a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> index df800ea2741c..d190d57fc81a 100644
> --- a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> +++ b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> @@ -6,6 +6,11 @@
>  #ifndef _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
>  #define _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
>  
> +/* LPASS AUDIO CC CSR */
> +#define LPASS_AUDIO_SWR_RX_CGCR				0
> +#define LPASS_AUDIO_SWR_WSA_CGCR			1
> +#define LPASS_AUDIO_SWR_WSA2_CGCR			2
> +
>  /* LPASS TCSR */
>  #define LPASS_AUDIO_SWR_TX_CGCR				0

Should you have different prefixes for the CSR and TCSR defines?

Looks good to me otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
