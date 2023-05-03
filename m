Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD26E6F612B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjECWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjECWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:21:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877DC83DD;
        Wed,  3 May 2023 15:21:19 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7515631b965so414605385a.0;
        Wed, 03 May 2023 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683152478; x=1685744478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qFMUK4gSXVCvFOIucsUQSFEP/01ciu1p1En0VOUwZ4=;
        b=KgD3uc7sXYULZb+YflsTVeS0uxsQ9iAY3rbcKLk9Xo5G6rL4b8qtc/wl8WRrH/aHC0
         78L8Jxz56jT4E8shMITwGb2nB5PnbIDE/Tp5pjCEC/drB8cDL4HmqbWfPlEwPCHu5BZO
         ubEGi5ZIrOE/5A3ZUY2L6S64PrO252rbzXFcuAs3W4xoOBO8lJpOdMyITwcnpX7BGEHS
         8Suxd03NF9gry8Q8Ym6fbmwF/bA9xnLwAGoGwaKy3q0m9IjnXIjORG2eDqZTP1z9vXeO
         YxspGNspdSMNcq9w6sp5SseY1dza38R2Hxbr0GcdoEe1a3G7ACA6SXoZufCFkjDfllED
         NmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683152478; x=1685744478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qFMUK4gSXVCvFOIucsUQSFEP/01ciu1p1En0VOUwZ4=;
        b=Z4VertvVLpjkoUXUX8NaqqrAnH7x/NFpgMPMRcECGz7VP+h7jcMmPXi+CpFS6vvjNV
         8IzcGWMf6GBB/DInGkGeHVDZsew75qRBqp0MLZlIuqXxhKaf0TLyL1Jeh4jb7ljjK7Bd
         o7PBiyJGK+kyNJlF1E+ds5inJEXLh+cEraRzpU+Q4rP2wIq94DHm4DbMtGgEf/3Hk/o4
         D4OPtxayv9vY90AtgdrPF3/aGkN+oVHSW1QqNHTY03a5rtuyYaKdukGCXDPH64w9pxIZ
         CHwRpzapS2Pz6jXYvPB13VX5Q6gih6ZnZXW1SjHM/OlndVRyY0tWyi/YG+NANkKtZSeH
         LJzg==
X-Gm-Message-State: AC+VfDyr5zOs++9qF2lReWzBfKtRf2YRgVVxesefIHRnVksDkPcBHSCX
        gXnMPNRNYSgFsXoF4vg4BkY=
X-Google-Smtp-Source: ACHHUZ7FN3yepJTfE9yjDHAPWtoFVMpOLH6qGhkyC1s2IYe78m9WyS1x4TzWuo1IrDWkT7oUTt/K/A==
X-Received: by 2002:a05:622a:1010:b0:3ef:3281:fb53 with SMTP id d16-20020a05622a101000b003ef3281fb53mr2620975qte.18.1683152478560;
        Wed, 03 May 2023 15:21:18 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id br40-20020a05620a462800b007435a646354sm11029538qkb.0.2023.05.03.15.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 15:21:18 -0700 (PDT)
Message-ID: <597ba853-1fe4-9263-c448-422b0c2a91d8@gmail.com>
Date:   Wed, 3 May 2023 15:20:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH 0/3] input: gpio-keys - fix pm ordering
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
References: <20230427221625.116050-1-opendmb@gmail.com>
 <CAGETcx-gDcqY7-_Ud0_rOtgvk7NbzevSa4UCV=NcqiV9zjAv7w@mail.gmail.com>
 <CAGETcx_xjNT1Tp0GeqoddFwGFpv3O33hZZpEiThNg1wwWcfEQw@mail.gmail.com>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <CAGETcx_xjNT1Tp0GeqoddFwGFpv3O33hZZpEiThNg1wwWcfEQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/2023 7:18 PM, Saravana Kannan wrote:
