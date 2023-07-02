Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14A744E0A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGBOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:08:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B5E55;
        Sun,  2 Jul 2023 07:08:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b88e84bfb8so5296385ad.2;
        Sun, 02 Jul 2023 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688306931; x=1690898931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2w54nxVPO6o+8J39UnS81CRAIwBFUFMqVaCHwISr5M=;
        b=NhA8IRXhuz+9cb9k7oJEZMFJB+zk8luptjHKRD33C9XVCRx/tJj0F9BwxZBPDFAH5c
         pkp5zQHJirG3UYoDwjjQo4ECLz0PpXTvxNsny8j414NguTK4EYbQmKcy0pe+75oz5ilT
         PvLRuqQ4Av8ajdzLMUeVFBOVFN5pGXLPQtQhoCYVfBGxxqJezE0C0LtWloErnPi5iC6H
         GDK0LFeZbMkbojtMzDaSzvlZHAm0CIH2I64MkYNCHV46VDmPN2uFw+oRK37xsAZynyu2
         YFFEScNGDXF+qtPk3dhaK2elIJwMhQxwh/RhKkGuiSglNPaNNfJvaQ8lzdAyvx3ij4sb
         iduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688306931; x=1690898931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2w54nxVPO6o+8J39UnS81CRAIwBFUFMqVaCHwISr5M=;
        b=WD2IVBIrvoTpqvJv5uzWxRItxn/jdyJvwBnp13zImOIJHYumnMKMKxf1VFvs/fhCB7
         ynfKgucn6fJjNke3BWCq20Omrj3NGOnU4sXniDlwPT95Qpi2WzoHgUpJW9VOZ0symy+k
         iGvchRcsxER1b3nQFPc2MmSUExx/Upc25xuH28trNp5h5p2gTZ46EdTHVDEJuT0wFAt2
         41myRs3Docxy+ZK3Wz4WlDaU7nMUzNJztL0/ItBN0CqQ4GShcjDQaYCdOJ+fTrL8uLRN
         yqBEbLHsMZeSj8om9+ZXEa1frOQS1/qPGKtD8L4u+3FvGgInO7gyvur1TKfn6hydUm6U
         RyzQ==
X-Gm-Message-State: ABy/qLaJSQOJC5bDgZkny9UTWzbbqCcendhQHR2JluxTTS+14RoSCKcb
        8UPjl7qE7F5ZxDiTirefIEk=
X-Google-Smtp-Source: APBJJlFa2PZ9jIdWwi9dWb1g0KHD9JH5PBgSre+nm+nmMS7SXICBfS5NfytLiK5hr6npw22hSdVnsQ==
X-Received: by 2002:a17:902:d703:b0:1b8:9046:4bfb with SMTP id w3-20020a170902d70300b001b890464bfbmr2062798ply.9.1688306930794;
        Sun, 02 Jul 2023 07:08:50 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902b58300b001ab2b415bdbsm13635200pls.45.2023.07.02.07.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 07:08:50 -0700 (PDT)
Message-ID: <644f4551-32e8-11f9-0d4a-ad1045fdae77@gmail.com>
Date:   Sun, 2 Jul 2023 21:08:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Eric DeVolder <eric.devolder@oracle.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        David R <david@unsolicited.net>,
        Boris Ostrovsky <boris.ovstrosky@oracle.com>,
        Miguel Luis <miguel.luis@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>,
        Wireguard Mailing List <wireguard@lists.zx2c4.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Manuel 'satmd' Leiner <manuel.leiner@gmx.de>
References: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
 <79196679-fb65-e5ad-e836-2c43447cfacd@gmail.com>
 <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/23 19:37, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 02.07.23 13:57, Bagas Sanjaya wrote:
>> [also Cc: original reporter]
> 
> BTW: I think you CCed too many developers here. There are situations
> where this can makes sense, but it's rare. And if you do this too often
> people might start to not really look into your mails or might even
> ignore them completely.
> 
> Normally it's enough to write the mail to (1) the people in the
> signed-off-by-chain, (2) the maintainers of the subsystem that merged a
> commit, and (3) the lists for all affected subsystems; leave it up to
> developers from the first two groups to CC the maintainers of the third
> group.
> 

Hi,

In this case I had to also Cc: wireguard, bonding, RCU, and x86 people,
since this issue spans these subsystems (I naively thought). Anyway,
thanks for detailed tip (honestly /me wonder if I forgot this later, as
is often the case).

>> On 7/2/23 10:31, Bagas Sanjaya wrote:
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>
>>>> I've spent the last week on debugging a problem with my attempt to upgrade my kernel from 6.2.8 to 6.3.8 (now also with 
>> [...]
>>> See Bugzilla for the full thread.
>>>
>>> Anyway, I'm adding it to regzbot to make sure it doesn't fall through cracks
>>> unnoticed:
>>>
>>> #regzbot introduced: fed8d8773b8ea6 https://bugzilla.kernel.org/show_bug.cgi?id=217620
>>> #regzbot title: correcting acpi_is_processor_usable() check causes RCU stalls with wireguard over bonding+igb
>>> #regzbot link: https://bugs.gentoo.org/909066
> 
>> satmd: Can you repeat bisection to confirm that fed8d8773b8ea6 is
>> really the culprit?
> 
> I'd be careful to ask people that, as that might mean a lot of work for
> them. Best to leave things like that to developers, unless it's pretty
> obvious that something went sideways.
> 

OK.

>> Thorsten: It seems like the reporter concluded bisection to the
>> (possibly) incorrect culprit.
> 
> What makes your think so? I just looked at bugzilla and it (for now)
> seems reverting fed8d8773b8ea6 ontop of 6.4 fixed things for the
> reporter, which is a pretty strong indicator that this change really
> causes the trouble somehow.
> 

OK too.

> /me really wonders what's he's missing
> 
>> What can I do in this case besides
>> asking to repeat bisection?
> 
> Not much apart from updating regzbot state (e.g. something like "regzbot
> introduced v6.3..v6.4") and a reply to your initial report (ideally with
> a quick apology) to let everyone know it was a false alarm.
> 

OK.

-- 
An old man doll... just what I always wanted! - Clara

