Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53061FBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiKGRiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiKGRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:38:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219F1A383;
        Mon,  7 Nov 2022 09:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F35CA611AB;
        Mon,  7 Nov 2022 17:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8279C433D6;
        Mon,  7 Nov 2022 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667842725;
        bh=xVAlVw8T4kdHMYEynEaUD6upOqRZnblNhn2cN35CtlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPtJHwSIV+DwFPdZpYjNHsElW3aQdKbKkG/CzfYJB3O6sjIzoo3Yk/PgPLlHuAf6J
         Pz4cg1lXsiJNBrOCCAskHDu/lu+fA9mWo5LzdHpxMZXOCi4TMlP07w/PSsyDnltWZO
         DIgimj886jLb4C3/sSiKavxtE3ikw4TI+XRkbQ6LaS7/3xAjFthZed6xWQYp0p+i5W
         YwBjoYcjTmOGS2uAAw4tDhozZzCtXF33HCd6GHWWmDxkzfuvjFjovUDFfMfDAfEWPx
         n+ZNjn3iJ3Av4sfMx+YpF5ms/YPonVOMldEWB1/0OzCgtohXgHDGmPFglZZgypIt5b
         FXhbY4DgJEpgA==
Date:   Mon, 7 Nov 2022 11:38:42 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Message-ID: <20221107173842.6ct43x7wyuulqv33@builder.lan>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
 <20221026190549.4005703-2-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026190549.4005703-2-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:05:45PM -0700, Melody Olvera wrote:
> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../devicetree/bindings/firmware/qcom,scm.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index be1b5746eddb..5352181aa393 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -38,6 +38,7 @@ properties:
>            - qcom,scm-msm8994
>            - qcom,scm-msm8996
>            - qcom,scm-msm8998
> +          - qcom,scm-qdu1000
>            - qcom,scm-sc7180
>            - qcom,scm-sc7280
>            - qcom,scm-sc8280xp
> @@ -81,6 +82,20 @@ properties:
>      description: TCSR hardware block
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,scm-qdu1000
> +    then:
> +      properties:
> +        '#reset-cells':
> +          maxItems: 1
> +        clocks: false
> +        clock-names: false
> +
> +      required:
> +        - '#reset-cells'

Please document what this reset is expected to be wired to, and write a
sentence or two in the commit message how the QDU differs from existing
platforms supported by the binding.

Thanks,
Bjorn

>    - if:
>        properties:
>          compatible:
> -- 
> 2.25.1
> 
