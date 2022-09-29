Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA75EF0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiI2IsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiI2IsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:48:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC10135043;
        Thu, 29 Sep 2022 01:48:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b5so863722pgb.6;
        Thu, 29 Sep 2022 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LPIjcxqEG5Ykvv0RYWwDgz52L7harSKek7HWfDdgQdU=;
        b=ZyIBEMLUoaESSJeqOS0JI3ZdR34f1X0R8oDd1KUAHBeOoKhXgjOXD34isIOsLSzzl1
         EwQwMwPg4xEB7shVlYtNOOHyh2wTeS95La91f2+vbdguvCRWLyWLJ1W8YGr5VLrdcl+y
         k0eLWMwSLo4bh+pTKNCaOhBnW8NMNEkkfJdd1fzigy7sGlkFpFrzCJFDg53xsF3KoSoh
         rNr00vwdmYtqeDPc45dQ4D9cOzURbyIKsKQelVEJP576xU8XQHcXkzi7L+fhQ60J3zQ4
         HjRUMVry5v2Z9lTdP3alMa/FGwL2okHlJ1OWXBqGAB8LmrJ3yJlKoTm27pIMCG2GffGn
         xddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LPIjcxqEG5Ykvv0RYWwDgz52L7harSKek7HWfDdgQdU=;
        b=75LOoxIKKbx7EQCDwl9oKSiS4Xcv7mmk4TUX7cSWzf9KnSjqIXa013r+G4jQ1i0ECF
         h/NyOJb/dZmpWM+vFvv7zZTN/sUtLPb5XfKzEXRSMZHbBiVeSezWm4chjYPVfwCkXaA/
         9NwkhnfaFVjl1uo2WxZgQI17va9h5pRvRBYuEX6aUiXZJ42JV4gbNe3C0a2QnEqhfwa5
         jeiRLB8PRQaUChU15vORIwD3dcbRsMYuE40km7sIGcjbmqOdxyA/uacn9bCTbrIjta9u
         If1FBhdNYTKKI/v1MhdiWwTj9yZ+DmR3HOz5i/5vN61jATFeCqGnUctnT6f6FkT5ddRG
         XodQ==
X-Gm-Message-State: ACrzQf3WmLlT50ayrVz6ourKbaf8Cur6o/QTU/MtcSlqhpAUg9K0/FQ7
        TmX2kbK6lgRRsvgh22Br3VQ=
X-Google-Smtp-Source: AMsMyM5FpKaM9A5fR9Nk6T/5JPue3Q5c9vpxFokqlZS7/CpEgL1GT2mHddYH5UlCXBA0AyI8m7Q7FA==
X-Received: by 2002:a05:6a02:318:b0:43c:e24a:961c with SMTP id bn24-20020a056a02031800b0043ce24a961cmr1909302pgb.589.1664441296956;
        Thu, 29 Sep 2022 01:48:16 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902e75100b00179eaf275d5sm5360741plf.27.2022.09.29.01.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:48:16 -0700 (PDT)
Message-ID: <db30d4f1-31c7-6cbd-f87f-abefa7f4e781@gmail.com>
Date:   Thu, 29 Sep 2022 15:48:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     babu.moger@amd.com
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <YzPMorJQFKPY+n4d@debian.me> <99bfbeac-1454-a453-a2ef-36eee2aea34c@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <99bfbeac-1454-a453-a2ef-36eee2aea34c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 22:23, Moger, Babu wrote:
>> Hi Babu,
>>
>> The description text for each snippets above shouldn't in the code
>> block. Also, split the block into three code blocks in the lists:
> Did you mean, I need to remove similar texts from code?

I mean extracting code description from the code block, see the diff below.

>>
>> ---- >8 ----
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index b4fe54f219b6f3..ec578b069276ce 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -206,25 +206,26 @@ with the following files:
>>          all the event types and the mbm_local_bytes configuration is set to
>>          0x15 to count all the local memory events.
>>  
>> -        Example::
>> +        Examples:
>> +
>> +        * To view the current configuration::
>>  
>> -            To view the current configuration, run the command.
>>              # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>              0:0x7f;1:0x7f;2:0x7f;3:0x7f
>>  
>>              # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>>              0:0x15;1:0x15;3:0x15;4:0x15
>>  
>> -            To change the mbm_total_bytes to count only reads on domain 0,
>> -            run the command. The bits 0,1,4 and 5 needs to set.
>> +        * To change the mbm_total_bytes to count only reads on domain 0
>> +          (the bits 0, 1, 4 and 5 needs to be set)::
>>  
>>              # echo  "0:0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>  
>>              # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>              0:0x33;1:0x7f;2:0x7f;3:0x7f
>>  
>> -            To change the mbm_local_bytes to count all the slow memory reads on
>> -            domain 1, run the command. The bits 4 and 5 needs to set.
>> +        * To change the mbm_local_bytes to count all the slow memory reads on
>> +          domain 1 (the bits 4 and 5 needs to be set)::
>>  
>>              # echo  "1:0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
>>  
> 
> Thanks for the diff. I cannot get this right for some reason. I will
> probably send the diff before the final series.
> 
>

OK.
 
>>
>> Also, there isn't description of mapping from bits from the supported events
>> table to the bytes input for mbm_{total,local}_config.
> 
> It is already there. Is that not clear?

No. I don't see why setting bits 0, 1, 4, and 5 on domain 0 translates to
`0:0x33`, for example.

>>
>>> +Slow Memory b/w domain is L3 cache.
>>> +::
>>> +
>>> +	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
>>> +
>> What b/w stands for in the context above?
> b/w is bandwidth. I will correct it.

OK.

Thanks for replying.

-- 
An old man doll... just what I always wanted! - Clara
