Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C770EF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbjEXH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbjEXH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:28:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855D90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:28:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f1411e8111so523017e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684913292; x=1687505292;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xma854wZg/j3dSWW85gZHGX8CceCdQFgSqI38gArUzE=;
        b=CbRnf+zgnJ6tfty/KxBoNeTJ/1h8SvkqHmQvuCxZiyuSnHxerVCEVMnGHEk+fC6nVf
         N4u3uYU6eBvDpnWyodMgc1dtdQd6sYtI5IzGpeCapa0DsnYmTVHkgZ5afILbh1LDDUGZ
         yDiKvJCZQyskyxk0IUxAMySw2CrU1Qncrfp7rBnGkZw8407luQ2QNTNTkNhJgftKThva
         eV0j9F1d0NaiijvvyhGs1qFY93eIuQFv8uJAZ2LDyuHrlP3IPsR1fEbQjdAOeIDgaEiH
         HO1basusLh+jPs5PvL1LXfnzxYOgcfOMIARDbcTzS18Wb5LNNP5liq3Jx1lih+3BpE5y
         MmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684913292; x=1687505292;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xma854wZg/j3dSWW85gZHGX8CceCdQFgSqI38gArUzE=;
        b=DRE1NIytyIA2G5TRSoBVC+hxhg8dL7ra0i1PSZ1fa/DcRByITuq7ylPtGsIrzTMsKM
         ltRg3q7NZbd7DqkPz/LvyrFUjW4F7nRXUNyknKgEoFSrmvN1n9kjDVeZPs0XjsSWltLf
         u3LVwQmooQpgieoYHH2PUfJrWbDJOzXEOlsa2TyVHSuIXUAqxarZ6A1f18fE7bw1nuE9
         ejeG1EDBAMlJfLH0Yq7KAkwJUacjVOo5+aCUqjvvXr5rxXP8azAyRwtPJQInagEnez4x
         CgxOJ5N7XMRqKZmV/dEoNvH52aXn5mBTI9eiHj3nnw0mir8jO7qQxgw7U+Y1K1r8LH6x
         kQ/A==
X-Gm-Message-State: AC+VfDwdaCSu5agjAjVjNazucVQMaXbTNBKBpCAviTJpme/N+/yf7Xjn
        o7kuin0jzmAYhB+RnyJlZEE=
X-Google-Smtp-Source: ACHHUZ70G6wCVJjotS+eOukCxLcNwUnaEWlGXJgEHvEJXYPMmSiTgVeczf/yj2Ogk+kXlMigsEw2FQ==
X-Received: by 2002:a19:7003:0:b0:4ef:eda6:c14 with SMTP id h3-20020a197003000000b004efeda60c14mr4676578lfc.35.1684913292039;
        Wed, 24 May 2023 00:28:12 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id q11-20020ac246eb000000b004f001b0eda2sm1618786lfo.56.2023.05.24.00.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:28:11 -0700 (PDT)
Message-ID: <5584a484-df7f-b927-9701-33dcea6230d0@gmail.com>
Date:   Wed, 24 May 2023 10:28:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, benjamin.bara@skidata.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
References: <9641aa06-4925-051c-2ebe-22e43bf9dd4f@gmail.com>
 <20230523115101.627722-1-bbara93@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v3 1/5] regulator: move monitor handling into own
 function
In-Reply-To: <20230523115101.627722-1-bbara93@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 14:51, Benjamin Bara wrote:
> Hi Matti,
> 
> thanks for the feedback!
> 
> On Tue, 23 May 2023 at 11:46, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> As far as I see, this changes the existing logic. Previously the
>> monitoring was unconditionally enabled for all regulators, now it gets
>> only enabled for regulators which are marked as enabled.
>>
>> Furthermore, if I am not reading this wrong, the code tries to disable
>> all protections if regulator is not enabled at startup(?)
>>
>> I am not saying this is wrong. I am just saying that things will
>> change here and likely to break something.
>>
>> There are PMICs like ROHM BD9576, where the protection can not be
>> disabled.
> 
> Thanks for letting me know! I dropped my initial "disable monitor while
> disabling the regulator" property, and activated it per default instead.
> But this basically means something like that will be required. I guess
> it might make sense to have a property which is called something like
> "monitor always on", to let the driver inform the core that the monitors
> cannot or should not be disabled, instead. > Except if you think there is a general problem with keeping monitors
> disabled while the regulator is disabled, then I might have to do it
> differently.

