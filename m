Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFA654F19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiLWKRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiLWKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:17:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D891D30D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:17:35 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so6496150lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yeWUow2E5pd2PmOCYDGqEvn8SqI6E1/L8N2s/4ZDIE=;
        b=Ve7gil8jUZYofM9V8JzFF/GvDmfNW8+AOx08yqR8aW50OA1NwjrDf+3dJ3z3Rrd2op
         6Hj6L6E2vnKBFbSpvFob6758PyXPL0SJchZeovU9FVdp+wFh9qz4o/SJ6jCfGHzVhW2k
         0671EN84JGD3ob0BsnsZjSkc5M7tfq+ZtoVEELCd2uFlHdISfjTRH5L1xQhF+NEpb/OP
         kKcpubaxqdIrqbxEbW4KCxhOSVxoTXB87xXjP+Aj9eHDmp9s3/rya2YMF+l3UZ1BboVU
         9L6fZkA7G8cLtjLpZWVsnk13GqX5LblVDTka24aFN9QreuE++buGBu+ae/5wGkkwRWo5
         s5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yeWUow2E5pd2PmOCYDGqEvn8SqI6E1/L8N2s/4ZDIE=;
        b=i6mfipcjwWVfVX1HoHl0MoN0ZGIFJeMxacaLmg35F58COgcj9AiYvonesqnC8h+e5g
         DCvJC5JdPOu5Zf9vD1CCNoRxScRzkNjNu5KjIIQ0m6pIDHavlyHrckdXKg+qslxL4Lqm
         gJLOT5hUJSHRqUt6xXnK90r39hjszrlh+W3igDIksNMLtCO+h0mbQT/OiEbzF3PEYpG0
         NW/Gw+kBWO0U7lJlccdhOCOASk/WgQvJKGSLAw4BsIu/gKkdzWvatpF76HX3tukslyk4
         GgDLu/BRvoAD7IFn+Fn/79CIUo7KObohw1E24LNFP7L4+CNQLc5pHrdhWbpV39Rl7NeG
         vKPw==
X-Gm-Message-State: AFqh2kpUDbnb4KtYxg+qQLFelqyr9yHIqHYA+BBcsYAqJQlkMWLQcSzS
        eWrgUbwm/GPKMoU93ykwewyIww==
X-Google-Smtp-Source: AMrXdXv1uMaEYM2D/w228oNwbo6Ir5UbrfEO2/Odx4oJ4msCRYOs55faL+1VZkr95dIxzDdUWKfPPw==
X-Received: by 2002:ac2:4834:0:b0:4b5:7f15:aa21 with SMTP id 20-20020ac24834000000b004b57f15aa21mr2963858lft.52.1671790653881;
        Fri, 23 Dec 2022 02:17:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512315000b0049876c1bb24sm463280lfi.225.2022.12.23.02.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 02:17:33 -0800 (PST)
Message-ID: <8756ed6b-6ac5-af0b-2f20-236f59f3f80d@linaro.org>
Date:   Fri, 23 Dec 2022 11:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 4/5] ARM: dts: qcom: fix various wrong definition for
 kpss-gcc node
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-5-ansuelsmth@gmail.com>
 <1f2901e3-c527-5528-9103-c722e56d046a@linaro.org>
In-Reply-To: <1f2901e3-c527-5528-9103-c722e56d046a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 11:17, Krzysztof Kozlowski wrote:
> On 14/09/2022 16:22, Christian Marangi wrote:
>> Fix dtbs_check warning now that we have a correct kpss-gcc yaml
>> schema. Add additional qcom,kpss-gcc compatible to differentiate
>> devices where kpss-gcc should provide a clk and where kpss-gcc should
>> just provide the registers and the syscon phandle.
>> Add missing #clock-cells and remove useless clock-output-names for
>> ipq806x.
>> Add missing bindings for msm8960 and apq8064 kpss-gcc node.
>>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> ---
>>  arch/arm/boot/dts/qcom-apq8064.dtsi | 5 ++++-
>>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
>>  arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
>>  arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
>>  arch/arm/boot/dts/qcom-msm8960.dtsi | 7 +++++--
>>  5 files changed, 13 insertions(+), 7 deletions(-)
> 
> 
> warning: 1 line adds whitespace errors.

Only this is relevant (rest of non-applying is not important)

Best regards,
Krzysztof

