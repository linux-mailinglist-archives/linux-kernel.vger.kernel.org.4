Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342F174C0F3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 06:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjGIEgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGIEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 00:36:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF61B1;
        Sat,  8 Jul 2023 21:36:39 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIM9x-0002mt-1c; Sun, 09 Jul 2023 06:36:33 +0200
Message-ID: <ac957af4-f265-3ba0-0373-3a71d134a57e@leemhuis.info>
Date:   Sun, 9 Jul 2023 06:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
Content-Language: en-US, de-DE
To:     Andrew Lunn <andrew@lunn.ch>, Ross Maynard <bids.7405@bigpond.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
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
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <05a229e8-b0b6-4d29-8561-70d02f6dc31b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688877399;eabebbaa;
X-HE-SMSGID: 1qIM9x-0002mt-1c
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.23 22:49, Andrew Lunn wrote:
>> Could someone please submit the patch for me?
> 
> You are not far from it yourself.
> 
> I've not followed the history here. Did it never work, or has it
> worked in the past, and then at some point broke?
> 
> If it never worked, this would be classed as new development, and so
> the patch should be for net-next. If it did work, but at some point in
> time it stopped working, then it is for net.
> [...]

To chime in here: I most agree, but FWIW, it broke more than a decade
ago in v3.0, so maybe this is better suited for net-next. But of course
that up to the -net maintainers.

Ciao, Thorsten
