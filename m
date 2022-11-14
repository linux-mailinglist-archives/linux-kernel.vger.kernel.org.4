Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5A62860C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiKNQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiKNQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:51:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552D22BEF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:51:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p8so20233243lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dLf4Wewae+9+C646HGqgQuWVwvqyOlsvboz2D5cvWY=;
        b=qW1e16qnKkNRaGKPE94EmHEd++Gx12+z6dNP+m7n3grXvXpbSUFF33ZUECS/AF3p0O
         zKxrr6T5eDUUqqdC6tp7cJLGHZYmpoeExDo/9uhRXklrMDCYyq2DD0CvsAbBDUkgXaSa
         jy6/DzDpdospmLDHeiCg9NUdWvgToOw7mDUyb+m9tdv1OK7uM63PEyVhnZ7Yk97BMVy2
         8nm/At14I4cp0d4+4vWX0HwedhN9poV+s7T7QZ1xOjcA8E7wEpgqOzgjdFDye7OzSO6P
         o3/TH2mwcZi0gxj/uftrEyAEIDFTLGTgAV5kuCcu3X7ewpyG/QYGF0KhdMDnnti0UamN
         7A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dLf4Wewae+9+C646HGqgQuWVwvqyOlsvboz2D5cvWY=;
        b=C7OR/QvkZr1g8+4jTHS+dQmSzkIqEZQbbvLkb6eWKUPxEVgFkFbuEMymLlrax1VncM
         1fPrunL0h4PFf94Uhk9/n9afVwmnDIai5SBoL1OwbTbZw0x3gljlk5PeJRvLiS75I0Na
         gSLX7vIsyef3TqPO76GYT5Trk+rzCWrW3PGB8/WhUgbvr0XXQAk0BLeH8ZObEr/yGs1P
         7JpoGc0zyV4K8u8apitp8lJdZPRtooBnYy98Nog+IsJEPu78C+gUkVYvHA46SRpeahYK
         rhXNvPqqyyzmgt8Uvo41HJ3srzI36u9le+KOn1C1N7GeQ+/w4g6tpGXQYJijMdPKsndC
         FxlA==
X-Gm-Message-State: ANoB5pk9r9G/ZATHlOrI8wq5J5q+/gDqy2oEQBIgqTnY/vj5nWbS4Zj2
        4weBt6Jx4VUanvuNFykMRLe/7g==
X-Google-Smtp-Source: AA0mqf4iplJlnBuDmLstDKHRy1Bhyq+KwJHcQisutdSSLy9f0NnEJsl0w9ATYuvkmt/Vh6kUejVp4w==
X-Received: by 2002:ac2:4f13:0:b0:4a2:25b1:10ff with SMTP id k19-20020ac24f13000000b004a225b110ffmr5037510lfr.274.1668444691947;
        Mon, 14 Nov 2022 08:51:31 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512201100b0049d83646ce7sm1875806lfb.110.2022.11.14.08.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:51:31 -0800 (PST)
Message-ID: <5920660e-34e4-8a6b-7d99-ba0511e2c86a@linaro.org>
Date:   Mon, 14 Nov 2022 19:51:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <78cda6f8-849c-219a-8dbb-966c283c1a92@linaro.org>
 <Y3Jg/qmMW3rC5Okc@hovoldconsulting.com>
 <bcc327b6-c38b-86a9-34cb-440ad33df210@linaro.org>
 <Y3Jv4ePkPiKiG8wj@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3Jv4ePkPiKiG8wj@hovoldconsulting.com>
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

On 14/11/2022 19:42, Johan Hovold wrote:
> On Mon, Nov 14, 2022 at 07:14:48PM +0300, Dmitry Baryshkov wrote:
>> On 14/11/2022 18:38, Johan Hovold wrote:
>>> On Mon, Nov 14, 2022 at 06:19:25PM +0300, Dmitry Baryshkov wrote:
>>>> On 14/11/2022 17:18, Johan Hovold wrote:
>>>>> On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 14/11/2022 14:27, Johan Hovold wrote:
>>>>>>> On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
>>>>>>>> On 11/11/2022 10:24, Johan Hovold wrote:
>>>
>>>>>>> I noticed that several bindings leave the clock indexes unspecified, or
>>>>>>> have header files defining some or all of them. I first added a QMP
>>>>>>> header but that seemed like overkill, especially if we'd end up with
>>>>>>> one header per SoC (cf. the GCC headers) due to (known and potential)
>>>>>>> platform differences.
>>>
>>>>>>> Shall I add back a shared header for all PHYs handled by this driver
>>>>>>> (another implementation detail) even if this could eventually lead to
>>>>>>> describing clocks not supported by a particular SoC (so such constraints
>>>>>>> would still need to be described by the binding somehow):
>>>>>>>
>>>>>>> 	/* QMP clocks */
>>>>>>> 	#define QMP_USB3_PIPE_CLK	0
>>>>>>> 	#define QMP_DP_LINK_CLK		1
>>>>>>> 	#define QMP_DP_VCO_DIV_CLK	2
>>>>
>>>> Maybe QMP_COMBO_USB3_PIPE_CLK, QMP_COMBO_DP_LINK_CLK,
>>>> QMP_COMBO_DP_VCO_DIV_CLK?
>>>
>>> "COMBO" is just the name of the Linux driver and does not belong in the
>>> binding.
>>
>> We do not have any standard (iow, coming from the docs) name, so we can
>> invent it on our own.
> 
> I still think the naming should reflect the hardware and not the Linux
> implementation if this is going into the binding.

Well, I always viewed docs as

> 
> And the USB4_USB3_DP defines are going to be a superset of USB3_DP (as
> far we know know).
> 
>>>> I'll then extend this header with QMP_UFS_RX_SYMBOL_0_CLK
>>>> QMP_UFS_RX_SYMBOL_1_CLK and QMP_UFS_TX_SYMBOL_0_CLK.
>>>
>>> Yeah, I had those in mind when creating the header and using a generic
>>> QMP prefix (even if I didn't end up using the header in v1).
>>>
>>> This could just be mapping of (arbitrary) QMP indexes to clocks and we
>>> use it for USB3, DP, UFS and later also USB4.
>>>
>>> This will however mean that the indexes are not necessarily zero-based
>>> and consecutive for a specific SoC and PHY. But that's perhaps a
>>> non-issue (cf. the PHY_TYPE defines).
>>
>> Ugh. Please, no. We have symbol clocks for UFS PHY, USB+DP clocks for
>> USB+DP PHY, but let's not go for the unified clocks index definition.
> 
> Yeah, this is the kind of issues I wanted to avoid by not using a per
> SoC header for three clocks which will almost always use the same
> indexes.
> 
> Because how can you be sure that your unified per-PHY type defines will
> never have to be amended? Or some index left out?
> 
> The only way then is to have per-SoC defines which is a pain to
> maintain (just consider that driver mapping table when some odd SoC
> shows up).

My vote is definitely against a per-SoC defines.

> 
> Johan

-- 
With best wishes
Dmitry

