Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA4A6C536F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCVSPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:15:46 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2BB6505A;
        Wed, 22 Mar 2023 11:15:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2459C604F0;
        Wed, 22 Mar 2023 19:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679508931; bh=uwjYpsJXPD7FhPZaDDmtv+fmfdYShZVfMh/QdHtxRZc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WwCN4ZdXYs5BOsQiqRQ8Rw3M2sbnYdUWzcCEf37qnBBbp5V2Civ9wjsJdENmzIXF0
         dDEYr+ufV/tJuE+TeqbUwoyjKwn8ljdg9BPOHqiuPR9CpS83nxs0KbNOQNm0nYmkbw
         BRAGEM5TyWqgxvRnd/JajguDccsGFkEJX6BPgRmTZ+PQfGSuZLoOy5YV8+BjGR35+h
         s9xS13JzXSEDvp0bUQwR/P28/HiAQIBAGZNyGd3UYDW8KGYOhQtUGOKBtrGiKFR0qT
         ezo+Asu8iqrZNIiCpvEA2SEsle3+lfzluY8FV8cwEgGI+Z8v0cO171Sngkoz0WhtH5
         9Aq000GOmrJZw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U-JVEDwxHgAI; Wed, 22 Mar 2023 19:15:28 +0100 (CET)
Received: from [192.168.1.4] (unknown [109.227.34.15])
        by domac.alu.hr (Postfix) with ESMTPSA id 49748604EF;
        Wed, 22 Mar 2023 19:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679508928; bh=uwjYpsJXPD7FhPZaDDmtv+fmfdYShZVfMh/QdHtxRZc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OU4UpEc2NVjeO4vFYbos9thOiUFCJXpXMzgmZLYIE5R+1L/KCPqSezEgdzQywYLN0
         hASlG7wX3E/2+mvvcCZhucIBb4A7zR11iWvU3rf4Wyw7/knQy9xjjknuLbx/AcWGEN
         AeepQ+bexmfJeI97Z+QlYLvmqH0bUeDTJxxVwkOK94tPz/nh9NeVvQSccWxODx1Fxp
         a8km5arkhfrRBaby4/PP+LB98k28g5kWtvTyzxe1uqDU1DrtZcVHmpqPgdfwDQSHPb
         L+Snp0rt8PzdaogujWF5kRdoG1EDo0ecSlhZy5+wvPf0R4YRdg3C5jV9CFxpnNbwkY
         haxbkgDZQ08hA==
Message-ID: <cb386732-7509-497d-8641-473ad853c9ed@alu.unizg.hr>
Date:   Wed, 22 Mar 2023 19:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] scripts: merge_config: Fix typo in variable name.
To:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
References: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
 <c93723aa-f01c-9f1e-c9c7-aa79f38390c1@infradead.org>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <c93723aa-f01c-9f1e-c9c7-aa79f38390c1@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 03. 2023. 16:20, Randy Dunlap wrote:
> 
> 
> On 3/22/23 01:51, Mirsad Goran Todorovac wrote:
>> ${WARNOVERRIDE} was misspelled as ${WARNOVVERIDE}, which caused a shell
>> syntax error in certain paths of the script execution.
>>
> 
> Fixes: 46dff8d7e381e ("scripts: merge_config: Add option to suppress warning on overrides")
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Hi, Randy,

I think this time thanks go to the Heavens, for preserving my physical integrity.

Though I don't know of a bike with ABS.

>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: linux-kbuild@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-of-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>>  scripts/kconfig/merge_config.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
>> index 32620de473ad..902eb429b9db 100755
>> --- a/scripts/kconfig/merge_config.sh
>> +++ b/scripts/kconfig/merge_config.sh
>> @@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>>  		NEW_VAL=$(grep -w $CFG $MERGE_FILE)
>>  		BUILTIN_FLAG=false
>>  		if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
>> -			${WARNOVVERIDE} Previous  value: $PREV_VAL
>> +			${WARNOVERRIDE} Previous  value: $PREV_VAL
>>  			${WARNOVERRIDE} New value:       $NEW_VAL
>>  			${WARNOVERRIDE} -y passed, will not demote y to m
>>  			${WARNOVERRIDE}

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
The European Union

