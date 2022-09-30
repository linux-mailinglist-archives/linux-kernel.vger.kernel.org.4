Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E65F13A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiI3U3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiI3U3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:29:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218216F865;
        Fri, 30 Sep 2022 13:29:18 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeMdD-0002Kj-6J; Fri, 30 Sep 2022 22:29:11 +0200
Message-ID: <3a036077-2cad-45c5-c5a3-9f4cb3288b69@leemhuis.info>
Date:   Fri, 30 Sep 2022 22:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
 <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
 <SJ1PR11MB60836F8B9E045C5542D01ADAFC569@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5c6a16c6-f762-9fcf-714e-3dd98137c556@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <5c6a16c6-f762-9fcf-714e-3dd98137c556@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664569758;febb40a3;
X-HE-SMSGID: 1oeMdD-0002Kj-6J
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.22 22:04, Randy Dunlap wrote:
> 
> 
> On 9/30/22 10:28, Luck, Tony wrote:
>>> E-mails sent from a web interface could have as much structure as you'd like.
>>> So one avenue would be to set up a nice interface for bug reporting, that just
>>> delivered the form data in e-mail format to the proposed bug-receiving mail list.
>>
>> Web interfaces have the advantage that they can be full of boxes which indicate
>> useful details to supply. Like what kernel version? Did this work on an older version,
>> is so, which one? Which CPU vendor/model are you using? Is there an error message?
>> Are there warnings in the console log before the error? Can you upload a full console log?
>> Does this happen repeatably? What are the steps to reproduce?
>>
>> Etc.etc.
> 
> We have Documentation for all of that, but (a) people don't read documentation
> and/or (b) it's too longwinded (not brief).

Yup. But as the one that is partly (mainly?) responsible for "(b)",
please allow me to quote the last sentence of reporting-issues.rst here:

"""The main author of this text hopes documenting the state of the art
will lay some groundwork to improve the situation over time."""

IOW: I really hope we over time can shorten that text somewhat (or even
a lot?) by...

* making some things a lot easier that currently are unnecessarily hard

* hiding some things in a reporting app or something like that (ideally
usable on the web and locally) that only bothers reporters with tainted
status, bisection, decoding of stack-traces, and things like that if
they are relevant in the particular case

Ciao, Thorsten
