Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39268D43E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjBGKaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjBGKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:30:38 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3836443
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:30:26 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mc11so41907891ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UsRhXRFs9hrZRt6IhSSd8w0WAFtLjYJYFnRkhP2FVc=;
        b=DAwArbfyDYK8YLfvK89NI4ckbt6HEMDT47v7a9/GelG5HKpqgAypdVh/Sm8ZNjk/jc
         BbSSI5aON8z6yptTLsvJSlfL7tPjkWbJAoYN4gdE7sB+JsiTRN8nxTexosW9d0crMZ0V
         cJ1hOmWt/z+6w29WnNcXwksfWIqqCwYchKr2e2lc3I3AF0zwcnZ3qdmJlfYKuuqXGCZH
         GBO/JsukBe2B1N6wKhLCKyyimIKoHk2McPpPCIqz9xJsQ4NJKkBWV0Rr34H8NucyfAPB
         lpoDnldrSxjj8icrypw5yjx1g9RsgqQuaG0hqxG03ykT9CzIiTPud+kj8JWlowGvvBXO
         sldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UsRhXRFs9hrZRt6IhSSd8w0WAFtLjYJYFnRkhP2FVc=;
        b=4uzKm4vH8R83bBAYYwb6Lfg7azqB1F4o+EoilYk/zs/AK1IA24MyIwhtYevu2mmGWA
         YLZB3NOHVZjhMA8fMzp7Ac0jAnCg1JCdli2TeePAOpn3Tfw62tTcf1nqkw/UMQ0oWMDX
         r3vu0N46aSxXPCC2cWrpFjKplp64kKcIxfHdopPD+Ijx+vePlRhIPKsL9RW5o4rpsdxz
         7g1Pz5s42pRavm++fp3PKbFr7viwewgwFxXx1etwp+roxJDdDWo2CwZvVm36KiZnNdhp
         Ulzxv6O08aK7vzQWww2Rnu/a63gwhvcswRDz9rVXvZMVTTxtJ8WqhRSGhpzzjutMbQEo
         VieA==
X-Gm-Message-State: AO0yUKXpevtzvy9/eHob/gYqzMJK1qoKE5U69LpoEu1SwSaHun/REJbC
        0gdzN353j+gh+JQJedvxm171/d/Fayd911qS
X-Google-Smtp-Source: AK7set81oA1hCR6TXYS1Al0eRsc/xby+y0Mc1ViatvGMtCUdUsIITyap+cUOU7OLaGr8tG+y7KkkEg==
X-Received: by 2002:a17:906:801:b0:884:37fd:bf4c with SMTP id e1-20020a170906080100b0088437fdbf4cmr3050044ejd.19.1675765825371;
        Tue, 07 Feb 2023 02:30:25 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t9-20020a170906608900b0088f464ac276sm6692727ejj.30.2023.02.07.02.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:30:25 -0800 (PST)
Message-ID: <f7e61ff2-4124-35b9-7d08-ce2be97aacf2@linaro.org>
Date:   Tue, 7 Feb 2023 12:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pmk8550: fix PON compatible
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-0-698d132ab285@linaro.org>
 <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-2-698d132ab285@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-2-698d132ab285@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 12:06, Neil Armstrong wrote:
> The right compatible is qcom,pmk8350-pon, it matches the
> reg resources associated to the node and the subnodes compatible
> properties.
> 
> Fixes: e9c0a4e48489 ("arm64: dts: qcom: Add PMK8550 pmic dtsi")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/pmk8550.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

