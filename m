Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF03760112D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJQOcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJQOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:32:11 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001EE66123
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:32:08 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id 8so5902234ilj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReaUl3dwFqklbNahtrtnKwxlz0RPx3WVempw5SjZrDc=;
        b=Q2NajULeiUVKlnmFOouF3qnIKXS1YJZhsSpZtrCQsr2o1m5brMhkWMpp8oKw6WOpuk
         IASmiRRO8H4tgj3BimwbSSLMtr7mj2WAeG3NYU97XfTkik83Jw6YoFEfZ6EHvM6oU8mn
         uu3AWtRvrlFqS37fsqpcJT8ivaz7SCpaKMpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReaUl3dwFqklbNahtrtnKwxlz0RPx3WVempw5SjZrDc=;
        b=nvh+tO0F6nZLyhyodzohkrNyneobVxDLzfvpGfIGYoZpjJ4haqP1dtcfbPVXEOMGkQ
         n18i8U3K05F/DTz9Mr1LPeggBVmwopbyMOCtbE8hbpxj6i5mVVsNBmDWYljvvpPMraIG
         /9V7ASg1Zrts44sakaZMzych3ePvtPi8ZP+FumWAxMZdmJy+UBPukSkiM/reZuHGvQ4d
         t15m9dkFBXicEZ2AIqR9/RlY8au6uyVd4TbPhWjjoDGdDPCYXSBu3XYIPiPvm7zyIqwB
         IHB9df1WvVyuqynnujgLjpSwrvABV68oUd4VjxqkHi1bT7zy/P0SP/Di89JxcD2FFFYQ
         PGww==
X-Gm-Message-State: ACrzQf3BOn0Zt3SclneCt6JhOcxI4aNuNDSiRMJTFTyTaJhwcoRR35vu
        zM/Czk9Ii73DJgqYeM+hm83vtw==
X-Google-Smtp-Source: AMsMyM5Iuw0RqbwbrMRUpxKJ5TJiDFzMaebqM/XNUSR6lEtfrIu/4s2HTdwzM+EyFahSXBfODig/UQ==
X-Received: by 2002:a05:6e02:17cb:b0:2f9:1fb4:ba3b with SMTP id z11-20020a056e0217cb00b002f91fb4ba3bmr4619132ilu.257.1666017127074;
        Mon, 17 Oct 2022 07:32:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p14-20020a92c60e000000b002f90ff8bcbbsm3757007ilm.37.2022.10.17.07.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 07:32:06 -0700 (PDT)
Message-ID: <4197d345-ff6f-ad43-bbfb-1f65635c191e@linuxfoundation.org>
Date:   Mon, 17 Oct 2022 08:32:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] tracing: fix dynevent test requirements
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221017090741.2881918-1-mark.rutland@arm.com>
 <20221017103000.7d0fa449@gandalf.local.home>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221017103000.7d0fa449@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 08:30, Steven Rostedt wrote:
> On Mon, 17 Oct 2022 10:07:41 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
>> Currently a couple of dynevent tests will always report UNSUPPORTED and
>> not run, even when support is actually present.
>>
>> In commit:
>>
>>    95c104c378dc7d4c ("tracing: Auto generate event name when creating a group of events")
>>
>> The README text for synthetic events was changed from:
>>
>>    "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]\n"
>>
>> To:
> 
> This was already fixed here:
> 
>   https://lore.kernel.org/all/20221010074207.714077-1-svens@linux.ibm.com/
> 
> Shuah, can you take Sven's patch through your tree?
> 
> Thanks,
> 
> -- Steve
> 

Yes.  I will take this in for the next rc

thanks,
-- Shuah
