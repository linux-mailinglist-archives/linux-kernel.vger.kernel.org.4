Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB25BB2DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIPTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiIPTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:37:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7FAB4D0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:37:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so37148248lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NNRdOM23izbKa+Aw8HpIWslxzvOiMKSIAdyLiMoAsLY=;
        b=bJAH2Y9xbr1n5XDwX8UeTmpgv4wdGkT9lZzLBx3S6rFymJ++hZ1xrtf7hN7kuMqFXh
         cOsuGtzExbdCCSdokmY+xaRjlgETCcUkGf2V3UhRjrTjOnA1fQ8omS48TtJ1KCM/8rRf
         k4JEWdmxsg/mmyX6RCWotMGEyx97qk7LCpbpR6eNJURg0Y16ECrZSbfRK80aD9c2M4mW
         LTnI8MVuLr7Ukn8gjzdWth8Jaut+zOpPINurTnUq0Eia+0r3uzupxDIV4rjJV9Xg427f
         6gyTC7/8sj3k4iuCIcrH2NBSTmBs7qpTImhs+d/cEJxWW1uWQcm6scaIWpsj51miKYF6
         AXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NNRdOM23izbKa+Aw8HpIWslxzvOiMKSIAdyLiMoAsLY=;
        b=7MGP8roxWXKx8r+Hxhf9bYCfSARDsZTbQQtSGw/F+XjbTPpRdZXx9Jb5G2JpK8GzDs
         T5eAdA5zxvWLbss+7ma7x48st67eEPV0mvVE+7O3Zfb1Rnem8xfZ3kgMfTiNZzasCWWU
         95TW9jaLUFnpVgkQG2Th6uw+rsoy915PM3Z+HBicIROn6l4Ua7iKKMS9qyl4TFwCp08i
         If0GJF/9NX47IWMOpZpSJMWMqMsTsFMXJgQQyciqlg0FWt2kyceWyjepoDSeNLGSd43C
         PArdu4BYXiPeKjC6oNSinr1XyJAo0D0jWtWdnyWA9MKRGVOC6joZbWMs0lJcn9E1i0J5
         GvYw==
X-Gm-Message-State: ACrzQf3jMgtOjAXhM8jz6u5HyzYjIw2eFkJFMqeoz28Z1iN671RXsKoR
        prOIegWRvwJIQISeDAOAtP4+UQ==
X-Google-Smtp-Source: AMsMyM6gQSiRwJwVgsqdmIJU+Z+pttmcsAlKrlWexGEqA1TZL8S6hua2dhvZHkzC2bbzLlgCQujTxg==
X-Received: by 2002:a05:6512:169b:b0:494:8305:ac77 with SMTP id bu27-20020a056512169b00b004948305ac77mr2042322lfb.172.1663357042902;
        Fri, 16 Sep 2022 12:37:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 11-20020a2eb94b000000b0026c3b5357d5sm455889ljs.68.2022.09.16.12.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 12:37:22 -0700 (PDT)
Message-ID: <41a2cc4b-2980-5743-1382-e5ba36331435@linaro.org>
Date:   Fri, 16 Sep 2022 22:37:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
Content-Language: en-GB
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
 <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
 <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
 <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com>
 <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
 <CAA8EJprBAtdWAGG=a7BYc_Zwx9B5Dqsy4n3dhvP5cA40agR8ew@mail.gmail.com>
 <CAK7LNARpPvBH0i55nD0v+8KDeqy2eK996TRhwE-KNAF+8mG3xQ@mail.gmail.com>
 <CAA8EJppdS4st0G21Nk1SU9fbXCcEefHO=8E=upOPdjgRYhPBLA@mail.gmail.com>
 <CAK7LNARZUkkyjUZCp5cXs_ROz+KzJPPGkoFpTKFXJaixXGofkw@mail.gmail.com>
 <CAA8EJpoDgHeYs2JwBwGksh10_5ZEQvJ7ARLig=HfX4K2uuL2XQ@mail.gmail.com>
 <CAL_JsqL=0G9nTwyCWy1TY5btvYO7CtGcZ4inok=u9mw4Da1b1Q@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAL_JsqL=0G9nTwyCWy1TY5btvYO7CtGcZ4inok=u9mw4Da1b1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 17:54, Rob Herring wrote:
