Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5945D66E7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjAQUlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjAQUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:35:51 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E52A17F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:21:10 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h26so15873795ila.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Dudq/IZ3pMnxQipACHsMz8BxYg84kEbOIRkYl+isuw=;
        b=vl8XuKsl9OlNroWuZnXukD8WH0O6Ff7x6kB4sDBWtSpcTbCTdLQJ/mWp6nGKUfUJ8P
         H8fr0NczwkmFozXi6PhI91cqWp/yXcLqZj/PuyUW02RzUSylvGsd9Q1ukW0O42tp3DLt
         /A6RhI1zKoXwTYFlCv0xDwqp6tNu3qTLMwO/dEZAQ9rGTNNFa/WnEGi/I4mf8K/kqI18
         XAt/iBITnHvrI24105yj2W8WxpFFYQoSCTmhtzUS5f94BDfBsNcq7tAhYgzQYW+3Uxn9
         rhUnek5HiHsnXfvLQ0T4VUiK4orV38prgV8Fz1hgcrR1HEHO3XJeEPE86p6+Kfv4OSF1
         QSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Dudq/IZ3pMnxQipACHsMz8BxYg84kEbOIRkYl+isuw=;
        b=1r0hWUyqWPBNZTJNy9t8uSribyt8QKmP5Ji0kCcODY/VtP7vjHrwVgk27CiZgjOK4p
         /BDfoxJq/6p/RfEwX/nI/aG1++CWc8Ypxy2O6htPieHlx0qR+V/+gWD5hmb+ddmNqSA5
         Ku/ErOywcISyowji3E1DCoDzLvgghmV94n+u8PdzvJCEFwOnEu771csYa3ayBakN5She
         /rtC1Zziyx/K6k/ze5MDbNYmMFC68cQiuQbXY1YFF5TS7BaTQxvQALrylfVab5ZmmxSF
         TRxVnqaBruzqR7Fp/tVNcA5qPmvRI5ihhkcpYtdYeMO7XUGS+nF1LyjUYtQXr0yLOn3I
         3rFA==
X-Gm-Message-State: AFqh2kpGVPe1uwl5zP+FdZxdC7sQFqneF9C+lcszZjtn1PlFumT4kh6g
        14hHWz5pm6wBaySB6x0pd7u68A==
X-Google-Smtp-Source: AMrXdXvBiRQtBWfFScJjVhXsnpbIDzbalKWTgtRqn2SowznS9hWQKhuL9agF1vX0NSjbHznhYhRieQ==
X-Received: by 2002:a92:dc0e:0:b0:302:e4c8:dace with SMTP id t14-20020a92dc0e000000b00302e4c8dacemr3385670iln.22.1673983270145;
        Tue, 17 Jan 2023 11:21:10 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id n5-20020a056638110500b00374fe4f0bc3sm9649869jal.158.2023.01.17.11.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:21:09 -0800 (PST)
Message-ID: <8c819213-b820-0ff3-b2c4-d9af1b6b3f83@linaro.org>
Date:   Tue, 17 Jan 2023 13:21:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 07/28] mailbox: Allow direct registration to a channel
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-8-quic_eberman@quicinc.com>
 <942f20cc-87d3-d014-1527-8d3d3e1ae44b@linaro.org>
 <8f47229a-2785-5f54-f7d1-a42299de64fe@quicinc.com>
Content-Language: en-US
In-Reply-To: <8f47229a-2785-5f54-f7d1-a42299de64fe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 11:57 AM, Elliot Berman wrote:
> 
> 
> On 1/9/2023 1:34 PM, Alex Elder wrote:
>> On 12/19/22 4:58 PM, Elliot Berman wrote:
>>> Support virtual mailbox controllers and clients which are not platform
>>> devices or come from the devicetree by allowing them to match client to
>>> channel via some other mechanism.
>>
>> The new function behaves very much like mbox_request_channel()
>> did before.
>>
>> The new function differs from omap_mbox_request_channel() in that
>> it can change the if chan->txdone_method is TXDONE_BY_POLL, it
>> is changed to TXDONE_BY_ACK if the client's knows_txdone field is
>> set.  Is this OK?  Why?

Sorry, reading that now, I see I placed an "if" in the wrong spot.

> Both of the current drivers that use mbox_bind_client use TXDONE_BY_IRQ, 
> so this doesn't cause issue for checking whether the client has 
> txdone_method.

I'm not so sure, but it's on you to make sure you don't break
anything...  I see only two spots where TXDONE_BY_IRQ is set,
and TXDONE_BY_IRQ seems to be set when channels are freed.

I spent (too much) time trying to track this back but I'm
giving up.  If you're sure it's correct, I accept that...

>>
>> It also assumes chan->mbox->ops->startup us non-null (though that
>> isn't really a problem).
>>
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>>   drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
>>>   drivers/mailbox/omap-mailbox.c | 18 ++-----
>>>   drivers/mailbox/pcc.c          | 18 ++-----
>>>   include/linux/mailbox_client.h |  1 +
>>>   4 files changed, 76 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>>> index 4229b9b5da98..adf36c05fa43 100644
>>> --- a/drivers/mailbox/mailbox.c
>>> +++ b/drivers/mailbox/mailbox.c
>>> @@ -317,6 +317,71 @@ int mbox_flush(struct mbox_chan *chan, unsigned 
>>> long timeout)
>>>   }
>>>   EXPORT_SYMBOL_GPL(mbox_flush);
>>> +static int __mbox_bind_client(struct mbox_chan *chan, struct 
>>> mbox_client *cl)
>>
>> There should be an unbind_client() call.  At a minimum, you are
>> calling try_module_get(), and the matching module_put() call
>> would belong there.  And even though one might just call
>> module_put() elsewhere for this, it would be cleaner to have
>> a function that similarly encapsulates the shutdown call
>> as well.
> n
> The function for this is "mbox_free_channel".

My point is about the way you are abstracting the "bind" operation
as a (now encapsulated) part of requesting the channel.  Yes, when
mbox_free_channel() is called, it effectively "unbinds" the channel.
But you're creating a "bind" abstraction, where it's not explicit
that you're requesting the channel.  I'm suggesting you also create
an "unbind" operation to reverse that.

This is more important for the mbox_bind_client() call than 
mbox_request_channel().  (And by the way, it looks like
pcc_mbox_free_channel() doesn't call pcc_mbox_free_channel()
as it should, but this unfamiliar code...)

And... it's weird to me that gh_rm_drv_probe() calls gh_msgq_init()
(to initialize the Gunhah message queue code), but then has to
call mbox_free_channel() *separate* from gh_msgq_remove(); the
free channel (or better, unbind client) should happen in the
message queue code.

It's not a critically important point, but now at least I hope
you understand what I'm trying to say.

					-Alex
> 
> Thanks,
> Elliot

