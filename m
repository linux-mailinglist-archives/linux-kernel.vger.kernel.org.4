Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47546748B46
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjGESLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGESLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:11:42 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0060A170B;
        Wed,  5 Jul 2023 11:11:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b3ca17f2a6so2144950fac.0;
        Wed, 05 Jul 2023 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688580700; x=1691172700;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Iq0v+9fymbgFhRihVMRoWwi6Rd8afLWBuIkpaTjTwk=;
        b=GFJl2Y1meDyik/DDdV9VstIX7NW4pypN69n0NdG9/8m2vlmFNGHwDpffvGlOBAc9O4
         I4CvfgPOLreiPrWVN37kcMlIuEP02Onz7qWVugbzvFvUkKu9NmcSGfiVkmGWMslio1+t
         y8pXEH8izTUccegunhOy7/ojDAveGeAiJzX2uHlyWD94e+uAeJzqLX9B662bRvpYqePz
         olO8zWzkP0lV3YhZEPnUMIuB2PR7JJeLX4t3QjciGdj44ZZQUrwS4ut//cy/G4RxhJ42
         4VwC4ie8W4oesEqplyVvmLHOrt3+nN8fkSWyCXeRNXyQsNem1prsojojl6hV6B+snjUI
         nLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580700; x=1691172700;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Iq0v+9fymbgFhRihVMRoWwi6Rd8afLWBuIkpaTjTwk=;
        b=Gmn6ETjDXHTKkVvd6g699nqyGsMTyTpE/tjBPtn5W7nqtSVjj88t3IUF/SKSyqO5gq
         1t+GEO1g4ihgqFcmVRq6Tf39gmObm+XzJTbR38M6GT1Dob5aNu1Kwh6lNyFM9MFpAmdu
         eYmuDNZ/A2FwlfOVJKBYPArxeNI3Wwb6TZacJCNrTt0Xe71obXZi+fwmVQ+DtQmdjUJ/
         2z29ZiGNynHEC+ptCIREBuA6A7m8eoRd8BObSwI2eDeKVgog5Gmfla7KYbHzV+N6GOE2
         u+/i8p/9idkdkm9cQmh2ObeRHqP28DKHfveEYE5w/D9LQSpSVzrKemcelgLUwCbMcaSE
         pi1g==
X-Gm-Message-State: AC+VfDwXez7WMOYUaSSdGIaNJRVbpEYsH6fucGV4qksYQ8GRl8Zz+bia
        l4k5sLb6NsmxxcjO9NRL+iY=
X-Google-Smtp-Source: ACHHUZ4r0Tu+dbwv/dV1GkBH1dLLBFf5AqxfoMNu9YqQeQVRfy3cj1/CSsqUUvLiOpENO4BXj5IO+Q==
X-Received: by 2002:a05:6870:3e04:b0:196:8dc3:4e16 with SMTP id lk4-20020a0568703e0400b001968dc34e16mr17033460oab.39.1688580700120;
        Wed, 05 Jul 2023 11:11:40 -0700 (PDT)
Received: from [192.168.1.128] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id oa24-20020a056870bc1800b001b075c1a6e5sm10139647oab.20.2023.07.05.11.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 11:11:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <64b8732f-6319-9f10-b82a-b4a3dd8d4b8e@lwfinger.net>
Date:   Wed, 5 Jul 2023 13:11:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Linux-6.5 iwlwifi crash
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
 <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
 <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info>
 <CAAJw_Zu=MPtGPARgCB2fteP+7F793YDFXE9RuzSH8EqYBS-OOw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAJw_Zu=MPtGPARgCB2fteP+7F793YDFXE9RuzSH8EqYBS-OOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 06:56, Jeff Chua wrote:
> On Wed, Jul 5, 2023 at 4:37 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> Hi! Thanks for your report.
>>
>> Side note: is there any relation to the thread[1] you posted this in?
> 
> Sorry, I was just posting to the same email list that I had reported
> about a different wifi list earlier. No relation to this, but it's a
> new wifi issue.
> 
>> Doesn't look like it from here.
>>
>> Side note: discussing multiple unrelated issues in one thread increases
>> the risk a lot that some or all of them are ignored:
>> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/
>>
>> [1] https://lore.kernel.org/all/ZE0kndhsXNBIb1g7@debian.me/
>>
>> On 05.07.23 09:24, Jeff Chua wrote:
>>> Latest linux-6.4
>>
>> What do you mean by that? From later in the mail it sounds like you mean
>> latest mainline -- is that correct?
> 
> It's from linux git pull. It's 6.5-rc but I didn't write that way
> becuase Linus's branch is still 6.4 ... that 6.5-rc0 or rc1 should
> have more appropriate.
> 
>>> after June 27 crash my whole linux notebook once
>>> iwlwifi is loaded. Anyone seeing this?
>>
>> I haven't heard of any such problems, but that doesn't have to mean much.
> 
>>> Bisect? Or there's a patch for this?
>>>
>>> # modprobe iwlwifi
>>> ... Whole system frozen!
>>>
>>>
>>> Here's my system before the crash ...
>>>
>>> # dmesg
>>> cfg80211: Loading compiled-in X.509 certificates for regulatory database
>>> Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>>> iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
>>> iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
>>> thermal thermal_zone1: failed to read out thermal zone (-61)
>>> iwlwifi 0000:00:14.3: Sorry - debug buffer is only 4096K while you
>>> requested 65536K
>>>
>>> # lspci
>>> 00:14.3 Network controller: Intel Corporation Alder Lake-P PCH CNVi
>>> WiFi (rev 01)
>>>
>>> # linux git log
>>> commit d528014517f2b0531862c02865b9d4c908019dc4 (HEAD -> master,
>>> origin/master, origin/HEAD)
>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>> Date:   Tue Jul 4 15:05:12 2023 -0700
>>>
>>> # lsmodModule                  Size  Used by
>>> iwlmvm                397312  0
>>> mac80211              626688  1 iwlmvm
>>> iwlwifi               307200  1 iwlmvm
>>> cfg80211              413696  3 iwlmvm,iwlwifi,mac80211

Jeff,

Fow what it is worth, my 6.4-git (6.5-rc0?) commit d528014517f2 (pulled today) 
is working OK with iwlmvm. Lspci says my device is

04:00.0 Network controller [0280]: Intel Corporation Wireless 7260 [8086:08b1] 
(rev 73)

I think you do need to do a bisection.

Larry



