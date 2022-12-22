Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E77E653E78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiLVKoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiLVKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:44:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0A18B07
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:44:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so2157013lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKoTdtVMqmk/FQkPYk1zIuQnbeZQZJIlbUEh2ppiwm4=;
        b=f/0ikqnITIxET4ZhVCuSY4rImkWCueaT68Nbvcs22Ksldw+sDH1sd9PKpstscMvmTt
         hYBSqtGX0Vtw6e+iDenk/RuM82vIMi8DrHpkGMFTJZopxurJ/8xmUS6ztLusQcuTlrPf
         zS4Da3EHGNLRmOO0kSo+QAsd/bmva5PdSf9+FmF4RLjIhpHdhR8bsp0sl/TheDXvWw0C
         34CF75KSbylZ4AeyIIzZ5qzsontMRXiw6MRyoWhSThFoVDcl71ZuIfJTXeGWCWEzb9dz
         BYqvScyiR+eAmb9CLMLPfZfGZzrYJQUHxSFE54GPcZRupcvGFDkFeWmLOHMacmH26qbA
         l1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKoTdtVMqmk/FQkPYk1zIuQnbeZQZJIlbUEh2ppiwm4=;
        b=PQpxKM0XUkSW3xq7cOF6KrutuQD33L3czi3OPcopSDIIbQLwIaePhVELOQAeB47XFx
         iZXky+82WqHrYlACpbqAn6RZqgIidHysWhuZ3Diwi/rRGsGhxrGzzVtGw5KKPysmYbw1
         /FeSmaymmRlGyJOME65TsqxOuwOpCY7BfpQiPF197v+rDP6/zBkknq5chud1Pe1Yj6b7
         RZCnZFRw9FO0gLGnTrxuXK9UPWDaDDWfnb78H4vsc/m3nE5wYQoysRSKvusv0Udag1w3
         c/g92WUOB2SNJsSUagf8B8KoPqObSdwWoVowqyFWUBFIMqEVAojI2OWB2IahAuU6+M9i
         1RAA==
X-Gm-Message-State: AFqh2kq5cJRL34+knTZ+0cP+wCUjqDttD8g2VoLUnsac+F/sAx87ECnl
        D17K8KWRc8a56sXcP9uPGLjnulsVCG82tkii
X-Google-Smtp-Source: AMrXdXvYLzQffCt7nO5knfenTpVWX2ktxwfEZ3fuXtQ2OLFluSuTbS75oEGRtcHNzUguIzb7Bcc+CA==
X-Received: by 2002:ac2:455c:0:b0:4b0:1b30:34a1 with SMTP id j28-20020ac2455c000000b004b01b3034a1mr1719394lfm.29.1671705855590;
        Thu, 22 Dec 2022 02:44:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c13-20020a19654d000000b004bc1dd05351sm28872lfj.206.2022.12.22.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 02:44:15 -0800 (PST)
Message-ID: <60e388df-cd03-3e88-e9c5-460ebdde29c5@linaro.org>
Date:   Thu, 22 Dec 2022 11:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] clk: qcom: lpasscc: Add resets for SC7280 audioreach
 clock controller
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com>
 <1671618061-6329-3-git-send-email-quic_srivasam@quicinc.com>
 <efde6373-f788-5c0c-4712-7b9caf7ad3d4@linaro.org>
 <e7edd629-986f-3e64-f9db-5ee68cf4e6f3@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e7edd629-986f-3e64-f9db-5ee68cf4e6f3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 14:18, Srinivasa Rao Mandadapu wrote:
> 
> On 12/21/2022 4:09 PM, Krzysztof Kozlowski wrote:
> Thanks for your time Krzysztof!!!
>> On 21/12/2022 11:21, Srinivasa Rao Mandadapu wrote:
>>> The clock gating control for TX/RX/WSA core bus clocks would be required
>>> to be reset(moved from hardware control) from audio core driver. Thus
>>> add the support for the reset clocks in audioreach based clock driver.
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> ---
>>>   drivers/clk/qcom/lpasscc-sc7280.c | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
>>> index 5c1e17b..d81d81b 100644
>>> --- a/drivers/clk/qcom/lpasscc-sc7280.c
>>> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
>>> @@ -12,10 +12,12 @@
>>>   #include <linux/regmap.h>
>>>   
>>>   #include <dt-bindings/clock/qcom,lpass-sc7280.h>
>>> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>> These are bindings for different device.
> 
> They are not exactly for different device. It's for same device with 
> ADSP enabled platforms.
> 
> Basically lpassaudiocc-sc7280.c and lpasscorecc-sc7280.c are for legacy 
> path.
> 
> lpasscc-sc7280.c is for ADSP based AudioReach Solution.

I see two different devices:
lpasscc@3000000
clock-controller@3300000

clock inputs and outputs are different, so it does not look like for
same device.

Best regards,
Krzysztof

