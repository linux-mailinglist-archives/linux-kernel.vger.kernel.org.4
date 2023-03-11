Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470FA6B5C50
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCKNk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCKNkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:40:24 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35360120E83;
        Sat, 11 Mar 2023 05:40:12 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-17671fb717cso9016076fac.8;
        Sat, 11 Mar 2023 05:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl8BZOtinMndJA6yo9kH7m4T56Q9iqXbatouPywOBOI=;
        b=gmIsmjYkjtdeAnlT1G53m2vJ8Yho59WtJBtb5NO9Z2qUEsu57opquqZ6NEF4WnkVPD
         ZtKgn9wBVL5sRmUEQCltMQ+RXz/x0NwWWwf+70UVCo74B7f+ltxLPaDLdtjQ4IymtzKM
         194+wjDZLj1dW/pTXkOuClwZxxQ3k8x9xSJ0cKzYcDjZkf0MHNneRlgfSXSBiBFGNATt
         TvGOTqG2blOV7q0sJeOzSOaHxvWa+wdxWA0obB4jGZ0SIbI4FDT74++2Bwa6uKNbDY2X
         m+3OMk4l2gEfB9MGYa4EDha7OaZ6AbGvcG6etHx5DNUImE+HgXngajB4OrUg7BRJwZfX
         yCYQ==
X-Gm-Message-State: AO0yUKVUmjtgm8sA82S+ujBQM+oOpeQBOj4P0xztdtFuNKrGU8DOFiil
        13+ndy/DBQmSrJiXWceXHSJteBhV4A==
X-Google-Smtp-Source: AK7set+0bP5QJ7JRrLq0ugfI9tM7uV4Py+NmxD1n437OiRnbpitOV2Eigxgvk7FPXOw8cnZiagylnA==
X-Received: by 2002:a05:6870:1f85:b0:16e:ac1:c644 with SMTP id go5-20020a0568701f8500b0016e0ac1c644mr2725591oac.21.1678542011376;
        Sat, 11 Mar 2023 05:40:11 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:ec2:d840:96d4:1bbf:55f])
        by smtp.gmail.com with ESMTPSA id k8-20020acaba08000000b0037d7f4eb7e8sm1086404oif.31.2023.03.11.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:40:10 -0800 (PST)
Received: (nullmailer pid 23618 invoked by uid 1000);
        Sat, 11 Mar 2023 13:40:08 -0000
Date:   Sat, 11 Mar 2023 07:40:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, gregkh@linuxfoundation.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [PATCH v3 11/28] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Message-ID: <20230311134008.GA20831-robh@kernel.org>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-12-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308235751.495-12-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:57:34PM -0800, Wesley Cheng wrote:
> Add a new definition for specifying how many XHCI secondary interrupters
> can be allocated.  XHCI in general can potentially support up to 1024
> interrupters, which some uses may want to limit depending on how many
> users utilize the interrupters.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index be36956af53b..4e2417191f93 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -359,6 +359,19 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>  
> +  snps,num-hc-interrupters:
> +    description:
> +      Defines the maximum number of XHCI host controller interrupters that can
> +      be supported.  The XHCI host controller has support to allocate multiple
> +      event rings, which can be assigned to different clients/users.  The DWC3
> +      controller has a maximum of 8 interrupters.  If this is not defined then
> +      the value will be defaulted to 1.  This parameter is used only when
> +      operating in host mode.

Is this an XHCI or DWC3 feature? The former should be added to the XHCI 
binding.

> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    minimum: 1
> +    maximum: 8
> +    default: 1
> +
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
>      description:
