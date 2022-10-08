Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8565F81F6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 03:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJHBg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 21:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJHBgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 21:36:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6093C98C83
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 18:36:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g28so6313943pfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 18:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAJSNEPmQtz3VN94KI8fdPFkmlQZ/JCs/asDLtJWQP0=;
        b=xOIYZTvrSIXAwH0fsMn8S9AbMsxAff0FNQnOwwlTZx6iK4V6CLLj2errbUbltc2YAy
         gnYAimw4H0df/3KAe0bRukezynyxRv+mAi8Cs/TrCMbdkXo4RqEbQZNx82T3zLCBgp7q
         KXFzibmVrznhpe9DbzVWdNPButPitxts55RDzEWkWO8S1f0AjriERNX4dFPsb+dUoEHk
         oV4/7GeRjk/3G+LimORaV/SnsYZMrOSqqppx1KVOAYsU3LO1StP29XdyGFb9o2daAwBf
         iC2D2GGflwpBUGGS8UBilCqSVJlHoELUC8vZJgUb21ZevdMtSgTtFX4bkvLLNn+WJp81
         x4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAJSNEPmQtz3VN94KI8fdPFkmlQZ/JCs/asDLtJWQP0=;
        b=mGKvswIoxavBi/JS9V5wXWfqLXlXFAlunfeqht4R2pg56eghb5NuQm0KRBfb2mvgX+
         YRFu2q15wxQWppyPcfSFOpyEUScdwkY0ksPPpN+Gs4dFbVlCFOFkN9MfEkZHK7qcRk16
         y48JmOmagb6ucinrOU1s8okyVSc/D0aH3qP/Gi36/lVJni/0OB0ZSXYqCN7Z1uhbmkuV
         Z10mLoYNuolloDo6NBDsX/jpTINuNSkdfEAuYOy0M8mWAs2Xrz02ghd6w/6kmGX5VD47
         Lwj51loVuAz0SdSkZ/vyxLNU0ZgbBeN8tH2a2lhGFG7KOclv4VnXXwU7hMV8yPC80ncw
         t3AQ==
X-Gm-Message-State: ACrzQf3xRV4u34wx6600NkOqky/kpT4AJpwm+g8UaXd6sGesluBupeCf
        jISHwH9W/45WYs/1U6jtTJg8aQ==
X-Google-Smtp-Source: AMsMyM6bTGfX4osDlfq9JTLg/Zsl4tQYaRVojW82I8SEJF+ZQQbC6pw6FZX1yva/nwjXAB9X4uy1gw==
X-Received: by 2002:a63:4a4b:0:b0:439:837:cc8d with SMTP id j11-20020a634a4b000000b004390837cc8dmr7003619pgl.199.1665192980828;
        Fri, 07 Oct 2022 18:36:20 -0700 (PDT)
Received: from [10.70.253.132] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e187-20020a621ec4000000b00562cfc80864sm1579422pfe.36.2022.10.07.18.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 18:36:20 -0700 (PDT)
Message-ID: <28367829-10e1-1a74-5572-ba01b8f8b716@bytedance.com>
Date:   Sat, 8 Oct 2022 09:36:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 1/3] ipmi: fix msg stack when IPMI is disconnected
Content-Language: en-US
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
 <20221007092617.87597-2-zhangyuchen.lcr@bytedance.com>
 <Y0CBbRqGPDU3g9hQ@minyard.net>
From:   Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
In-Reply-To: <Y0CBbRqGPDU3g9hQ@minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

