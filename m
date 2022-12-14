Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21364CDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiLNQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiLNQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:20:03 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9E286F3;
        Wed, 14 Dec 2022 08:19:58 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12c8312131fso17225061fac.4;
        Wed, 14 Dec 2022 08:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmxnkBtZ4+9GBAc6tSJuQtB+ybkrmuXMMJ4mdgofo5Q=;
        b=oPIagKHqwlIJdy8bOyPYe/oPl+fyy1m+ieTJq5HUljujwsYysieVueQeLSieGHcTtN
         /l8+JIURRtg6ptzfwnA0OqMN14dmdjWU8fTBhEjrE5p2MgnARv+K4Fzv8BOyvh9GwYN7
         E4HXvId20iJn1n3JVtz/n4LPjfW595eU9JxYxmN3roKUSuHp3yWXFXyO8h1k9xknYXDJ
         ue4OxTI6pJaiYUQO8NrABvW5LpFx+ftDfGGRWXxRa5jfDffCZxtX9Z6I30ScvnZdCyk8
         m8reHaVQSEDIjymQ3tXmky1vRsFBJ4m1P2IVKF2ahU8adfYHNNY6JZyVjwuwY+FRrAki
         0e5A==
X-Gm-Message-State: ANoB5pktGN3hr5KMeA/wtl2ag0U8tESRQSnVmnpXRRp+TRYbtsw/m4L1
        QPw8Qz/Qyf+P/sb9KLKxUugHvCvxCA==
X-Google-Smtp-Source: AA0mqf6e3VGZKdUfXLywAorV3vsZOOgy1lwiko6BtumOLTx0JRi0nVu+raQ/iZcLaTVqcLb++8wnEw==
X-Received: by 2002:a05:6871:213:b0:142:9258:b78d with SMTP id t19-20020a056871021300b001429258b78dmr12829578oad.12.1671034798148;
        Wed, 14 Dec 2022 08:19:58 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id h4-20020a056870170400b0011f22e74d5fsm2888651oae.20.2022.12.14.08.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:19:56 -0800 (PST)
Received: (nullmailer pid 1168312 invoked by uid 1000);
        Wed, 14 Dec 2022 16:19:38 -0000
Date:   Wed, 14 Dec 2022 10:19:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        dmitry.baryshkov@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, airlied@gmail.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Message-ID: <20221214161938.GA1164047-robh@kernel.org>
References: <1670972181-4961-1-git-send-email-quic_khsieh@quicinc.com>
 <1670972181-4961-3-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670972181-4961-3-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 02:56:18PM -0800, Kuogee Hsieh wrote:
> Add both data-lanes and link-frequencies property into endpoint
> 
> Changes in v7:
> -- split yaml out of dtsi patch
> -- link-frequencies from link rate to symbol rate
> -- deprecation of old data-lanes property
> 
> Changes in v8:
> -- correct Bjorn mail address to kernel.org
> 
> Changes in v10:
> -- add menu item to data-lanes and link-frequecnis
> 
> Changes in v11:
> -- add endpoint property at port@1
> 
> Changes in v12:
> -- use enum for item at data-lanes and link-frequencies
> 
> Changes in v13:
> -- revised changes at port@0
> -- use correct ref schemas for both port@0 and port@1
> -- mark both port@0 and port@1 are required
> -- add line between data-lanes and link-frequencies properties
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`
> ---
>  .../bindings/display/msm/dp-controller.yaml        | 26 ++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index f2515af..9d002de 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -81,6 +81,7 @@ properties:
>  
>    data-lanes:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> +    deprecated: true
>      minItems: 1
>      maxItems: 4
>      items:
> @@ -98,12 +99,31 @@ properties:
>      $ref: /schemas/graph.yaml#/properties/ports
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: "/schemas/graph.yaml#/$defs/port-base"

This means you have extra properties to add in the endpoint, but you 
didn't define any.

>          description: Input endpoint of the controller
>  
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: "/schemas/graph.yaml#/$defs/port-base"

Don't need quotes. Why did you add them?

>          description: Output endpoint of the controller
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  enum: [ 0, 1, 2, 3 ]
> +
> +              link-frequencies:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  enum: [ 1620000000, 2700000000, 5400000000, 8100000000 ]
> +
> +    required:
> +      - port@0
> +      - port@1
>  
>  required:
>    - compatible
> @@ -193,6 +213,8 @@ examples:
>                  reg = <1>;
>                  endpoint {
>                      remote-endpoint = <&typec>;
> +                    data-lanes = <0 1>;
> +                    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>; 
>                  };
>              };
>          };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
