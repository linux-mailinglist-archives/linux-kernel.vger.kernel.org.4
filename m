Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D16D5B18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjDDInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjDDIm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:42:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7193585
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:42:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so15867303wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680597751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKhe9Y5JEaP4z1zeWvbQyAnZVIyrCqdZxp2GHp+Z3cc=;
        b=TTl/ADQs4hEpjXJPyC2dBO7s+PlDBsWUCbN9IM0npJvyQZuD8wPzugJe5bBk0l1tBX
         FisY1JxDmetnYsyBBMB0+OT0OzU3foUd9DHqHoxHKiEIDbzhNCT5fNmQM4ddfZ0YBNSd
         ++0AmTCxVXdi3DVnKzfqmMQcxWftjDxzhEmpdYbXaq9IU5mLN1dY334hIvjSMZARCWiq
         ZFTjdY37+ZMJk6vhdZmP86teZpqfOyixU1boFx3b9BnNYQD2xsSSCGH3lw1/bexClLkz
         +j/J+jnaiNlfUtqJDi+IL3yhJ0P33TJx47LYADxuAcpfl4xZNp8Ftl13EGBUtMOCpIxD
         rNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680597751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKhe9Y5JEaP4z1zeWvbQyAnZVIyrCqdZxp2GHp+Z3cc=;
        b=k0Aoz6Oc6ag59Gk3KQaGsgblg6GOCpLFz3lud696usqAADLqPRuTS9M0dlLgwPtJMP
         TzupRRSXfPp0PMGEZCvjmQIHVoAZuK8jdzK14yE1uMHnPeC2DrK3DiUVDnFwc8acv1V2
         tMX09PB/nJ79GdYVbQBKEZ/hmN5eyRs+CHMvSHWDz295C8/pSZnl0MPCevI2kf01bPx4
         nvwTdih5gbHy9rD3uQR43yDWUZEjPnrB4C/EYrZR7DAEuGFl++0xyQS4Jad5iy1pS65x
         V7LryGUJn9MOTgCvl0FSQP74l9blfacSeBP62+YjFTH2tK6H+LAklCd7TheanRLAHyCr
         tiTg==
X-Gm-Message-State: AAQBX9eXU/uktfHgTduCPWLyjhW+n55Mob+Tt6r6ri2x4SI0tNORrxBm
        +GJSYSnC+mbeqpf1x1iMYIzAVg==
X-Google-Smtp-Source: AKy350Y5DMU8kEAJOzbfmW7NGKy5hnaCRv7A7hFu+RQQNUqByLYI+v3iTHv8cRT+S8Q+uybES9Z5PA==
X-Received: by 2002:a05:600c:2312:b0:3ef:6396:d9c8 with SMTP id 18-20020a05600c231200b003ef6396d9c8mr1461785wmo.5.1680597751348;
        Tue, 04 Apr 2023 01:42:31 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9bac:ba77:27a:f657? ([2a02:578:8593:1200:9bac:ba77:27a:f657])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d5506000000b002e463bd49e3sm11660988wrv.66.2023.04.04.01.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 01:42:30 -0700 (PDT)
Message-ID: <8edb82ed-10e8-c236-fb08-ed14ed3e4634@tessares.net>
Date:   Tue, 4 Apr 2023 10:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/5] docs: process: allow Closes tags with links
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v4-1-d26d1fa66f9f@tessares.net>
 <e671189c-086e-87bd-68db-fb80678d4666@leemhuis.info>
Content-Language: en-GB
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e671189c-086e-87bd-68db-fb80678d4666@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

Thank you for this review.

On 04/04/2023 10:09, Thorsten Leemhuis wrote:
> 
> On 03.04.23 18:23, Matthieu Baerts wrote:
>> [...]
>> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> index 828997bc9ff9..12d58ddc2b8a 100644
>> --- a/Documentation/process/submitting-patches.rst
>> +++ b/Documentation/process/submitting-patches.rst
>> @@ -113,11 +113,9 @@ there is no collision with your six-character ID now, that condition may
>>  change five years from now.
>>  
>>  If related discussions or any other background information behind the change
>> -can be found on the web, add 'Link:' tags pointing to it. In case your patch
>> -fixes a bug, for example, add a tag with a URL referencing the report in the
>> -mailing list archives or a bug tracker; if the patch is a result of some
>> -earlier mailing list discussion or something documented on the web, point to
>> -it.
>> +can be found on the web, add 'Link:' tags pointing to it. If the patch is a
>> +result of some earlier mailing list discussions or something documented on the
>> +web, point to it.
>>  
>>  When linking to mailing list archives, preferably use the lore.kernel.org
>>  message archiver service. To create the link URL, use the contents of the
>> @@ -134,6 +132,16 @@ resources. In addition to giving a URL to a mailing list archive or bug,
>>  summarize the relevant points of the discussion that led to the
>>  patch as submitted.
>>  
>> +In case your patch fixes a bug, use the 'Closes:' tag with a URL referencing
>> +the report in the mailing list archives or a public bug tracker. For example::
>> +
>> +	Closes: https://example.com/issues/1234
> 
> YMMV, but is this...
> 
>> +Some bug trackers have the ability to close issues automatically when a
>> +commit with such a tag is applied. Some bots monitoring mailing lists can
>> +also track such tags and take certain actions. Private bug trackers and
>> +invalid URLs are forbidden.
>> +
> 
> ...section (and a similar one in the other document) really worth it
> and/or does it have to be that long? A simple "Some bug trackers then
> will automatically close the issue when the commit is merged" IMHO would
> suffice, but OTOH it might be considered common knowledge. And the
> "found on the web", "a public bug tracker" (both quoted above) and
> "available on the web" (quoted below) already make it pretty clear that
> links to private bug trackers are now desired. And there is also a
> "Please check the link to make sure that it is actually working and
> points to the relevant message." in submitting-patches.rst already, so
> invalid URLs are obviously not wanted either.

This paragraph seems worth it to me: the two first sentences explain how
this tag can be used by external tools and the last one clearly explain
what is not allowed. I agree that it makes sense and it is somehow
already described around with the "positive form" but it is very common
to use the "Closes:" tag with just the ticket ID, not the full URL. It
might then be important to clearly mention that it has to be used with a
valid URL and not a short version. While at it, I think it is fine to
add that private bug trackers are forbidden too because it can be very
tempting for devs to use them if automations are in place. And also
because checkpatch.pl is not going to verify if URLs are public.

But I'm clearly not an expert in writing docs, it is just my point of
view as a developer :)
I don't mind changing the text.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
