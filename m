Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4385ED60C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiI1H2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiI1H15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:27:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A39AFC6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:24:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a8so19032035lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1Fcjg+cr/kivPTm/GJb7y8jmzhRLvf3S0ZdXAVdnOJ4=;
        b=pIEAF7CmpeuNeerOjifq8bpwxJUxDu0IhdixG7O6Bzt6ga6FDxRzK3xVNbtzdFk8aJ
         qO8xeH0alV1B3+7fjnQQoIP8pUUTg2xON02V1lW+2DLgMYtwxnjqbpLKkRd6ia54NygP
         gQPPmzMxhwfFz6CTG8z+0T7wPnGAC5HGlZ4pKwMjk0OIDDAqgU3gy4b6+iFcxOBq+Ix5
         vfLMwYsHxSHmQh2YBNKXjAfVQwmmwbj0TSuTezApYhPO0DTMPREMpRUG+rBLal0Qyudh
         5I0Fx9H/4zUjLCX1v69tmiU4UK5+gDf44feD4RL75X3052nPOxWT8+tulsy45arbovLF
         kHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1Fcjg+cr/kivPTm/GJb7y8jmzhRLvf3S0ZdXAVdnOJ4=;
        b=6EJzrRY5zTz2Aq4dUcsLum5rVmDhobSC4tNXD9CbiwKp4AKX1LCNKSllCCOXt9GdC8
         DzNFh/qlWxylfEr5TBRRxVIoeD1+02Q3y11NYaMYP9z4F7NcAeroGf9dhaX9OEGJ2s3E
         u8rJoi2TnmtcbbTrAkoG4G6ZnxiFDzo0QJUVNXSc7quEImW/11LmPgazFRS+qjBU6hPu
         C7xri37E/+K2+jM6dZ6G9p1kHC8U3GdYebvOXWcwnthXkWISU3bGyNq/w/oUSoSdpsxt
         ysbjC5FZTbP10jiHRZE6S/TKCpqK58IxhdBEc6wUJoF1xUmQn/KGI72vkv/j9QrK+yIf
         GOng==
X-Gm-Message-State: ACrzQf3CT5nLyMRAjCCWP+6jBqq7CCwAOgTqtj2W+UIsEaXOqDmxayG1
        IB1iO4bTvaysG/QacvHvb3iKYg==
X-Google-Smtp-Source: AMsMyM6kIwuBG/XkP+Hl8WnArBsRLdJDRAI28PZIjVFq8EEHgxYrmDVoYYp+8AujJn5Gftc+Hy7wFg==
X-Received: by 2002:a19:490b:0:b0:49f:52cf:aeaf with SMTP id w11-20020a19490b000000b0049f52cfaeafmr12249740lfa.46.1664349863733;
        Wed, 28 Sep 2022 00:24:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s12-20020a05651c048c00b0026da7734d7bsm357017ljc.112.2022.09.28.00.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:24:22 -0700 (PDT)
Message-ID: <a3d2d7db-e27b-3d6b-2bbf-9f8b258a23b4@linaro.org>
Date:   Wed, 28 Sep 2022 09:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] ARM: dts: qcom: pm8941: adjust node names to bindings
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925210229.128462-1-luca@z3ntu.xyz>
 <3070538e-fa8d-4506-bbf8-c2770d092eb5@linaro.org>
 <3dda8e86-b92b-488a-5afb-0cb49e7e52ae@linaro.org>
 <13105309.uLZWGnKmhe@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <13105309.uLZWGnKmhe@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 17:07, Luca Weiss wrote:
> Hi Krzysztof,
> 
> On Montag, 26. September 2022 12:29:11 CEST Krzysztof Kozlowski wrote:
>> On 26/09/2022 12:04, Neil Armstrong wrote:
>>> On 26/09/2022 11:22, Krzysztof Kozlowski wrote:
>>>>>   		};
>>>>>
>>>>> -		usb_id: misc@900 {
>>>>> +		usb_id: extcon@900 {
>>>>
>>>> Why? extcon is Linux specific name and should not be added to DTS.
>>>> Anything requires it?
>>>
>>> It matches the current dt bindings:
>> Then instead maybe let's fix it in the bindings and DTS?
> 
> What node name do you propose? I doubt "misc" is a better name as it really 
> doesn't describe anything so I don't really have a suggestion here..
> 

Some manufacturers call it a muic (Micro-USB IC), but maybe just
usb-detect? The role of this device is accessory and cable detection.

Best regards,
Krzysztof

