Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32AD6D1CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjCaJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjCaJpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:45:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841B9113DB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:44:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i5so87511777eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680255887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojIigKKb4lX50seD+r4LK2VBtF1oxiuySnQx5T9yLKM=;
        b=SGm3jlndegPmQiUUfg/Z5lk0Mz2MCPTRgeR8JQizpHp6ESfVhi4iDD6zpByLQEdD7/
         oKeQdqE/oC5Ak6OIpGMEmlNGcJvNCFppT4gUE55XeiQbvuf8KUusEauDcZntvxoiBCXf
         QEZ/HPuq2+HiD0u1l0H1twwiICj4d3CRd6Rb0S8yKSRCLcuAeHOxsslppz8dhZJ/CHOQ
         H0SgKeyrmBsYhegda/A1dJTj6XuDExyixqj7IbjqaWLJ3FtovaVL4xPSdpJzB/PngUYF
         cQr7apDAy/11SOdQwsAv32AYdD6VdJscKALIe95v5b8AlgvKBd39NQ4wx0X+mDEeIjF/
         Qs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680255887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojIigKKb4lX50seD+r4LK2VBtF1oxiuySnQx5T9yLKM=;
        b=FZcHgaWe+7e+kMUlPpMBI6i7RcK+KNUwq6O5y/ZmKqnx2Nhw4q6sy2RdjJzpaWO8Zv
         sDQUxhpMkF/+XV6R89OUL/6fs6u06fSfdX9MqyFRoqsnEhvTgq3rHBTVeKzyt/aXNEtP
         UdiSjg5bup9EuZb0+UjmcrsHmK6BFxh+05JOsqTpqMk8uwxKzHtVLtIYqfnUlt5awFUS
         1uDnV8EaqOof7uiVPPp4n86fsZGBCMJesK+ZrW2K3I2GuHBUrux+N1vPaBthAwIa2jWu
         TkLGZhdT9H5HksJ9Yr3WL5U15rjek2O9I/dQ+0KlF80wP3G/FrrHTUesu65GDDdR0h9w
         2wBg==
X-Gm-Message-State: AAQBX9eGVFfSQS0W/n910SNzYqCxPghF2FIfPRA1awtAIzC1p92IcSwm
        WcecnKlMDbzYkoj2SDmxMVqtCA==
X-Google-Smtp-Source: AKy350ZCmmubrfuVppv7kX+VgOSXjLcMMRRmyUpkkRsRiAykSjmJYcQ5zjnP73l2IJdnR4WGGMdAHQ==
X-Received: by 2002:a17:907:7701:b0:92f:efdc:610e with SMTP id kw1-20020a170907770100b0092fefdc610emr25137363ejc.66.1680255887209;
        Fri, 31 Mar 2023 02:44:47 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id r6-20020a05640251c600b004fd219242a5sm836854edd.7.2023.03.31.02.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:44:46 -0700 (PDT)
Message-ID: <ac473b8f-e7c1-edf9-9d9c-f1fd726e1e17@tessares.net>
Date:   Fri, 31 Mar 2023 11:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/4] checkpatch: check for misuse of the link tags
Content-Language: en-GB
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
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
 <c2d5cc07-ec95-eb64-0cef-42f8378ea054@leemhuis.info>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c2d5cc07-ec95-eb64-0cef-42f8378ea054@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On 31/03/2023 10:57, Thorsten Leemhuis wrote:
> On 30.03.23 20:13, Matthieu Baerts wrote:
>> "Link:" and "Closes:" tags have to be used with public URLs.
>>
>> It is difficult to make sure the link is public but at least we can
>> verify the tag is followed by 'http(s):'.
>>
>> With that, we avoid such a tag that is not allowed [1]:
>>
>>   Closes: <number>
>>
>> Link: https://lore.kernel.org/linux-doc/CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com/ [1]
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> [...]
>> +# Check for misuse of the link tags
>> +		if ($in_commit_log &&
>> +		    $line =~ /^\s*(\w+:)\s*(\S+)/) {
>> +			my $tag = $1;
>> +			my $value = $2;
>> +			if ($tag =~ /^$link_tags_search$/ && $value !~ /^https?:/) {
>> +				WARN("COMMIT_LOG_WRONG_LINK",
>> +				     "'$tag' should be followed by a public http(s) link\n" . $herecurr);
>> +			}
>> +		}
>> +
> 
> I must be missing something here, but it looks to me like this is
> checked twice now. See this line in patch2 (which is changed there, but
> the check itself remains):
> 
>> } elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {

If I'm not mistaken, we had the following checks:

- after Reported-by, there is a link tag (Link:|Closes:)
- (link tags can take more than 75 chars)
- tags followed by "http(s)://" are restricted to link ones

Then not: link tags (Link:|Closes:) are followed by "http(s):".

But maybe I missed something, the checkpatch.pl script is quite big, I
would not be surprised :-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
