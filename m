Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E36DD273
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDKGKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDKGKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:10:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5A010C3;
        Mon, 10 Apr 2023 23:10:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o1so9019661lfc.2;
        Mon, 10 Apr 2023 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681193416;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex+N0NIjvQk04B4IFN9HJNETYsrKzDHTFohbiv4tHU8=;
        b=DOwBZUYXXB4W8pKOTWVWkycOB++XfX49k6hh7zYJ9aH85Ond5ZEX19/oipfUHcniTY
         IvpFDza1bXf3Mc8WA7L7pJ8r9m0DnzOGr8s/T8F1x9QN0W61k/rhfI6ux7NmnOBiOuBd
         NwOXMK7jYjUP2Oz8HIQ+q5epWS7GtiqbnrAP9aWgStkB8xvK3SigkQy1fORBMMjbbhwX
         1DwB4207gWk3L0yHYsJvqRCdi3d5uo9u0RExrHufr2CTUcVtLnzZEtX4y3duFjo6wL/l
         HiXrUgn3gC9rhwdTnXuOs3JbjUC0Jbh2YwIqB93WRgmAzFSptSMNHqUxJHqg9BcgiLK1
         fxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681193416;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex+N0NIjvQk04B4IFN9HJNETYsrKzDHTFohbiv4tHU8=;
        b=ndcXHKSuAofKiD0kk2xdeVoyp518W/kYrZ9/mFy0iXotmu+EwihgmF++cWtvKvcSrC
         bsAspVhj2UwzXt7fNYsNJOBXr4cvwx1CltjP+kiEEuquFHtDG9uBQIb1fIjXmTfQVKcQ
         Kl4702qe+Ul2w993Y7pdK8G3RGs2e44SCVbMbbukDx+sS21jT53qBrYiwZhQA8i/ZTus
         NlNVcs9/3BUKEFRje/5ODnKtK6X2kkKCphiML5upK4342M2BIw+n825NEJuwFm0Qi3bu
         wZjunuod7x2phlyItXS9PNhNIs4YHCTW3FyCPythwRhMfVBze5n0UHTFIPGIRMDaHbkM
         6WIg==
X-Gm-Message-State: AAQBX9ekMZVtFAFnySXEtvvwDsrRkGjb+yTNxjUGEAYVUIwnWgQM7HAP
        g4LeNfq5K5u/qKTFv/RPQnU=
X-Google-Smtp-Source: AKy350Yk3Bfy6WUXpX/hMKDXz7jR/yU6sHbJ5i17fbLCJ2FWBZHkLu3YE4vHxAK7PK+JGA+a2BSHZQ==
X-Received: by 2002:ac2:430c:0:b0:4ec:8816:f4fc with SMTP id l12-20020ac2430c000000b004ec8816f4fcmr1371204lfh.6.1681193415601;
        Mon, 10 Apr 2023 23:10:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w18-20020ac254b2000000b004ec89319b03sm873250lfk.211.2023.04.10.23.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:10:15 -0700 (PDT)
Message-ID: <8d1651b8-ceba-53ae-105b-e9ae8813b372@gmail.com>
Date:   Tue, 11 Apr 2023 09:10:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
 <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
 <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
 <7c71d182-2ac5-b01e-2875-5060fb509056@roeck-us.net>
 <65e06627-c368-d081-e18f-a45f245c37ab@gmail.com>
 <b49cc518-634e-4812-ae4a-ee6ec45b42f2@roeck-us.net>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
In-Reply-To: <b49cc518-634e-4812-ae4a-ee6ec45b42f2@roeck-us.net>
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

