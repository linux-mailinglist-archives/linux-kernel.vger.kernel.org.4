Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B9873E354
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFZPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFZPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:30:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB3191
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:30:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313f18f5295so1375647f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687793410; x=1690385410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQSMKa1lqIeXBAWXkGHFFZVwVC13OaPv1XUC7vDJ6CI=;
        b=bMiI3fFIy/oqErys2CQAu7hnmar4xwo3C92bbg9o/f7Ue1lAAneFRRWea7AFfsFv3d
         n75FESTifIp+ymYqG/NhTiRxbvkhJBI4mPDjfnMq+1JfPn2/SrYH9UXOfz/4cddyeaWA
         ZKD3lfitdbY5DPdhf2vESVNS4hYFfF/mD3GqiwH8TXDwoA53J5gBF7r9sYMVWRNmo8ta
         OGKlu1zPnxKDVkfaBLHa5/SQsRMPOND3YqIe8yyATypmvSKBGgUmkGdr1MYhj4fq5Qgw
         fIrs3ePqxSoy2jbZ48DvuJwCKU1KgqvU9CA8VxAqRFy6b1oBERdWRNYQGm0zxuTP2PRv
         Mx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793410; x=1690385410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQSMKa1lqIeXBAWXkGHFFZVwVC13OaPv1XUC7vDJ6CI=;
        b=d8fH5U/7GrvYm0cnp4Hr4AyEIqaG22c1q/TQV7Sg4q9fLWshn72UNIXjyTQjs5iVN4
         kIXqFIcAeV1Mbrov7tkskanWNAstoF4Nsfuc/LXtREGsN1NHBeXP+yp9BWLd3TT4rGlC
         EaiRWSMhgaCB0zdJK+KZzWC/7/y6G8aU/V3EGVas1Ukv74FZif6qCA5bU6AG79W0CzRz
         Gq/Ta3NAxybQNUNoQfj2+D/h8Hb4afc24V5I/C3QquE61T8GWsQFhQzj7mG3rMYoiGwK
         4hFb0cQTbwZuF8oVbQwXpSnQXqn60II2EHu6Z8sPKh0nOVIdSbpgytq3Vpb0s7VA8zPV
         +TrQ==
X-Gm-Message-State: AC+VfDx2wZphncWsVx5FY5oBa7KOWvTiVQJXeUfL20vxGAcwU4mHuwA2
        S+MBCguuM15Y1zXSK+rxIVHIFQ==
X-Google-Smtp-Source: ACHHUZ4TAv/xBlOCnaHre8LFq3CjLmWT47Zbg3P0zn2fX5oHlNK+Fb+4CY7bXvgsCy51VP/LF88gpw==
X-Received: by 2002:a05:6000:1008:b0:30f:c1f5:e91e with SMTP id a8-20020a056000100800b0030fc1f5e91emr25146865wrx.27.1687793410264;
        Mon, 26 Jun 2023 08:30:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b00313f1c5b56dsm3001356wrd.79.2023.06.26.08.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:30:09 -0700 (PDT)
Message-ID: <9bf3f3d0-9655-3549-1d1b-02816f51b666@linaro.org>
Date:   Mon, 26 Jun 2023 17:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-4-nfraprado@collabora.com>
 <8b5e4a9b-7496-02a1-d3b6-a0be8ea85798@linaro.org>
 <a82b7f2d-04d4-4ac0-9a72-ad1c17118e19@notapiano>
 <cb2dd67a-d3df-f194-6595-789d12b38f3d@linaro.org>
 <6b41c5e4-bae9-4c99-8a28-7272c8a598a3@notapiano>
 <9c36cdbb-7204-f9ca-6191-88e0f0f71915@linaro.org>
 <132ec056-2186-4be5-9770-4d8c4d07bd76@notapiano>
 <6af2faf2-8624-948b-6efa-3bf00695293b@linaro.org>
 <aef120c8-bb25-476f-8976-7f699a851334@notapiano>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aef120c8-bb25-476f-8976-7f699a851334@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 15:54, Nícolas F. R. A. Prado wrote:
> On Fri, Jun 23, 2023 at 06:21:31PM +0200, Krzysztof Kozlowski wrote:
>> On 21/06/2023 20:00, Nícolas F. R. A. Prado wrote:
>>>>
>>>> But anyway this variant comes with some set of regs and reg-names. Other
>>>> variant comes with different set. In all cases they should be defined,
>>>> even by "defined" means not allowed.
>>>
>>> I'm not sure what you mean. Are you suggesting to disable reg-names on mt8173?
>>
>> That's one of the options if for some reason you don't want to define them.
>>
>>>
>>>>
>>>>>
>>>>> But in a separate series we could drop vdecsys from mt8173's reg as well,
>>>>> passing it as a syscon instead, which would solve the warning on that platform,
>>>>> though some more driver changes would be needed to be able to handle it for that
>>>>> SoC. The newer SoCs like mt8192, mt8195, etc, should also get vdecsys dropped
>>>>> from their regs to have a correct memory description.
>>>>>
>>>>
>>>> Sure, but I don't understand how does it affect defining and making
>>>> specific regs/reg-names or keeping them loose.
>>>
>>> We need some way to tell in the driver whether the first reg is VDEC_SYS or not.
>>> Since so far reg-names have not been used for the vcodec, the simplest, and
>>> cleanest, way to do it, is to add reg-names when VDEC_SYS is not present. When
>>> the other SoCs are updated to no longer have the first reg as VDEC_SYS, they
>>> would also have reg-names added to their binding, to clearly indicate that.
>>
>> Don't use reg-names for that. The order of entries is anyway strict.
> 
> Since the order of entries is strict, if I remove VDEC_SYS from mt8183, I also
> need to remove it from mt8173, is that what you mean?

It's different compatible, so it can have different entries.


> I would still check for
> the presence of reg-names in the driver to differentiate whether the old or new
> binding is used, you just don't want different reg-names between compatibles in
> the binding?

I wrote already what I want:

  In all cases they should be defined, even by "defined" means not allowed.

Now of course the best would be if the reg-names are always the same, at
least in respect of order of items. This is what we try to do for all
devices.

> 
>>
>>>
>>> For example, for mt8173 we currently have
>>>
>>> 		vcodec_dec: vcodec@16000000 {
>>> 			compatible = "mediatek,mt8173-vcodec-dec";
>>> 			reg = <0 0x16000000 0 0x100>,	/* VDEC_SYS */
>>> 			      <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
>>> 			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
>>> 			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
>>> 			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
>>> 			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
>>> 			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
>>> 			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
>>> 			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
>>> 			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
>>> 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
>>> 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
>>>
>>> In a future series, when removing VDEC_SYS from it, it would become
>>>
>>> 		vcodec_dec: vcodec@16020000 {
>>> 			compatible = "mediatek,mt8173-vcodec-dec";
>>> 			reg = <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
>>> 			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
>>> 			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
>>> 			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
>>> 			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
>>> 			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
>>> 			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
>>> 			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
>>> 			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
>>> 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
>>> 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
>>> 			reg-names = "misc", "ld", "top", "cm", "ad", "av", "pp",
>>>                                     "hwd", "hwq", "hwb", "hwg";
>>
>> So you want to use reg-names to avoid ABI break. This is not the reason
>> not to define reg-names for other case.
> 
> There will be an ABI break anyway when the first reg is removed (as shown
> above), I'm just trying to avoid churn: adding a reg-name that will be removed
> later.

So remove the reg-name now and there will be no "later"?

Best regards,
Krzysztof

