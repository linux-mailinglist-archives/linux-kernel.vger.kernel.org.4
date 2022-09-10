Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB45B4539
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIJIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIJIYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 04:24:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75314008
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662798278; x=1694334278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3Cx5V1X+W7yy5o4//P50VU22wRF+vaid1kU1sjxXoMk=;
  b=qIPDdhghR1xd/wsvhuO/zEEhNSJ8J8heCCaEl11pz4uRqS3gOPYWgOZS
   jINK4KNw5nwJkTNlQgmDUke+srRzmNW/n5POq6t67ydP+d+SDqjDc1uVc
   dtbJRJj7jvbT9MPq5P1Q+7hfb4kIzr42LR/rzwPih7X7NtE4L0VJo9dfN
   ba73clWgCm0nCGnsEtgZT2kEmv+v2IXafYpgOyOwWcNHKk/w0fndD6SP4
   RWhHRlVtj+A3Z1tqjXYizOO6RDEqdLNPu8vU9gSLm6um84VVwUxUZ6f8G
   m+mjrUdeyaDtK+q7+LXQNoIeDnSA071XjX6SQzabKN4LovSctj+geWaBm
   w==;
X-IronPort-AV: E=Sophos;i="5.93,305,1654531200"; 
   d="scan'208";a="315286074"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2022 16:24:31 +0800
IronPort-SDR: ewYlTomsdmGOC+i0S46HiHOg+4PJnjJrhpnE5OCT3KE5PA7Cc0se96f8c3JrRS8t+2YneCHSGh
 DroIDg7jUPJJQyd210wQt6WfFWNlJokIzBiy7IEoRurapEuYuwcUh+XuYftmQdcroQk1WcU66Q
 cVNomDA1UXqWxd+vm2bJFAPNzf4ksU7fQtRKpjrhiflH03fRX6iEEhpbvij9exsaapt6ckN0le
 dd4+wGEIW87jW/y6tuaxAWB4XNszzX0uTFkA12ulpjYWSNtHhZzaVcpQGxZJQsNhDLPKpMwMWV
 ePtaR+3EC/D19zik2p+9Q47r
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2022 00:44:49 -0700
IronPort-SDR: DFncbpgrrPnXT2K8VtQpTZGSGBNsbz+EFTB0VfGcNo0PgE20EHD1gLGHBlHNUnZbtKcwQl7jJR
 5clIByephv1ig85XC0yQoWHx+bZ5sDd/cisrBD/rtStB/mB27D0Yk2f0OjNuu+cr7eOGh33OoL
 sCamLbkcP0FxpP3EyIQnBButJojqnmv64coC7sFWV2JGVxGNKVwiT3qQJXaeO3iXXpsL4RQCMh
 47VZ4q8LYr2BrkGOsqtHmQhKNqFG8GFL0CugKrLwM8guZ0rhDpYq9+ldGty/ETbKHAGMJzgkgK
 7po=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2022 01:24:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MPm9q3k9Pz1Rwt8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 01:24:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662798270; x=1665390271; bh=3Cx5V1X+W7yy5o4//P50VU22wRF+vaid1kU
        1sjxXoMk=; b=MsMJyhOp/GAMNKZ9LvKV2dWLG7YyCEJ4HiIcWvec9Jr7O42Q3dq
        iEm23hczQDhV9pAKyG0YIuvMmCLJSHsmk+PMtIcWvf4JrpfWrJTEaYiVb5gad8NJ
        igSEn41laJ12/i0+VDjsskBjhA3OkKMak4P5u/g6RZ2Oyoclf6zzJD4HArb1sx8R
        kyKuLiNQHPVT8UfkOw3ezbltXxWvpNpKhpYPw3uKCQeQu/A5rVWatX3IvugIf2AT
        spB3TwLOWJNamqYV2KUZ75N7gDqKfyY+LCWxIrs1nXzoPChxW3itZL3oTQ3WizHV
        DHY/zp0M3H7M7ClKjqOvL+5nN2qTM6dxGbQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BHO8htRiUrw9 for <linux-kernel@vger.kernel.org>;
        Sat, 10 Sep 2022 01:24:30 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MPm9n38KCz1RvLy;
        Sat, 10 Sep 2022 01:24:29 -0700 (PDT)
Message-ID: <3597fe1a-aca3-b854-ae30-f5d069c5003b@opensource.wdc.com>
Date:   Sat, 10 Sep 2022 17:24:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Conor.Dooley@microchip.com, wangjianli@cdjrlc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908124937.25962-1-wangjianli@cdjrlc.com>
 <e2f882f7-6871-a754-fbbd-6a5201f45f4a@microchip.com>
 <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/08 22:02, James Bottomley wrote:
> On Thu, 2022-09-08 at 12:56 +0000, Conor.Dooley@microchip.com wrote:
>> On 08/09/2022 13:49, wangjianli wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>
>>> Delete the redundant word 'in'.
>>>
>>> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
>>> ---
>>>   drivers/ata/libata-eh.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 7c128c89b454..ca865a95cf24 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list
>>> *t)
>>>    *
>>>    *     Set ATA_PFLAG_EH_PENDING and activate fast drain if
>>> @fastdrain
>>>    *     is non-zero and EH wasn't pending before.  Fast drain
>>> ensures
>>> - *     that EH kicks in in timely manner.
>>> + *     that EH kicks in timely manner.
>>
>> Hey wangjianli,
>> This does not look like the right fix to me.. To me, it looks like it
>> should be s/in in/in in a/.
>>
>> If you're using an automated tool, which I can only assume you are,
>> to find these typos it'd be a good idea to check the output for
>> correctness prior to sending patches.
> 
> And it would also have been nice to accommodate the exact same feedback
> last time these patches were posted:
> 
> https://lore.kernel.org/all/cec12e246d7151f6041bf553629a3047e81d4afe.camel@HansenPartnership.com/
> 
> It's really disappointing you haven't accommodated any feedback either
> into your bot or the patches it sends.  Not doing so really does render
> this work largely useless.

And another submitter sent a similar incorrect "fix", twice, ignoring my
comments. I am OK with applying such fixes, even though they have little value.
But the submitter has to be willing to listen and fix their patches. I will not
do that for them :)


-- 
Damien Le Moal
Western Digital Research

