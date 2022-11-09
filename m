Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FA4623375
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKIT1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKIT1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:27:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D226487
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:27:48 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g7so27470419lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXJn3wRJvG74Ahsr/X+Onmc/VKFhlVPUovnUVOo53U4=;
        b=YbYvLSxSpYE+jt7vwxj7OVhLmXgAPOA/TY5Je8XqU9owlGQFKjDO3t/JmRNDnjxxLV
         H5L3GQJwuG/EOjwoT7lkMxIDqwPg3uQfnzHV+XfFQ5QPMbqmRZqO20kMCA+VmSNyCkvn
         BmspsC9tMAaWus3aLITiTU9yP/TCJ/qw7Zc4lAkmC/1cUHPCcaNMzdjtdJruAY10tpRm
         7Mz9g0NSrpqQejpQ0br+TUli0qY9eZ8z5/VwK2eu8HFqEWF9xgBKcvGrQD+yRMCcA4OX
         GhL+biyiE3/t5Y4wxA7OPX8wq/VCIwxtslhHCZgWu5spdi+iAB99DhVIyy57uQt47BR3
         dtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXJn3wRJvG74Ahsr/X+Onmc/VKFhlVPUovnUVOo53U4=;
        b=RPqG+pR7LIgUgw0M2Utg/qiwqFQkE7PGkblN/WLf+1c7hwPXlQ4cLFbjj44it0qIZj
         U5TeiV8KGYMYclSlqV5g0iyAjF7KVcOZ2q+ubqrGUrkrEc0vjkJyaxIbnAOxIN4oY4FJ
         wAfamlTlpeTJaVGvkGzbOvk2ZRV2Z5lXzppJoSki5eWjQYjxBarozPs/tbgknF60kJkv
         dK/yqe3HcsqZ5fMkYBx5GJow4xehUf4zDXAh3AsoteLZlVI8KSBE8yif4hxsxsJp45uA
         /NzZPnMZ5ZbIhvULrV/mj2cT1WBMLVytLwAP0odnw8qVt/xwLzVqCFaZuBB0gqZSRKeU
         R8+g==
X-Gm-Message-State: ACrzQf00ufI1Yo7I3h6IVE+Q0haSoiNVg2g/CwcaOhqlPwEuoF2vW2j5
        iJ96hFbtAt5GY5gGZ2ygCtMnKQ==
X-Google-Smtp-Source: AMsMyM4EbNcHKhibXcvKZHiCPuO2vkJu1vdpocAjRZub4zhkTfio9MoqToCwPRo7wk7zZeYvd0WJJQ==
X-Received: by 2002:a05:6512:12c9:b0:4a2:8760:47f1 with SMTP id p9-20020a05651212c900b004a2876047f1mr20715550lfg.24.1668022067060;
        Wed, 09 Nov 2022 11:27:47 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id e23-20020a196917000000b004979df1c1fasm2378780lfc.61.2022.11.09.11.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:27:46 -0800 (PST)
Message-ID: <776f0e3b-932f-d4fe-d949-9001866d0093@linaro.org>
Date:   Wed, 9 Nov 2022 22:27:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add link-frequencies property to
 specify the max link rate allowed
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1668018895-29023-1-git-send-email-quic_khsieh@quicinc.com>
 <1668018895-29023-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1668018895-29023-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 21:34, Kuogee Hsieh wrote:
> This patch add link-frequencies property to allow each platform to specify its
> DP max link rate.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 93e39fc..7e5d755 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -441,6 +441,7 @@ ap_i2c_tpm: &i2c14 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&dp_hot_plug_det>;
>   	data-lanes = <0 1>;
> +        link-frequencies = <810000>;

The link frequency is a property of the link - in other words a graph 
connection. Please don't put random propreties into DT nodes where they 
are not to be used.


>   };
>   
>   &mdss_mdp {

-- 
With best wishes
Dmitry

