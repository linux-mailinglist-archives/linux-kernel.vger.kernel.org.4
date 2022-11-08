Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6C62101B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiKHMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiKHMQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:16:53 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A982F3AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:16:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t1so8685595wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oy8fNIahsBx3vtTe9hvgf4a/7hnmlEn4ezDWT7gnkfs=;
        b=Ef7F2oxs6rtbcUxBc1pUCZCtXZUPJsH586RlelsWz7FFCL8WJxlEs8/g9fnEuiaQzb
         mo5k16GMPwYUaHIqag8gCHRGufqXERNw/tACpH5yMB6VbJcCMoetyV1FzdAgX05aMnfZ
         wgi2h2CxjKN1hE1puIBWGIu1yrzA0D3SrrzAda5Vihyyk9o3q/kQLb4SKFqUlA1hJTmY
         n3Wo+XSGY0zy9TyIrlf//vX7ec4+OYWlAkoWynkfgZTTP6wiejKczj8j2SyUGVhO3QZp
         Qh5D4tyQ9fmtyOcwahAc92z0QAgdnCyEMfCV3fAhn+I2IQpGfTLWKCCWcr+gPlNSLYiw
         FXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oy8fNIahsBx3vtTe9hvgf4a/7hnmlEn4ezDWT7gnkfs=;
        b=f9DcCCK/w9z7gQiptS/J084VU9B1nc6CluoqJ2f6Z3AtYgHwPcEzjA6ughKjoiWacH
         AaKVnmp+edvKYceaIqqBaJnMKUfa48l8IYGTJe18/XVl0e+/LgTDGgAdCOn9PqoBUf66
         aaxJgwcpcv+dt1pEcAGuCPtlFlpPUmkJ0UPmIdh0XQGEriprv57HRDZqSfKlWNvzPUzm
         JMkn60HVb3tdl6MfAYmoEfBMw9H1zSdQJXAOV6R58fMsW3TbSpNI+BohB0SOgB90bPwW
         dkoqGK79oh4hhr7S44LrviD4ptHBetz7vJVtviXcVBVeVMC9xXWQPnb4DAvssx/aROVY
         LKGA==
X-Gm-Message-State: ANoB5pklm3IiOsqQFI1dHBDYXsNzUgKc8WXIIQc9qXQgVisLRbd5gNe5
        kG0UTbA9wHxoFBeEIyZduEgrJA==
X-Google-Smtp-Source: AA0mqf4bOzFPBf9nqxVYz2ey9wkBGO5R/pMSwoNsyGLIDngNVH9CBbpshPdAQcule338C1uymSSk1Q==
X-Received: by 2002:a05:600c:4e8b:b0:3cf:ad58:feaa with SMTP id f11-20020a05600c4e8b00b003cfad58feaamr6301168wmq.70.1667909810176;
        Tue, 08 Nov 2022 04:16:50 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b003c6b70a4d69sm10909264wma.42.2022.11.08.04.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:16:49 -0800 (PST)
Message-ID: <7a0c6afd-e757-46f6-5837-576070e966ec@linaro.org>
Date:   Tue, 8 Nov 2022 12:16:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 13/18] arm64: dts: qcom: sc7180: Add compat
 qcom,mdss-dsi-ctrl-sc7180
To:     Doug Anderson <dianders@chromium.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-14-bryan.odonoghue@linaro.org>
 <CAD=FV=XZ79JjmCW7wYoc0eEhMsAtqxb+p40x2f4mH+kdb0byow@mail.gmail.com>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAD=FV=XZ79JjmCW7wYoc0eEhMsAtqxb+p40x2f4mH+kdb0byow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 00:24, Doug Anderson wrote:
> This seems fine, but I don't think it matches your bindings. Your
> bindings says you can have one compatible string. It could be
> "qcom,mdss-dsi-ctrl-sc7180" or it could be "qcom,mdss-dsi-ctrl".
> ...but your device tree has two compatible strings: the SoC specific
> one and the fallback one. You need to change your bindings to make
> this work.

With the update in this series the binding has a required const.

If you drop back to just "qcom,mdss-dsi-ctrl-sc7180" you get a warning 
like this.

arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb: dsi@ae94000: 
compatible: ['qcom,mdss-dsi-ctrl-sc7180'] is too short

If you just have 'qcom,mdss-dsi-ctrl' you get

arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb: dsi@ae94000: 
compatible:0: 'qcom,mdss-dsi-ctrl' is not one of 
['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl-apq8064', 
'qcom,mdss-dsi-ctrl-msm8916', 'qcom,mdss-dsi-ctrl-msm8974', 
'qcom,mdss-dsi-ctrl-msm8996', 'qcom,mdss-dsi-ctrl-sc7180', 
'qcom,mdss-dsi-ctrl-sc7280', 'qcom,mdss-dsi-ctrl-sdm630', 
'qcom,mdss-dsi-ctrl-sdm660', 'qcom,mdss-dsi-ctrl-sdm845', 
'qcom,mdss-dsi-ctrl-sm8250']

---
bod
