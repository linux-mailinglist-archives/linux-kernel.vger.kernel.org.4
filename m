Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1274874FB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGKWrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGKWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:47:50 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE536E60;
        Tue, 11 Jul 2023 15:47:48 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a3efee1d44so3508985b6e.3;
        Tue, 11 Jul 2023 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689115668; x=1691707668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpcCgQS0gXCD+hvSguR3UnFG1qnT0lm+T8n1vVCxIxM=;
        b=KjTLIEMy/UOKJS1nUesRrgNqETtpUU0ym+GtGAS0nFpmlOsPFT0VC/jMhiTqKwR7x3
         tfYaqWNaR4ur3HpMyd3W+6YOkE561EpXrBmhhMWYXTBP6LnMYlvWxTzwOFmFqdsnEwcL
         snkaXVqvV4e1gS6bEc5wMcRFH41l/KzwrKQwnftmp4+xhprfLzdF/PHafuYWzblnuGe5
         3paEvWudVifKhm1nRSzBUrntu6IUDNQ7HTI0uIKEKGkRJMNXX5Ovimtp460oe/LG+pBA
         Y8okBDt7o/qGr9yFlfPgtAsXL6pErNaLJzgxtAy+EnUPM/DBWFzas+/8GvI3k96PWhTM
         W8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689115668; x=1691707668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpcCgQS0gXCD+hvSguR3UnFG1qnT0lm+T8n1vVCxIxM=;
        b=Ws/s8Od7gKKUHof1aS6a9pLtnTFiflWWTygt1ay/2KvHcWdG58/O2DXPSPd3UepCDs
         pJsflMgCz9PO6oFce3OuuRMWmxugC1SvVTNEu1bgPjeE02ZGSP03ftm7rqoAPrNUbo9E
         EuK3jmsompG+cpc4RGpsyLZY39qo23tqVQhx390EIbieFISHTBR2yMUWCByz4oGLXuQJ
         zjSoZO3R7qn0f9EIY4nmH5GnZMH/9IgEZkDHASeSk/LTT+JqxozD/WEo3XX45zcg/lGE
         c+3NY9XZZy1h+HqXDPlqokGPuYOcadmV/hfnCSe5Bw1bTXjvl7sLFMjK6fNBMOjxICBN
         lypg==
X-Gm-Message-State: ABy/qLaHlObQRytc23U621Dp8uhg8Xy+nKYI/6eMtORfMudm+QwqxEf4
        /gxK/Vjt90aargzPLOIv6eEuD4hT4o4=
X-Google-Smtp-Source: APBJJlHv0PeOyk7BhG/GOv1k9Z29OiBGd6p6xJrUCOn9UGhShD6VDfAqkzbNdM8f7Sm9K9D+9ipTOw==
X-Received: by 2002:a54:4f8e:0:b0:3a3:ffb7:a28 with SMTP id g14-20020a544f8e000000b003a3ffb70a28mr7749566oiy.45.1689115668098;
        Tue, 11 Jul 2023 15:47:48 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bv11-20020a05622a0a0b00b003fdebf1a634sm1580898qtb.75.2023.07.11.15.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 15:47:47 -0700 (PDT)
Message-ID: <0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com>
Date:   Tue, 11 Jul 2023 15:47:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
 <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2023 5:07 AM, Daniel Wagner wrote:
> Hi James,
> 
> On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
>> As much as you want to make this change to make transports "similar", I am
>> dead set against it unless you are completing a long qualification of the
>> change on real FC hardware and FC-NVME devices. There is probably 1.5 yrs of
>> testing of different race conditions that drove this change. You cannot
>> declare success from a simplistic toy tool such as fcloop for validation.
>>
>> The original issues exist, probably have even morphed given the time from
>> the original change, and this will seriously disrupt the transport and any
>> downstream releases.  So I have a very strong NACK on this change.
>>
>> Yes - things such as the connect failure results are difficult to return
>> back to nvme-cli. I have had many gripes about the nvme-cli's behavior over
>> the years, especially on negative cases due to race conditions which
>> required retries. It still fails this miserably.  The async reconnect path
>> solved many of these issues for fc.
>>
>> For the auth failure, how do we deal with things if auth fails over time as
>> reconnects fail due to a credential changes ?  I would think commonality of
>> this behavior drives part of the choice.
> 
> Alright, what do you think about the idea to introduce a new '--sync' option to
> nvme-cli which forwards this info to the kernel that we want to wait for the
> initial connect to succeed or fail? Obviously, this needs to handle signals too.
> 
>  From what I understood this is also what Ewan would like to have
To me this is not sync vs non-sync option, it's a max_reconnects value 
tested for in nvmf_should_reconnect(). Which, if set to 0 (or 1), should 
fail if the initial connect fails.

Right now max_reconnects is calculated by the ctrl_loss_tmo and 
reconnect_delay. So there's already a way via the cli to make sure 
there's only 1 connect attempt. I wouldn't mind seeing an exact cli 
option that sets it to 1 connection attempt w/o the user calculation and 
2 value specification.

I also assume that this is not something that would be set by default in 
the auto-connect scripts or automated cli startup scripts.


> 
> Hannes thought it would make sense to use the same initial connect logic in
> tcp/rdma, because there could also be transient erros (e.g. spanning tree
> protocol). In short making the tcp/rdma do the same thing as fc?

I agree that the same connect logic makes sense for tcp/rdma. Certainly 
one connect/teardown path vs one at create and one at reconnect makes 
sense. The transient errors during 1st connect was the why FC added it 
and I would assume tcp/rdma has it's own transient errors or timing 
relationships at initial connection setups, etc.

For FC, we're trying to work around errors to transport commands (FC 
NVME ELS's) that fail (dropped or timeout) or commands used to 
initialize the controller which may be dropped/timeout thus fail 
controller init. Although NVMe-FC does have a retransmission option, it 
generally doesn't apply to the FC NVME LS's, and few of the FC devices 
have yet to turn on the retransmission option to deal with the errors. 
So the general behavior is connection termination and/or association 
termination which then depends on the reconnect path to retry. It's also 
critical as connection requests are automated on FC based on 
connectivity events. If we fail out to the cli due to the fabric 
dropping some up front command, there's no guarantee there will be 
another connectivity event to restart the controller create and we end 
up without device connectivity. The other issue we had to deal with was 
how long sysadm hung out waiting for the auto-connect script to 
complete. We couldn't wait the entire multiple retry case, and returning 
before the 1st attempt was complete was against the spirit of the cli - 
so we waited for the 1st attempt to try, released sysadm and let the 
reconnect go on in the background.


> 
> So let's drop the final patch from this series for the time. Could you give some
> feedback on the rest of the patches?
> 
> Thanks,
> Daniel

I'll look at them.

-- james