> On Fri, Sep 16, 2022 at 9:21 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Fri, 16 Sept 2022 at 04:10, Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>
>>> On Thu, Sep 15, 2022 at 8:40 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> On Thu, 15 Sept 2022 at 07:51, Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>>
>>>>> On Sun, Sep 11, 2022 at 2:36 AM Dmitry Baryshkov
>>>>>
>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>
>>>>>> On Thu, 4 Aug 2022 at 18:27, Rob Herring <robh+dt@kernel.org> wrote:
>>>>>>>
>>>>>>> On Fri, Jul 29, 2022 at 1:46 AM Dmitry Baryshkov
>>>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>>>
>>>>>>>> On Fri, 29 Jul 2022 at 10:05, Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
>>>>>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
>>>>>>>>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> It is useful to be able to recheck dtbs files against a limited set of
>>>>>>>>>>>>> DT schema files. This can be accomplished by using differnt
>>>>>>>>>>>>> DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
>>>>>>>>>>>>> for some reason if_changed_rule doesn't pick up the rule_dtc changes
>>>>>>>>>>>>> (and doesn't retrigger the build).
>>>>>>>>>>>>>
>>>>>>>>>>>>> Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
>>>>>>>>>>>>> and dt-validate into a single new command. Then if_changed_dep triggers
>>>>>>>>>>>>> on DT_SCHEMA_FILES changes and reruns the build/check.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>   scripts/Makefile.lib | 14 ++++++--------
>>>>>>>>>>>>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>>>>>>>>>>>> index c88b98b5dc44..3df470289382 100644
>>>>>>>>>>>>> --- a/scripts/Makefile.lib
>>>>>>>>>>>>> +++ b/scripts/Makefile.lib
>>>>>>>>>>>>> @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
>>>>>>>>>>>>>   DT_BINDING_DIR := Documentation/devicetree/bindings
>>>>>>>>>>>>>   DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
>>>>>>>>>>>>>
>>>>>>>>>>>>> -quiet_cmd_dtb_check =  CHECK   $@
>>>>>>>>>>>>> -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
>>>>>>>>>>>>> +quiet_cmd_dtb =        DTC/CHECK   $@
>>>>>>>>>>>>
>>>>>>>>>>>> This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
>>>>>>>>>>>> always do just 'DTC'. I can fixup when applying.
>>>>>>>>>>>>
>>>>>>>>>>>> I'll give it a few days for other comments.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
>>>>>>>>>>> You do not need to re-run dtc.
>>>>>>>>>>>
>>>>>>>>>>> I guess the strangeness comes from the fact that you are trying to do the
>>>>>>>>>>>   two different things in a single rule.
>>>>>>>>>>
>>>>>>>>>> The issue is that with the current rules the dt-validate isn't
>>>>>>>>>> re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.
>>>>>>>>>
>>>>>>>>> Correct.
>>>>>>>>>
>>>>>>>>> What I said is like this.
>>>>>>>>>
>>>>>>>>> # touch the timestamp file, %.dtb.checked
>>>>>>>>> $(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE
>>>>>>>
>>>>>>> Not really a fan of the thousands of files that creates. Maybe if it
>>>>>>> was turned into something useful like a list of schemas that apply to
>>>>>>> the dtb. IOW, a dependency list. That would speed up re-running after
>>>>>>> a schema change. Though if a schema change created new dependencies,
>>>>>>> that wouldn't work.
>>>>>>>
>>>>>>>>>          $(call if_changed_rule,dtb_check)
>>>>>>>>>
>>>>>>>>> $(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
>>>>>>>>>          $(call if_changed_rule,dtc)
>>>>>>>>>
>>>>>>>>> $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>>>>>>>>>          $(call if_changed_dep,dtc)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> With the dtc/check split, we can avoid unneeded regeneration of
>>>>>>>>> %.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
>>>>>>>>> changed.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> One drawback is we track %.dtb.checked and and %.dtb separately,
>>>>>>>>> so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
>>>>>>>>> may come back.
>>>>>>>>
>>>>>>>> It's up to you and Rob, but I'd really prefer a simpler solution here.
>>>>>>>> Regenerating dtbs sounds like a minor pain compared to hacking the
>>>>>>>> top-level Makefile again. What I really like is that if one has
>>>>>>>> CHECK_DTBS=y (for whatever reason), he can not generate dtb without
>>>>>>>> validation.
>>>>>>>
>>>>>>> I lean towards just rebuilding the dtbs. That's pretty quick and
>>>>>>> ensures we get dtc warnings with schema warnings. In the long run, I
>>>>>>> would like to make the schema checks not optional to run. The
>>>>>>> impediment to doing that is lots of warnings (but not not some
>>>>>>> platforms), adding a tool dependency, and validation time.
>>>>>>
>>>>>> Rob, Masahiro, do we have any conclusion here? I can change my patch,
>>>>>> but I'd like to understand in which way I should change it.
>>>>>> Fixing/testing yaml changes is a bit painful w/o this change.
>>>>>>
>>>>>> --
>>>>>> With best wishes
>>>>>> Dmitry
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> I am fine with the patch as long as you fix DTC/CHECK to DTC.
>>>>
>>>> Ack, I completely forgot about this part. Please excuse me. I'll
>>>> change it to DTC_CHK (as suggested before) to fit into 7 chars in v2.
>>>>
>>>>>
>>>>> Another idea is to re-check the schema every time,
>>>>> like this:
>>>>
>>>> I think this will add the external build dependency. We tried a
>>>> similar approach several releases ago and had to revert the change.
>>>
>>>
>>> If you are talking about
>>> 75e895343d5a2fcbdf4cb3d31ab7492bd65925f0,
>>> you are completely misunderstanding.
>>>
>>> Look at my code closely.
>>> It is how the sparse checker works with C=2.
>>
>> Ah, I see. Then I'm fine with either your patch or mine v2 at your
>> (and Rob's) preference.
> 
> I'd rather not recheck every time. The user can remove the dtbs if
> they want to do that.

Then [1] should be the better fit.

[1] 
https://lore.kernel.org/linux-kernel/20220915114422.79378-1-dmitry.baryshkov@linaro.org/

-- 
With best wishes
Dmitry

