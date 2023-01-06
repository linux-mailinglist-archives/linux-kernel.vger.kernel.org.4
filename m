Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C76605B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjAFR1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjAFR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:27:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74F7D9DD;
        Fri,  6 Jan 2023 09:26:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C30161EDA;
        Fri,  6 Jan 2023 17:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF62CC433EF;
        Fri,  6 Jan 2023 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026016;
        bh=BnaDCQK5J3VTfJLC54IauL/DCN/7VgdPqsOeLuTrL1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UELGVchE3nc9rRTg546B29EbyU+Elnjsz7Yo8DpdMyukz9puX7sq5t0AmBhCFw03u
         w92Ytn83c3GwkOoXw3QOnWd00+3a9oeOXmXaCm8VeeayAI9XrVrWS2H92c+X2wsNkt
         y4dpkPWo8/an8Q0U4fsJqY6Q5nBD1JS8O0AAJ2fJY2iINguPokS/iO7Vi6qtnqoqsk
         UW15TxcDPQBGHgfESFGUUwi6naIFo8GHJOVq2MDVIkow/JjBwe0uZpGtCYY1ZO3YUd
         wFTLoRhktfD+SKS/LXEPXiXAOLiN+zqSFswGfIBqHCPSBHTn8ojI+d8yzeVMwIPf6B
         xcQW86/OWhJ6A==
Date:   Fri, 6 Jan 2023 11:26:53 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, quic_schowdhu@quicinc.com,
        agross@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250
 binding
Message-ID: <20230106172653.cmyd4whqslrlibah@builder.lan>
References: <20230103150419.3923421-1-bhupesh.sharma@linaro.org>
 <20230103150419.3923421-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103150419.3923421-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 08:34:18PM +0530, Bhupesh Sharma wrote:
> Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.
> 
> On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
> needs to be set first to 'enable' the eud module.
> 
> So, update the dt-bindings to accommodate the third register
> property required by the driver on these SoCs.
> 
> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,eud.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> index c98aab209bc5d..1dffe14868735 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> @@ -18,12 +18,22 @@ properties:
>      items:
>        - enum:
>            - qcom,sc7280-eud
> +          - qcom,sm6115-eud
>        - const: qcom,eud
>  
>    reg:
> +    minItems: 2
>      items:
>        - description: EUD Base Register Region
>        - description: EUD Mode Manager Register
> +      - description: TCSR Check Register

So this is going to be a 4 byte region in the middle of the &tcsr block?

Could we instead make that a reference to &tcsr + offset?

Regards,
Bjorn

> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: eud-base
> +      - const: eud-mode-mgr
> +      - const: tcsr-check-base
>  
>    interrupts:
>      description: EUD interrupt
> -- 
> 2.38.1
> 
