Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1775F27B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJCC4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 22:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJCC4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 22:56:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165B2A25E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 19:56:13 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 3so5937371qka.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KAAlL7qc3QNZomCjUUEDiMSHcBQehuSzbhVOyWtKOAY=;
        b=VGKkwPiIWp3rZLe+58DJ5FLlC9yVNVjZLRR3Yf/TFG2jECbS9DuxGkYaEh4A24xunM
         9Xwxr4RgMJoBS2eqPEi0ZeaS8hFC9F6Kqx46im21PFrYhVNojkU0Jz1pcxsS2FDRB+QR
         1GFZ1Zrf8T2xq8cV1HHCauaLPIYXhDsYhPu3+Dr8vs/+3L9K1IcJ2KXBtbMgOugirK9+
         NLv5X3J8dRxWliWiaJ4H4pAzN0/0nWdJ5MPgoSlmKGNM58LGZS1LfQE2uIuDZYUTBjXc
         Q9+kBkwkGOVAt3eHAADZoQw4QAolMcBWD3ZV4r2Cp/mMndB6Uh5xZi7aYG8TEWgyPP/3
         lS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KAAlL7qc3QNZomCjUUEDiMSHcBQehuSzbhVOyWtKOAY=;
        b=TVABB5wXw9+s3nOn+tE0NbGAXMQL5nmrXqvt2Op44ikUwbFtD5bfFeO8n3UaVCthlX
         XO6fDyVtEYpUZ3pHEQPgKEti8vlFquk/hxFq4ZHjkqSt8z0Q6LfzrdDVHi+sRGDrFQca
         8TioCjShFYTtC5Ti332OyY0hBzvs1E21fMvvSs5ibjzYl4azA8g+1YcpU4DcvMv2wkPd
         /aegar+VkDek958FdV44yCkwFxJIE4ZbZZLd3nm0IC/HfXJVprpA2VXel+2dJ3NCFTJ+
         93P1cZz3DIqHPIz4lJ3icUYN1VxYIRtPVskG9GbM19ks7vC2PCuozosr75tdUysyUrIz
         4Qnw==
X-Gm-Message-State: ACrzQf3URaI/U1JU0x9cZZh41isX4wKGlakj3+MUgvGRc5ZHT2dRDdeB
        8zbUXsMthKSJqyCm1IwxqRs=
X-Google-Smtp-Source: AMsMyM5aHJ6xt7xoIYEcJa49IsZJ1uPLeVmWRV979AHtQwR2arzL3n9aaFyJj/j58wiRlRH9hS61XA==
X-Received: by 2002:a05:620a:1724:b0:6ce:9bb6:404b with SMTP id az36-20020a05620a172400b006ce9bb6404bmr12640211qkb.539.1664765773069;
        Sun, 02 Oct 2022 19:56:13 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id cq15-20020a05622a424f00b0035cdd7a42d0sm8342371qtb.22.2022.10.02.19.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 19:56:12 -0700 (PDT)
Message-ID: <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
Date:   Sun, 2 Oct 2022 19:56:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To:     duoming@zju.edu.cn
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
 <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2022 6:50 PM, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Sun, 2 Oct 2022 10:12:15 -0700 James Smart wrote:
> 
>> On 10/1/2022 5:19 PM, Duoming Zhou wrote:
>>> The function lpfc_poll_timeout() is a timer handler that runs in an
>>> atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
>>> As a result, the sleep-in-atomic-context bug will happen. The processes
>>> is shown below:
>>>
>>> lpfc_poll_timeout()
>>>    lpfc_sli_handle_fast_ring_event()
>>>     lpfc_sli_process_unsol_iocb()
>>>      lpfc_complete_unsol_iocb()
>>>       lpfc_nvme_unsol_ls_handler()
>>>        lpfc_nvme_handle_lsreq()
>>>         nvme_fc_rcv_ls_req()
>>>          kzalloc(sizeof(.., GFP_KERNEL) //may sleep
>>>
>>> This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
>>> GFP_ATOMIC in order to mitigate the bug.
>>>
>>> Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>> ---
>>>    drivers/nvme/host/fc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>>> index 127abaf9ba5..36698dfc8b3 100644
>>> --- a/drivers/nvme/host/fc.c
>>> +++ b/drivers/nvme/host/fc.c
>>> @@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>>>    	lsop = kzalloc(sizeof(*lsop) +
>>>    			sizeof(union nvmefc_ls_requests) +
>>>    			sizeof(union nvmefc_ls_responses),
>>> -			GFP_KERNEL);
>>> +			GFP_ATOMIC);
>>>    	if (!lsop) {
>>>    		dev_info(lport->dev,
>>>    			"RCV %s LS failed: No memory\n",
>>
>> I would prefer this was fixed within lpfc rather than introducing atomic
>> allocations (1st in either host or target transport).  It was introduced
>> by lpfc change in irq handling style.
> 
> Thank your for your reply and suggestions!
> 
> Do you think change the lpfc_poll_timeout() to a delayed_work is better?
> 
> Best regards,
> Duoming Zhou

as a minimum: the lpfc_complete_unsol_iocb handler should be passing off 
the iocb to a work queue routine - so that the context changes so that 
either nvme host or nvmet ls callback routines can be called. If 
possible, it should do the axchg alloc - to avoid a GFP_ATOMIC there as 
well...

It's usually best for these nvme LS's and ELS's to be done in a slow 
path thread/work queue element. That may mean segmenting a little 
earlier in the path.

-- james

