Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727A163E63F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiLAAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLAANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:13:37 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAE1A0577
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 16:07:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r12so21515lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 16:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPrD93pLoHJDHfqU7iF0kkDXNwOLW25TnHPn7r3B0pg=;
        b=PbwrQ+zNQO06RoSt28/h+Fo+ZAGGkUX+1xRMtY3NFaVNuHM4s5AL9l0nVM2y2WqdQJ
         5o993rjsVbuk5utuGKFYe+IZgBxb136GclFy3Tn6jpNoEPRNVZDQLdxWT5jiaCO8SsGi
         GkL1grn9ye0cli9iHmZpOW2Aa3bjOr4DUoiA9B6tyeR67d36aaMQHZCIqJvrDmLAN49a
         6An2unYmCwRTBthslSxGE+Tn2N4qrMoti6UwLm5iMnvzFTDb8Eteb66kTVPNsy27EmGm
         BAe8rlAHbyAg/jVsq/APY0il3qemUDJ+gfNVOanlwjEOQQ6Tlvb4kMuhtjLxwtDD4Riz
         OVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPrD93pLoHJDHfqU7iF0kkDXNwOLW25TnHPn7r3B0pg=;
        b=U3LG6IqZkcHorTHHFa9CVDINkLiPj8F8jEA/GDJWCcQ09fAWT7TLLhmm6IvEUWmsyE
         ac2zOH1CZmWgq8p4iGNPSJj68mjP4hrlXft91OqROjPP9J+zdvIbWHy1tmHmAsnB4FPP
         uaEvK5Ag0sBzGN9GrBe2PI1jKpHGv7pchQkLsGO6AxKd8hSry68D2n8CJ5dD0Ca9TgUM
         bVbV2bIfXGeyXw5IhTbZ5nYep1sE0cn92Qg8lIVvn9uUxndEvT9w9Ms4SgAXRks3YRVJ
         MXyGOQe2Wy7HkvBMG3u/CdMqiDfmVOeWknfFLbjonM8VmwzzDEPNXwtDrYtUAjbQmX3b
         Jw1Q==
X-Gm-Message-State: ANoB5pmiEiq0CTXS0vdTroG9JYV0tYwTm2skchyu42uBSS7DtUbAy5Up
        rIwBOgmwkF3JINYy78plsEg4ag==
X-Google-Smtp-Source: AA0mqf5YORHL5xhY4w8QqEjEt6mP1L5AvXuK5wuAdacXYewzC1TfB6Hz/F541WQCWirzdXPkyQskLA==
X-Received: by 2002:a19:7b0f:0:b0:4a2:3bed:2008 with SMTP id w15-20020a197b0f000000b004a23bed2008mr22732329lfc.88.1669853223337;
        Wed, 30 Nov 2022 16:07:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004b4b90a6992sm426023lfv.95.2022.11.30.16.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 16:07:03 -0800 (PST)
Message-ID: <7bf73466-e476-4a1d-5dc0-1b63ea742226@linaro.org>
Date:   Thu, 1 Dec 2022 02:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: add data-lanes and
 link-freuencies into dp_out endpoint
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669852310-22360-1-git-send-email-quic_khsieh@quicinc.com>
 <1669852310-22360-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1669852310-22360-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 01:51, Kuogee Hsieh wrote:
> Move data-lanes property from mdss_dp node to dp_out endpoint. Also
> add link-frequencies property into dp_out endpoint as well. The last
> frequency specified at link-frequencies will be the max link rate
> supported by DP.
> 
> Changes in v5:
> -- revert changes at sc7180.dtsi and sc7280.dtsi
> -- add &dp_out to sc7180-trogdor.dtsi and sc7280-herobrine.dtsi
> 
> Changes in v6:
> -- add data-lanes and link-frequencies to yaml
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   .../devicetree/bindings/display/msm/dp-controller.yaml  | 17 +++++++++++++++++

Separate patch. Also you didn't check the get_maintainers output, so 
required parties were not included into the distribution.

Also as you'd check the get_maintainers output, please fix other email 
addresses too.

>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi            |  6 +++++-
>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi          |  6 +++++-
>   3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 94bc6e1..af70343 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -90,6 +90,20 @@ properties:
>           $ref: /schemas/graph.yaml#/properties/port
>           description: Output endpoint of the controller
>   
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +
> +          properties:
> +            link-frequencies: true
> +            data-lanes: true

No. Use $ref for both of them.

> +
> +          required:
> +            - link-frequencies
> +            - data-lanes

No, they are not required.

> +
> +          additionalProperties: false
> +

deprecation of old data-lanes property?

>   required:
>     - compatible
>     - reg
> @@ -158,6 +172,9 @@ examples:
>                   reg = <1>;
>                   endpoint {
>                       remote-endpoint = <&typec>;
> +                    data-lanes = <1 2>;
> +                    link-frequencies = /bits/ 64 <160000000 270000000
> +                                                  540000000 810000000>;

I guess the number of zeroes is wrong here. This is 160 MHz ... 810 Mhz, 
rather than 1.6 GHz ... 8.1 GHz

>                   };
>               };
>           };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 754d2d6..39f0844 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -812,7 +812,11 @@ hp_i2c: &i2c9 {
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&dp_hot_plug_det>;
> -	data-lanes = <0 1>;
> +};
> +
> +&dp_out {
> +    data-lanes = <0  1>;
> +    link-frequencies = /bits/ 64 <160000000 270000000 540000000>;

Same comment here.

>   };
>   
>   &pm6150_adc {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 93e39fc..b7c343d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -440,7 +440,11 @@ ap_i2c_tpm: &i2c14 {
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&dp_hot_plug_det>;
> -	data-lanes = <0 1>;
> +};
> +
> +&dp_out {
> +	data-lanes = <0  1>;
> +	link-frequencies = /bits/ 64 <160000000 270000000 540000000 810000000>;

And here.

>   };
>   
>   &mdss_mdp {

-- 
With best wishes
Dmitry

