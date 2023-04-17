Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F06E518B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDQUTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDQUTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:19:50 -0400
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585BE64;
        Mon, 17 Apr 2023 13:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681762774; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Nh67ZVxGZOtPI0YPuEsO5n6zXe2uAlsfgybuTesRvEPNBzV+AvoRMz6sIQe+iRSkDRYiRZ4sgBX9HwuGHRWmmEyNrMbR76EDr+2PakPYucMnHZnQknRsGWpJY2cufEx1dGhCZ1RZT9zefGtQ4zN3Ih+Mg30KprbRHaEGPRV0SkA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1681762774; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=99nBUScf0UzmRjbHdBIG8CFWP6lyqlBlwCp6YdHNPk8=; 
        b=ISrRcOpmW+I6maTYxMswBBrxeUNQYxrHKwghE0iKDucobAzCFjMZQ2BkeeOgPGhpspXCRPRwQKcRc1vps7h/KvQyIzC5HKWtSfDfiwuFu5G8g11z7l+dw/UMmheks9sRhlV3+ZFIsucWyyyFavHghgz5nWCZ3dKMXrdVwMc0Muw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1681762774;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=99nBUScf0UzmRjbHdBIG8CFWP6lyqlBlwCp6YdHNPk8=;
        b=YuIEvfy7aoglv31EHZgnmopK+XiS+IksvXH4rGHaWW8NcFjRCwBPQeW4zoIHu1HV
        mp3QD61MREPwf32QvhJmOP7sh9gzEd7EJY56Ot0pY3SArwgHZmKgY0/HaoyxnNGdEOM
        MhSoMY84+kwMj/nxn02ZBt+6G1v6mgZAGjO/bjIs=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1681762772588384.36097550065824; Mon, 17 Apr 2023 13:19:32 -0700 (PDT)
Message-ID: <8d185a8c-f5b5-b11a-cb83-23b250c235e8@arinc9.com>
Date:   Mon, 17 Apr 2023 23:19:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] USB: serial: option: add UNISOC vendor and TOZED LT70C
 product
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, me@1conan.com,
        erkin.bozoglu@xeront.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417152003.243248-1-arinc.unal@arinc9.com>
 <ZD1ufX/oyif5LRY7@hovoldconsulting.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZD1ufX/oyif5LRY7@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2023 19:06, Johan Hovold wrote:
> On Mon, Apr 17, 2023 at 06:20:03PM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Add UNISOC vendor ID and TOZED LT70-C modem which is based from UNISOC
>> SL8563. The modem supports the NCM mode. Interface 0 is used for running
>> the AT commands. Interface 12 is the ADB interface.
>>
>> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
>> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
>> P:  Vendor=1782 ProdID=4055 Rev=04.04
>> S:  Manufacturer=Unisoc Phone
>> S:  Product=Unisoc Phone
>> S:  SerialNumber=<redacted>
>> C:  #Ifs=14 Cfg#= 1 Atr=c0 MxPwr=500mA
>> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
>> E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
>> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#=10 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#=11 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#=12 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=option
> 
> I changed this to:
> 
> I:  If#=12 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> 
>> E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#=13 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 2 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
>> E:  Ad=84(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
>> I:  If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
>> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 4 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
>> E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
>> I:  If#= 5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
>> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 6 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
>> E:  Ad=88(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
>> I:  If#= 7 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
>> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
> 
> Next time, remember to include a brief changelog here when respinning.
> 
> Now applied, thanks.

Thanks a lot. I just realised I made a slight mistake on the comment 
line, calling the modem TL70-C instead of LT70-C. Would you take another 
patch for this or apply a potential v3 instead?

Arınç
