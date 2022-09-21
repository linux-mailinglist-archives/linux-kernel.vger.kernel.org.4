Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE3A5E5679
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIUXAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIUW7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:59:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139B426AC9;
        Wed, 21 Sep 2022 15:59:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so309031pjh.3;
        Wed, 21 Sep 2022 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=lBnR53ANCaDyPc3qcocGRLcYZiJwG7+RpYHqZ1x2chU=;
        b=jgGHVa4cdfBaZ3z/8SzRvRrtkw8prE1WflVhGggPG0zFrMh7W7HMmF/HMOxVeNNl1B
         SEpAp8+nC/4LguO6KmZLn/rsusoQ5ErtzaizLHS7myZgkWHVNQj3tAd10gIUV37LJluM
         pkygN1Rl9O3qxgP703Y/t8l7evyScaoNtOd9rX8MW4HIBN0hlscadXT+3u++Bnhzgd1B
         D2PeT7pPx2nHKrY/c20fIXeK757UlbVGxaJr+vNQlPnRk7ItkpoCu/EJFJ2D2A6bcdgz
         g5deXP6ZxrRKifKpVNEnUD0WC3IFPSx5wt0OEPDDrHchmDWnoUcoPGPP0PC270lZSKY7
         JTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lBnR53ANCaDyPc3qcocGRLcYZiJwG7+RpYHqZ1x2chU=;
        b=ZfyO96ZqTujz7k8uwSrlxO24VWKNpz67ObClpLwGUJerYDBjIBhauQat9nVej6+FNR
         oaFxL92LvnyvmKm5/7fijA6JEaq/0ig7F5A2dpXpGeGUs8zKxW6lZLUVw4brsq491va3
         SsuvGx2R73lp0p7bhLkua96Ipgb2CwPv0B8Vq9AuxB3me/BGm2GgdJBlJNGN59g+DCPr
         Yj7Gxm6LESXaomlHH8ssQ4o9zfUu2ZHOJW+SBLAoU8qQuXfB8YE08wsuCNRixsEuKLBA
         SNfPL/kIG1sPd3tPeY+LTa70im93qJLux9YhyZk472y9TLm8v4OF3YWVfmWF8CiK15bh
         rEDw==
X-Gm-Message-State: ACrzQf1B4MQDdCkOEodVGybdgz8BzTzrbgU/VNuJRXqyybTT2Y7NyTF5
        NfiZGuF4UUSJ689VU8R1hRU=
X-Google-Smtp-Source: AMsMyM5/h31u9f1TYLMFVZMqNEoGB/fUW/DdlS8BRUAJtUvc50rVA9A1rAm33RAkjAMJmHouEoIi7w==
X-Received: by 2002:a17:902:e742:b0:176:dc6b:eecc with SMTP id p2-20020a170902e74200b00176dc6beeccmr371049plf.104.1663801193360;
        Wed, 21 Sep 2022 15:59:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nn17-20020a17090b38d100b0020396a060cdsm2449182pjb.13.2022.09.21.15.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 15:59:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1a6e7165-cdae-6c8c-f57d-159fdb68897b@roeck-us.net>
Date:   Wed, 21 Sep 2022 15:59:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        Sean Christopherson <seanjc@google.com>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
 <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
In-Reply-To: <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 13:59, Dave Hansen wrote:
> On 9/21/22 13:07, Guenter Roeck wrote:
>> [    2.042861] CPA refuse W^X violation: 8000000000000063 -> 0000000000000063 range: 0x00000000c00a0000 - 0x00000000c00a0fff PFN a0
>> ILLOPC: cbc65efa: 0f 0b
>> [    2.043267] WARNING: CPU: 0 PID: 1 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0xdca/0xdd0
> ...
>> [    2.050307] ---[ end trace 0000000000000000 ]---
>> [    2.050762] PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
>> [    2.051115] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>> [    2.051115] BUG: unable to handle page fault for address: c00fd2bf
> 
> This _looks_ like it is working as intended.  The PCI BIOS code tried to
> make a RWX page.  The CPA code refused to do it and presumably returned
> an error, leaving a RW page, non-executable page.  The PCI code didn't
> check the set_memory_x() return code and tried to go execute anyway.
> That resulted in the oops.
> 
> I was able to reproduce this pretty easily.  The workaround from dmesg
> is pci=nobios.  That seems to do the trick for me, although that advise
> was sandwiched between a warning and an oops, so not the easiest to find.
> 
> I'm a bit torn what to do on this one.  Breaking the boot is bad, but so
> is leaving RWX memory around.
> 
> Thoughts?

For my part I'll do what the above suggests, ie run tests with PAE enabled
with pci=nobios command line option. AFAICS that hides the problem in my tests.
I am just not sure if that is really appropriate.

Guenter
