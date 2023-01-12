Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB8668439
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbjALUtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjALUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:49:01 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AACE2;
        Thu, 12 Jan 2023 12:17:33 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so1512292otf.8;
        Thu, 12 Jan 2023 12:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btQgNlSBjxnAMfAgJUU4z0y9PbJwjBme41/xmNEEuGA=;
        b=Mznfe7AL9kCXU4n3oBzZ0E6faDcDoiAN79hZHijEZFO99CXnCpa99u0FOSj0Sh/RqV
         xfpbFGmTAqfFBza90Kr1kVQj0P1yvERK65zGz6cMKP+YBFT+OZanOwTHS1ypClItJ2o6
         wBd0aDYgj2iA+p4FCpGE1J7u/WCgJESy9OX/4dJmZI22gEuIMZDoz1OIcdE5WDAPaLRg
         CSepo/EBjet/I0rkBBrPpnfn6sJCP+C144YknRPnzUKOR/Zn5H0dMyK+WPh22reSXEnQ
         0ruCZeLMKteRjhbhHPr5Gl1xQL6F9Tj/RjEgn+hv9saN3H9ZIi4iDQk34wU3JCCxuJBo
         S/hA==
X-Gm-Message-State: AFqh2krDrzes0DxxrBppsMMKXnBXEILvCcXyOP0Yn54aB2nbrN9JA75n
        RdBsDCVNA6PbYLNi7eKJYQssc5aw6Q==
X-Google-Smtp-Source: AMrXdXsvoztJqd/eb5qZ/ouK+S7+DwWqBpSTfqKEUq4UCgOXLgjAGJh0KcCLYcdUZmNvMX5SjmeNEQ==
X-Received: by 2002:a9d:127:0:b0:684:ccc3:1569 with SMTP id 36-20020a9d0127000000b00684ccc31569mr726710otu.0.1673554652850;
        Thu, 12 Jan 2023 12:17:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 73-20020a9d04cf000000b00684a10970adsm4261695otm.16.2023.01.12.12.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:17:32 -0800 (PST)
Received: (nullmailer pid 4061816 invoked by uid 1000);
        Thu, 12 Jan 2023 20:17:31 -0000
Date:   Thu, 12 Jan 2023 14:17:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        manivannan.sadhasivam@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com,
        robin.murphy@arm.com
Subject: Re: [PATCH V3 03/10] dt-bindings: remoteproc: qcom,sc7180-mss-pil:
 Update memory-region
Message-ID: <20230112201731.GA4038840-robh@kernel.org>
References: <20230111114337.24782-1-quic_sibis@quicinc.com>
 <20230111114337.24782-4-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111114337.24782-4-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:13:30PM +0530, Sibi Sankar wrote:
> The dynamic memory region used for metadata authentication would still
> be a part of the kernel mapping and any access to this region by the
> application processor after assigning it to the remote Q6 will result
> in a XPU violation. This is fixed by using a no-map carveout instead.
> Update the bindings to reflect the addition of the new modem metadata
> carveout on SC7180 SoC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v3:
>  * remove double space [Krzysztof]
>  * Pickup R-b
> 
> v2:
>  * Pad commit message to explain bindings break [Krzysztof]
>  * Split dt/bindings per SoC  [Krzysztof] 
> 
>  .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml    | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> index e4a7da8020f4..b1402bef0ebe 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> @@ -95,6 +95,7 @@ properties:
>      items:
>        - description: MBA reserved region
>        - description: modem reserved region
> +      - description: metadata reserved region

Based on dtbs_check, looks like you need 'minItems: 2'.

>  
>    firmware-name:
>      $ref: /schemas/types.yaml#/definitions/string-array
> @@ -223,7 +224,7 @@ examples:
>                          <&rpmhpd SC7180_MSS>;
>          power-domain-names = "cx", "mx", "mss";
>  
> -        memory-region = <&mba_mem>, <&mpss_mem>;
> +        memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
>  
>          qcom,qmp = <&aoss_qmp>;
>  
> -- 
> 2.17.1
> 
