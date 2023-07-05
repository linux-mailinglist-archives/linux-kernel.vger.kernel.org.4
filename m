Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B18747DC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjGEHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjGEHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:04:16 -0400
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7213E7B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:04:12 -0700 (PDT)
Received: from [172.18.100.99] ([109.238.20.116])
        by Aruba Outgoing Smtp  with ESMTPSA
        id GwYaqFGCwF0TUGwYaq4XKz; Wed, 05 Jul 2023 09:04:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1688540649; bh=BffAVpd+VCtsOxhtkVVypDCW94v4CBSzFynZPTC1+Nk=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=DDUdPZVXgAQU8Vo++kl/BVQpOaHAK+FdDtuVlgZgYuKxwJCUNnkEyizDpra1bCHdO
         lX6+YliEmb/4PC4FUC9B8MZBZ0Pu/Ojn2PLfb59faLZZlcFdIE7zahrWmUkPP37in6
         7V7r6IhSh5c2njoi1U9gRNPxz1AG51H27jJwNJQ70hcnlVi5gsWjCJKNUjfwv0CFNE
         JPuHxVUwlehdp8f4hmzQMbt8eTYKD+pyPlcIU5wayR/ozr3Sbr5Rkrk79QlhDlat77
         ZUaD9UwmYA6jMoQcxLmNuvsj6+1K5eSZaWAzY8qeH9/oly8Di2o/RtRtwAZlAbVWGK
         lgAhO8bCK2U/A==
Message-ID: <991959c5-37b2-4b41-e329-c088a250cef8@enneenne.com>
Date:   Wed, 5 Jul 2023 09:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] pps: clients: gpio: add option to set capture-clear
 from device-tree
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com
References: <20230625142134.33690-1-farbere@amazon.com>
 <20230625142134.33690-4-farbere@amazon.com>
 <04d52b5d-700c-c5d3-07ae-d4b8ad4fc3cd@amazon.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <04d52b5d-700c-c5d3-07ae-d4b8ad4fc3cd@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIoyDDsFoRjFLxsd60pYGpXRu/gTI9ppel1UIMHnNHywMSO1UZDQfOIL+496NqnzvyQSk3z0RztX/mR7VHMddM08O1O7QtniPJtux/IphjfAjCT7RO2t
 c6T7TRlJKBK5C6V+VbXmEpbJny9a7HKWWfHdPSDffporeLkVSqH1VMn1K+hurCNQXyEGrwPJg3jT27ynqvOSarK8rkjrzw+1lawlqEt6CMfZZwqo2sep859y
 w6iyNUECBhfuDDxlrWM/FqklkLN4ZZimS2xSXOW8Pt4iXYdROtAtYoeI8RdVasmAWxn2il9qXjj3Icqv8tjtApo8bpg0vje6LNhB9ubgt5smxQC8sd7l+ou2
 oxEWFJhhCMmHWNtXUQCKQlx50NoR6SiBpf9lUMZW1/Y0ervJ9pLSgHlzrHcNy/BJrPCH2FayrEapPLIabw+oaPLQwElLnyZJoI+x/SVfwY733n8BHcEWcJyi
 P6IVdJX40keuJYl91s37cgsCXbM/T43ilsHeKrDAp23UFS/dzjlDLw6ztHgTRzcz+6edXjME4O+rKGYj7hNKhxk0SrWEJSoiX/94LkZRGOfJh5Kh76Zn2W18
 dUbtRK7MWd0zq0n/fCp8A0Bw
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/23 07:07, Farber, Eliav wrote:
> On 6/25/2023 5:21 PM, Eliav Farber wrote:
>> Enable capture clear events if "capture-clear" boolean property exists
>> in device-tree.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> drivers/pps/clients/pps-gpio.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
>> index 2f4b11b4dfcd..a61dc1299ce9 100644
>> --- a/drivers/pps/clients/pps-gpio.c
>> +++ b/drivers/pps/clients/pps-gpio.c
>> @@ -112,6 +112,7 @@ static int pps_gpio_setup(struct device *dev)
>>
>>     data->assert_falling_edge =
>>         device_property_read_bool(dev, "assert-falling-edge");
>> +    data->capture_clear = device_property_read_bool(dev, "capture-clear");
> 
> Rodolfo, currently data->capture_clear is false by default, and there
> is no way of setting it in the pps-gpio driver.
> How would you suggest setting it?

I think that driver needs a review... in fact, by using gpiod_*() functions we 
should be able to remove both assert_falling_edge and capture_clear flags.

> Will it be OK to setting PPS_WIDTHASSERT by default?

I think they can both be asserted by default. Why should someone may prefer to 
disable one of them?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

