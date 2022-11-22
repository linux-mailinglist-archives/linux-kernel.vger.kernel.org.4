Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED89634AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiKVXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiKVXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:11:05 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDAFBEB76
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:11:01 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r81so12081481iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbyKEJ2d2bWv/zjpHmb3KUXo3X107tG1WXPFafidPA4=;
        b=hNNTZ7JlssYurZeLwyACwvjSRWhzM+GQnIbp4ki2Pm42cOnbEo+gb8E/UA1bOQXjr7
         +e4hZl0b+WcLOntJY00P0QP5fN6Vh4Sk6IIOjAYRurpHfGY5aZalKE35e1UyN6grjdLV
         HV44hp5vLnVDhr6AFC0wBq08xXGqrzESkb/Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbyKEJ2d2bWv/zjpHmb3KUXo3X107tG1WXPFafidPA4=;
        b=3pJllTYyUxxuuafALx+luNHac2Df2iK7UQhv1z8ZDx65iuRs+QDotrAhHQRzR0HPiQ
         3PsnMvaAirfqeH44NTFbK/U+NWohJ+Geup6yP3yBdqJ9tau20U65dsasUzMGbPI4pzcO
         EOLjOX+oQPCJwQrAZdpOE58UmS5+qEz15Q0Z567nEAqIE0iPHt2WUl7d9rMPZ3+4D8Tm
         i0gfSTCiB7MCYZG6qGa6PhlobR78jn8EvpPjQQazgKGocg1X8ly0XTZDQu2lTnkhk0hh
         lLUKa9T9GbdVrpWg00IzV5/Hogyk+sEJMjA6nEDpuntAHCsdUCQ9Ziw7bELl7HafkM+N
         yaHw==
X-Gm-Message-State: ANoB5pnYqxlhdPdbgkLADuI9BoTCo2b+5jCiDwGGIdUIhuAk6M2wcCcC
        3sdxgPtHhIKOhS55UZmqPZGvIw==
X-Google-Smtp-Source: AA0mqf6UZq2Tm1NlDTq7KRtXa/kJNZd0FAArsyPBvqbtAWSJrlLqvsogIgnxRCLinLFziioHu2CVXw==
X-Received: by 2002:a02:3f48:0:b0:376:2a35:3b21 with SMTP id c8-20020a023f48000000b003762a353b21mr2883165jaf.284.1669158660823;
        Tue, 22 Nov 2022 15:11:00 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029582000000b0037612be6830sm5719343jai.140.2022.11.22.15.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 15:11:00 -0800 (PST)
Message-ID: <274d7857-a80a-1d00-b73d-cd0f814b9c6b@linuxfoundation.org>
Date:   Tue, 22 Nov 2022 16:10:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH v2 0/2] selftests/ftrace: Capture dependency on
 external programs
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
 <20221122164936.1a92f529@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221122164936.1a92f529@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 14:49, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 12:46:08 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> This is a repost of v2 with the tags collected, and with cc to
>> linux-kselftest list:
>> https://lore.kernel.org/all/cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com/
>>
> 
> Hi Shuah,
> 
> Can you take this (if you haven't already)?
> 

Already in linux-kselftest next - will send them for 6.2-rc1


https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

thanks,
-- Shuah