> On Mon, May 1, 2023 at 1:40 PM Saravana Kannan <saravanak@google.com> wrote:
>>
>> On Thu, Apr 27, 2023 at 3:18 PM Doug Berger <opendmb@gmail.com> wrote:
>>>
>>> Commit 52cdbdd49853 ("driver core: correct device's shutdown
>>> order") allowed for proper sequencing of the gpio-keys device
>>> shutdown callbacks by moving the device to the end of the
>>> devices_kset list at probe which was delayed by child
>>> dependencies.
>>>
>>> However, commit 722e5f2b1eec ("driver core: Partially revert
>>> "driver core: correct device's shutdown order"") removed this
>>> portion of that commit causing a reversion in the gpio-keys
>>> behavior which can prevent waking from shutdown.
>>>
>>> This RFC is an attempt to find a better solution for properly
>>> creating gpio-keys device links to ensure its suspend/resume and
>>> shutdown services are invoked before those of its suppliers.
>>>
>>> The first patch here is pretty brute force but simple and has
>>> the advantage that it should be easily backportable to the
>>> versions where the regression first occurred.
>>
>> We really shouldn't be calling device_pm_move_to_tail() in drivers
>> because device link uses device_pm_move_to_tail() for ordering too.
>> And it becomes a "race" between device links and when the driver calls
>> device_pm_move_to_tail() and I'm not sure we'll get the same ordering
>> every time.
>>
>>>
>>> The second patch is perhaps better in spirit though still a bit
>>> inelegant, but it can only be backported to versions of the
>>> kernel that contain the commit in its 'Fixes:' tag. That isn't
>>> really a valid 'Fixes:' tag since that commit did not cause the
>>> regression, but it does represent how far the patch could be
>>> backported.
>>>
>>> Both commits shouldn't really exist in the same kernel so the
>>> third patch reverts the first in an attempt to make that clear
>>> (though it may be a source of confusion for some).
>>>
>>> Hopefully someone with a better understanding of device links
>>> will see a less intrusive way to automatically capture these
>>> dependencies for parent device drivers that implement the
>>> functions of child node devices.
>>
>> Can you give a summary of the issue on a real system? I took a look at
>> the two commits you've referenced above and it's not clear what's
>> still broken in the 6.3+
>>
>> But I'd think that just teaching fw_devlink about some property should
>> be sufficient. If you are facing a real issue, have you made sure you
>> have fw_devlink=on (this is the default unless you turned it off in
>> the commandline when it had issues in the past).
>>
> 
> I took a closer look at how gpio-keys work and I can see why
> fw_devlink doesn't pick up the GPIO dependencies. It's because the
> gpio dependencies are listed under child "key-x" device nodes under
> the main "gpio-keys" device tree node. fw_devlink doesn't consider
> dependencies under child nodes as mandatory dependencies of the parent
> node.
> 
> The main reason for this was because of how fw_devlink used to work.
> But I might be able to change fw_devlink to pick this up
> automatically. I need to think a bit more about this because in some
> cases, ignoring those dependencies is the right thing to do. Give me a
> few weeks to think through and experiment with this on my end.
Thank you for taking a deeper look at gpio-keys, and for getting through 
the gobblety-gook description in my cover-letter ;).

Yes, the dependencies of children are not automatically inherited by 
their parents and it is not clear to me whether or not that should 
change, but it definitely creates a problem for the sequencing of 
gpio-keys device callbacks.

I initially prepared the second patch as a way to explicitly create 
device links specifically for the gpio-keys device from these child 
dependencies as a work around for the fw_devlinks being dropped. I don't 
really consider this a viable patch which is why I made it an RFC, but I 
hoped it would highlight the issue.

However, the regression actually occurs in v4.18 and fw_devlink isn't 
introduced until v5.7 so it is desirable to think about solutions that 
could be backported to older versions. This is why I provided the first 
patch for discussion. Again, it is not a desirable solution just an 
illustration what could be easily backported to restore the gpio-keys 
behavior prior to commit 722e5f2b1eec ("driver core: Partially revert
"driver core: correct device's shutdown order"") without affecting other 
devices.

Thanks again for your willingness to take the time to think this through,
     Doug

> 
> -Saravana

