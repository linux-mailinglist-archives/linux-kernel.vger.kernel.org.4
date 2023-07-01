Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55C7447E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGAIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjGAIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:06:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51B1B0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:06:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso3012677a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688198796; x=1690790796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2AOA85WPLNeq59zZIQIWUFQQzF6b4WaPXnHpsoj/pM=;
        b=uTt9U+aYLjgWdXce3eySEIwUYyScwz33iTbz8S7vol+S7QzIP9b1Fio3ugyjMzlTEM
         H35JObt6DdDe+ZAcrodw8uN/VW+NQ0CqZ3BQL4MYQyK/VG/jqB9fXAiem+0ABDpT8SMD
         jtIdYLOMBEssloGgEwn0cZsSLT3+MKV5fWePDdwy5GOGUNilj/gsbg/gPIl5znH0T4Wu
         vzEsOA4OW+uHY00syfFg4Kk7fezNivoQaQSTeCBtNOfjXPeHitfb0gcotxrQzmejiOg3
         Ym29/2O6Y8KtJR8Z70kir6HCS6nh0pKIyzJxpXQqPSeCQaqa/GXYh7L3Bhc+EOvvhCfl
         rA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688198796; x=1690790796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2AOA85WPLNeq59zZIQIWUFQQzF6b4WaPXnHpsoj/pM=;
        b=I0Uby/1i2XUv16auSquBGloRbfd5CB6MYLlnQsD+SZmAtNImMLdYLa92xTF+/i0MBx
         PLIiw6gUiotJ6cbnRn9xSsylewyd6LvlcxSTiimyh1gvYhLQdn6aYGmWSj18/o4MRTP5
         3tkF5bEP+AuNgXALIEUzN+qxiUm5bhcy7GCb4sdVSYBgUqTLvYjjROs75AKI51nvWqBf
         mIWZmg61W+19LMRwVyuoWlyw99tKXo+ldO9W/PA8N5Km0R5E/j1SlVlIHVXpPf9Zhgsm
         vO56LHaKiK990owS/70k65UzYJGD4/SHFtpwkPayGZe1pH9J2RdV5dZWdKm/ul+fhOjC
         /n6g==
X-Gm-Message-State: ABy/qLZ7QL9446uCo5X/CT5+V8+M4aDXm+xGbofFvqKLO3eOXBY99mMz
        z76rNIrrze/7P6HzBUpDnRcPug==
X-Google-Smtp-Source: APBJJlEAcfboaxVqaehIP+kbquc2c7WH/RTZTv63cSm62Jc7muAl9JsCRYIb9E82IwV3w1SZdW4oEA==
X-Received: by 2002:a05:6402:64d:b0:51d:9605:28fd with SMTP id u13-20020a056402064d00b0051d960528fdmr2861016edx.26.1688198796353;
        Sat, 01 Jul 2023 01:06:36 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906850c00b00992f81122e1sm1268309ejx.21.2023.07.01.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:06:35 -0700 (PDT)
Message-ID: <05d97994-49a4-1618-890f-9f5c70c201fa@linaro.org>
Date:   Sat, 1 Jul 2023 10:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/11] arm64: dts: qcom: msm8939: Add missing
 'cache-unified' to L2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-3-6b4b6cd081e5@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-3-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 18:24, Konrad Dybcio wrote:
> Add the missing property to fix the dt checker warning:
> 
> qcom/apq8039-t2.dtb: l2-cache: 'cache-unified' is a required property
> 
> Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 ++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

