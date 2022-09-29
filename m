Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A55EF3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiI2KwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiI2KwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:52:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65B4F5096
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:52:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m4so1557916wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ihoBeSs59iWbP1E9Pgfi7qjgA83tLkmtSuTnB+5qvn0=;
        b=y2BK8UjVOnfiBFEm8F2vRRObjQQ43UGd+qxTauE5Ih3VfyXRy/ZWKdP/SOHqsv9zRP
         jXUrA2YwnbhxhqKfDDRXfYdo0BvlZQACjUTyPOhq3l0vnGwaLjy0bzqiL7DWaTw9fZR1
         HAIb/B6XpICVEpOuPrvDN9ojdKkzkw4uu+OQkItbQQnCiQbFSm06HMQ7OSkQ2Q8DkfP6
         TFx42QLWFgG9Qyqm1Kahbznh4TEoWEeAaSuHn2AA6ndaWacfUZGGK8wSd5yN6hkmwHhZ
         n4ifnKHYoCmNVIYMYqzSm9ioKF9Wfkp0hAuK4LDolEQKOEc/7RyGCeIxvFO3P7btkHSf
         lPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ihoBeSs59iWbP1E9Pgfi7qjgA83tLkmtSuTnB+5qvn0=;
        b=jG+yoMuIUK8wZJwcO2KH1fzY5HIH3f7kn38owvbtjj6Lo9xsfJAVbz9Q9OEJ25fYCV
         Jh5iMOXsThPWXJpH2VB0JUXmWjd3URELf/ixymGyhdfWqSvjfAVVHhGN4ShcPh4ngPZP
         XA3uJBN2nYIo+2jooCy8uQ0I6ZeCZfj6E3EwTUSUIuxY60Gts7o0DrF30SYDDifh/aMo
         8olVzVEqvTY26BhGpznCb28ag7mP3gqjxWuU3n5kJMl5AcA631q7WyezYqPiCLsvKwHO
         VIr3pEbw9riVHfgjeYTVzvlS70WRdYlNrbjMwhq5c6eWp4ft1V0fIBlN6Q5bysjOKT42
         OCjA==
X-Gm-Message-State: ACrzQf32n+43QrZffn3JMQy76D5bVdcSyUwZ/G0M2FZH3gRTlKEcyA1J
        lhGS7YnnvG+GSUE5dvdY3aY13g==
X-Google-Smtp-Source: AMsMyM4JIlbLulujJCXJwbQnwzxyOKM+JfidEmi7PnULTuIctLX4Om3NMlORxyDJiIfwNlBUeKPKyQ==
X-Received: by 2002:adf:e847:0:b0:22c:cef0:4fcf with SMTP id d7-20020adfe847000000b0022ccef04fcfmr1785701wrn.247.1664448727259;
        Thu, 29 Sep 2022 03:52:07 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003b4bd18a23bsm4143781wma.12.2022.09.29.03.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 03:52:06 -0700 (PDT)
Message-ID: <a9bd8038-255b-eb2c-babf-db329981f5d5@linaro.org>
Date:   Thu, 29 Sep 2022 11:52:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] Documentation/process: Add text to indicate
 supporters should be mailed
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
 <20220929002500.283481-3-bryan.odonoghue@linaro.org>
 <54a19490-aa0d-2dcd-8407-319d6167add4@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <54a19490-aa0d-2dcd-8407-319d6167add4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 08:29, Krzysztof Kozlowski wrote:
> On 29/09/2022 02:25, Bryan O'Donoghue wrote:
>> Recently when submitting a yaml change I found that I had omitted the
>> maintainer whose tree the change needed to go through.
>>
>> The reason for that is the path in MAINTAINERS is marked as Supported not
>> Maintained. Reading MAINTAINERS we see quote:
>>
>>             Supported:   Someone is actually paid to look after this.
>>             Maintained:  Someone actually looks after it.
>>
>> The current submitting-patches.rst only says to mail maintainers though not
>> supporters. When we run scripts/get_maintainer.pl anybody who is denoted a
>> paid maintainer will appear as a supporter.
>>
>> Let's add some text to the submitting-patches.rst to indicate that
>> supporters should similarly be mailed so that you can't do as I did and
>> mail every maintainer get_maintainer.pl tells you to, without actually
>> mailing the one supporter you need to.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   Documentation/process/submitting-patches.rst | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> index be49d8f2601b4..aabccaea93375 100644
>> --- a/Documentation/process/submitting-patches.rst
>> +++ b/Documentation/process/submitting-patches.rst
>> @@ -227,9 +227,11 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
>>   to code that they maintain; look through the MAINTAINERS file and the
>>   source code revision history to see who those maintainers are.  The
>>   script scripts/get_maintainer.pl can be very useful at this step (pass paths to
>> -your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
>> -maintainer for the subsystem you are working on, Andrew Morton
>> -(akpm@linux-foundation.org) serves as a maintainer of last resort.
>> +your patches as arguments to scripts/get_maintainer.pl).  You should mail
>> +everyone who appears as "maintainer[volunteer]" or "maintainer[supporter]" as
> 
> As I said before, this still ignores reviewers. I don't think it is
> going to good direction. The submitter is expected to CC
> everyone/everything which is pointed by get_maintainers.pl except the
> Git-fallback entries.


I just found the --nogit-fallback option which produces:

scripts/get_maintainer.pl Documentation/process/submitting-patches.rst
Jonathan Corbet <corbet@lwn.net> 
(maintainer:DOCUMENTATION,commit_signer:10/12=83%)
Konstantin Ryabitsev <konstantin@linuxfoundation.org> 
(commit_signer:2/12=17%)
Thorsten Leemhuis <linux@leemhuis.info> 
(commit_signer:2/12=17%,authored:2/12=17%,added_lines:24/46=52%,removed_lines:13/67=19%)
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 
(commit_signer:2/12=17%,authored:2/12=17%,added_lines:8/46=17%,removed_lines:4/67=6%)
Randy Dunlap <rdunlap@infradead.org> (commit_signer:2/12=17%)
"Bryan O'Donoghue" <bryan.odonoghue@linaro.org> 
(authored:1/12=8%,added_lines:5/46=11%)
Erik Ekman <erik@kryo.se> (authored:1/12=8%)
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> (authored:1/12=8%)
Jiri Kosina <jkosina@suse.cz> (removed_lines:20/67=30%)
Miguel Ojeda <ojeda@kernel.org> (removed_lines:19/67=28%)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)

scripts/get_maintainer.pl --status --nom --nol --nogit --nogit-fallback 
-f Documentation/process/submitting-patches.rst

How about something like "send email to every mail address produced by 
scripts/get_maintainer.pl $filename but consider linux-kernel optional 
when sending subsystem specific patches"

---
bod
