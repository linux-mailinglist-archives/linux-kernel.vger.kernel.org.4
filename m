Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE226008F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJQInt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJQInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:43:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997D2B198
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:43:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m23so13094882lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p23jnQNQ6JC6/vxi7zw6GQkHOBG7ZpOlqxBcqeLSsBY=;
        b=erUNPQmYvqeKh2VbLgBzmizyrnnZC2uQQTGooV4d9SzFHe9PhjXSJP+wx5Q4CsmwAL
         +L5CkOJnS3sj/u3GC/TAuVjX6bahwzPV/EBPP6DWTEG0zccaEgZHk6uVyfiv8AKjeM/q
         vdSySjT5io0djVS8dfVGbB5+8ySG2LPhe8zTlFl/nX7UqcqmrUnqM7cImm5BIfSxyaj+
         OvVBpsAruCn5QZRqcU4h6vQ2cZp/kpoHmDRKodWilfkX6yEuk3Q37L5ILLLKk1GlbBSA
         dRlEliqqiKHeoLj/BV0q3AnXs2w44pDtYeBV+THjAuYw7phP9D+b7apSaYStTEEjKwsB
         AxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p23jnQNQ6JC6/vxi7zw6GQkHOBG7ZpOlqxBcqeLSsBY=;
        b=a2uE1sffOlOO/kzg1h4W3hUrnTkBzldctw4xfK+lWdnocWsnUJd78/PzLw9AY/ANcO
         PsS1sM+pMFObfEwGj4/lWI6sZblrcVg/zikn6gVNtMIWs+9GH32TxLI4gnfJK0nyJXTo
         w+Ci71nnXm3Qgvfx8qWndkScU0XtU+paxfJEsZ/rWVFsKhBQdSWkfinwNvZvSb2hlATO
         xQJkjOdOL5KdUnYCuA3+elEBQY/TLAqa8k29zxeEZCl7oNBdvqEC993ccYbGL1JLKc0I
         NKqYCwhGQ0FQ/bSPakPdqCIbAzrN59U8AqHKNNzkkj/YKX/cwDkgGUzwKIbEzg4S+Jsx
         wxLA==
X-Gm-Message-State: ACrzQf2EkHi8f+kFc9n1ByefBi7paJ6zbxw3Lqea7tUTT/zYwp6iSoFV
        hsPXmSHUWJWgEEyvCAsX+A4i7w==
X-Google-Smtp-Source: AMsMyM4+l6WqvfUjCX8XWsHsk6YAn7bdpDsUTToKjUg99qgXfKxK1XzYx4rgrLg29QGkKJDql77plw==
X-Received: by 2002:a05:651c:983:b0:26c:1c6b:8473 with SMTP id b3-20020a05651c098300b0026c1c6b8473mr3478239ljq.341.1665996222210;
        Mon, 17 Oct 2022 01:43:42 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r3-20020a2ea383000000b0026faf7bfa62sm1404744lje.76.2022.10.17.01.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 01:43:41 -0700 (PDT)
Message-ID: <a4a8557e-3fe7-356c-9434-01263f6d9771@linaro.org>
Date:   Mon, 17 Oct 2022 11:43:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 09/13] mailbox: Add Gunyah message queue mailbox
Content-Language: en-GB
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-10-quic_eberman@quicinc.com>
 <38a62751-799d-67ff-68d8-2946f2308e59@linaro.org>
 <c6c32b15-e32e-4362-00fc-e6710dca2546@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <c6c32b15-e32e-4362-00fc-e6710dca2546@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 01:32, Elliot Berman wrote:
> 
> 
> On 10/12/2022 2:47 PM, Dmitry Baryshkov wrote:
>> On 11/10/2022 03:08, Elliot Berman wrote:
>>> +
>>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>>> +{
>>> +    struct gunyah_msgq *msgq = data;
>>> +
>>> +    mbox_chan_txdone(gunyah_msgq_chan(msgq), 0);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static void gh_msgq_txdone_tasklet(unsigned long data)
>>> +{
>>> +    struct gunyah_msgq *msgq = (struct gunyah_msgq *)data;
>>> +
>>> +    mbox_chan_txdone(gunyah_msgq_chan(msgq), msgq->last_status);
>>
>> I don't quite get this. Why do you need both an IRQ and a tasklet?
>>
> 
> I've now tweaked the code comments now as well to explain a bit better.
> 
> Gunyah tells us in the hypercall itself whether the message queue is 
> full. Once the the message queue is full, Gunyah will let us know when 
> reader starts draining the queue and we can start adding more messages 
> via the tx_irq.
> 
> One point to note: the last message to be sent into the message queue 
> that makes the queue full can be detected. The hypercall reports that 
> the message was sent (GH_ERROR_OK) and the "ready" return value is 
> false. In its current form, the msgq mailbox driver should never make a 
> send hypercall and get GH_ERROR_MSGQUEUE_FULL because the driver 
> properly track when the message queue is full.
> 
> When mailbox driver reports txdone, the implication is that more 
> messages can be sent (not just that the message was transmitted). In 
> typical operation, the msgq mailbox driver can immediately report that 
> the message was sent and no tx_irq happens because the hypercall returns 
> GH_ERROR_OK and ready=true. The mailbox framework doesn't allow txdone 
> directly from the send_data callback. To work around that, Jassi 
> recommended we use tasklet [1]. In the "atypical" case where message 
> queue becomes full, we get GH_ERROR_OK and ready=false. In that case, we 
> don't report txdone right away with the tasklet and instead wait for the 
> tx_irq to know when more messages can be sent.

Can we please get some sort of this information into the comments in the 
source file?

> 
> [1]: Tasklet works because send_data is called from mailbox framework 
> with interrupts disabled. Once interrupts are re-enabled, the txdone is 
> allowed to happen which is also when tasklet runs.
> 
>>> +
>>> +    /**
>>> +     * EAGAIN: message didn't send.
>>> +     * ret = 1: message sent, but now the message queue is full and 
>>> we can't send any more msgs.
>>> +     * Either way, don't report that this message is done.
>>> +     */
>>> +    if (ret == -EAGAIN || ret == 1)
>>> +        return ret;
>>
>> '1' doesn't seem to be a valid return code for _send_data.
>>
>> Also it would be logical to return any error here, not just -EAGAIN.
>>
> 
> 
> If I return error to mailbox framework, then the message is stuck: 
> clients don't know that there was some underlying transport failure. It 
> would be retried if the client sends another message, but there is no 
> guarantee that either retrying later would work (what would have 
> changed?) nor that client would send another message to trigger retry. 
> If the message is malformed or message queue not correctly set up, 
> client would never know. Client should be told that the message wasn't 
> sent.

I see. msg_submit() doesn't propagate the error.

> 
> 
>>> +int gunyah_msgq_init(struct device *parent, struct gunyah_msgq 
>>> *msgq, struct mbox_client *cl,
>>> +             struct gunyah_resource *tx_ghrsc, struct 
>>> gunyah_resource *rx_ghrsc)
>>
>> Are the message queues allocated/created dynamically or statically? If 
>> the later is true, please use devm_request(_threaded)_irq and 
>> devm_kzalloc.
>>
> 
> With the exception of resource manager, message queues are created 
> dynamically.
> 
> P.S. Thanks for all the other suggestions in this and the other patches, 
> I've applied them.
> 
> Thanks,
> Elliot

-- 
With best wishes
Dmitry

