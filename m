Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130EA740CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjF1J2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:28:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39676 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbjF1I7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687942770; x=1719478770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H5XOlVYF53c/y157iszIY78jZEcz/O9uOxgpG6UDJZM=;
  b=1BY/EKVTCKqKJN1BK2u7VJQVgd5cIlSCCmuBERP1t+aNmM+pewTvDh96
   DeqzSDdhKaWBVTnrzwn1OjKV7I6vY9BxRWATYnOnxySOeGNQar6ltaFw0
   SXvVWaKEkRa0/a5FPDtAU8QdTEooTOZcKLHhVyKFA6+UjpZ+4oWhHX3Lj
   nuaiaI4RnskwMSt1Vgu4V4bHLWC2WNgp+XNaEBa+uqQoj2hydpuEnL0aB
   AvPciMMa6FV3EoTAqBpkbggXs2PIJoQYxqF6akKZmxXdfdJWoOygpb/Hw
   R9QpsptvJmxkriQff5u5/WPAM10vHhd3DxLvrN5+pgxiuuXXsmxyj6o5Z
   A==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="232626321"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2023 01:59:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 28 Jun 2023 01:59:19 -0700
Received: from [10.12.67.138] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 28 Jun 2023 01:59:17 -0700
Message-ID: <2b323110-428c-e2a0-9d2c-fbffd4524cf9@microchip.com>
Date:   Wed, 28 Jun 2023 10:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: Orphan the OV7740 driver
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <linux-media@vger.kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <mchehab@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        "Songjun Wu" <songjun.wu@atmel.com>,
        Hari Prasath <Hari.PrasathGE@microchip.com>
References: <20230522134751.30489-1-nicolas.ferre@microchip.com>
 <ZGuJ7GqxDI0aZxK6@kekkonen.localdomain>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <ZGuJ7GqxDI0aZxK6@kekkonen.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sakari,

On 22/05/2023 at 17:27, Sakari Ailus wrote:
> Hi Nicolas,
> 
> On Mon, May 22, 2023 at 03:47:51PM +0200, nicolas.ferre@microchip.com wrote:
>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> Wenyou's email is bouncing, remove him from this camera driver's entry
>> and mark it as orphan.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> ---
>> Wenyou, all,
>>
>> If you want to take this driver, please don't hesitate to update this patch for
>> a better maintenance. My only concern is the @microchip.com email address
>> bouncing.

I'm sorry to insist, but bouncing email on our domain is becoming a real 
problem.
I don't see this patch on Linux-next, so what can I do to make this move 
forward?

> What about the driver author (cc'd)?

I didn't hear about Songjun for a long time.

Best regards,
    Nicolas

>>   MAINTAINERS | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e0ad886d3163..bae9c7591144 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15577,9 +15577,8 @@ F:    drivers/media/i2c/ov772x.c
>>   F:   include/media/i2c/ov772x.h
>>
>>   OMNIVISION OV7740 SENSOR DRIVER
>> -M:   Wenyou Yang <wenyou.yang@microchip.com>
>>   L:   linux-media@vger.kernel.org
>> -S:   Maintained
>> +S:   Orphan
>>   T:   git git://linuxtv.org/media_tree.git
>>   F:   Documentation/devicetree/bindings/media/i2c/ov7740.txt
>>   F:   drivers/media/i2c/ov7740.c
>> --
>> 2.34.1
>>
> 
> --
> Kind regards,
> 
> Sakari Ailus

-- 
Nicolas Ferre

