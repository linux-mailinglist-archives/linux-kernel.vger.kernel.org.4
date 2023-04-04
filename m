Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4376D66D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjDDPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDDPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2979359F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58210635B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E708EC433EF;
        Tue,  4 Apr 2023 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680620952;
        bh=fI+/oAxzjbKxByy+sfvWFSwYPZoHBDXtOh/1aSssELo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XEXfIBfZwu6ZeHRkHAdTDu/Xi4uwUJKYxfkIMmoez0A0ti+yyt+oCU+KuxUU+9dSr
         6XbijiZKP1Cp3iBS8cGNE9a5RqlJTyHq2D528QWv0zlwee4qI2WSXJ6IqQ/vCO8fmA
         gLbEABZsVLdqbpyBl4Qb1+B/y80P62cppSbtDLlL9kw2IOEuvT8/4hGy17WMNInbju
         576Zqf8qEtDg+vRxkaTJCgLgVD2omoMfzwLkgMau5j3PSh+DuUg6TBXg04kQZpZuxX
         +Iq/AmfAB8Np9QkK7KqFvF2NZ7yAwcEd/9GKDJHSeXyUbr1G1Fn7wN1UwBFLOLsR5f
         HYlNInQ/rYttw==
Message-ID: <2e1d31df-3a5e-eac2-df88-08587aa3c7b9@kernel.org>
Date:   Tue, 4 Apr 2023 18:09:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module
 instead of built-in
To:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230404084259.13752-1-rogerq@kernel.org>
 <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
 <0ffa9690-9709-669c-b44d-dbb93446ec95@linaro.org>
 <076b5775-18eb-05b3-b803-c54420b3e5fe@kernel.org>
 <08b12571-5ca6-4e3d-8c56-5fc48827d17a@app.fastmail.com>
 <87cc8d92-0345-bc4b-60e8-1ca016691371@kernel.org>
 <5a85b6db-f4c9-4cff-ab25-73fed75d6983@app.fastmail.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <5a85b6db-f4c9-4cff-ab25-73fed75d6983@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2023 16:08, Arnd Bergmann wrote:
> On Tue, Apr 4, 2023, at 14:59, Roger Quadros wrote:
>> On 04/04/2023 15:14, Arnd Bergmann wrote:
>>> On Tue, Apr 4, 2023, at 13:46, Roger Quadros wrote:
>>> That seems really high, so I had a look at what's going on.
>>
>> It was based on the configuration we are using at TI.
>>
>> (as built-in)
>>
>> $ size vmlinux
>>    text	   data	    bss	    dec	    hex	filename
>> 14616949	5285870	 491776	20394595	1373263	vmlinux
>> $ ls -l vmlinux
>> -rwxrwxr-x 1 roger roger 120866544 Apr  4 15:54 vmlinux
>>
>> (as module)
>>
>> $ size vmlinux
>>    text	   data	    bss	    dec	    hex	filename
>> 14550571	5258106	 491776	20300453	135c2a5	vmlinux
>> $ ls -l vmlinux
>> -rwxrwxr-x 1 roger roger 120324528 Apr  4 15:52 vmlinux
>>
>>
>> $ diff built-in-config module-config
>> 5547c5547
>> < CONFIG_USB_XHCI_PLATFORM=y
>> ---
>>> CONFIG_USB_XHCI_PLATFORM=m
>> 5614c5614
>> < CONFIG_USB_DWC3=y
>> ---
>>> CONFIG_USB_DWC3=m
> 
> Ok, so the size difference here is only 94KB, presumably
> because have the non-TI variants as well as debugfs and/or
> gadget mode disabled. For the file size, my guess is that
> you have CONFIG_DEBUG_INFO enabled in your config, which

That's right.

> drastically increases the size of the vmlinux file, but
> not the in-memory size, or the size of the stripped and
> compressed zImage.

Image file diff is ~128K.
Image.gz diff is ~33K.

--
cheers,
-roger