On 4/10/23 20:47, Guenter Roeck wrote:
> On Mon, Apr 10, 2023 at 07:53:46PM +0300, Matti Vaittinen wrote:
>> On 4/10/23 17:40, Guenter Roeck wrote:
>>> On 4/10/23 01:19, Matti Vaittinen wrote:
>>>> to 6. huhtik. 2023 klo 16.43 Mark Brown (broonie@kernel.org) kirjoitti:
>>>>>
>>>>> On Thu, Apr 06, 2023 at 11:00:02AM +0300, Matti Vaittinen wrote:
>>>>>> ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
>>>>>>> On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:
>>>>
>>>>>>> It can also try to avoid
>>>>>>> interacting with hardware if that might not work.
>>>>>
>>>>>> It'd be great to have documentation / specification for sending and/or
>>>>>> handling the regulator events. I don't think we currently have such.
>>>>>> As far as I understand, the notifications can be picked up by all
>>>>>> consumers of a regulator. I am a bit worried about:
>>>>>> a) Situations where notification handlers 'collide' by doing 'actions'
>>>>>> which are unexpected by other handlers
>>>>>
>>>>> I'm not sure what you're expecting there?  A device working with itself
>>>>> shouldn't disrupt any other users.
>>>>
>>>> I have no concrete idea, just a vague uneasy feeling knowing that
>>>> devices tend to interact with each other. I guess it is more about the
>>>> amount of uncertainty caused by my lack of knowledge regarding what
>>>> could be done by these handlers. So, as I already said - if no one
>>>> else is bothered by this then I definitely don't want to block the
>>>> series. Still, if the error handling should be kept internal to PMBus
>>>> - then we should probably either say that consumer drivers must not
>>>> (forcibly) turn off the supply when receiving these notifications - or
>>>> not send these notifications from PMBus and allow PMBus to decide
>>>> error handling internally. (Again, I don't know if any in-tree
>>>> consumer drivers do turn off the supply regulator in error handlers -
>>>> but I don't think it is actually forbidden). Or am I just making  a
>>>> problem that does not exist?
>>>>
>>>
>>> For my part I (still) don't understand why this is considered a problem
>>> for this driver but not for all the other drivers reporting various
>>> error conditions to the regulator subsystem. At least some of them
>>> also have programmable reaction to such error conditions.
>>
>> I may not know the drivers you're referring to. And, as I said, maybe there
>> is no problem.
>>
>> To explain why I asked this question for this driver:
>>
>> What caught my attention was use of the REGULATOR_EVENT_*_WARN flags, which
>> were originally added so regulators could be flagging 'not yet
>> critical'-errors Vs. the other, older REGULATOR_EVENT_* flags. From the
>> discussions I have understood the older flags were informing severe hardware
>> failures where system is typically thought to be no longer usable. I have
>> understood that the most likely handling for such notification is shutting
>> off the regulator. I have further understood that there are not many
>> consumers doing handling of these events. (This is all just my understanding
>> based on discussions - take it with grain of salt).
>>
>> I was the one who added these warning level notifications. Thus, I have been
>> following (only) use of those warnings. I have no proper insight to existing
>> drivers using all these flags.
>>
>> When grepping for the WARNING level regulator events I can find following
>> drivers:
>> drivers/regulator/bd9576-regulator.c
>> drivers/regulator/max597x-regulator.c
>> drivers/regulator/tps65219-regulator.c
>>
>> The difference (in my head) between these and PMBus-core is that these are
>> very specific PMIC ICs. The board designer should have a good understanding
>> which of the power-rails may have 'warning level' failures, and which errors
>> are 'critical'. They should select and set the IRQ limits and error
>> severities in the device-tree accordingly.
>>
>> PMBus core (again, in my head) is more generic purpose system. This is why I
>> originally asked if the 'error severity' in PMBus specifies also the error
>> handling - and if these regulator notifications map to intended handling.
>> Now, after this discussion I think that:
>>
>> PMBus has it's own error-handling which is implemented independently from
>> these notifications. This handling should not be messed-up by regulator
>> consumers, for example by touching the regulator state.
>>
>> This is what made me think sending regulator notifications might not be the
>> best approach - (but as I said, I may be wrong. I am no longer sure what
>> kind of handling there is expected for these events. Furthermore, as we see
>> below, I did not find in-tree consumers taking "radical" actions when
>> receiving the notifications).
>>
>> Yep, I didn't find other in-tree consumers for these notifications except:
>> drivers/usb/host/ohci-da8xx.c
>>
>> (I was not thorough so may have missed some, but seems there is not many
>> in-tree consumers.)
>>
>> I did only a very very brief shallow peek but it seems to me that even there
>> driver only sets a flag - which is used in debug message. (I may have missed
>> something here as well).
>>
>> Judging this it seems to me that, at the moment, these notifications are
>> mostly ignored by consumers - and they are sent by only a handful of
>> devices. There probably exist some downstream users for those, but I have
>> not heard of them. Maybe they are only used on very specific systems. This
>> could explain why there has been no problems.
>>
>> I know, I know. Lot's of guessing, assuming and hand waving. Sorry :/
>>
> 
> Oh, now the problem (though I still don't understand what the problem
> actually is) is extended to warnings. I thought you were concerned
> about errors.

Yes. I am concerned about errors - as I thought handling errors might 
have an impact to the regulator supply state. I don't see this as a 
problem with warnings.

It was the use of warnings that got this series in my mailbox. Hence 
this series caught my attention.

The only thing I could be concerned about with warnings is whether they 
are sent for problems that are actually errors. But even if they were, 
that would not really cause any issues outside the specific use-case. 
So, no. I am not really concerned about warnings but I tried to explain 
why I was commenting on this PMBus series as you asked that.

> Personally I think you are concerned about a non-issue, but without
> explicit guidance from regulator maintainers (and no clear definition if
> and when regulator notifications should or may be sent) I won't be able
> to apply this series.

Thanks Guenter. I value your opinion on this. (And there was _no_ 
sarcasm. I've learned that I am often discussing with people who have 
much broader understanding than I do, so I do truly appreciate hearing 
your opinion).

I think part of the problem is that we lack of insight as to how these 
notifications / errors are used. I am trying to clarify this. As a 
matter of fact, I today received an email that my talk proposal to ELCE 
was accepted. I am going to go through these notifications and error 
flags there, and I hope to be able to collect some feed-back as to how 
they are / can be utilized.

> Having said this, I find the whole discussion kind of surreal,

Sorry about that. What do you think I should've done differently? Do you 
think I should not have brought-up these questions? I have openly 
admitted I may not understand all the details and thus You as a 
maintainer are free to act as if I never asked a thing. I've explained 
why I think there is a potential problem - but if you or others do not 
see the issue, then it's your call to decide.

> especially since the PMBus drivers already report error states to the
> regulator subsystem using the get_error_flags callback, but it is what
> it is. Also, no, I won't revert that code without a clear explanation
> of the _actual_ (not perceived) problem that such a revert is supposed
> to solve.

I agree with you that these notifications and error flags go 
hand-by-hand. Actually, the use of (warning) notifications does more or 
less require using also the error flags (as we don't have a notification 
when things get back to normal). The flags do not require using 
notifications though, some consumers can do polling of flags.

Let's hope no problems with these error flags surface.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

