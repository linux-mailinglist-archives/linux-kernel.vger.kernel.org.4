Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457FD6D9D9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjDFQhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjDFQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:36:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA17EC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:36:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so2816716ejx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680799015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GiN+bdc9flg9WBnmPGDLiXSY2JIdJVbrctj9Em7/5aI=;
        b=PDYjE39rDxgqj82gn7sMLrrCgVGKgBcGOWjDiRh1JtpuxeTweyrEs57kA3+qKgsk5F
         H6RUuRjq8g2toCH4e38ehSYTc5USvaiCYWFNFTJN5cyh2OpRgq32RrHS04t5sO6TddNQ
         rgYFnfMXnFPDkTdIgnJ/27SnuwvbIbmnd9ESCjimCCX9md+AHA5cjR+Mf2ba//JEQ0r+
         NK/NMQEmuCw5HcfRNzaliEDuWIJJufm1HfI/I1oc+AN4FZTGFmKO6L53cmSBucpE8oWB
         GovtLXTLIAglvwGZzGlF74nzdKfGIq2bTyhldA/nv9Bqpe1+2ExqlFFegOPHcClW9fxt
         YnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiN+bdc9flg9WBnmPGDLiXSY2JIdJVbrctj9Em7/5aI=;
        b=OJfkkG1cjgqSpUNshpTPIxfzd/jdj5dfDrBp+bC4Rbeq2E50gPffX5mYei9zJBw8og
         qaMDFNIZC5H7nko5vxDm9cRRyqikaEDQTx8Fcu9c4nIyfdWk6sfDS31h4KDWV3m4Eyp7
         r6RnF/VxzGZu4fSqTBZqj9l+U/kLN2Z99cfaNxiv1sDzrVQ4HHmuDVk4jBQnKvbFgi9T
         FMAlNNuxdso5FLo5Q8syN9IZQPZFKuiA3QnN6vvCNe4UqP5et7MGf9u/pc8TjQfJOFeU
         8+xuz0eU7iPm5yKompjXFoffZjERVXBTjJNd9tcdKJeOpGYd6RiNuMrClgSYkvHAHcic
         xC1w==
X-Gm-Message-State: AAQBX9falyjiIaCvtaxCBqBeAEgYPgmM19X4cru4MtRw9xQxOEo/HIKj
        F4Yjcdn7YVlLmcCEOip/bIUfUg==
X-Google-Smtp-Source: AKy350a32KTWiAed4A3ybnDeyPP8SUNar1QVwzvKi8g14wgwAULFc0Y6x+79u4XbjZYOQycCMzpYLQ==
X-Received: by 2002:a17:906:7b50:b0:878:52cd:9006 with SMTP id n16-20020a1709067b5000b0087852cd9006mr7683835ejo.69.1680799014860;
        Thu, 06 Apr 2023 09:36:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id ww7-20020a170907084700b00947a40ded80sm1012286ejb.104.2023.04.06.09.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:36:54 -0700 (PDT)
Message-ID: <aa947a69-a0bf-50e6-9ff2-770f436d58e2@linaro.org>
Date:   Thu, 6 Apr 2023 18:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marek Vasut <marex@denx.de>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e7aa3b3220e148ee96f5a1c361721845@dh-electronics.com>
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

On 05/04/2023 20:24, Christoph Niedermaier wrote:
> From: Marek Vasut [mailto:marex@denx.de]
> Sent: Wednesday, April 5, 2023 6:25 PM
>> On 4/5/23 18:02, Christoph Niedermaier wrote:
>>
>> [...]
>>
>>> +/ {
>>> +     model = "DH electronics i.MX6ULL DHCOR on maveo box";
>>> +     compatible = "dh,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
>>> +                  "fsl,imx6ull";
>>> +
>>> +     aliases {
>>> +             /delete-property/ mmc0; /* Avoid double definitions */
>>> +             /delete-property/ mmc1;
>>> +             mmc2 = &usdhc2; /* eMMC should be mmc2 */
>>
>> Why not mmc0 ?
>>
>> Use root=PARTUUID= when booting to avoid any dependency on
>> root=/dev/mmcblk2pN enumeration.
> 
> This is due to software interchangeability with the DHCOM
> i.MX6ULL, where the eMMC is always mmc2.

That's not the reason to have aliases. The number should match numbering
in your datasheet/schematics/user-guide, not what your software wants.

Use PARTUUID for SW dependencies.

Best regards,
Krzysztof

