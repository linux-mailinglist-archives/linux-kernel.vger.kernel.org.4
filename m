Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA06D9F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbjDFSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbjDFSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:03:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9526BA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:03:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sg7so3395912ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680804218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivjKih8jFIj8/KL96EOvzPUwa2sZHHiEqT0P1qAVkao=;
        b=AU2ZJcssSzxK5DbJhNIPGcdHDbSz/oeMYaCRqbXnpf7PztQyv0k0ltX3gi60NNbpVd
         xV13dWQxrO4JrXMc5guRdLtj6zG1BLpW9gtqgQDnb6yQqse1lPAoNFi/f3n/Vhox5n+u
         EthavbVxj8dhvQ9RQOLkupbjiBiCjBkVI4o3dLf91rBhnevcx+Jzue9Tdbk4Msz9/q3o
         DfbG76a7ggmGRxG/Fgn/xYyGP+l8QCLmILUok/+RFG5hZaE7zB5nykslwdBXIDioNzAz
         OWR+zvIwPEuR1iKcwbv5Qir2sERV7I3TfsLK7+jzBhwde7E9c1MCSECp4OYBhIqgnEHy
         SovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivjKih8jFIj8/KL96EOvzPUwa2sZHHiEqT0P1qAVkao=;
        b=AimXbc+WcVMlot1d0+cc6BQh27Lv9W65RTbD0mw5DvPqVwgcRcwZq2G+Qrw/L6vi3P
         4TIcJ14P5sEQ1xFb0sU2cjaKHS9FxlHjBafmchSF7jfxjJyhSs+DC3sBXVuTQjwMehbq
         hUE1gCVUv9BUXHxUo2rKz3enktJNWoY7Huc7G2gRjbWqcYDvUQyJ681QqsNn0uGvtlj7
         qLanGoa09E4VOrS4fkNoBu3ORAMh1heiBmlU20WbpLnJmI7+LcqWtHrlDhaqzhuDQZ2H
         1lVkNNHkdqbNLpEzGCcZYw2RZTlBKRqaB1O1zDXI4O6Q6RbJs4ceyYAGUY8a/5tcFtfM
         LyJw==
X-Gm-Message-State: AAQBX9ct8IvuVajSfeRwygyKlzs8ulKOInnk1LLh4Rw2/p2V1OcHMN6D
        Gl1x2/HGLzFNjl7FJR1FW/757hqdrDYhWnvpfCs=
X-Google-Smtp-Source: AKy350ZfQNTkhRRqeuIMbmp0+NPAWZSvSxhmvagYoW2u4iVxlsfCba97WdCNnvjiNqgVTAJYdVOTEw==
X-Received: by 2002:a17:906:74d9:b0:92f:924b:e8f4 with SMTP id z25-20020a17090674d900b0092f924be8f4mr8247971ejl.4.1680804218607;
        Thu, 06 Apr 2023 11:03:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id ta14-20020a1709078c0e00b00949c02dcf10sm1101798ejc.6.2023.04.06.11.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:03:38 -0700 (PDT)
Message-ID: <46301ba1-16d0-8d7e-712b-c52aef52c576@linaro.org>
Date:   Thu, 6 Apr 2023 20:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
 <20230405160258.46998-2-cniedermaier@dh-electronics.com>
 <05fa147c-116b-59b4-d14b-760bbefd7602@denx.de>
 <e7aa3b3220e148ee96f5a1c361721845@dh-electronics.com>
 <aa947a69-a0bf-50e6-9ff2-770f436d58e2@linaro.org>
 <75b02961-bcf9-4af5-4450-cb23a50d5f7b@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <75b02961-bcf9-4af5-4450-cb23a50d5f7b@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 19:32, Marek Vasut wrote:
> On 4/6/23 18:36, Krzysztof Kozlowski wrote:
>> On 05/04/2023 20:24, Christoph Niedermaier wrote:
>>> From: Marek Vasut [mailto:marex@denx.de]
>>> Sent: Wednesday, April 5, 2023 6:25 PM
>>>> On 4/5/23 18:02, Christoph Niedermaier wrote:
>>>>
>>>> [...]
>>>>
>>>>> +/ {
>>>>> +     model = "DH electronics i.MX6ULL DHCOR on maveo box";
>>>>> +     compatible = "dh,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
>>>>> +                  "fsl,imx6ull";
>>>>> +
>>>>> +     aliases {
>>>>> +             /delete-property/ mmc0; /* Avoid double definitions */
>>>>> +             /delete-property/ mmc1;
>>>>> +             mmc2 = &usdhc2; /* eMMC should be mmc2 */
>>>>
>>>> Why not mmc0 ?
>>>>
>>>> Use root=PARTUUID= when booting to avoid any dependency on
>>>> root=/dev/mmcblk2pN enumeration.
>>>
>>> This is due to software interchangeability with the DHCOM
>>> i.MX6ULL, where the eMMC is always mmc2.
>>
>> That's not the reason to have aliases. The number should match numbering
>> in your datasheet/schematics/user-guide, not what your software wants.
>>
>> Use PARTUUID for SW dependencies.
> 
> Regarding the PARTUUID, Christoph raised a valid concern I think. These 
> machines can come with A/B update scheme, where the PARTUUID could 
> become identical between two partitions. Or, you can write the same 
> image to both eMMC and SD card. I don't think PARTUUID is the silver 
> bullet solution, but I agree the enumeration is a great solution either.

If you remove other aliases it means it comes only with emmc, right? One
storage. Then any A/B means you have two partitions. Two partitions will
have different PARTUUID as partition number is there. You can also use
PARTLABEL=root_a (root_b). That's BTW easy way to switch between A/B
partitions.

Best regards,
Krzysztof

