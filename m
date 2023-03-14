Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041146BA215
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCNWNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCNWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:12:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C95A1BF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:11:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s22so21920727lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678831842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xa6qL+0cyQtdd06tlhVcRMFF8+ijkQsFwj/v1CH/YRY=;
        b=DGMqSQPQuS+r9I5ntAoMsVOVOjmu/EuPgstaOB9ABRALVI14LAFehPzSOqHKG9eOT9
         zJqBzEOouvJ16zWawVP1+pYWnAj/0BUbcH2jzF3rE516SDvyE4Ok4EThPx7urw8Tsdtu
         L3lwgQJkXGAw+HuQltEGgpzNfovW4bf7tbtu+1Ph2f91kXlKgg/OMTvVlII+bdGeyt2n
         xqOBVu95Bp21eag5csmSue1xiBQMVqXoKSlqZXTfa3oFkRcmPc2pZBTn9LincDMXtBaO
         wIki9/weLTQYXMdtOCLRxBvFUTYcf4q+R9vGKeJk1QXtM/u2oKSeZn8nbJmeHwmHUV/T
         y77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa6qL+0cyQtdd06tlhVcRMFF8+ijkQsFwj/v1CH/YRY=;
        b=6Lww9wLeeOjTYklmbBuMVyPy80RDY6sRBVsQGKCjuaOju6/yBrz5g7fs5GkM9spxgc
         ZQVpIgmB0CPmK7Faaqb29WC3f6UFVTAU4J4SYVGl9kic2/nX7W/9oUG9BqTuV9tXfyMn
         CkvgSkffkaJODQSBjRarKbMPl0dlM45DTYtx+Wl3WEVx9S8rnRH1Y0yc9BV/8GOB/8lW
         q8hoR+NubC3EUZX9pJfI/6A7AVTqMr+i4sIDnsoICmPyTWw0PH4wOr6DXlPISZxdj2HH
         dHcJhtX49oo1DKeHCFfD6K6v+VWxWbt+5szAhlvYGdprZXQb/sQZziEudjaQ2sMQo25O
         cifQ==
X-Gm-Message-State: AO0yUKVOLMAW5EZE0ImXVlGJ1EtstWgH7VeFQSgDJTk7wbl/smUmebbr
        I8xarVvmrFHn7avNJjy4uEK1jw==
X-Google-Smtp-Source: AK7set/CL8Ze4Qk9YgtnTcm6u3tNa1jyupEcdr8xxX4+Sr4/EUKmodC99ZABfJHlPuVuyJ8q2JycLQ==
X-Received: by 2002:a05:6512:7c:b0:4cd:ae0b:9397 with SMTP id i28-20020a056512007c00b004cdae0b9397mr1176558lfo.67.1678831842680;
        Tue, 14 Mar 2023 15:10:42 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id d2-20020ac241c2000000b004db1b99055dsm552935lfi.229.2023.03.14.15.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 15:10:42 -0700 (PDT)
Message-ID: <68a26435-4f00-1571-88ef-1f3c0a254cef@linaro.org>
Date:   Tue, 14 Mar 2023 23:10:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: sm8350: add dp controller
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v4-0-dca33f531e0d@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v4-3-dca33f531e0d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v4-3-dca33f531e0d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.03.2023 10:19, Neil Armstrong wrote:
> Add the Display Port controller subnode to the MDSS node.
> 
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #SM8350-HDK
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]
> +				dp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
Downstream doesn't seem to use this lowest freq

Konrad
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
>  				};
>  			};
>  
> 
