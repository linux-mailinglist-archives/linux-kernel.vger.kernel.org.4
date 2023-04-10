Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2298B6DC992
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjDJQxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjDJQxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:53:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B01FDD;
        Mon, 10 Apr 2023 09:53:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g19so50126495lfr.9;
        Mon, 10 Apr 2023 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681145628;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5qsWKuBZDTHzznDI2xsHIh3+ApXDvtqkntFHb7ykBE=;
        b=KqqLmUOnXiAMyo2m426DfQlLDtzOQxSRV4HWdjsAyNBi+lw1/xxx+5EAXwJuSrebEO
         cnxwWSJ5/IcDUe2MNAxf6iCELn+HgWWcT+LxI+NMH4gPXdrAforrc9CvXKYNtZXnbQT6
         hVrqSBgjBKyDG3Vf6n1QzDx4n+4Uz5PMUpkzgMIuogy2FXozyevzkbNDIQrTFCIWX9rX
         b/gsfTx+pYLi65kOVt0I2HmqJr7bpakOKmIU6Xzwp2+5BRLv6JDxVsY+8Qn7eL9psh4W
         mWS5iLQkkk0NI9xGFfkSBDFDj+U7mKPGaD5e0AVQc4sPuW6ZX1fpovyYmSuYNK0mfqEr
         BqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145628;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5qsWKuBZDTHzznDI2xsHIh3+ApXDvtqkntFHb7ykBE=;
        b=luAp1pSQTTW4sAKIBxuPHMLLMz/Sip7xSAePAt5PWBNgWTQw97qGMu1wK18J1oQv+q
         fUCtFwF4lI9f9LYCoYLj/8hmCKhyK+n1LQ4s7km7PrWQGuQMM8+h35plH3/2pgos9uCM
         5qTytb12MOkxEtxiuXPD/vbpJPD57oLLUicOssBiaVYBKXmDap2vUdAz0Sf1S/ZkZTaW
         sMHYjEp/jIze7X1OV2k/WXYTreEHa2g0GQGaGJ/ZHw02y9qTIjR589q05hf0XkLhl6co
         gfpivSfFE4mIfYZWwoDvpzJ1HeyPlgeKPGJvILWX+467asKpMdqlybgcT2cfA9Ox794B
         ic5A==
X-Gm-Message-State: AAQBX9ehymDH4OrNhfLE0PF2Xl/IDKJz5hFqPk8JkFqWzF9Y0z6f4Jbk
        FD9wWR97hlG6RZofz79OQQY=
X-Google-Smtp-Source: AKy350ZYc1L5J2DjeaJf1WdOF95Azezf3RiReT+spGKrg7MSGFrXyunKucDNGWeFWkubnWDqZ3vzTQ==
X-Received: by 2002:ac2:4d12:0:b0:4e8:4a21:9c92 with SMTP id r18-20020ac24d12000000b004e84a219c92mr3493103lfi.4.1681145627587;
        Mon, 10 Apr 2023 09:53:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id z11-20020ac2418b000000b004eb2f35045bsm2190273lfh.269.2023.04.10.09.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 09:53:47 -0700 (PDT)
Message-ID: <65e06627-c368-d081-e18f-a45f245c37ab@gmail.com>
Date:   Mon, 10 Apr 2023 19:53:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
 <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
 <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
 <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
 <7c71d182-2ac5-b01e-2875-5060fb509056@roeck-us.net>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
