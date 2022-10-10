Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED55F9BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiJJJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiJJJbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:31:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB753A6D;
        Mon, 10 Oct 2022 02:31:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q7so10093642ljp.3;
        Mon, 10 Oct 2022 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Fxn9QGVaJXGqKZtoP2lqUpTx+oEOE+k+RPuApWc6uU=;
        b=JCmAAVoS44/DnHekgmFzrD1tPDH1TA98QCvrSnmXQmFyvvUJqb6xpiKTeSIKqZklB9
         OGgSEXHeMTuJvXnHMWwAup8jGz4ZHTA16fAcZz0s80U0FaixTcxOq9wb8SgKYmW8W2yu
         Tl/XRSpFPA0kUVw4Z7ZWb7vwmI5UxGrZtPSczQu3AvzfDVCsiy5EcGHuzM5PHu746XIi
         UIdvbx4KmSHImfJn73ngUIBDvWpK3Mp8OG7N8zPm9/bWd/HO0kVKP/JUB9GNS0Ll4Isc
         7F8pibssDmri/SGCAjTcoWcpIJIRL36Tm26H03MYMTErNJeVzLd0dH9ql7JQp6uV0uSG
         7KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fxn9QGVaJXGqKZtoP2lqUpTx+oEOE+k+RPuApWc6uU=;
        b=N2IBsQMAqiBStBGZa3qyS5zfh4MStikqGnBTfMgWHJVt0lhPwcVdMJ24cxIqI5FkJ9
         cjF8EYuUPnbBg7BAaTz9mIJJqQDguAGBqtjkJyW1qEXr2TIcYXGROY0VXiOEKuItzZAE
         LP3U/AbKcdqAbprASg7/2i/VpmEs7fIxbOcpRzk5vDhwDxSXcfjR/G+CvONlBiyYRHaB
         bGwqD4DrXUgJiEkW++MmmrYXzaTRqSf9Rqw32QPreYtRj/PK9Vq6PFg8lr1afkicH4fW
         p2X22qFPvcvE0wXr5l6Ugu4ta0HV6SPW7RbM9gJcyQiuyRzcBAYO8rOZkW6pt144r1BW
         00Rw==
X-Gm-Message-State: ACrzQf24edJUEKLJplGn0U8Jg/X+i99Y61q2wi0e3Hrg8yrVkJoKurrE
        jyDphG34CD3tRfEUQohUmVs=
X-Google-Smtp-Source: AMsMyM5uk+BxY3P5FJSIs1jXqHpku1u/F3VyA+hps4sTFTLfZ+dRecc9NsDiWUsQ1AePKbwW2UMQTg==
X-Received: by 2002:a2e:9d88:0:b0:26a:95c1:218f with SMTP id c8-20020a2e9d88000000b0026a95c1218fmr6351200ljj.223.1665394267448;
        Mon, 10 Oct 2022 02:31:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p4-20020a2ea4c4000000b002682754293fsm1612237ljm.1.2022.10.10.02.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:31:06 -0700 (PDT)
Message-ID: <87ac9a5e-b5ba-82f3-c00c-75d5e6f01597@gmail.com>
Date:   Mon, 10 Oct 2022 12:31:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 5/5] MAINTAINERS: Add KX022A maintainer entry
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <08ccdc318b448eb69c82efc82adcd044536df4af.1665066397.git.mazziesaccount@gmail.com>
 <20221009133836.4266fbeb@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221009133836.4266fbeb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/22 15:38, Jonathan Cameron wrote:
> On Thu, 6 Oct 2022 17:38:34 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Add maintainer entry for ROHM/Kionix KX022A accelerometer senor driver.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> I can also add myself as a maintainer instead of a reviewer if it better
>> suits iio maintainer. I however don't plan setting up my own public
>> repository and hope the further patches will be merged via IIO tree.
>>
>> So, as Geert once explained to me - In that case the difference between
>> me as a maintainer vs. a reviewer would be only really relevant to the
>> subsystem (in this case IIO) maintainer. The subsystem maintainer who
>> merges patches is allowed to take in changes acked by downstream
>> maintainer w/o obligation to do thorough review. (Downstream maintainer is
>> to be blamed if things explode :]). If ack is given by a reviewer, then
>> the subsystem maintainer has the full responsibility and should always
>> do the review. Or - this is how I remember our discussion went - feel
>> free to correct me if I am wrong :] In any case - please let me know if
>> you'd rather see M: not R: in front of my name for the kx022a.
> 
> 
> Entirely up to you.  I tend to take a look at all IIO patches but will
> take a less detailed look if there is a tag from someone I've built
> up trust with - doesn't matter if they are a maintainer of a particular
> driver or not. I only ever look at MAINTAINERS when sending out patches,
> never when reviewing except to perhaps moan that someone wasn't cc'd
> who should have been!

In that case I'll keep the R as I have done with the other corners I've 
touched.

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

