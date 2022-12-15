Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D86B64E042
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLOSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiLOSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:10:59 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CF3B9CD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:10:57 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c7so190153qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG+0Rm2jjJBdDqmN8Ttr20QoiXVl3Uv9oEGlc46bveo=;
        b=ZB0jhIhSEOHra6B1YQUlgFF+ymijtV1D53w5jNp8hIlXEZ3u0UAMnjYbgnh2hnB+iE
         3VS0fAoDYKYvlash2fysc5pxkb1NhqbStXUUfzySkOLx7rf0wl0Xl5wtGpmtZ0HU6iTy
         PF4Vpj8ec/A/AliXDJ5Qbcx/w1d9GYrXkz6Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG+0Rm2jjJBdDqmN8Ttr20QoiXVl3Uv9oEGlc46bveo=;
        b=K/9WaOXJ8aBaxr5tmZMCPFJ1VThIPnhDTxxFAd72m8AWE0z/E0mxYt5/HRz0Gs6+it
         aQomD0Iu3IvEdiAwLiRsM90pRFc18+CwPBg5l3YDiP4jJjOZtdZarm6G8lf246xqOgdU
         t/zbPoiIJrlHwVhexMgRxOzsdDlBYXpufE2ba/J/19N2f80F5biRuzKpoQfxuf7AiJH5
         NiwVQxCyXuRI0ZE0TL5mOuthd5WUaJxEcX3AhBSIaZrRlSyxTOlq5ZaNgH32osWrxc+x
         fvoWvUdLhnFLx4OmTRVzhNPKItzdFLGYJgx53aDy9x9DHY+I0CZ1I8jrwmVPR5H7CxIj
         4dUg==
X-Gm-Message-State: ANoB5pnrC94qrxa8hq/im3UxapSVwyrNIpg8dmkgCC0rKVnigK6hA8nk
        z9vVAqOK8fUjGVk4UN9UkZhz8s99UbHtJJlRQ2M=
X-Google-Smtp-Source: AA0mqf7RBcIiUGEjs2ruJb5Gpo9nNZ2fWhTarkZrIs3D93QDLsw2nGS8V3n0HJDN/Gyk5WAvvkkFBw==
X-Received: by 2002:a05:622a:1cce:b0:3a8:28b2:af69 with SMTP id bc14-20020a05622a1cce00b003a828b2af69mr10952843qtb.58.1671127856216;
        Thu, 15 Dec 2022 10:10:56 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id o25-20020ac86999000000b003a5430ee366sm3894807qtq.60.2022.12.15.10.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:10:55 -0800 (PST)
Message-ID: <6ec85678-9029-4725-eadf-39e814ff807d@ieee.org>
Date:   Thu, 15 Dec 2022 12:10:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: enable IPA in
 sc7280-herobrine-lte-sku.dtsi
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org
Cc:     elder@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221208183837.505454-1-elder@linaro.org>
 <a5ec259a-9f78-a54d-c15a-291f192ee220@quicinc.com>
 <78cd38f1-6ebc-097c-07f1-f7a028f07315@linaro.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <78cd38f1-6ebc-097c-07f1-f7a028f07315@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 12:01 PM, Konrad Dybcio wrote:
> 
> 
> On 15.12.2022 18:38, Sibi Sankar wrote:
>> Alex,
>>
>> Thanks for the patch.
>>
>> On 12/9/22 00:08, Alex Elder wrote:
>>> IPA is only needed on a platform if it includes a modem, and not all
>>> SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
>>> used to encapsulate definitions related to Chrome OS SC7280 devices
>>> where a modem is present, and that's the proper place for the IPA
>>> node to be enabled.
>>>
>>> Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
>>> DTS files for Qualcomm reference platforms (all of which include the
>>> modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
>>> enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
>>> to enable it.
>>>
>>> The only other place IPA is enabled is "sc7280-qcard.dtsi".
>>> That file is included only by "sc7280-herobrine.dtsi", which
>>> is (eventually) included only by these top-level DTS files:
>>>     sc7280-herobrine-crd.dts
>>>     sc7280-herobrine-herobrine-r1.dts
>>>     sc7280-herobrine-evoker.dts
>>>     sc7280-herobrine-evoker-lte.dts
>>>     sc7280-herobrine-villager-r0.dts
>>>     sc7280-herobrine-villager-r1.dts
>>>     sc7280-herobrine-villager-r1-lte.dts
>>> All of but two of these include "sc7280-herobrine-lte-sku.dtsi", and
>>> for those cases, enabling IPA there means there is no need for it to
>>> be enabled in "sc7280-qcard.dtsi".
>>>
>>> The two remaining cases will no longer enable IPA as a result of
>>> this change:
>>>     sc7280-herobrine-evoker.dts
>>>     sc7280-herobrine-villager-r1.dts
>>> Both of these have "lte" counterparts, and are meant to represent
>>> board variants that do *not* have a modem.
>>>
>>> This is exactly the desired configuration.
>>>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 5 +++++
>>>    arch/arm64/boot/dts/qcom/sc7280-idp.dtsi               | 5 -----
>>>    arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi             | 5 -----
>>>    3 files changed, 5 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>>> index ad66e5e9db4ed..956708397f035 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>>> @@ -34,3 +34,8 @@ &remoteproc_mpss {
>>>    &rmtfs_mem {
>>>        reg = <0x0 0x9c900000 0x0 0x800000>;
>>>    };
>>> +
>>> +&ipa {
>>> +    status = "okay";
>>> +    modem-init;
>>> +};
>>
>> nit; You'll probably want to move the ipa node above remoteproc node to
>> maintain sorting.
>>
>> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Tested-by: Sibi Sankar <quic_sibis@quicinc.com>
> That + please flip the property order, as we're trying to
> keep status last wherever possible.

Thank you, I'll post version 2 this afternoon.	-Alex

> 
> Konrad
>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> index f7efb9966afd1..0ddbe7f732bd9 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> @@ -376,11 +376,6 @@ &gpi_dma1 {
>>>        status = "okay";
>>>    };
>>>    -&ipa {
>>> -    status = "okay";
>>> -    modem-init;
>>> -};
>>> -
>>>    &lpass_cpu {
>>>        status = "okay";
>>>    diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>>> index df49564ae6dc1..cd6ee84b36fd4 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>>> @@ -336,11 +336,6 @@ vreg_bob: bob {
>>>      /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
>>>    -&ipa {
>>> -    status = "okay";
>>> -    modem-init;
>>> -};
>>> -
>>>    &lpass_va_macro {
>>>        vdd-micb-supply = <&vreg_bob>;
>>>    };