I am thinking that maybe the default should still be to not touch the 
monitoring unless explicitly requested. My thinking is that the hardware 
should by default be able to handle the voltage change / enable / 
disable etc while monitoring is enabled. Hardware which requires 
explicit monitoring disabling sounds (to me) like a 'design problem' and 
disabling the monitoring sounds (to me) like a workaround. I wouldn't 
make this workaround default. Furthermore, monitoring is a safety 
feature, and as such core should not autonomously disable it (unless 
such behaviour is requested). Well, experience has proven that my 
thinking is not _always_ right, so feel free to voice other opinions :)

>> I am unsure if we might also have cases where some regulator could
>> really be enabled w/o core knowing it.
> 
> Unfortunately, I am not 100% sure what you mean by that.

I was thinking of a case where regulator state is not readable - I'm not 
100% sure how core thinks of their state. Another case could be a 
regulator which is not registered to the core but shares monitoring with 
some other regulator. This falls under the common monitoring category 
mentioned below.

> On the da9063, for example, it might be possible that a monitor is
> activated by the OTP, without that the kernel actually activates it.
> I think it is not recommended, but it is possible.
> 
> 
>> There can also be a problem if we have hardware where monitoring is
>> common for all regulators, eg either globally enabled / disabled.
> 
> Yes, but I think in this case it should be the responsibility of the
> driver to ensure that either all or no regulator is monitored, because
> the same requirement is valid for implementing the protection ops.

If I didn't misread the code, the differences here are that existing 
"ideology" is to a) only touch the monitoring (enable/disable) when 
explicitly requested for a given level and b) knowing that all monitors 
that are requested to be enabled are enabled at the end of the probe.

In my eyes change a) is problematic. For example, if a board using 
BD9576 wants to have protection disabled via device-tree (let's assume 
there is a board where we know that some disturbance to voltages will 
occur under specific conditions) - it is very valid to complain 
disabling protection is not supported. Go fix your board design message 
needs to be given because protection can't be disabled. This is very 
different from case where we just try disabling monitoring because 
regulator is turned off. In latter case with BD9576 the failure to 
disable protection should just be silently ignored. When we use same 
callbacks for both the initial configuration and the runtime 
enable/disable/voltage-change handling the driver has no way knowing if 
this is an error or not. Writing this leads me back to thinking that the 
monitor configuration for enable/disable/voltage-change should be done 
via separate driver callback - that would allow driver to separate these 
use-cases. If this was change I wrote, I might try creating separate 
driver callbacks for 
enable/disable/voltage_change_start/voltage_change_done which get the 
initial monitor configuration (as was read from device-tree) as an 
argument. Do you think that could give the flexibility to handle all 
different hardware quirks?

The change b) does also have consequences. Some PMICs like the BD9576 do 
use same IRQ for indicating either ERROR or WARNING level problem. 
Whether to use WARNING or ERROR is selected at star-up when the 
device-tree flags are read. Eg, the .set_<XXX>_protection callbacks 
store the severity information (WARNING or ERROR) and complain if both 
are tried to be used. With the current approach we know the validity of 
this configuration is checked right when regulator is registered, not 
later at runtime when regulator is enabled.

Another example regarding design that uses the knowledge that all 
requested monitors are enabled when regulator is registered is BD96801 - 
which is not upstream (although I've had patches in my outbox for an 
year already waiting for permission from the HQ to actually send them... 
Don't ask...). This PMIC can configure fatality of the fault monitoring. 
This driver checks that all regulators did agree on whether to use 
PROTECTION or ERROR/WARNING level monitoring at the end of the probe - 
and toggles the IRQ fatality accordingly. I truly believe that 
out-of-tree drivers must not mandate upstream design - but I equally 
believe that we may see similar HW designs in upstream and considering 
this now makes sense :) Yes, in order to paper over b) a driver can for 
sure go and parse all the monitoring properties from device-tree itself 
and decide things based on that - but it might be quite a lot of 
duplicated code.

To sum up my view - I do definitely like the idea that core supports 
toggling the monitors for duration of enable/disable/voltage-change as 
this is needed by some real world ICs.

I, however, think drivers should be able to separate the "set the 
default monitoring config" request from the "change config to something 
we use for duration of this operation" - because the best monitoring 
config that is required for an operation may not be a "disable all". 
Hence, we should leave it for the driver to decide what config to set 
for the duration of an enable/disable/voltage_set-operation.

Furthermore, I believe the default should be "don't touch the 
monitoring" and not to try disable/enable it w/o explicit request.

Again, thank you for working on this and including me in the discussion :)

Yours,
	-- Matti



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

