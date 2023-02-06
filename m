Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2054368BF8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjBFOHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjBFOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:07:33 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2A3274AA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:04:57 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id r34-20020a05683044a200b0068d4a8a8d2dso3209177otv.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqCfgYIduMpW5p7a5hUsldl/3wfeQTqY76tooEP032g=;
        b=DnyGpXsFlpveu0IYQM1Xfx9HIIaoLeO8QN5tGRVRkU1waaDsD7k2MlmoY2PvSu/fUx
         EAgJoOhqef51u1Cebvfe6nMpHvPzOq5jmJvyZE90OzHlCeYb/KBZg6IriOX5jvpeHWhg
         GJxcqYXT8E9bRsPxbpNGMwLftCOptjcli/2Az1dHVC115LPYnZ1HU48Gnf5opwb1i38q
         J3T/ZemXPMYtg2BBLdKPn4lbc78600Hcc2FBYDoyD3QHLxOUNkEsTGa3+BZYYoHJ6O+G
         osxpaTNE4ugadm22ElvMJDZli41BaG9TSjclZXoIzdiM1nskavJysfbsotpO9Dq28ZKr
         Nl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqCfgYIduMpW5p7a5hUsldl/3wfeQTqY76tooEP032g=;
        b=ImQY4KgK4lXWVUSZVu2Lvm4SovYxoQxCRjYELPOUst51/gIO9WJNpNjD/7leh7FyxE
         fEp5suR2A6CFwDm+C0NM4N5zOzSeQAjk4WWueiKDKyNn4zQ0Sw2CkaUOVOzOs3bG6sRm
         YwCKNsBlIgm/2BN7GPF8mc+tvKPJrc+PPIIvAtJ+HD5l0nEgqBGLE6V7gj3m8p84xjAm
         p+wmtC46r2puXDw6YMbYJbtKB8bYSKfvJfgoRdl0JfNOpfm7uIwRQzZCQLOraZvJzONi
         gZs1THGEYzFPXRP54C/cTqlPODbzI4wgUo2ruN+BVa+ZOM4xp/YiRoS1bRofUSc0rgbE
         nTNg==
X-Gm-Message-State: AO0yUKXTMZaTsVKBN3XLaqxVCbaISaG2Fo9E5TGFagWPXqYExkItb6ap
        bw3S72yl8gsfwkxGdsU42EQ=
X-Google-Smtp-Source: AK7set9SFjS0GJsFRorEMiNYTOeUZqrzss49nl/vIfEMjuHcvaD0UnXQMmuGOYXd1ZcVf1Ek/JAjYA==
X-Received: by 2002:a9d:1b27:0:b0:68b:dd09:2b6 with SMTP id l36-20020a9d1b27000000b0068bdd0902b6mr11374574otl.25.1675692284033;
        Mon, 06 Feb 2023 06:04:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d22-20020a9d5e16000000b006864b5f4650sm5030851oti.46.2023.02.06.06.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:04:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1ba5cedb-0f0f-69a9-96f0-d93ba060745e@roeck-us.net>
Date:   Mon, 6 Feb 2023 06:04:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     David Rau <david.rau.zg@renesas.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk> <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
 <Y9wQygzbFyOWl54r@sirena.org.uk> <20230204154222.GA877819@roeck-us.net>
 <OS3PR01MB6641CA1DB8524BCA0F9867D9CDDA9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
In-Reply-To: <OS3PR01MB6641CA1DB8524BCA0F9867D9CDDA9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/23 21:38, David Rau wrote:
> 
> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Saturday, February 4, 2023 23:42
> To: Mark Brown <broonie@kernel.org>
> Cc: David Rau <david.rau.zg@renesas.com>; perex@perex.cz; lgirdwood@gmail.com; tiwai@suse.com; support.opensource@diasemi.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP headsets when playing music
> 
> On Thu, Feb 02, 2023 at 07:36:42PM +0000, Mark Brown wrote:
>>
>>>> they have the potential to actually lock up are the
>>>> cancel_work_sync() calls but they were unchanged and the backtrace
>>>> you showed was showing the thread in the msleep().  My guess would
>>>> be that you've got systems where there are very frequent jack
>>>> detection events (potentiallly with broken accessories, or
>>>> possibly due to the ground switch putting things into the wrong
>>>> priority) and that the interrupt is firing again as soon as the
>>>> thread unmasks the primary interrupt which means it never actually stops running.
>>
>>> That is what I strongly suspect is happening. I don't know why
>>> exactly the interrupt is firing continuously, but the hang is always in msleep().
>>> One possibility might be that the event is actually a disconnect
>>> event, and that enabling and immediately disabling the ground switch
>>> causes another interrupt, which is then handled immediately, causing the hang.
>>
>> Could be.  I'd be willing to guess that it's not just one event but
>> rather a stream of events of some kind.  Possibly if it's due to the
>> ground switch it's spuriously detecting a constant stream of button
>> presses for the affected systems, which don't produce any UI visible
>> result which would cause users to pull the accessory for whatever
>> reason?  Whatever's going on I bet it's broken accessories triggering it.
>>
> 
>> That seems to be unlikely. The average number of crashes per affected system is 1.92, which points to something the users are doing and less to a broken accessory.
>> We do observe crashes due to broken accessories, but in those cases the number of crashes per system tends to be much > higher.
> 
>> Anyway, below is a patch with a possible fix. Of course, I still don't know what the patch originally tried to fix, so it might not do much if anything good.
> I added the software debouncing before insertion task to ensue the better compatibility of OMTP Jack.
>> For example, it keeps button detection in the interrupt handler to avoid dropping button events, so if spurious button detection as you suspected is indeed (part of) the problem we might still see a large number of interrupts.
> 
>> Guenter
> 
> Thanks a lot for your big efforts to implement the temporary fix and verifications.
> Would you please let me know the average number of crashes per affected system if you rollback to the pervious fix?
> Ref:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/codecs?id=2d969e8f35b1849a43156029a7a6e2943b89d0c0
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/codecs?id=06f5882122e3faa183d76c4ec2c92f4c38e2c7bb
> 

You mean just keep the above two patches and revert 969357ec94e6 ?
Sure, I can do that, but feedback from the field would take some
2-3 months. Is that what you recommend to do for now ?

Thanks,
Guenter