In-Reply-To: <7c71d182-2ac5-b01e-2875-5060fb509056@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 17:40, Guenter Roeck wrote:
> On 4/10/23 01:19, Matti Vaittinen wrote:
>> to 6. huhtik. 2023 klo 16.43 Mark Brown (broonie@kernel.org) kirjoitti:
>>>
>>> On Thu, Apr 06, 2023 at 11:00:02AM +0300, Matti Vaittinen wrote:
>>>> ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
>>>>> On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:
>>
>>>>> It can also try to avoid
>>>>> interacting with hardware if that might not work.
>>>
>>>> It'd be great to have documentation / specification for sending and/or
>>>> handling the regulator events. I don't think we currently have such.
>>>> As far as I understand, the notifications can be picked up by all
>>>> consumers of a regulator. I am a bit worried about:
>>>> a) Situations where notification handlers 'collide' by doing 'actions'
>>>> which are unexpected by other handlers
>>>
>>> I'm not sure what you're expecting there?  A device working with itself
>>> shouldn't disrupt any other users.
>>
>> I have no concrete idea, just a vague uneasy feeling knowing that
>> devices tend to interact with each other. I guess it is more about the
>> amount of uncertainty caused by my lack of knowledge regarding what
>> could be done by these handlers. So, as I already said - if no one
>> else is bothered by this then I definitely don't want to block the
>> series. Still, if the error handling should be kept internal to PMBus
>> - then we should probably either say that consumer drivers must not
>> (forcibly) turn off the supply when receiving these notifications - or
>> not send these notifications from PMBus and allow PMBus to decide
>> error handling internally. (Again, I don't know if any in-tree
>> consumer drivers do turn off the supply regulator in error handlers -
>> but I don't think it is actually forbidden). Or am I just making  a
>> problem that does not exist?
>>
> 
> For my part I (still) don't understand why this is considered a problem
> for this driver but not for all the other drivers reporting various
> error conditions to the regulator subsystem. At least some of them
> also have programmable reaction to such error conditions.

I may not know the drivers you're referring to. And, as I said, maybe 
there is no problem.

To explain why I asked this question for this driver:

What caught my attention was use of the REGULATOR_EVENT_*_WARN flags, 
which were originally added so regulators could be flagging 'not yet 
critical'-errors Vs. the other, older REGULATOR_EVENT_* flags. From the 
discussions I have understood the older flags were informing severe 
hardware failures where system is typically thought to be no longer 
usable. I have understood that the most likely handling for such 
notification is shutting off the regulator. I have further understood 
that there are not many consumers doing handling of these events. (This 
is all just my understanding based on discussions - take it with grain 
of salt).

I was the one who added these warning level notifications. Thus, I have 
been following (only) use of those warnings. I have no proper insight to 
existing drivers using all these flags.

When grepping for the WARNING level regulator events I can find 
following drivers:
drivers/regulator/bd9576-regulator.c
drivers/regulator/max597x-regulator.c
drivers/regulator/tps65219-regulator.c

The difference (in my head) between these and PMBus-core is that these 
are very specific PMIC ICs. The board designer should have a good 
understanding which of the power-rails may have 'warning level' 
failures, and which errors are 'critical'. They should select and set 
the IRQ limits and error severities in the device-tree accordingly.

PMBus core (again, in my head) is more generic purpose system. This is 
why I originally asked if the 'error severity' in PMBus specifies also 
the error handling - and if these regulator notifications map to 
intended handling. Now, after this discussion I think that:

PMBus has it's own error-handling which is implemented independently 
from these notifications. This handling should not be messed-up by 
regulator consumers, for example by touching the regulator state.

This is what made me think sending regulator notifications might not be 
the best approach - (but as I said, I may be wrong. I am no longer sure 
what kind of handling there is expected for these events. Furthermore, 
as we see below, I did not find in-tree consumers taking "radical" 
actions when receiving the notifications).

Yep, I didn't find other in-tree consumers for these notifications except:
drivers/usb/host/ohci-da8xx.c

(I was not thorough so may have missed some, but seems there is not many 
in-tree consumers.)

I did only a very very brief shallow peek but it seems to me that even 
there driver only sets a flag - which is used in debug message. (I may 
have missed something here as well).

Judging this it seems to me that, at the moment, these notifications are 
mostly ignored by consumers - and they are sent by only a handful of 
devices. There probably exist some downstream users for those, but I 
have not heard of them. Maybe they are only used on very specific 
systems. This could explain why there has been no problems.

I know, I know. Lot's of guessing, assuming and hand waving. Sorry :/

Yours,
	-- Matti.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

