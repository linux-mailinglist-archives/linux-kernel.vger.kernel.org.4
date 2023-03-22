Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3406C4579
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCVI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCVI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:57:44 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB35D77F;
        Wed, 22 Mar 2023 01:57:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2E856604F5;
        Wed, 22 Mar 2023 09:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679475459; bh=PmUvmAKlQAoBfkAZbH/JxxoahIWApj6/Ox1y/c2t0Hs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lpu4q4918ZL7GqtkKQxDaIApaGv4pGNda7lmsh1sOoqcpxFYzzkHF1jKH0cHNZOh0
         g5RRD9/DWmiAHYr6TEbAM0Lw8xuiUHWQ+C6toiNNkFqumLnfLIAlBsbZJhyKtauKRZ
         /PMjyd/+hb8InfNq5lAC0ib7X/vpu806lgBWeHKxXgUPlk1JACw+I31goWDlnbiNxy
         gNldsfpecy2rFxxYHhv+rWAT+9DP3+wJZnm3ZEh5SBBMdkLx7mpWG4UuU6LhFdx1vZ
         nT3D2VyfACMDXCpJB4VR543nnat8l+x/H52RNCRXM2F9CnlrSOBwhqTvuSrRpJd0L5
         ZsSY08FmYypFQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1FBfpTSaobaY; Wed, 22 Mar 2023 09:57:36 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 7C288604EF;
        Wed, 22 Mar 2023 09:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679475456; bh=PmUvmAKlQAoBfkAZbH/JxxoahIWApj6/Ox1y/c2t0Hs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zBNhE3c8J0RwmgLzHlwGvPydX/9cTWKNA0a/H9mWmlI0oVpirvWd/f1AGRuoQEoEW
         x/4RHEELQ4+YKMDaiCamUFFD1yhnecuy1jp5YTJSRM3tfzk8Fc/esfreBcXLaoRqIM
         JY63MDGD47sZ0A7h9yDfepZH+BojmKz5auBDQgJ9tuSxuLc5QRqobJgnXiBfSzm7CI
         K78+7Wj5fFdGWxivNgXtZBfCKnyS45FwlaM9O2fCL0bjXFEYZbkVvQBuyZ9MYUw1CN
         bwG5ZjIotCH3TRZGgDb/qOSMNirunPnrSkubyE3uva0gmSv9sUYNgbwd0GmXyXK/Fl
         b75DvN7S9Nyqw==
Message-ID: <40379213-6283-4ac7-b761-244df5537e56@alu.unizg.hr>
Date:   Wed, 22 Mar 2023 09:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: BUG: scripts/kconfig/merge_config.sh: typo in variable name
Content-Language: en-US, hr
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
References: <17ab5a21-5512-5388-f9fa-c462b2ebd351@alu.unizg.hr>
 <7349a16f-6e7e-51d4-4686-ec7e688d891b@alu.unizg.hr>
 <CAK7LNARxu0hjOp6N7jnLWvqWb0h3LPPSAgF7+7+c-eB7Fmc9dA@mail.gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAK7LNARxu0hjOp6N7jnLWvqWb0h3LPPSAgF7+7+c-eB7Fmc9dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 04:40, Masahiro Yamada wrote:
> On Wed, Mar 22, 2023 at 5:14 AM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> On 3/21/2023 2:04 PM, Mirsad Goran Todorovac wrote:
>>> Hi all,
>>>
>>> There is a typo in variable name in scripts/kconfig/merge_config.sh, with the
>>> script returning:
>>>
>>> $ ./scripts/kconfig/merge_config.sh -y -m ../.config tools/testing/selftests/net/config
>>> ./scripts/kconfig/merge_config.sh: 148: ./scripts/kconfig/merge_config.sh: Previous: not found
>>>
>>> Problem is probably best explained by this diff:
>>>
>>> ---
>>> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
>>> index 32620de473ad..902eb429b9db 100755
>>> --- a/scripts/kconfig/merge_config.sh
>>> +++ b/scripts/kconfig/merge_config.sh
>>> @@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>>>                   NEW_VAL=$(grep -w $CFG $MERGE_FILE)
>>>                   BUILTIN_FLAG=false
>>>                   if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
>>> -                       ${WARNOVVERIDE} Previous  value: $PREV_VAL
>>> +                       ${WARNOVERRIDE} Previous  value: $PREV_VAL
>>>                           ${WARNOVERRIDE} New value:       $NEW_VAL
>>>                           ${WARNOVERRIDE} -y passed, will not demote y to m
>>>                           ${WARNOVERRIDE}
>>>
>>> Hope this helps.
>>
>> P.S.
>>
>> Later I thought of searching the committer of the patch that introduced the change,
>> so I Cc:ed Mark.
>>
>> Best regards,
>> Mirsad
> 
> Good catch.

Thanks.

> Will you please send a patch with your signed-off?

Submitted. I hope I did it right this time.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
