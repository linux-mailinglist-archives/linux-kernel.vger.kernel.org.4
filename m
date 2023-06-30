Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221AB7442CC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjF3Tk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3TkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D967F3C3C;
        Fri, 30 Jun 2023 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F24B61773;
        Fri, 30 Jun 2023 19:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F26EC433C8;
        Fri, 30 Jun 2023 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688154023;
        bh=f4ZT04acv8jhClxAzPRU6wHrP1dP/42XxHkIt0O7tIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XNIGm+o2TWYIo4roryHW75aES8fogItxPyjNROzZBPFlDkd762yw/9m0Hm4EBMVR7
         fSe/zysLj/l4mzjXqlRVRJHwrUoxH695NpUpQoyq/GHN8hjfEBRRrcaHqYAbcSIEHz
         vv0IwSncXkOAZ9bxNIXHBg6h1sIlXm/iyPsWv0znYXnelNs0urdASJlh45z/02DO2v
         vISAK1NrXTZ4gxhovLQFfFVh7u2lgFQVf2EnT4U5a1z6nZZkcWDcKKoErwXuv/NkPy
         Dq4EIAlSpvLyZkziv650Inaq6yMlZZoQzlseMRUTy/h1J3WUUZaia5NMWeetT3AkD1
         7nPawZ1nDPdLg==
Message-ID: <7f44798b-e2bf-1620-da37-ca13bfd07a21@kernel.org>
Date:   Fri, 30 Jun 2023 22:40:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Configure usb0 as peripheral on am335x boards
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, nm@ti.com
References: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
 <20230630072047.GK14287@atomide.com>
 <f4fa80fd-1a6a-4718-0287-f5288cd9d912@baylibre.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <f4fa80fd-1a6a-4718-0287-f5288cd9d912@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/06/2023 11:30, Julien Panis wrote:
> Hello Tony,
> 
> On 6/30/23 09:20, Tony Lindgren wrote:
>> Hi,
>>
>> * Julien Panis <jpanis@baylibre.com> [230629 13:10]:
>>> This series configures usb0 dr_mode as 'peripheral' for am335x-evm,
>>> am335x-evmsk, and am335x-icev2. This USB port is mainly used for
>>> RNDIS and DFU.
>> Is this a mini-B connector? Just wondering if it was originally attempted
>> to be configured as OTG or how it ended up with a host configuration..
> 
> It's a micro USB-AB connector.
> I don't know how it ended up with a host configuration, it looks like an oversight.
> Maybe Vignesh or Nishanth can confirm (?)

usb0 role should be "otg".
It is rightly so in Linux DT. am33xx.dtsi contains "otg" and all AM335x board files inherit from it.

So I don't think setting it to "peripheral" in u-boot is the right thing to do.

> 
>>
>>> Initially, a series was submitted to overlay dr_mode in u-boot specific
>>> device trees ('<board>-u-boot.dtsi'):
>>> https://lore.kernel.org/all/20230621-fix_usb_ether_init-v2-0-ff121f0e8d7a@baylibre.com/
>>>
>>> It was finally decided to modify linux device trees.
>> Do we need these as fixes? If so is there a fixes tag for these?
> 
> I don't think so.
> The u-boot series mentioned above was submitted to fix an error returned
> by usb_ether_init() function. This error appeared after changes in u-boot
> (arch/arm/mach-omap2/am33xx/board.c). The u-boot commit is:
> 6815a66ad7430 ("am33xx: musb: Remove unused configuration logic").
> But this commit is right actually, and the error appeared because dr_mode
> was not properly configured for am335x-evmsk and am335x-icev2 dts.
> In other words, this u-boot commit is correct but revealed an oversight
> in dr_mode configuration for these boards.
> So, there is not a fixes tag here. That was just an omission in device trees.
> 
>>
>> Regards,
>>
>> Tony
> 
> Julien
> 

-- 
cheers,
-roger
