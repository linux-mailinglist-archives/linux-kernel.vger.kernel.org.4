Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B76C607F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjCWHSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCWHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:18:13 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B1F26AE;
        Thu, 23 Mar 2023 00:18:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 128B1604EF;
        Thu, 23 Mar 2023 08:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679555883; bh=QVE808cwkNfbooK81o8zbpVIwpt+glEgis/QPj/A8XM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hp4dpuavGMKTP0bhvWSsfV4ZT37ZlHkeMIzf8cCxKLflU82D+qsTgXqH+QenhbuYg
         g/B6q30w+PQiLzEJiGYl73zYHg/azxxAZvCKQvYMUlFzNqyc/O9jQlNKHcBLb/8ZWH
         rsNc58agmfwC9K5/yxzocWUKem6vjIfreqA7NDnouplfJsVgAEC2hdDRjhFi6x1Z+j
         CEx2nfeuxiR6V2VrevqLybrD2vFm3o6BnoxvLRY9AHpExJEsJlWz5AMGAPkim45Rqy
         ipjr2XYKI8k4elkneNM+JdVfPtov/jDau+pAHBgvJ+igKwlVM4EysdMhUiBrwm+TWf
         xcB86U6r84t3A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cvHsWzQgVEVO; Thu, 23 Mar 2023 08:18:00 +0100 (CET)
Received: from [10.0.1.103] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id B935E604ED;
        Thu, 23 Mar 2023 08:18:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679555880; bh=QVE808cwkNfbooK81o8zbpVIwpt+glEgis/QPj/A8XM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kVDbvisEuY5FGklMcYWRZiyyApxhK1agAKLK63rVFDwiD0/Sha9O1lIEjvcUOnatO
         f71b5803Kzk79BbhpDOOhDU99qqolLtxTQyBX+hcPMJeu0WDSVY1WMrsSVOmshEsAh
         x/EHTkyxlnIvssibk76zmASNGfVJYSuQ1Pl5X+vwznswEdvIC2RRR4/5GmIlLJvzAQ
         Ldd7Mt1EloiVzor7nWud+I1uc7tSpSnEF1KxIOJboxR9dZin+5nsqcDcCUvh54Oh+q
         +t8Djk5MTLfY9gBJaL8Wzlp4lhnHCT+vIJt27ahfc2VYDZ+zmKxs26Z80DUWYTS1oO
         Cygl3TEhPmnOQ==
Message-ID: <e9967b4f-ec36-f1b0-859b-7f3c7350f7ac@alu.unizg.hr>
Date:   Thu, 23 Mar 2023 08:17:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/1] scripts: merge_config: Fix typo in variable name.
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
 <c93723aa-f01c-9f1e-c9c7-aa79f38390c1@infradead.org>
 <cb386732-7509-497d-8641-473ad853c9ed@alu.unizg.hr>
 <CAK7LNARAS7DEtpS2HMK=a7egwRdj-uD9JhxsOcKpfpstiiFLhQ@mail.gmail.com>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAK7LNARAS7DEtpS2HMK=a7egwRdj-uD9JhxsOcKpfpstiiFLhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.3.2023. 7:24, Masahiro Yamada wrote:
> On Thu, Mar 23, 2023 at 3:15 AM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> On 22. 03. 2023. 16:20, Randy Dunlap wrote:
>>>
>>> On 3/22/23 01:51, Mirsad Goran Todorovac wrote:
>>>> ${WARNOVERRIDE} was misspelled as ${WARNOVVERIDE}, which caused a shell
>>>> syntax error in certain paths of the script execution.
>>>>
>>>
>>> Fixes: 46dff8d7e381e ("scripts: merge_config: Add option to suppress warning on overrides")
>>>
>>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Thanks.
>>
>> Hi, Randy,
>>
>> I think this time thanks go to the Heavens, for preserving my physical integrity.
>>
>> Though I don't know of a bike with ABS.

> Applied to linux-kbuild/fixes,
> fixing another typo "Signed-of-by".
> 
> You do not need to spell it out by yourself.
> 
> "git commit -s" will insert the Signed-off-by tag.

Sorry to have wasted your time and effort. A typo fixing typo.

It is visually hard to detect once it's done. :(

I'm grateful for your quality control.

Best regards,
Mirsad

>>>> Cc: Mark Brown <broonie@kernel.org>
>>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>>> Cc: linux-kbuild@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-of-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>> ---
>>>>   scripts/kconfig/merge_config.sh | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
>>>> index 32620de473ad..902eb429b9db 100755
>>>> --- a/scripts/kconfig/merge_config.sh
>>>> +++ b/scripts/kconfig/merge_config.sh
>>>> @@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>>>>               NEW_VAL=$(grep -w $CFG $MERGE_FILE)
>>>>               BUILTIN_FLAG=false
>>>>               if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
>>>> -                    ${WARNOVVERIDE} Previous  value: $PREV_VAL
>>>> +                    ${WARNOVERRIDE} Previous  value: $PREV_VAL
>>>>                       ${WARNOVERRIDE} New value:       $NEW_VAL
>>>>                       ${WARNOVERRIDE} -y passed, will not demote y to m
>>>>                       ${WARNOVERRIDE}

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

