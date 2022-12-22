Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC988653B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 04:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiLVD5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 22:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLVD52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 22:57:28 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168419C31
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 19:57:27 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NcxN52VGWz1S5DK
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:57:25 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:subject:from
        :content-language:references:to:user-agent:mime-version:date
        :message-id; s=dkim; t=1671681444; x=1672545445; bh=9EgG6+Ok/3tO
        B99n2VhMHRfFlk/p7dYnKVT7K/MuQgA=; b=QL/XmD/k68xrP5p3KxqZrfIPP1Xn
        wyVlOeyUNdjc4xnSx5sWI4AtxB3iWnytdAe2l2l1PzUVEFxZWUAIAriZEXnE07Ca
        sn6jtOfN4b0A0L6E3OpTzm0nTeSBo19G6iL1FEG9HepKLbsYauYRZC/ZldkoS67i
        Aw9Kd/GPTKpwoD+Sl+GYcsIw+0fMb9hbz9ZSvq14GOzUwuQYqEPk6MeuGsolkhTI
        sQaLnRxFCBkjC84CmRQre5l0LD1zMNM0gZs4FfYHcL9UjAp7oWHyq4AJcxk5DFLp
        c7YLQCi3cAIdrjch3L/khZkxtygiJ/UoGqVCZqRYrjlsEDCnHFE9uz3uBQ==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SbtpFfEt_GgH for <linux-kernel@vger.kernel.org>;
        Wed, 21 Dec 2022 22:57:24 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NcxMt2DXhz1S5B4;
        Wed, 21 Dec 2022 22:57:13 -0500 (EST)
Message-ID: <f76f19df-ff82-e24d-511c-ad5b4ff7683b@mint.lgbt>
Date:   Thu, 22 Dec 2022 00:57:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Johan Hovold <johan@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-2-they@mint.lgbt>
 <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
 <6ddf93eb-aadb-a9b8-d91a-0c56ed54418f@mint.lgbt>
 <Y6Kx+iq9c5izbYRH@hovoldconsulting.com>
Content-Language: en-US
From:   Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
In-Reply-To: <Y6Kx+iq9c5izbYRH@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 04:12, Johan Hovold wrote:

> On Wed, Dec 21, 2022 at 12:34:46AM -0300, Lux Aliaga wrote:
>> On 16/12/2022 08:24, Konrad Dybcio wrote:
>>> On 15.12.2022 20:04, Lux Aliaga wrote:
>>>> Adds a UFS host controller node and its corresponding PHY to
>>>> the sm6125 platform.
>>>> +			reg = <0x04807000 0x1c4>;
>>>> +
>>>> +			power-domains = <&gcc UFS_PHY_GDSC>;
>>>> +
>>>> +			clock-names = "ref", "ref_aux";
>>>> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>>>> +
>>>> +			resets = <&ufs_mem_hc 0>;
>>>> +			reset-names = "ufsphy";
>>>> +
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +			ranges;
>>>> +
>>>> +			status = "disabled";
>>>> +
>>>> +			ufs_mem_phy_lanes: lanes@4807400 {
>>>> +				reg = <0x4807400 0x098>,
>>>> +				      <0x4807600 0x130>,
>>>> +				      <0x4807c00 0x16c>;
>>>> +				#phy-cells = <0>;
>>>> +			};
>>> I believe this is deprecated. See [1].
>>> [1] https://lore.kernel.org/linux-arm-msm/20221104092045.17410-1-johan+linaro@kernel.org/T/#m988f3fe3d83b76bac247aea2d9dac34f37728d65
>> I've looked into the documentation and this is only for the sc8280xp.
>> This PHY is defined as it is for the msm8996 and derivatives.
> No, it's not just for sc8280xp. It's intended for all new bindings (i.e.
> do not add more platforms to the msm8996 schema file).
>
> Johan
Alright. But this would mean writing a new config for the sm6125 
specifically. If we're changing how the bindings for UFS PHYs work, 
wouldn't it make more sense to change the sm6115 config instead, since 
they're defined pretty much the same?

-- 
Lux Aliaga
https://nixgoat.me/

