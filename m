Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62973BC72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjFWQVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFWQVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:21:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C41FCB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:21:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so8360975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687537295; x=1690129295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s66CMFI3pxYY1rtYgcyJdXI802GvMkDoIKZwY+RkMlI=;
        b=cI2KnYSqgIOoakdI/3f3XO2RXeuD/j4SZ+Ef8O749EjrPtDd/n0MH7RNPJcHxw053c
         4JdpeIlNC7TpplMXPqOmMqBD3+PMKQQrQq+AOXCR0ZTi8Kbwt+s7w9WNH3jhjopgWmYV
         zu3hG0fGwJSLWfCsFEJMoOnURlCxD9vd/C/XXhD9Q4M9G3OqhE0DaaRIev6wXTgOmJEv
         7Als6e875b5lKxYnsW8VGgc6aKrzW+uqioLMDoFU0YFpuAcyKGB4qaFY7/vsg9BnV7jW
         A7qgkj/eMpFVsYgkXaIPyhH5yvCSC7oRFh/FXYZ42gSz+q1caVNTsXqeekNQnKSO25Ok
         a0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537295; x=1690129295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s66CMFI3pxYY1rtYgcyJdXI802GvMkDoIKZwY+RkMlI=;
        b=WXjmmYF8MoXZKcMuELfwqfQb4ugckVIhJXLZDPMX3m4GWYAGkdYx3O9kt5Gu1LmxpF
         4EbiokixmXIUZsj3rizIa+wFE69HEVpgbrmrVbIScIlFuMutafcQD0nbQXzKuCbt9OLk
         2AaPmfFBovKd/OvpQ9k9G8RUyqA2z3U+PJ+3MAhmhYqlB3kSC9sbeqUgeshWE6S6yhxc
         BDEGGPqxn3KdMXrUTme85v9eg92YzBYVSpFSoVqgsRc5PZottO+HwodBmJzyDjBd9kss
         12MDjQypplOeKQxlGe0KKQ7HhX6cQ74tSlnqe6nccUbvbemjTcFY6IZDEhu28ucQVMgH
         HrXg==
X-Gm-Message-State: AC+VfDwNxqj9HwL8fW32V1k9dzTE+FOmBoLEfKnGXSYopejqaH7NGgEH
        ePVC1D2lFE0i8iCDPsAkE9664g==
X-Google-Smtp-Source: ACHHUZ5vUrAy2DIbSp5wbwuXEk164vw3cptb3GXQkvceDrMBht3gEh9SIMUtT4+I0MV7m7y+bP5L7A==
X-Received: by 2002:a1c:7705:0:b0:3f9:6f7:9d7d with SMTP id t5-20020a1c7705000000b003f906f79d7dmr17403667wmi.0.1687537295609;
        Fri, 23 Jun 2023 09:21:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003f50d6ee334sm2726014wmj.47.2023.06.23.09.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:21:35 -0700 (PDT)
Message-ID: <6af2faf2-8624-948b-6efa-3bf00695293b@linaro.org>
Date:   Fri, 23 Jun 2023 18:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <132ec056-2186-4be5-9770-4d8c4d07bd76@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 20:00, Nícolas F. R. A. Prado wrote:
>>
>> But anyway this variant comes with some set of regs and reg-names. Other
>> variant comes with different set. In all cases they should be defined,
>> even by "defined" means not allowed.
> 
> I'm not sure what you mean. Are you suggesting to disable reg-names on mt8173?

That's one of the options if for some reason you don't want to define them.

> 
>>
>>>
>>> But in a separate series we could drop vdecsys from mt8173's reg as well,
>>> passing it as a syscon instead, which would solve the warning on that platform,
>>> though some more driver changes would be needed to be able to handle it for that
>>> SoC. The newer SoCs like mt8192, mt8195, etc, should also get vdecsys dropped
>>> from their regs to have a correct memory description.
>>>
>>
>> Sure, but I don't understand how does it affect defining and making
>> specific regs/reg-names or keeping them loose.
> 
> We need some way to tell in the driver whether the first reg is VDEC_SYS or not.
> Since so far reg-names have not been used for the vcodec, the simplest, and
> cleanest, way to do it, is to add reg-names when VDEC_SYS is not present. When
> the other SoCs are updated to no longer have the first reg as VDEC_SYS, they
> would also have reg-names added to their binding, to clearly indicate that.

Don't use reg-names for that. The order of entries is anyway strict.

> 
> For example, for mt8173 we currently have
> 
> 		vcodec_dec: vcodec@16000000 {
> 			compatible = "mediatek,mt8173-vcodec-dec";
> 			reg = <0 0x16000000 0 0x100>,	/* VDEC_SYS */
> 			      <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
> 			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
> 			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
> 			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
> 			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
> 			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
> 			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
> 			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
> 			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
> 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
> 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
> 
> In a future series, when removing VDEC_SYS from it, it would become
> 
> 		vcodec_dec: vcodec@16020000 {
> 			compatible = "mediatek,mt8173-vcodec-dec";
> 			reg = <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
> 			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
> 			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
> 			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
> 			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
> 			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
> 			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
> 			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
> 			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
> 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
> 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
> 			reg-names = "misc", "ld", "top", "cm", "ad", "av", "pp",
>                                     "hwd", "hwq", "hwb", "hwg";

So you want to use reg-names to avoid ABI break. This is not the reason
not to define reg-names for other case.



Best regards,
Krzysztof

