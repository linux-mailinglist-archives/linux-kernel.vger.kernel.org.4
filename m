Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350346814F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbjA3PZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbjA3PZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:25:04 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7817C642
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:25:03 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id k13so1959800iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIj6X5EQwU+zt2s2NVZaRGj2fHnmi4rvaR46C6Ts9ik=;
        b=srycCoZrz0D3cJQSJ5yEDD/NV+aTBOmA3DQhNqwE7koP7/SmweBb/Cg4O+hRL9+LvQ
         bty4zWDoo7vW7Xu+vGYrEG3NnDiGoL+oNRUw6jbyMK4TIV5tC8/amUDemlS+gTvRrewr
         E4KbqAZqTQXc+wYchIfWKBy7n2631v+gB/NZ429SGxophek9eaTm5vW6rt6WuUH/JCKn
         CPbjs/8UYbniaCs8i1DEgOa0cIkC4NGSAC5qAS8eBaVIUh91xV/nwW6beZp/FTjYYs2I
         YjVwl+sBqOe3PDEl0VIO7GwVrzXvc3iIW5XXwvsfRG4sfZ7cgp+h8A1R0RZrm/gh59dE
         lTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIj6X5EQwU+zt2s2NVZaRGj2fHnmi4rvaR46C6Ts9ik=;
        b=BnT2IUDYB6vMnSRMC6eas5+pslBjeXe+HiYnelsLS9C9dMcnfLBUKpcWnd1SjN4RZh
         b55BFN/wgf5mmQuq/DAUFwX6IIs8GloUhRxPw0Eytftj/J7laGyRRLoFzL0l7vNz1avC
         7QuudYlq4koZlNi9cdL5EAr4WQhpyLifAX7bjQiBYHveI5gpno9kMa2/Zao37FQ05H62
         fPVGrrADgP+mHaZyQOBa4YQ4lwtpW+fcSaKafYZ3+To8EpNhMpxcALXjT7MmIXk6X8gn
         ch6j6mEDV4Wy61no7HsHGh4rnHqS9LCYpPSBnEqRvBnoD88WihquwnayUWHL0msgN5w5
         iVRQ==
X-Gm-Message-State: AO0yUKVJa1RwxEryGfPJjQlIbrsQ70RhEXQYtrITWLEXVecHlinkH6s9
        po6A4IAC600mJACByER7wv3lew==
X-Google-Smtp-Source: AK7set+2i+bZZBzscJGtyJR5TloQY3GR5UiWEDoXi8ZWM0dmD4MRY9y3627VHwgMUlrFjilmS2AJKw==
X-Received: by 2002:a5e:dc04:0:b0:718:2903:780f with SMTP id b4-20020a5edc04000000b007182903780fmr1226779iok.2.1675092303105;
        Mon, 30 Jan 2023 07:25:03 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e5-20020a02a785000000b0039e07ca9ae5sm4648551jaj.113.2023.01.30.07.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:25:02 -0800 (PST)
Message-ID: <7a2f5b2f-3ed9-eabb-6c9b-dcb2bfe82a08@kernel.dk>
Date:   Mon, 30 Jan 2023 08:25:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
 <20230123190954.5085-1-linux@zary.sk>
 <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
 <20230130064815.GA31925@lst.de>
 <569cb9ba-52d6-da73-dba0-cc62c91f6db2@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <569cb9ba-52d6-da73-dba0-cc62c91f6db2@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 12:10 AM, Damien Le Moal wrote:
> On 1/30/23 15:48, Christoph Hellwig wrote:
>> On Sun, Jan 29, 2023 at 08:44:06PM -0700, Jens Axboe wrote:
>>> I would prefer if we just delete it after merging this one, in the same
>>> release. I don't think there's any point in delaying, as we're not
>>> removing any functionality.
>>>
>>> You could just queue that up too when adding this patch.
>>
>> I'd prefer to just deprecate.  But most importantly I want this patch
>> in ASAP in some form.
> 
> I will queue it. But I think it needs a follow up to result in something
> consistent with KConfig. So either deprecate or delete PARPORT. I can queue the
> deprecate patch and delete in 6.4, even though I share Jen's opinion to simply
> delete directly. I am still fine either way.
> 
> Jens,
> 
> If you are OK with that, can I get your ack for the deprecate patch ? Unless you
> prefer taking it through the block tree. Either way is fine with me.

Yeah I'd be happy to ack that, did you post it? You can add my ack to the
new driver, fine with that now.

-- 
Jens Axboe