On 10/8/22 3:43 AM, Corey Minyard wrote:
> On Fri, Oct 07, 2022 at 05:26:15PM +0800, Zhang Yuchen wrote:
>> If you continue to access and send messages at a high frequency (once
>> every 55s) when the IPMI is disconnected, messages will accumulate in
>> intf->[hp_]xmit_msg. If it lasts long enough, it takes up a lot of
>> memory.
> 
> The IPMI driver really wasn't designed to handle this sort of thing.  If
> there is a BMC there, it should be there except when it's rebooting,
> which should only take a few seconds.  Which is what this is all
> designed to handle.
> 
I think no matter what machine it is, there is always a chance that it
will make mistakes. IPMI drivers should consider this.
>>
>> The reason is that if IPMI is disconnected, each message will be set to
>> IDLE after it returns to HOSED through IDLE->ERROR0->HOSED. The next
>> message goes through the same process when it comes in. This process
>> needs to wait for IBF_TIMEOUT * (MAX_ERROR_RETRIES + 1) = 55s.
>>
>> Each message takes 55S to destroy. This results in a continuous increase
>> in memory.
>>
>> I find that if I wait 5 seconds after the first message fails, the
>> status changes to ERROR0 in smi_timeout(). The next message will return
>> the error code IPMI_NOT_IN_MY_STATE_ERR directly without wait.
> 
> So basically, you will stay in error state until the BMC recovers.  The
> KCS state machine will reject messages until the state machine detects
> that the BMC is working again.  I think this is ok.
> 
> Have you tested that if the BMC comes back that the driver recovers and
> works?  Looking at the code it seems to be the case, but can you test to
> be sure, if you have not already?
> 
I have tested this case. IPMI will be restored immediately when BMC is
restored.
> Also, the following is in start_kcs_transaction():
> 
> 	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
> 		dev_warn(kcs->io->dev, "KCS in invalid state %d\n", kcs->state);
> 		return IPMI_NOT_IN_MY_STATE_ERR;
> 	}
> 
> You probably need to remove the (kcs->state != KCS_HOSED) part of this
> now.  Would you agree?
> 
> -corey
> 
I agree. KCS_HOSED state should be an invalid state.
>>
>> This is more in line with our needs.
>>
>> So instead of setting each message state to IDLE after it reaches the
>> state HOSED, set state to ERROR0.
>>
>> After testing, the problem has been solved, no matter how many
>> consecutive sends, will not cause continuous memory growth. It also
>> returns to normal immediately after the IPMI is restored.
>>
>> The verification operations are as follows:
>>
>> 1. Use BPF to record the ipmi_alloc/free_smi_msg().
>>
>>    $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc
>>        %p\n",retval);} kprobe:free_recv_msg {printf("free  %p\n",arg0)}'
>>
>> 2. Exec `date; time for x in $(seq 1 2); do ipmitool mc info; done`.
>> 3. Record the output of `time` and when free all msgs.
>>
>> Before:
>>
>> `time` takes 120s, This is because `ipmitool mc info` send 4 msgs and
>> waits only 15 seconds for each message. Last msg is free after 440s.
>>
>>    $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc
>>        %p\n",retval);} kprobe:free_recv_msg {printf("free  %p\n",arg0)}'
>>    Oct 05 11:40:55 Attaching 2 probes...
>>    Oct 05 11:41:12 alloc 0xffff9558a05f0c00
>>    Oct 05 11:41:27 alloc 0xffff9558a05f1a00
>>    Oct 05 11:41:42 alloc 0xffff9558a05f0000
>>    Oct 05 11:41:57 alloc 0xffff9558a05f1400
>>    Oct 05 11:42:07 free  0xffff9558a05f0c00
>>    Oct 05 11:42:07 alloc 0xffff9558a05f7000
>>    Oct 05 11:42:22 alloc 0xffff9558a05f2a00
>>    Oct 05 11:42:37 alloc 0xffff9558a05f5a00
>>    Oct 05 11:42:52 alloc 0xffff9558a05f3a00
>>    Oct 05 11:43:02 free  0xffff9558a05f1a00
>>    Oct 05 11:43:57 free  0xffff9558a05f0000
>>    Oct 05 11:44:52 free  0xffff9558a05f1400
>>    Oct 05 11:45:47 free  0xffff9558a05f7000
>>    Oct 05 11:46:42 free  0xffff9558a05f2a00
>>    Oct 05 11:47:37 free  0xffff9558a05f5a00
>>    Oct 05 11:48:32 free  0xffff9558a05f3a00
>>
>>    $ root@dc00-pb003-t106-n078:~# date;time for x in $(seq 1 2); do
>>    ipmitool mc info; done
>>
>>    Wed Oct  5 11:41:12 CST 2022
>>    No data available
>>    Get Device ID command failed
>>    No data available
>>    No data available
>>    No valid response received
>>    Get Device ID command failed: Unspecified error
>>    No data available
>>    Get Device ID command failed
>>    No data available
>>    No data available
>>    No valid response received
>>    No data available
>>    Get Device ID command failed
>>
>>    real        1m55.052s
>>    user        0m0.001s
>>    sys        0m0.001s
>>
>> After:
>>
>> `time` takes 55s, all msgs is returned and free after 55s.
>>
>>    $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc
>>        %p\n",retval);} kprobe:free_recv_msg {printf("free  %p\n",arg0)}'
>>
>>    Oct 07 16:30:35 Attaching 2 probes...
>>    Oct 07 16:30:45 alloc 0xffff955943aa9800
>>    Oct 07 16:31:00 alloc 0xffff955943aacc00
>>    Oct 07 16:31:15 alloc 0xffff955943aa8c00
>>    Oct 07 16:31:30 alloc 0xffff955943aaf600
>>    Oct 07 16:31:40 free  0xffff955943aa9800
>>    Oct 07 16:31:40 free  0xffff955943aacc00
>>    Oct 07 16:31:40 free  0xffff955943aa8c00
>>    Oct 07 16:31:40 free  0xffff955943aaf600
>>    Oct 07 16:31:40 alloc 0xffff9558ec8f7e00
>>    Oct 07 16:31:40 free  0xffff9558ec8f7e00
>>    Oct 07 16:31:40 alloc 0xffff9558ec8f7800
>>    Oct 07 16:31:40 free  0xffff9558ec8f7800
>>    Oct 07 16:31:40 alloc 0xffff9558ec8f7e00
>>    Oct 07 16:31:40 free  0xffff9558ec8f7e00
>>    Oct 07 16:31:40 alloc 0xffff9558ec8f7800
>>    Oct 07 16:31:40 free  0xffff9558ec8f7800
>>
>>    root@dc00-pb003-t106-n078:~# date;time for x in $(seq 1 2); do
>>    ipmitool mc info; done
>>    Fri Oct  7 16:30:45 CST 2022
>>    No data available
>>    Get Device ID command failed
>>    No data available
>>    No data available
>>    No valid response received
>>    Get Device ID command failed: Unspecified error
>>    Get Device ID command failed: 0xd5 Command not supported in present state
>>    Get Device ID command failed: Command not supported in present state
>>
>>    real        0m55.038s
>>    user        0m0.001s
>>    sys        0m0.001s
>>
>> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
>> ---
>>   drivers/char/ipmi/ipmi_kcs_sm.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
>> index efda90dcf5b3..e7f2cd10e5a6 100644
>> --- a/drivers/char/ipmi/ipmi_kcs_sm.c
>> +++ b/drivers/char/ipmi/ipmi_kcs_sm.c
>> @@ -122,10 +122,10 @@ struct si_sm_data {
>>   	unsigned long  error0_timeout;
>>   };
>>   
>> -static unsigned int init_kcs_data(struct si_sm_data *kcs,
>> -				  struct si_sm_io *io)
>> +static unsigned int init_kcs_data_with_state(struct si_sm_data *kcs,
>> +				  struct si_sm_io *io, enum kcs_states state)
>>   {
>> -	kcs->state = KCS_IDLE;
>> +	kcs->state = state;
>>   	kcs->io = io;
>>   	kcs->write_pos = 0;
>>   	kcs->write_count = 0;
>> @@ -140,6 +140,12 @@ static unsigned int init_kcs_data(struct si_sm_data *kcs,
>>   	return 2;
>>   }
>>   
>> +static unsigned int init_kcs_data(struct si_sm_data *kcs,
>> +				  struct si_sm_io *io)
>> +{
>> +	return init_kcs_data_with_state(kcs, io, KCS_IDLE);
>> +}
>> +
>>   static inline unsigned char read_status(struct si_sm_data *kcs)
>>   {
>>   	return kcs->io->inputb(kcs->io, 1);
>> @@ -495,7 +501,7 @@ static enum si_sm_result kcs_event(struct si_sm_data *kcs, long time)
>>   	}
>>   
>>   	if (kcs->state == KCS_HOSED) {
>> -		init_kcs_data(kcs, kcs->io);
>> +		init_kcs_data_with_state(kcs, kcs->io, KCS_ERROR0);
>>   		return SI_SM_HOSED;
>>   	}
>>   
>> -- 
>> 2.30.2
>>

-- 
Thanks,
Zhang Yuchen
