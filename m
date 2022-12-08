Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F3647A03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHXdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLHXdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:33:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE846ACD4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:33:18 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so4485134lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKLCGPGfVZh6K4P5LObd29YMXv67XFhw120dHjFqUZo=;
        b=Gaqs+aAobAs+lOUTPXm908H7oa0DBenVVlakNRzRT5qX22jZDr2hE/G0iMP7Fd8cSk
         BeZUT0pmmPqyjFN5L+BAM85LoJsxtjYAleaSEWd0dIR6Ks2gkyXiSYW27lFoMy0BBZQv
         o/vJ2ZMzI4xsVd+kNvwXv0bfzHFZYjM8O+8TA2cmLM7SvHInimLkUqq87fTR2ueC5dy1
         /cW09r4JuHeW8yWLxGZe+Izdn2V2pid/FJHXhMFhRoDQRCpYpwXjU2u/8uFxNKxKY5J7
         nfoowsTC4oZyEVspoivUI2WLoMs73bA23yEgnq0qzGGpvZCnLo7rN/A2QDWdJZaUUixp
         j4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKLCGPGfVZh6K4P5LObd29YMXv67XFhw120dHjFqUZo=;
        b=PSJ8SX0uYNQOqZmeC4mK4Jgyh+Y9eDn8gxqv5dHVsKdd5KFC3vS4Hl4HkQK/6gRXNG
         73l09VwzRXGLdpeCC6Y4auP5m0RwhDtDWs0NHklTvPP0tNxIJrMkDs6A43f66u8KiOjV
         G2yzcdjvxYm1ZCbt2I1t3bAiBVjD8jik7l+i5vvpJib0kFEobF0+flVMgmUi3KSbO7bH
         y42lnkLd/kfrGHwyAeNDhP44csYIze4bfQj4pV4Fxt8TTJ7Dg+Gs+/oq5Rrzfjp1K9wv
         HmiVeSjQh5m+tCtVnpSudspDx4hF4EMIFa1YYvG701/5Dt/Md+H6Kb+WjzUWRwabU+a2
         Vruw==
X-Gm-Message-State: ANoB5pnRCBA94DfOQw34sOZWA5LRnyHA99k8+O/REFq0iaafKY+An0eq
        62dQ3lgeh/WzztiWhHL4PbQr/g==
X-Google-Smtp-Source: AA0mqf4ttdrlIL415TFzJIJKvMPqmL4hzylAmJ4ddxoVWA9pCJpeG9f1mln1+c2kxMD18c/zKp6O1w==
X-Received: by 2002:ac2:5a43:0:b0:4b5:90c5:281c with SMTP id r3-20020ac25a43000000b004b590c5281cmr926818lfn.19.1670542397012;
        Thu, 08 Dec 2022 15:33:17 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w26-20020ac2443a000000b004b1892aa5c8sm2823lfl.56.2022.12.08.15.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 15:33:16 -0800 (PST)
Message-ID: <5a3865ed-8847-db04-3d60-f35438250bef@linaro.org>
Date:   Fri, 9 Dec 2022 01:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
 <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 00:36, Kuogee Hsieh wrote:
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
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`

Applying: dt-bindings: msm/dp: add data-lanes and link-frequencies property
.git/rebase-apply/patch:47: trailing whitespace.

.git/rebase-apply/patch:51: trailing whitespace.


Also the dt_binding_check fails with an error for this schema. And after 
fixing the error in the schema I faced an example validation error. Did 
you check that the schema is correct and that the example validates 
against the schema?

> ---
>   .../bindings/display/msm/dp-controller.yaml        | 27 ++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index f2515af..2a7fdef8 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -81,6 +81,7 @@ properties:
>   
>     data-lanes:
>       $ref: /schemas/types.yaml#/definitions/uint32-array
> +    deprecated: true
>       minItems: 1
>       maxItems: 4
>       items:
> @@ -96,6 +97,7 @@ properties:
>   
>     ports:
>       $ref: /schemas/graph.yaml#/properties/ports
> +
>       properties:
>         port@0:
>           $ref: /schemas/graph.yaml#/properties/port
> @@ -105,6 +107,29 @@ properties:
>           $ref: /schemas/graph.yaml#/properties/port
>           description: Output endpoint of the controller
>   
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +
> +            properties:
> +              remote-endpoint: true

PLease add empty lines between the property definitions

> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array

This is already a part of video-interfaces, so you don't need $ref

> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 3

enum: [0, 1, 2, 3]

> +              link-frequencies:
> +                $ref: /schemas/types.yaml#/definitions/uint64-array
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 8100000000

I think we can have enum here too.

> +
> +  required:
> +    - port@0
> +    - port@1
> +
>   required:
>     - compatible
>     - reg
> @@ -193,6 +218,8 @@ examples:
>                   reg = <1>;
>                   endpoint {
>                       remote-endpoint = <&typec>;
> +                    data-lanes = <0 1>;
> +                    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>                   };
>               };
>           };

-- 
With best wishes
Dmitry

