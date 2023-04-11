Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBF6DCFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDKCyy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 22:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKCyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:54:49 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930211FE6;
        Mon, 10 Apr 2023 19:54:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id AA21624E292;
        Tue, 11 Apr 2023 10:54:42 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 10:54:42 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 10:54:42 +0800
Message-ID: <c9e5e8cf-cfa9-0081-2851-2db46c2cddf3@starfivetech.com>
Date:   Tue, 11 Apr 2023 10:54:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/4] mmc: starfive: Add sdio/emmc driver support
To:     Shengyu Qu <wiagn233@outlook.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-3-william.qiu@starfivetech.com>
 <TY3P286MB26115A8F90DAD2D7DA4DCBEB988B9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <TY3P286MB26115E6311132C791616D32B98889@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <cfde7320-323f-725e-8ed5-c8473bce1755@starfivetech.com>
 <TY3P286MB26113FF6ABD3CBA616DEC6DC98959@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <TY3P286MB26113FF6ABD3CBA616DEC6DC98959@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 2:04, Shengyu Qu wrote:
> Hello William,
> 
>> On 2023/3/29 0:08, Shengyu Qu wrote:
>>> Hello William,
>>>
>>> Sorry for making noise about this, but seems deleted voltage swtich function
>>>
>>> doesn't help about this. But there's still a problem about eMMC speed. Currently
>>>
>>> only about 20MB/s maximum reading speed could be reached when using eMMC
>>>
>>> on VF2, any idea about this?
>>>
>>> Best regards,
>>>
>>> Shengyu
>>>
>>> 在 2023/3/28 0:01, Shengyu Qu 写道:
>>>> Hello William,
>>>>
>>>> I'm digging into downstream mmc driver these days and found a problem
>>>>
>>>> that current version mainline driver doesn't has a voltage switch function for
>>>>
>>>> it. Downstream older version has one but was deleted in this commit [1].
>>>>
>>>> It was deleted since vf2's SD slot doesn't have 1.8V input but commiter forgot
>>>>
>>>> that vf2's eMMC slot has a proper 1.8V input.
>>>>
>>>> So could you add voltage switch function for mainline? I've met a eMMC speed
>>>>
>>>> problem possibly due to it.
>>>>
>>>> Best regards,
>>>>
>>>> Shengyu
>>>>
>> 
>> Hi Shengyu,
>> 
>> Sorry for the late reply.
>> 
>> First of all, I will consider adding voltage switch function, but the implementation
>> method is to configure the pmic register configuration in dts, and the implementation
>> interface will use the voltage switch function in dw_mmc.c.
>> 
>> As for speed, the main reason for the low rate is the clock of JH7110 and the
>> associated IO driving strength, in this limit, the maximum reading speed I tested was
>> about 50Mb/s.
>> 
>> I will try to reproduce your problem and try to solve it. Thanks for suggestions.
>> 
>> Best regards,
>> William
> I found out the reason and fixed that. dmwci driver needs vqmmc supply
> configured in device tree and a successful voltage change to actually
> enable 1.8v mode, even 1.8 supply actually already physically exists.
> So to solve this problem, I wrote AXP15060 driver and device tree
> bindings basing on -upstream branch and gets over 75MB/s read speed. The
> driver series is already under review here:
> 
> https://lore.kernel.org/all/TY3P286MB26117891DFB2DD615A7C54EF98969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/
> 
> Best regards,
> Shengyu

Hi Shengyu,

Thanks for the patch series. I will try it on my branch.

Best regards,
William
