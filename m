Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5174DBF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjGJRJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGJRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:09:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E8AC0;
        Mon, 10 Jul 2023 10:09:21 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIuNj-000676-Ls; Mon, 10 Jul 2023 19:09:03 +0200
Message-ID: <c76eae67-b391-a39e-a907-988b8277a72b@leemhuis.info>
Date:   Mon, 10 Jul 2023 19:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: 3 more broken Zaurii - SL-5600, A300, C700
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Andrew Lunn <andrew@lunn.ch>,
        Ross Maynard <bids.7405@bigpond.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
 <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
 <e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
 <ZKbuoRBi50i8OZ9d@codemonkey.org.uk>
 <62a9e058-c853-1fcd-5663-e2e001f881e9@bigpond.com>
 <14fd48c8-3955-c933-ab6f-329e54da090f@bigpond.com>
 <05a229e8-b0b6-4d29-8561-70d02f6dc31b@lunn.ch>
 <ac957af4-f265-3ba0-0373-3a71d134a57e@leemhuis.info>
 <20230710095519.5056c98b@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230710095519.5056c98b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689008961;6a1d2bdd;
X-HE-SMSGID: 1qIuNj-000676-Ls
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 18:55, Jakub Kicinski wrote:
> On Sun, 9 Jul 2023 06:36:32 +0200 Linux regression tracking (Thorsten
> Leemhuis) wrote:
>> To chime in here: I most agree, but FWIW, it broke more than a decade
>> ago in v3.0, so maybe this is better suited for net-next. But of course
>> that up to the -net maintainers.
> 
> I'm surprised to see you suggest -next for a fix to a user reported bug.
> IMO it's very firmly net material.

Yes, yes, normally it would argue the other way around. :-D

But Linus a few times in one way or another argued that time is a factor
when it comes to regressions. Here for example:

https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

But there are no "semantic changes that now mean that fixing the
regression could cause a _new_ regression" here I guess. And what he was
talking about there is quite different from this case as well (I vaguely
remember a better example, but I can't find it; whatever).

In the end this is one of issue where I don't care much. :-D

Ciao, Thorsten
