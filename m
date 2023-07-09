Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513CE74C66B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGIQ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 12:28:06 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B2A8;
        Sun,  9 Jul 2023 09:28:05 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5634db21a78so2678409eaf.0;
        Sun, 09 Jul 2023 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688920084; x=1691512084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Mnp7Gx1O4lBi6RB6np/kLFboJ0ahJMfnsN6pSM7+9k4=;
        b=C3Z8Rw5eHLgZLt/1ByF8+nxD3uvgzIOCbeyD6rfZNLgsRMPLgEexhGgcnFPbQyoWGj
         74ImKO3YsvkZWRNVmzLcacKTxJV6nV7KsBeEtOC1BKWbHH86F1mJOGgbAV459dfl/FJu
         XCevRxYtHvMp4XASirzqqS2qF7pTeDqdiTaLpj106T/gzelDXnvnkLOjmjBb6o//AOZH
         tlEA7j0fgMYsdlLibdsah5rlxd+qVHwDj4I+hYcOXU8l58HHRk2O5InJCRhk6VpW8t43
         gEgCi1VhGtk0YgXXtzYSioCp237OKLhuxeKxNP67W21scEUsDzxjr99/QQNo9lTTK5np
         bG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688920084; x=1691512084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mnp7Gx1O4lBi6RB6np/kLFboJ0ahJMfnsN6pSM7+9k4=;
        b=HRRbPPrdzS6qQaAf6kUq+cnDGWP6eFLRrpmHJ76RDFN5FnsVc+S089Bod6FJyzwiUL
         9/uVjq5eOnjMbSt5+ADoJRF27Bi22mZHeQvRHS2LKi/RgKz9wX0bm+qdL8Pm3wNlzH4T
         V8uFqKFzCOSTWv7EqniG/am9kV/GMWfzgnNpiXRcQPjc7ehtsPYk6t6/ZqU3h7CZFwGf
         dP09D85g4WGZxF36Tsus6M6InNl1dvaRSOCLw/5nbz9VTLuJcna7AsuMV35VMWBcQxwc
         czvtlFIQiqXIWvOQOhIDPdAh0AE0vBcnLZ7Cg0PNCC7MUeIS63AOh8ZAakBn1IyUUXgJ
         ndsg==
X-Gm-Message-State: ABy/qLbjXSmG9wljqTMauu5+4d1k6/RJDuMaLfwfvxeO9E2M9UNewmJ2
        kwd+tSlXL7UIzxflILQQNhc=
X-Google-Smtp-Source: APBJJlE60avBl+3E9vLwVQj9Z7ucwDB15X967F/kv0vGm7ovzn82ucw0rFV/AvNaXRSZZAkAskZtJQ==
X-Received: by 2002:a05:6808:1a81:b0:3a3:6536:dd89 with SMTP id bm1-20020a0568081a8100b003a36536dd89mr9022353oib.49.1688920084438;
        Sun, 09 Jul 2023 09:28:04 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n5-20020aca2405000000b003a1f444307esm3367199oic.58.2023.07.09.09.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 09:28:03 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b4063a55-be7c-8f3a-2529-e1211080d323@lwfinger.net>
Date:   Sun, 9 Jul 2023 11:28:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "Baruch, Yaara" <yaara.baruch@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com>
 <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
 <c65d0837-5e64-bec7-9e56-04aa91148d05@leemhuis.info>
 <4153ce0aac6dc760a3a9c7204c5c9141b60839a4.camel@intel.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <4153ce0aac6dc760a3a9c7204c5c9141b60839a4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/23 08:27, Zhang, Rui wrote:
> On Sat, 2023-07-08 at 16:17 +0200, Thorsten Leemhuis wrote:
>> On 07.07.23 12:55, Linux regression tracking (Thorsten Leemhuis)
>> wrote:
>>> On 07.07.23 10:25, Zhang, Rui wrote:
>>>>
>>>> I run into a NULL pointer dereference and kernel boot hang after
>>>> switching to latest upstream kernel, and git bisect shows that
>>>> below
>>>> commit is the first offending commit, and I have confirmed that
>>>> commit
>>>> 19898ce9cf8a has the issue while 19898ce9cf8a~1 does not.
>>>
>>> FWIW, this is the fourth such report about this that I'm aware of.
>>>
>>> The first is this one (with two affected users afaics):
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217622
>>>
>>> The second is this one:
>>> https://lore.kernel.org/all/CAAJw_Zug6VCS5ZqTWaFSr9sd85k%3DtyPm9DEE%2BmV%3DAKoECZM%2BsQ@mail.gmail.com/
>>>
>>> The third:
>>> https://lore.kernel.org/all/9274d9bd3d080a457649ff5addcc1726f08ef5b2.camel@xry111.site/
>>>
>>> And in the past few days two people from Fedora land talked to me
>>> on IRC
>>> with problems that in retrospective might be caused by this as
>>> well.
>>
>> I got confirmation: one of those cases is also caused by 19898ce9cf8a
>> But I write for a different reason:
>>
>> Larry (now CCed) looked at the culprit and spotted something that
>> looked
>> suspicious to him; he posted a patch and looks for testers:
>> https://lore.kernel.org/all/0068af47-e475-7e8d-e476-c374e90dff5f@lwfinger.net/
> 
> I applied this patch but the problem still exists.
> 
> thanks,
> rui

Rui,

I am not surprised that the patch did not help. I guess you will need to stay 
with kernel 6.3.X until the Intel developers return from their summer break.

Larry


