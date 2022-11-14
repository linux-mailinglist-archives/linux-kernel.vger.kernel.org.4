Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A56283EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiKNPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiKNPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:31:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D0327B28
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:31:05 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l12so19855113lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+APgoteAuoO9mTtV8vV2XOtx8Kwbf4hasGLOR8qZ8g=;
        b=SmEB42jxy4krB5JX6BEkkRMQiM9SlqtbFGemcikWQQZLBssxu7SPbe5Y1GbzVFYo+7
         1jA9Ltt814b8gr3ULe0d1nr7tpNRWXP9plxF7wymjAzwC/XwG7aMtzkXW0gFcFcz/LZF
         aRGKAjimGtp5l4H7QbGp1fOLyXrybsnkDXNBH8eRoTYu0IEGEhqzNSnM4H4aSg/wR+vO
         0vh/2p6oPVoQkGhPmxKvCcVgFNpqF3rb3ClnttXkS1xl7R/MeEK/UyyUQDiCaqT3DHfa
         jmig5MLNLskqJYTNV2Ey9BA0lLRdKjhyuw7lrGbK6gJ3COQrYiGZBUgbzCwNF73mH74L
         argA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+APgoteAuoO9mTtV8vV2XOtx8Kwbf4hasGLOR8qZ8g=;
        b=2Lyr+2CBSIL4wIF4694twQFhIJcQqvHJxDm8QHVUryYppwY7m2CYIZDu6iBtwe4lMP
         TXkwabk40r97e2qJKPJiuHm/ttjGEYUa/vJBXEidBpWXwlzPpimaUwNKxz6Mr9HP37Md
         AME7A5/wHwE+RW1YdHPVvELCobQEzCfLF8OZNwch/Crf1g8W4HRji82ELMkWoAeLLDOP
         udRgTiHgZEQZKEJ4yeE9+XntbwuQz5Oy+TsJzndwgeif9IkUfeUJF5LOVniME8oiAV1V
         idXQMcW2YgIDW93ihoKfGm+sqWXiZ+hFoZDJ5mHtolDTTZ5lyADSB+AGj4FBBfH/hZN0
         B5hQ==
X-Gm-Message-State: ANoB5pk7o0FIQJ1Uo/Is4btKfYXTed68cF3bekjoS+EKyazSC8u/h7l8
        0DFlWE0zhfkry93eXnbt6a2HW+1fFnVtrQ==
X-Google-Smtp-Source: AA0mqf5sZWN0bwnuk52AgLtN24jImYplJsDYfbprTaBDktg4nm08CK729SR/ymyuDx00Wh2odDmBlA==
X-Received: by 2002:ac2:4f13:0:b0:4a2:25b1:10ff with SMTP id k19-20020ac24f13000000b004a225b110ffmr4912341lfr.274.1668439863459;
        Mon, 14 Nov 2022 07:31:03 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a3-20020a2e8303000000b002770e531535sm2062990ljh.55.2022.11.14.07.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:31:03 -0800 (PST)
Message-ID: <42ae9612-43da-5f3a-534d-d30b9f399f90@linaro.org>
Date:   Mon, 14 Nov 2022 18:31:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <ace91d8b-9a14-5569-7c59-344e9751fa96@linaro.org>
 <Y3JEh7wO394kepXq@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3JEh7wO394kepXq@hovoldconsulting.com>
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

On 14/11/2022 16:37, Johan Hovold wrote:
> On Sat, Nov 12, 2022 at 02:43:03PM +0300, Dmitry Baryshkov wrote:
>> On 11/11/2022 12:24, Johan Hovold wrote:
>>> The current QMP USB3-DP PHY bindings are based on the original MSM8996
>>> binding which provided multiple PHYs per IP block and these in turn were
>>> described by child nodes.
>>>
>>> The QMP USB3-DP PHY block provides a single multi-protocol PHY and even
>>> if some resources are only used by either the USB or DP part of the
>>> device there is no real benefit in describing these resources in child
>>> nodes.
>>>
>>> The original MSM8996 binding also ended up describing the individual
>>> register blocks as belonging to either the wrapper node or the PHY child
>>> nodes.
>>>
>>> This is an unnecessary level of detail which has lead to problems when
>>> later IP blocks using different register layouts have been forced to fit
>>> the original mould rather than updating the binding. The bindings are
>>> arguable also incomplete as they only the describe register blocks used
>>> by the current Linux drivers (e.g. does not include the PCS LANE
>>> registers).
>>>
>>> This is specifically true for later USB4-USB3-DP QMP PHYs where the TX
>>> registers are used by both the USB3 and DP parts of the PHY (and where
>>> the USB4 part of the PHY was not covered by the binding at all). Notably
>>> there are also no DP "RX" (sic) registers as described by the current
>>> bindings and the DP "PCS" region is really a set of DP_PHY registers.
>>>
>>> Add a new binding for the USB4-USB3-DP QMP PHYs found on SC8280XP which
>>> further bindings can be based on.
>>>
>>> Note that the binding uses a PHY type index to access either the USB3 or
>>> DP part of the PHY and that this can later be used also for the USB4
>>> part if needed.
>>>
>>> Similarly, the clock inputs and outputs can later be extended to support
>>> USB4.
>>>
>>> Also note that the current binding is simply removed instead of being
>>> deprecated as it was only recently merged and would not allow for
>>> supporting DP mode.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
> 
>>> +  "#clock-cells":
>>> +    const: 1
>>> +
>>> +  clock-output-names:
>>> +    items:
>>> +      - const: usb3_pipe
>>> +      - const: dp_link
>>> +      - const: dp_vco_div
>>> +
>>> +  "#phy-cells":
>>> +    const: 1
>>> +    description: |
>>> +      PHY index
>>> +        - PHY_TYPE_USB3
>>> +        - PHY_TYPE_DP
>>
>> I'm stepping on Rob's and Krzysztof's ground here, but it might be more
>> logical and future proof to use indices instead of phy types.
> 
> Why would that be more future-proof?
> 
> I initially added defines for these indexes to a QMP header, but noticed
> that we already have PHY drivers that use the PHY types for this. So
> there's already a precedent for this and I didn't see any real benefit
> to adding multiple per-SoC defines for the same thing.

As you guessed from my question, I was thinking about USB4 (for which we 
do not have a separate PHY_TYPE, but that probably shouldn't matter). 
Would it be a separate PHY here, or would it be a combo UBS3+USB4 plus 
separate DP phy?

Yes, we have other PHYs, which use types as an index, however it's 
slightly more common to have indices instead.

Anyway, this is a minor issue. It might be just that I'm more common to 
using indices everywhere (in other words, I have preference here, but 
it's not a strong requirement from my side).


>> Just for my understanding, would USB4 support add another qserdes+tx/rx
>> construct or would it be the same USB3 register space?
> 
> The TX/RX registers are shared by the all three parts of the PHY (USB4,
> USB3, DP), while USB4 has two dedicated sets of PLL (serdes) and PCS
> registers.

Ack, thanks.

-- 
With best wishes
Dmitry

