Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F3641311
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiLCBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiLCBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:52:50 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861F01C424;
        Fri,  2 Dec 2022 17:52:47 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C186D5C00C2;
        Fri,  2 Dec 2022 20:52:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Dec 2022 20:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670032364; x=
        1670118764; bh=qCFdQNJyL5Qi9scJku+NmJywt0J5lgF/iOTG+QsY94g=; b=i
        vYLCqdVtr8DPyj6NdN0/Y84CnCuPO8LxmvuHIGUHazadhfwpV5MKxl4GH2rTfKgi
        LknmZ67+mCkDVa7CH8O04Fdrb4EaWkEXY2XJmvsS37kXD7iFoT45tG11sJrprgXr
        LcXF4qC2gJjb95B+bmAXBC4JT49jAO13fW7hpjo5MGOYLRXxqhVtu75vhTRDnSBX
        CI4NhaKPqHVqeQUkEgIatk2BRkFdoHM1DWP1CuAgSwP2E/eXPwOJMBNbYkqrLFdq
        1N+haPpxilqj9awxUdm9SnAIUtfteJmd3G7RXHLJ8Tv1WTIaJZzugyDt98GP19H6
        I0kJc4s+eQN2CA8NK4eTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670032364; x=
        1670118764; bh=qCFdQNJyL5Qi9scJku+NmJywt0J5lgF/iOTG+QsY94g=; b=D
        lHkpOYDxiC1wCVtKKi5YMDF0b/EKrJaTwUrkn31v9epUy9z+1NgGGW5puIUWMbYB
        U/0c+pKz96WzOrSY+Kdlr59Tv26wX/lATGlNchwBh1OXhSwFfy77nROahKyyJNJQ
        of44jMCkd1GvSR7NlIGEbQYvyxxKPHUQmfSqboP1FtDS7sczAfjP8U0VHv+zmj1Y
        mq+V/ErnUyU6wzT+WYn1riw2glmsaF8eTjpKC/pY/yYFnDqdWO+ZCvpzMhXdLc/z
        Ot/qBabML4dLtn6SmTfhNY76Mf9nFyefGoSrnsPiO9O4Hb50EqriHm47+V+1lFvp
        VwQ5Mm0TIfKogx4QLSAoQ==
X-ME-Sender: <xms:66uKY7GB6fI_mJm_rPpWdeai4QQGlKnRly1BF7oZC9WIaWaOI351qg>
    <xme:66uKY4VaE40ZtgUr-H3uiedM9K9VRw_-1MK1Cy7Tbw_GmSWxg8GJqTULw8bRydIZ3
    8rTUgaj33Cn23TYQg>
X-ME-Received: <xmr:66uKY9JgjTRZ2AwsxPguwwP4Bm9sjDLNmNHP1ROSBmJjBNhL5JbLL726_vxbNT2rhPRmkpaMrHadw_xoa6p3TTlpctJ8PP0A9o3StaMkLa6PmaEJeEn8hfu1Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdelgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:66uKY5FRqgfZgwKo988t8REdQu7HUxb7_-iAq2qbgv1NyF3Wk9Agxw>
    <xmx:66uKYxXFvHTMkFletaQrcdKSLTQQtP3rI4gKBGaY3NmFrCnhsnbaEA>
    <xmx:66uKY0Nks7PoT7NA7Toc3fZLf4SoRWOV7-49zHnFytxDGrn7Ttrd8w>
    <xmx:7KuKY8MNR9QDNkxdTyVkSMbTZ7yuLzIPsRebrvU_OkQeDgSZjj9OJA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 20:52:42 -0500 (EST)
Message-ID: <b7774c58-ccf8-4204-2e7e-6841fd13002d@sholland.org>
Date:   Fri, 2 Dec 2022 19:52:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20221126191319.6404-1-samuel@sholland.org>
 <20221126191319.6404-2-samuel@sholland.org>
 <20221203001439.64284671@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/5] clk: sunxi-ng: Remove duplicate ARCH_SUNXI
 dependencies
In-Reply-To: <20221203001439.64284671@slackpad.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 18:14, Andre Przywara wrote:
> On Sat, 26 Nov 2022 13:13:15 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi,
> 
> thanks for addressing this!
> 
>> SUNXI_CCU already depends on ARCH_SUNXI, so adding the dependency to
>> individual SoC drivers is redundant.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/clk/sunxi-ng/Kconfig | 43 ++++++++++++++++++------------------
>>  1 file changed, 21 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
>> index 461537679c04..64cfa022e320 100644
>> --- a/drivers/clk/sunxi-ng/Kconfig
>> +++ b/drivers/clk/sunxi-ng/Kconfig
>> @@ -14,43 +14,43 @@ config SUNIV_F1C100S_CCU
>>  
>>  config SUN20I_D1_CCU
>>  	tristate "Support for the Allwinner D1 CCU"
>> -	default RISCV && ARCH_SUNXI
>> -	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
>> +	default RISCV
>> +	depends on RISCV || COMPILE_TEST
> 
> I agree on the "depends" part: Indeed the guard symbol already covers
> that, so it's redundant.
> However I am not so sure about the "default" part: When ARCH_SUNXI is
> deselected, but COMPILE_TEST in enabled, we default to every CCU driver
> being built-in. I am not sure this is the intention, or at least
> expected when doing compile testing?

SUNXI_CCU, which these depend on, is still "default ARCH_SUNXI", so if
you have ARCH_SUNXI disabled, you only get any drivers if you manually
enable SUNXI_CCU. I mentioned this in the patch 2 description, but maybe
I should move that comment here.

>>  
>>  config SUN20I_D1_R_CCU
>>  	tristate "Support for the Allwinner D1 PRCM CCU"
>> -	default RISCV && ARCH_SUNXI
>> -	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
>> +	default RISCV
>> +	depends on RISCV || COMPILE_TEST
>>  
>>  config SUN50I_A64_CCU
>>  	tristate "Support for the Allwinner A64 CCU"
>> -	default ARM64 && ARCH_SUNXI
>> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>> +	default ARM64
>> +	depends on ARM64 || COMPILE_TEST
> 
> I wonder if this "depends" line was always wrong and should be fixed:
> We can compile a 32-bit ARM kernel and run it on an A64. Granted this
> requires a special bootloader or a hacked U-Boot (tried that), and
> reveals some other issues with the decompressor, but technically there
> is no 64-bit dependency in here.
> The same goes for all the other ARM64 CCUs: Cortex-A53s can run AArch32
> in all exception levels.

I was trying to simplify things by hiding irrelevant options, and you
bring up an edge case of an edge case. :) I am okay with relaxing the
dependency, though I would want to leave them disabled by default for
32-bit kernels (excluding them from the change in patch 2).

> So shall we just completely remove the "depends" line for those, and
> let SUNXI_CCU do that job? Or use use !RISCV || COMPILE_TEST?

That, or we could add MACH_SUN8I to the condition. I don't have a strong
opinion.

Regards,
Samuel

