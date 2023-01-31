Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DA968364F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjAaTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjAaTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:20:27 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764215C87
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:20:16 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i6so3082551ilq.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5E0WkKSlwMnkSQam2K3hwAbOWLDxhrQDjQkwQIk6UGI=;
        b=C2RXPodxbAjGP9NOH0qoHVRffXo9Nwg19A5X8bgvah5RjCclVxYDZyTeWJHNO5xvE0
         xBv3WZbNKLizKvyS8VfePoZytlLTIZNkVrYO4J63nOwRJtI0wJJxwsqBxNn6TvFlBF0Z
         /n1kRKUjDEmItPG7UbkeoKKGZj1VDLPVyyEE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5E0WkKSlwMnkSQam2K3hwAbOWLDxhrQDjQkwQIk6UGI=;
        b=mqlPW9/FjU+xaRscUW7BZK65qu5jRIt6DZ+pZRlrmUvl9e3rS3eoZxGCoUUVfJX1ia
         DOQKydV2WuGWBk88qoWv5DtXV1SKLlfo/Yr62O5SdjvD0cg+a+CYJ5SG7wptgPYoWW7l
         qiiuqZuJ7jVSzJOegH21jWnn3hmfZfk9xv3OWcvsEbU0f6oqq+b3OEgCeeZCR5T3Skoz
         no/PYS1nVjarsRFSapzqirx5PHGvFEyswJ7qcD8a3SNlHuOjL015/cGb73wrb7pZfoNL
         3gyIvBckvMQ/j+w6df4/1X3Lnazq6iaRJxCVi9R1Pth3sdk9uSG2n4JoG5RQeeNcJH1l
         GA1w==
X-Gm-Message-State: AO0yUKXWFM5WobwxoF2sN10Q0fnVC9Uk8D55TFM9u86fZ+mfdIvqiWOo
        Cb9Z+RXx+krIMcAbT/0/1tNZ9g==
X-Google-Smtp-Source: AK7set8siwIO4FaKPC7+dFQb1GCIBMBKs+WowGEQeuNvAcOtEmsAGVYIjeTiVl721VXKW5e0mms6EA==
X-Received: by 2002:a05:6e02:1d05:b0:310:cc70:a152 with SMTP id i5-20020a056e021d0500b00310cc70a152mr5682741ila.2.1675192815542;
        Tue, 31 Jan 2023 11:20:15 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s8-20020a02cc88000000b003aa9ddab101sm3438287jap.19.2023.01.31.11.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:20:14 -0800 (PST)
Message-ID: <53f52975-98d0-dbb3-9781-0366143f2dd0@linuxfoundation.org>
Date:   Tue, 31 Jan 2023 12:20:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
 <f48e8dab-2a68-88d2-7917-f8f34a39e322@leemhuis.info>
 <021776e6-b37f-0a2e-41e0-5c09f9582c57@linuxfoundation.org>
 <87o7qf4m2p.fsf@meer.lwn.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87o7qf4m2p.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 16:52, Jonathan Corbet wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> On 1/28/23 01:35, Thorsten Leemhuis wrote:
>>> Adding another section that doesn't seem to a be a good fit feels a bit
>>> like "making things worse than better".  So wouldn't this maybe be a
>>> good opportunity to create a totally new top-level section for
>>> application developers and system integrators, even if it's tiny for
>>> now? The audience is likely big enough to justify that -- and the topics
>>> are likely different enough, too (of course sometimes there will be
>>> overlap, as always). Any maybe it will help to bring other stuff over
>>> from admin guide that is more targeted for application developers and
>>> system integrators, which will help to get more structure into the
>>> admin-guide.
>>>
>>
>> I like the idea of creating a new top-level section for application developers
>> and system integrators. I foresee this section growing and also we can look
>> at other documents that are a good fit under this category and move them over.
>>
>> Jon, Thoughts on this.
> 
> The fit with the admin guide caught my attention as well, but I didn't
> immediately have a better place to suggest.  I am somewhat resistant to
> creating another top-level directory; I really want to have *fewer* of
> them.  I certainly don't want to create one for a single document.  My
> inclination would be to leave it where it is for now; we can always
> revisit this if it turns out we have a lot of material that justifies a
> new book.
> 

Makes perfect sense. I didn't want to suggest a new top level for the same
reasons. For now I will send v3 keeping it in the same location.

I will take a pass at the existing documents under admin-guide and in other
places to see if others could be grouped under a top-level as suggested by
Thorsten

thanks,
-- Shuah
