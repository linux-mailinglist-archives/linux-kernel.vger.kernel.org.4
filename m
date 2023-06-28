Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71D740C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbjF1JAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:00:00 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:12797 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjF1IsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687942094; x=1719478094;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=X1lV//NrL/Byabvyiiu9zop46VBbKgQ0MLmfcRSCKjc=;
  b=tI6ej/derrKpQTO6BhzZ3We7uPmPDqLmFhwnWC0Q5LWntmE/roLsYh9N
   3oi28aj+lK2TK5QCLwdmufhGPw+Jw5CG3/zjRUbrFLd2ZwRCvUHUOZdeu
   9R+0xRFvtu2CtZ9qVOA31cFRjGiAmrsw5Na64YtCqbqYyesGT7F4vprDO
   4=;
X-IronPort-AV: E=Sophos;i="6.01,165,1684800000"; 
   d="scan'208";a="223542877"
Subject: Re: [PATCH 2/5] dt-bindings: pps: pps-gpio: introduce capture-clear property
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:48:06 +0000
Received: from EX19D006EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id 746CF40A6A;
        Wed, 28 Jun 2023 08:48:04 +0000 (UTC)
Received: from EX19D044EUA002.ant.amazon.com (10.252.50.212) by
 EX19D006EUA003.ant.amazon.com (10.252.50.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 08:47:54 +0000
Received: from [192.168.159.6] (10.85.143.176) by
 EX19D044EUA002.ant.amazon.com (10.252.50.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 08:47:48 +0000
Message-ID: <7d2fa941-8c3e-d99a-f556-ac9c11b500d8@amazon.com>
Date:   Wed, 28 Jun 2023 11:47:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <giometti@enneenne.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>
References: <20230625142134.33690-1-farbere@amazon.com>
 <20230625142134.33690-3-farbere@amazon.com>
 <4244c92d-2079-e3d9-44c8-8e5593d093a5@linaro.org>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <4244c92d-2079-e3d9-44c8-8e5593d093a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.85.143.176]
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D044EUA002.ant.amazon.com (10.252.50.212)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2023 6:46 PM, Krzysztof Kozlowski wrote:
> On 25/06/2023 16:21, Eliav Farber wrote:
>> Add a new optional "capture-clear" boolean property.
>> When present, PPS clear events shall also be reported.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 4 ++++
>
> Please convert the bindings to DT schema first.
I will convert to DT schema first, if I indeed end up modifying this file.

>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt 
>> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> index 9012a2a02e14..8d588e38c44e 100644
>> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> @@ -14,6 +14,10 @@ Additional required properties for the PPS ECHO 
>> functionality:
>>  Optional properties:
>>  - assert-falling-edge: when present, assert is indicated by a 
>> falling edge
>>                         (instead of by a rising edge)
>> +- capture-clear: when present, report also PPS clear events, which 
>> is the
>> +                 opposite of the assert edge (if assert is 
>> rising-edge then
>> +                 clear is falling-edge and if assert is falling-edge 
>> then
>> +                 clear is rising-edge).
>
> Why this is board-dependant? Falling edge is happening anyway, so it is
> in the hardware all the time. DT describes the hardware, not Linux
> driver behavior.
Falling edge of the pulse is happening all the time, but the falling
edge event is currently never reported by the pps-gpio driver.

It is because there is no place in the pps-gpio driver that sets
info->capture_clear, so
   pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
will never be called.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pps/clients/pps-gpio.c?h=v6.4#n59

There was an option in the past to set info->capture_clear, but that
option was removed in commit ee89646619ba ("pps: clients: gpio: Get rid
of legacy platform data").

This node in the DT isn't a pure HW device, but rather a SW driver.
The patch I shared allows to set capture-clear from device-tree same as
setting of assert-falling-edge is done.

Do you suggest I enable capture_clear in a different way?
Perhaps module-param?

> What's more, your property name sounds a lot like a driver property, so
> even if this is suitable for DT, you would need to name it properly to
> match hardware feature/characteristic.
I chose capture-clear as a name since it is aligned with the driver's
terminology. It sets the capture_clear parameter, just like
assert-falling-edge in DT sets assert_falling_edge parameter.

---
Regards, Eliav
