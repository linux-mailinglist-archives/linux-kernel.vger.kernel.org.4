Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1742744D7E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 13:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjGBL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGBL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 07:57:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E67E73;
        Sun,  2 Jul 2023 04:57:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b82bf265b2so15577465ad.0;
        Sun, 02 Jul 2023 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688299042; x=1690891042;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qagKLZGa10wVvAq9nJ5ZILI98Y2jy96AWT9f4TfrO8=;
        b=Lp2sEjNT5bKhVCBgHl3nADK0T6dCzbAGMULQ8a01f0WSYh5V+VyzpqN6nRviRXY14l
         TuGij9y1QDbB5weNaxnndCHewGgNzjQctmmwA9p10EraO6jqGyd4Y9mSs3iXpc0eMQ0f
         mhqA80KUShZ6yE+rTLGzQcrp5XD3ZyYA/5W3IASKWR5MxWvgZJCWILuEPI/wtdBUpq7h
         jS3zBfTPXVGAyWplOa3qj8l5StQhaGEi+dRHM+o80rS8CQdAgMFAIqrr2/dwywj7cf3N
         /Pwv97UPtiwTZdTWV2IxxVSbbaPt1rPPOzN2PbXcrZd3x7dJK8bFOsbp+3tDdGPiN0XA
         KVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688299042; x=1690891042;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qagKLZGa10wVvAq9nJ5ZILI98Y2jy96AWT9f4TfrO8=;
        b=N8wJOHLbU+84Ilz5ELGGORJJm4YF0Le2m86kGI0rj+JRF585sN95tsgX7N8bSF/HaB
         zJmW83RKd4QIYaE8KtbuS5oL76Iig35iMHaj/EvXjMZUOmzd0g0ysheX4zx6nSSjboIc
         FDYsKbpjdHqUNw8yw6XKm7AzHzXxe6o4lVlRnEmenoYQ85PpzbzTAIBTR3WjXjDPTOvf
         GnZ58OoWTDUNpchRtMG0af8bRoODwLwO4l2T5CoXifTuEbAGaLAKxaFdgh3jYB5WfGZU
         cIGXR9etvjW2jpBNvMIH/LR5NzwpTPKsb+l2lBdj/PGdzdWgDnhcS+wEGJcMW69LyQzK
         r4rA==
X-Gm-Message-State: ABy/qLblAd4Dbsmd+5ALIpkV/8vp2oAlHl5pJy71VHNZjFZFLL+0yLYR
        Daj1vBq0alfYzPPqMfAdXaA=
X-Google-Smtp-Source: APBJJlE4CbVvUaMvQBQttUFOCXJMSfMnxOJ3T5YMiAeUk7XAACrdXab8dfLsDFAcYWm09mkvHX3dOQ==
X-Received: by 2002:a17:902:d4c4:b0:1b8:2c6f:3247 with SMTP id o4-20020a170902d4c400b001b82c6f3247mr6252238plg.4.1688299041674;
        Sun, 02 Jul 2023 04:57:21 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b001b8932d77d7sm490425plb.279.2023.07.02.04.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 04:57:21 -0700 (PDT)
Message-ID: <79196679-fb65-e5ad-e836-2c43447cfacd@gmail.com>
Date:   Sun, 2 Jul 2023 18:57:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Eric DeVolder <eric.devolder@oracle.com>,
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
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RCU <rcu@vger.kernel.org>,
        Wireguard Mailing List <wireguard@lists.zx2c4.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Manuel 'satmd' Leiner <manuel.leiner@gmx.de>
References: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
In-Reply-To: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
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

[also Cc: original reporter]

On 7/2/23 10:31, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> I've spent the last week on debugging a problem with my attempt to upgrade my kernel from 6.2.8 to 6.3.8 (now also with 6.4.0 too).
>>
>> The lenghty and detailed bug reports with all aspects of git bisect are at
>> https://bugs.gentoo.org/909066
>>
>> A summary:
>> - if I do not configure wg0, the kernel does not hang
>> - if I use a kernel older than commit fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c, it does not hang
>>
>> The commit refers to code that seems unrelated to the problem for my naiive eye.
>>
>> The hardware is a Dell PowerEdge R620 running Gentoo ~amd64.
>>
>> I have so far excluded:
>> - dracut for generating the initramfs is the same version over all kernels
>> - linux-firmware has been the same
>> - CPU microcode has been the same
>>
>> It's been a long time since I seriously involved with software development and I have been even less involved with kernel development.
>>
>> Gentoo maintainers recommended me to open a bug with upstream, so here I am.
>>
>> I currently have no idea how to make progress, but I'm willing to try things.
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding it to regzbot to make sure it doesn't fall through cracks
> unnoticed:
> 
> #regzbot introduced: fed8d8773b8ea6 https://bugzilla.kernel.org/show_bug.cgi?id=217620
> #regzbot title: correcting acpi_is_processor_usable() check causes RCU stalls with wireguard over bonding+igb
> #regzbot link: https://bugs.gentoo.org/909066
> 

satmd: Can you repeat bisection to confirm that fed8d8773b8ea6 is
really the culprit?

Thorsten: It seems like the reporter concluded bisection to the
(possibly) incorrect culprit. What can I do in this case besides
asking to repeat bisection?

-- 
An old man doll... just what I always wanted! - Clara

