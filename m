Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA206D9EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbjDFRc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:32:56 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659447AB9;
        Thu,  6 Apr 2023 10:32:54 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3B07585F13;
        Thu,  6 Apr 2023 19:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680802372;
        bh=5SiwuVsqj9Oz3FPieNOFQyRy6+MjAAIzlniuZBG3/po=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hYga2HS+VEcpfETfJxhwrR51B2XJ/O2mZ9EA1rCqCubQpSo6F2gSKkp1pNNaypmY8
         hGNmxSJSH7cH7I9D2I8HTQsDmCcxjOT6juUZAWdvZwQRq/fli8sWZ+7oX6NXl0Z5h/
         wfE0KhoUGnS0sy2ubRjqRWblyOJoBNMklgs4ntZD/FDtjHj/4xQQOzFqw+5aiifPD1
         i3oSexZy2CPMmE1lszRSenc3sTZ1IMCkZmo1SHxzokpESeiwnHuIPnACgyPqT0zDU4
         iUdVd1XVu1rQ6ZfhsoE0RIQw/YAy9SS/a8cNc2m3+PkdLN2GFcX99Ajd4D4Hqaf+NF
         y43NtRNRNpNiQ==
Message-ID: <75b02961-bcf9-4af5-4450-cb23a50d5f7b@denx.de>
Date:   Thu, 6 Apr 2023 19:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <aa947a69-a0bf-50e6-9ff2-770f436d58e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 18:36, Krzysztof Kozlowski wrote:
> On 05/04/2023 20:24, Christoph Niedermaier wrote:
>> From: Marek Vasut [mailto:marex@denx.de]
>> Sent: Wednesday, April 5, 2023 6:25 PM
>>> On 4/5/23 18:02, Christoph Niedermaier wrote:
>>>
>>> [...]
>>>
>>>> +/ {
>>>> +     model = "DH electronics i.MX6ULL DHCOR on maveo box";
>>>> +     compatible = "dh,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
>>>> +                  "fsl,imx6ull";
>>>> +
>>>> +     aliases {
>>>> +             /delete-property/ mmc0; /* Avoid double definitions */
>>>> +             /delete-property/ mmc1;
>>>> +             mmc2 = &usdhc2; /* eMMC should be mmc2 */
>>>
>>> Why not mmc0 ?
>>>
>>> Use root=PARTUUID= when booting to avoid any dependency on
>>> root=/dev/mmcblk2pN enumeration.
>>
>> This is due to software interchangeability with the DHCOM
>> i.MX6ULL, where the eMMC is always mmc2.
> 
> That's not the reason to have aliases. The number should match numbering
> in your datasheet/schematics/user-guide, not what your software wants.
> 
> Use PARTUUID for SW dependencies.

Regarding the PARTUUID, Christoph raised a valid concern I think. These 
machines can come with A/B update scheme, where the PARTUUID could 
become identical between two partitions. Or, you can write the same 
image to both eMMC and SD card. I don't think PARTUUID is the silver 
bullet solution, but I agree the enumeration is a great solution either.
