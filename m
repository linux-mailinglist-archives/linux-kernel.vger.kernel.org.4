Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20336ED8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjDXXam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjDXXaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:30:35 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6EA46A9;
        Mon, 24 Apr 2023 16:30:26 -0700 (PDT)
Received: from [IPV6:2408:824e:f25:7460:b092:16d8:698e:4b1a] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33ONTtLx029003-33ONTtM0029003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 25 Apr 2023 07:29:56 +0800
Message-ID: <ead628fe-c7fc-5e1e-0eba-02683a21b429@hust.edu.cn>
Date:   Tue, 25 Apr 2023 07:29:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND] usb: dwc3: remove dead code in dwc3_otg_get_irq
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        lihuya <lihuya@hust.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230424105930.49944-1-lihuya@hust.edu.cn>
 <20230424213339.avocjfchjd2ptaqg@synopsys.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20230424213339.avocjfchjd2ptaqg@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/25 05:33, 'Thinh Nguyen' via HUST OS Kernel Contribution wrote:
> On Mon, Apr 24, 2023, lihuya wrote:
>> platform_get_irq() only return non-zero irq number on success, or
>> negative error number on failure.
>>
>> There is no need to check the return value of platform_get_irq()
>> to determine the return value of dwc3_otg_get_irq(), removing
>> them to solve this problem.
>>
>> Signed-off-by: lihuya <lihuya@hust.edu.cn>
> Is this your full name?

Hi Yuhang,

Please use your full name: Yuhang Liang. This is essential in the kernel 
patch submission.

Dongliang Mu

>
>> ---
>>   drivers/usb/dwc3/drd.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index 039bf241769a..c2e09700212d 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -154,11 +154,6 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
>>   		goto out;
>>   
>>   	irq = platform_get_irq(dwc3_pdev, 0);
>> -	if (irq > 0)
>> -		goto out;
>> -
>> -	if (!irq)
>> -		irq = -EINVAL;
>>   
>>   out:
>>   	return irq;
>> -- 
>> 2.34.1
>>
> FWIW, here's the ack again.
>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>
> Thanks,
> Thinh
>
