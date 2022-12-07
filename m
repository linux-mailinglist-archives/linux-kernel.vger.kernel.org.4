Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C43646211
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLGUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLGUGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:06:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A256151C26
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:06:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x28so13082591lfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVZZ17cW0EmuZRh2nTo/dxOsOvCo68gbOMlI0qg0Oes=;
        b=f83oDLXIKgXTvGRYKqZtWpfPU8ufCWVDcdrjasaCLvpkw7nA/JC9IYESereH++ibEn
         dyVjnTTFusrXcYYJqJXpKhfVOrZoWAEBj3AxokAfqEvE6nDqEVi9Uxat0xtez4s1+Wr2
         f90QZSh2x+gG0xb1yApoMeZNSB1FxEDyC7wVP90pwRrPLXi88cepilas96RCOzMH+nfG
         KQ79MkzVpLTfDPbMFnVm3/AJGgNui4KuB9lms45NY87q8eP7BeiiU8Vx5B6CnRzKdFw5
         4fcWEUcP03ArwhKl7wAVOYsk0sMBXuUlDkGdrrlJM9qABic+vfz5BkHLKBj+GpCFk0K2
         DH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVZZ17cW0EmuZRh2nTo/dxOsOvCo68gbOMlI0qg0Oes=;
        b=1QoBAGnUv0lqX8+CBDbO4jBN8D8IgIeNGMnq73LaLrPGb+DBdsGkviLN2d8sA5A8pj
         LZmiHBBaMye+CX6C8CzCHQpvYXsV3X6Y2YqA8prxutNE6qjxApumgBMmmC2HmUyQzBED
         baUby1CyUAxXABTgacbGwbO5x+XJcGD/GDFz0nhJ4M/OqL81CnG0yAZcwDFOOeeMZ87s
         ZalvM5Ka+AFZvKYuFhYpFJnHTFGuuAAfL1JPA9xXlHZkHsLoM/a2YqLVNIQsbMIgZADy
         C00U0Ar1Jvpbe9BPMU671Y1teRRnq0Cyidot5LmZ9DZ7kTz0i4s2A0Dmrw4XaiJImQcs
         FVUg==
X-Gm-Message-State: ANoB5pl2m9JVoXSsUd8whDQzdFdHygNO8GQ3mtc07YsXrRf7oU1tm7oi
        Ic7K5T31E/JSQg8Z4hiW+QeYdA==
X-Google-Smtp-Source: AA0mqf6lF43siP7A8cs36cAr32BfjPsWC/tEMDD+5bQ4FNR5cgq2SC2e+dr0o9VhXGZ0Qy5V7AFotQ==
X-Received: by 2002:ac2:4e07:0:b0:4a2:2a60:ecf5 with SMTP id e7-20020ac24e07000000b004a22a60ecf5mr32619085lfr.57.1670443572075;
        Wed, 07 Dec 2022 12:06:12 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i10-20020a0565123e0a00b004b59067142bsm474079lfv.8.2022.12.07.12.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 12:06:11 -0800 (PST)
Message-ID: <fc1b64dc-938e-0bb2-ef28-c09c7ec17efd@linaro.org>
Date:   Wed, 7 Dec 2022 22:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v10 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Content-Language: en-GB
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
References: <1670432278-30643-1-git-send-email-quic_khsieh@quicinc.com>
 <1670432278-30643-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1670432278-30643-3-git-send-email-quic_khsieh@quicinc.com>
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

On 07/12/2022 18:57, Kuogee Hsieh wrote:
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
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`
> ---
>   .../devicetree/bindings/display/msm/dp-controller.yaml      | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index f2515af..c4a278f 100644
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
> @@ -104,6 +105,15 @@ properties:
>         port@1:
>           $ref: /schemas/graph.yaml#/properties/port
>           description: Output endpoint of the controller
> +          data-lanes:
> +          $ref: /schemas/types.yaml#/definitions/uint32-array
> +          minItems: 1
> +          maxItems: 4
> +
> +          link-frequencies:
> +          $ref: /schemas/types.yaml#/definitions/uint64-array
> +          minItems: 1
> +          maxItems: 4

There is an issue here. You are describing the properties beneath the 
port@1, while in reality they are found beneath the endpoint node. See 
analogix,anx7625.yaml for a proper example.

>   
>   required:
>     - compatible
> @@ -193,6 +203,9 @@ examples:
>                   reg = <1>;
>                   endpoint {
>                       remote-endpoint = <&typec>;
> +                    data-lanes = <1 2>;
> +                    link-frequencies = /bits/ 64 <1620000000 2700000000
> +                                                  5400000000 8100000000>;
>                   };
>               };
>           };

-- 
With best wishes
Dmitry

