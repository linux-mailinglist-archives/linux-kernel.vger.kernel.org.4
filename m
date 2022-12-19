Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850B7650E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiLSPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiLSPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:17:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644463E6;
        Mon, 19 Dec 2022 07:17:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso6709540wmb.0;
        Mon, 19 Dec 2022 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE2wnLe1zQwpUgdkaV82HIeqF7pshRKC4WnQ2bpJY/k=;
        b=CF+6cPb7SiTANsjqBYJPCXXmWE/kQImVInxzbTAqvBeyI6Xg3uMHdrbFE38oCVdRyu
         2ZTEDDFuoh8KU67Z7wodP+Z7Yub7qASqMFpnwNsLjkKvm4ROBO3TAw1mtFXT/Grp1VKQ
         WfBJva0ShpnhqTG/NAgDdiPGBy54qt5RQDrqnVuTMR6FMP/TzTPjLdOvomyy3gJaDf8T
         pj96Sgz33JCX1R9Kd/XzGyZPimUsIBMF6UpIgeSiat0N9/ZpF8fGhnjXVdDRUh1EFU7p
         LhyL4welxMQW4AGgJa2XxU/ZRZ7A4T+w6aDearyl8CUYyMokqw5S55U3ZK2KAf/Kw2uS
         80Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SE2wnLe1zQwpUgdkaV82HIeqF7pshRKC4WnQ2bpJY/k=;
        b=RVAyV4Fle86FUIRD0VpjTkG5Ld76bXxG9D/pw+T65t0lEwyjbYmmzMexfTYxZ6eYR4
         C13ec2nfSaEXTD3owQDgghO2pIj+Du4rEtek3sPxZX0yqH/joj7wVDNLZPUm3TwudBpt
         QLOe7cboswrQo1aQcHWY0cNqSNq4GsbAaO92wBAHDwZHniWUtDSZG4R0FVTmM8Dpf3FS
         7E7l3i9RIFcE9NKc9n5u7XUAhpfaFQJIo4n0qnYvbs3ru+g7WAWaifa2lL2ScyrKWgPA
         h2TmvALNdxSJZC0eTp6rjs6Ys2QgmXkzIhLZ6mMH3odT9NJSFxQFEDVgQGmj8sabWEs7
         bw/w==
X-Gm-Message-State: AFqh2kpsw+ku7Bdsgc6M8AVgbabYrNI7hFjFeki2DcQ+48cX9dpvjhQp
        7JX7eXZSM8KKL1PSIudhGJe5y/DfVjA=
X-Google-Smtp-Source: AMrXdXuH6Zq5ZzI7Dwg/UowK+RUEcQgPwybSI7MWtJprY0o3lhEbsd07Wa6X+KcEVK3Iic5PLouPyg==
X-Received: by 2002:a7b:c856:0:b0:3d3:4406:8a2e with SMTP id c22-20020a7bc856000000b003d344068a2emr8931252wml.15.1671463031555;
        Mon, 19 Dec 2022 07:17:11 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003b47e75b401sm23545595wmb.37.2022.12.19.07.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:17:11 -0800 (PST)
Message-ID: <ba8ce731-2d9c-901f-e208-deafe589b723@gmail.com>
Date:   Mon, 19 Dec 2022 16:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     Rob Herring <robh+dt@kernel.org>, Moudy Ho <moudy.ho@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221207094921.15450-1-moudy.ho@mediatek.com>
 <20221207094921.15450-2-moudy.ho@mediatek.com>
 <CAL_JsqKdaVmGKSwR0yiYGKc6Kp6jki632GA6CBOOjGzUmvSRWA@mail.gmail.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: arm: mediatek: mmsys: Add support for
 MT8195 VPPSYS
In-Reply-To: <CAL_JsqKdaVmGKSwR0yiYGKc6Kp6jki632GA6CBOOjGzUmvSRWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2022 14:44, Rob Herring wrote:
> On Wed, Dec 7, 2022 at 3:49 AM Moudy Ho <moudy.ho@mediatek.com> wrote:
>>
>> For MT8195, VPPSYS0 and VPPSYS1 are 2 display pipes with
>> hardware differences in power domains, clocks and subsystem counts,
>> which should be determined by compatible names.
>>
>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml     | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> This landed in today's linux-next causing the following binding
> warnings. Is this a fix? Only fixes for 6.2 should be added during the
> merge window.
> 

No it's not a fix, it's queued for the next -rc phase. I didn't know of the 
limitation of linux-next only allowing fixes in the merge window.

Actually the patch is wrong. It shouldn't include "mediatek,mt8195-mmsys" as 
fallback for mediatek,mt8195-vppsys[0,1].

I'll revert the whole series from v6.2-tmp/dts64 and v6.2-tmp/soc

Regards,
Matthias

> /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.example.dtb:
> clock-controller@14000000: $nodename:0: 'clock-controller@14000000'
> does not match '^syscon@[0-9a-f]+$'
>          From schema:
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.example.dtb:
> clock-controller@14000000: compatible: 'oneOf' conditional failed, one
> must be fixed:
>          ['mediatek,mt8195-vppsys0'] is too short
>          'mediatek,mt8195-vppsys0' is not one of
> ['mediatek,mt2701-mmsys', 'mediatek,mt2712-mmsys',
> 'mediatek,mt6765-mmsys', 'mediatek,mt6779-mmsys',
> 'mediatek,mt6795-mmsys', 'mediatek,mt6797-mmsys',
> 'mediatek,mt8167-mmsys', 'mediatek,mt8173-mmsys',
> 'mediatek,mt8183-mmsys', 'mediatek,mt8186-mmsys',
> 'mediatek,mt8188-vdosys0', 'mediatek,mt8192-mmsys',
> 'mediatek,mt8365-mmsys']
>          'mediatek,mt8195-mmsys' was expected
>          'mediatek,mt7623-mmsys' was expected
>          From schema:
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
