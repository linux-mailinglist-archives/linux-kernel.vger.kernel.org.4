Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2470B78E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjEVIYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjEVIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB79B6;
        Mon, 22 May 2023 01:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB9F061261;
        Mon, 22 May 2023 08:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3097C433D2;
        Mon, 22 May 2023 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684743842;
        bh=0n7M+nhoujC6lGE2NpxPQoL8mXQVSH4ipk/JaoRH43E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYGUcb8eRRD6jBw9u2Jk/5fYxXYr7NphWZ36oG28vw+ZN2zlxmwvdoe11EgKXU3x/
         Fg9FydthNuPF6trYJ66ErAHVYHbCIIfV+nbXa+9iKq/9aO60IPOcuxuyc7GJuyUxeT
         B3xr56Jy2WgBIi46HHFGYulyOkXqAR0w2m5WxFO+egczFukG3JKhcVEUU6W8lRieMy
         A54FvPbv2SaTafPjIKdMwRu48S8Po2iYvaVA+7UTtf/Lp18y9JYo3iK8MkyomIo2qE
         fwiFdz7D5DNtIMRZnan+vAcSlsDs8ZJ9lSu0nELeHvaHnQaDyYlFRThgAf/heNiWsN
         mLhoNAjQXweIQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q10pm-0004NV-1C; Mon, 22 May 2023 10:24:02 +0200
Date:   Mon, 22 May 2023 10:24:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: clock: Add YAML schemas for LPASS
 AUDIOCC and reset on SC8280XP
Message-ID: <ZGsmokWd_PusByku@hovoldconsulting.com>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
 <20230518113800.339158-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113800.339158-3-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:37:57PM +0100, Srinivas Kandagatla wrote:
> The LPASS(Low Power Audio Subsystem) Audio clock provider provides reset

Missing space after "LPASS".

Same comments as on previous patch seem to apply to the reset of the
commit message.

> controller support when is driven by the Q6DSP.
> This patch adds support for those resets and adds IDs for clients
> to request the reset.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/clock/qcom,sc8280xp-lpasscc.yaml         | 11 +++++++++++
>  include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h     |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> index 7c30614a0af9..394833819ba3 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> @@ -22,6 +22,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc8280xp-lpasscc
> +      - qcom,sc8280xp-lpassaudiocc

Add before lpasscc to maintain alphabetical sorting.

>  
>    '#reset-cells':
>      const: 1
> @@ -45,6 +46,16 @@ required:
>  additionalProperties: false
>  
>  examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
> +    lpass_audiocc: clock-controller@3300000 {
> +      compatible = "qcom,sc8280xp-lpassaudiocc";

4-space indentation.

> +      reg = <0x32a9000 0x1000>;

Does not match node unit address either.

> +      #reset-cells = <1>;
> +      #clock-cells = <1>;
> +      qcom,adsp-pil-mode;

Keep cells provider cells properties last?

> +    };
> +
>    - |
>      #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
>      lpasscc: clock-controller@3900000 {
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

Johan
