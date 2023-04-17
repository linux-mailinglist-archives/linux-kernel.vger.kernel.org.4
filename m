Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633826E45F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDQLC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDQLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:02:45 -0400
X-Greylist: delayed 1070 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 04:01:53 PDT
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DCCD;
        Mon, 17 Apr 2023 04:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681728135; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DH2IVBozEs6pUVU0K5hsGDcJrZ6CJ3nWzbDYtoGHioVjFxvvacBPxjbSGWH8Kwswq+tEGtQKkyNjbUIcy85yGQ+LCiAVUYh3c1t9X10EcoKz88sQSyWZU3VL360BRkKpVVJCqriaiVP0/EytUxC2oeyP+MpIFOW/0ZYtPzcXewU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1681728135; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=l5UzRmzjBmdp1SHIiT+fyytsFP7exoqSFPSjT6fGmo8=; 
        b=RyUcRo2i4spe6I+LR7SWSY/0esnRpNPujxx7OXsrHHH7tILwVrL6RhM7Pcaayk2YSy+K56pG3OkHv7CNzTX1wDknQWlbG6O5P75DBOoXT7e2IAWD6dM2v689mSz37FjY76luaHgQgUsS2ZKDZxnLALzN0IGECiz5LhGAxIJzqAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1681728135;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=l5UzRmzjBmdp1SHIiT+fyytsFP7exoqSFPSjT6fGmo8=;
        b=eSaBIRkapZ8gYAkR0KtPDJQXlGi43FvP/QaKqV4Ye7LnFHrhROfOJcUNasnqO426
        vj6MilsJgrTzWjK5nUgeYBPv/yJTFVNgK51KKJQWUZfI/E1tnEWTFC6fX8kw8KLY3Y5
        epoNYk08hRpl6WR6CtYaiilxb9QPiTQj9KbTvQ64=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1681728134506248.94212542722335; Mon, 17 Apr 2023 03:42:14 -0700 (PDT)
Message-ID: <a6474ebf-67be-cdd9-8213-6251f27da2bd@arinc9.com>
Date:   Mon, 17 Apr 2023 13:42:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] USB: serial: option: add UNISOC vendor and TOZED LT70C
 product
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>, me@1conan.com,
        erkin.bozoglu@xeront.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406055004.8216-1-arinc.unal@arinc9.com>
 <ZDgca7wgfGlK/9cZ@hovoldconsulting.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZDgca7wgfGlK/9cZ@hovoldconsulting.com>
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

On 13.04.2023 18:14, Johan Hovold wrote:
> On Thu, Apr 06, 2023 at 08:50:04AM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Add UNISOC vendor ID and TOZED LT70-C modem which is based from UNISOC
>> SL8563. The modem supports the NCM mode.
> 
> Thanks for the patch. Looks mostly good, but see my comments below.

Thanks a lot for looking at this Johan!

> 
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
>> E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> This looks like an ADB interface which should be blacklisted (reserved)
> so that the driver does not bind to it.

Will do.

> 
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
>> Bus 001 Device 002: ID 1782:4055 Unisoc Phone Unisoc Phone
>> Device Descriptor:
>>    bLength                18
>>    bDescriptorType         1
>>    bcdUSB               2.00
>>    bDeviceClass            0
>>    bDeviceSubClass         0
>>    bDeviceProtocol         0
>>    bMaxPacketSize0        64
>>    idVendor           0x1782
>>    idProduct          0x4055
>>    bcdDevice            4.04
>>    iManufacturer           1 Unisoc Phone
>>    iProduct                2 Unisoc Phone
>>    iSerial                 3 <redacted>
>>    bNumConfigurations      1
> 
> When resending you can put the verbose lsusb output below the cut-off
> line (---) so that we have it in the mail archives if ever needed.

Will do.

> 
> Could you also add something what the various serial interfaces are used
> for?

Me and Conan only know the first interface which is where the AT 
commands are run. I will mention this and the ADB interface on v2.

> 
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>
>> I did not receive any comments on RFC so I'm sending this as is.
>>
>> Arınç
>>
>> ---
>>   drivers/usb/serial/option.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>> index f31cc3c76329..65a050a9ca39 100644
>> --- a/drivers/usb/serial/option.c
>> +++ b/drivers/usb/serial/option.c
>> @@ -595,6 +595,11 @@ static void option_instat_callback(struct urb *urb);
>>   #define SIERRA_VENDOR_ID			0x1199
>>   #define SIERRA_PRODUCT_EM9191			0x90d3
>>   
>> +/* UNISOC (Spreadtrum) products */
>> +#define UNISOC_VENDOR_ID			0x1782
>> +/* TOZED TL70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
>> +#define TOZED_PRODUCT_LT70C			0x4055
>> +
>>   /* Device flags */
>>   
>>   /* Highest interface number which can be used with NCTRL() and RSVD() */
>> @@ -2225,6 +2230,7 @@ static const struct usb_device_id option_ids[] = {
>>   	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
>>   	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
>>   	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
>> +	{ USB_DEVICE(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C) },
> 
> You should match also on the interface class so that you don't try to
> bind to the cdc interfaces. See USB_DEVICE_INTERFACE_CLASS() (and
> RSVD() for the ADB interface).

Thanks, the final result should look like this:

{ USB_DEVICE_INTERFACE_CLASS(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff),
   .driver_info = RSVD(12) },

Arınç
