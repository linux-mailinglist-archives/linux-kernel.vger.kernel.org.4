Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5495689FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjBCQ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjBCQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:57:09 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99719AA272
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:56:53 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id l15so2311413ilj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6dU/MLK19R27v5TumqJxeFfIoPB7aII2OkV9V6qrvA=;
        b=HiWjdHnBDoeXnKH6lL2kguYnHVGDxzJXoSOcg8NeZz4ZdmP3SHj9YySZKNujyeUDQp
         KXiEfpUuaX+bxRCty364k+H9dFIUpgmPL3kOOXnuDkCQVWHqdEAQN+SGfj4JEv/CTnog
         coSWTS/11nF87rzoMpJNsjOhdTV+opofoKF04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6dU/MLK19R27v5TumqJxeFfIoPB7aII2OkV9V6qrvA=;
        b=GaM+0khYdtNZ9Nkm2+C11M0829Q459C2yUR2mdz9FiylLmU+erGJtOKGVzTuEUMRej
         nRBzOK49grxlUHmrHxWuLfXPjIDFIvQ++kB6ShXZN7GTlr85SCiDo8lKGrfCziu3lz86
         Kkp4b8LKCyRiki8IQjPLCx3cyp16/SXIECWlgeRrNZtS7RSwYxgBScFi3SNEDXt933+B
         tICAImQQpGWoEd3AkcDolmbQP3uPX97kJrZMs8iSsE4Hz2HqmkfaG1WmfJQqRCHzJxwp
         7EKgKAf6DWnlXbQn3N/Iq27IN8GCM5u9/xWqsBiK7FeU/ubGnGsQUdH/PN9gsFbt0ckE
         kjgQ==
X-Gm-Message-State: AO0yUKVvE4bCly+QBDX057TEdZZvZz+olteEV6TkDHY6sHjTMTbcKKvn
        TXNEOFQdOFBhRAqljNAgjNIdWQ==
X-Google-Smtp-Source: AK7set/Jrl89jWi4wJJZHkXYIVCz+HKbR2LJVPcbUot7rENhrH80xbnluC31AjAunmEtL9Xj0QUe/g==
X-Received: by 2002:a92:ce06:0:b0:310:8c56:d7de with SMTP id b6-20020a92ce06000000b003108c56d7demr5886170ilo.0.1675443412851;
        Fri, 03 Feb 2023 08:56:52 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e0211b200b0030bfd384821sm884381ilj.81.2023.02.03.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 08:56:52 -0800 (PST)
Message-ID: <de935b11-f5b7-9217-b73c-aef32c19c3c7@linuxfoundation.org>
Date:   Fri, 3 Feb 2023 09:56:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests/ftrace: Fix bash specific "==" operator
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Yipeng Zou <zouyipeng@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <167434397083.3069767.14730152459198287532.stgit@devnote3>
 <20230124191637.0b2b8785@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230124191637.0b2b8785@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 17:16, Steven Rostedt wrote:
> On Sun, 22 Jan 2023 08:32:50 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Since commit a1d6cd88c897 ("selftests/ftrace: event_triggers: wait
>> longer for test_event_enable") introduced bash specific "=="
>> comparation operator, that test will fail when we run it on a
>> posix-shell. `checkbashisms` warned it as below.
>>
>> possible bashism in ftrace/func_event_triggers.tc line 45 (should be 'b = a'):
>>          if [ "$e" == $val ]; then
>>
>> This replaces it with "=".
>>
>> Fixes: a1d6cd88c897 ("selftests/ftrace: event_triggers: wait longer for test_event_enable")
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Care to pull this through your tree?
> 

Yes. Will appear shortly in linux-kselftest next.

thanks,
-- Shuah

