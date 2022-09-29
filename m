Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E55EF6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiI2Nee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiI2Neb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:34:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F95145CA7;
        Thu, 29 Sep 2022 06:34:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b75so1463639pfb.7;
        Thu, 29 Sep 2022 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7WfdncdEGCadZJ3/QS+GtGXLT8IkfFnobfUtHRR5YNg=;
        b=o44F1pPy1sJ/51HdRSxMd9Ao1GEYzBWXqikGK5QsnQ951c31zL0rYVlKeqUhWRoT2F
         V+EPOqmFl8EcRF21EFQctLGbSWK3emZTXSDCUMLq65EUtKAwDGk5Acs8dreEaMo+VaRw
         OZlD84TJhR5RXqjrfWZjSHSue44Z4Mlun1KzvZvfsybUVXBmdXAz9W6bv7vAZLnflCUH
         bjHxEklZCWktw7u5WdqPouS9sdiQ/aF6TNF45bu30qZogdd5N6IP2vcM46Oqx11W0wIh
         +XaLTvA1zLhFuF3IY7dDiKXDD+pqLVFr4r/dMMc6GSxkMiACMxRYKAMPVJ21yXq1OnOy
         PaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7WfdncdEGCadZJ3/QS+GtGXLT8IkfFnobfUtHRR5YNg=;
        b=myY0Fb28I9bxQmGv38M5SL2i4Oep6vm77EmUqhwERuPtQmdT72dFUsU9edyxM0AGcY
         zDE6PCJxfj1/VVsUaVPtyZ6j5zT8FbPGpor4h0W+OsQTe7Suag47dcWfwDt8sfNiJ/3t
         85XQS/t3dAlgktluoBfNS26fFMCZudLFk9h0LESFp5BrJpsZolsIz/MoC9qKGsHwG53L
         6Au64EEQEuwDOfS57FbiLHkABfsjTMl5D5uBX3Yx8vYNO8K9obNu1o1vv5pPSmcITHgt
         OxLXOuiXyqlXP7UIbY+S1llUEPHepnre4wOasrMakODpS0e+/NDfMgqX9OZjSMPP96pq
         97cA==
X-Gm-Message-State: ACrzQf1cT2l+fRJ+wrrWoK5RBhmDG6vuhehilFPXzWZZXC1a305gujUe
        7+QpJAxW99TeSXhQzGEj+H0=
X-Google-Smtp-Source: AMsMyM6idfvdXSqLXEQcJI3fBq6wvKSo0+7WepsYsxkGN1iKjzo7efaRzvF/glGmUf82Lf42CBesUg==
X-Received: by 2002:a05:6a00:f04:b0:547:50b1:4f4e with SMTP id cr4-20020a056a000f0400b0054750b14f4emr3615696pfb.69.1664458469591;
        Thu, 29 Sep 2022 06:34:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001766a3b2a26sm5957321plg.105.2022.09.29.06.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 06:34:29 -0700 (PDT)
Message-ID: <8286def4-8086-9014-7893-afa805bd2afc@gmail.com>
Date:   Thu, 29 Sep 2022 20:33:13 +0700
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
 <db30d4f1-31c7-6cbd-f87f-abefa7f4e781@gmail.com>
 <00e2440f-0f01-5d25-a5c0-d10ff52108ca@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <00e2440f-0f01-5d25-a5c0-d10ff52108ca@amd.com>
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

On 9/29/22 20:22, Moger, Babu wrote:
>>>> Also, there isn't description of mapping from bits from the supported events
>>>> table to the bytes input for mbm_{total,local}_config.
>>> It is already there. Is that not clear?
>> No. I don't see why setting bits 0, 1, 4, and 5 on domain 0 translates to
>> `0:0x33`, for example.
> 
> It is 110011b(binary) which is 0x33. I can make that little more clear.
> 

Ah! I see that flipping bits in order to to set the flag. Thanks for
the explanation.

-- 
An old man doll... just what I always wanted! - Clara
