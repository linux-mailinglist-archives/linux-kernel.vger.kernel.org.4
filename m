Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABE6E3813
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDPMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjDPMhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:37:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EBF2D40;
        Sun, 16 Apr 2023 05:37:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1po1cv-0006Na-5h; Sun, 16 Apr 2023 14:37:05 +0200
Message-ID: <70355498-3902-9efb-192a-3b60661ffdab@leemhuis.info>
Date:   Sun, 16 Apr 2023 14:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [regression] Bug 217252 - warning: v4l_enum_fmt+0x125a/0x1c20 -
 Unknown pixelformat 0x00000000
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <dc8e5276-ef88-648f-9f0d-10151ea62c90@leemhuis.info>
 <1bd64a7f-9bcb-3057-4c51-7144122370fc@leemhuis.info>
In-Reply-To: <1bd64a7f-9bcb-3057-4c51-7144122370fc@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681648629;3230c4ec;
X-HE-SMSGID: 1po1cv-0006Na-5h
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.04.23 11:18, Linux regression tracking #update (Thorsten Leemhuis)
wrote:
> [TLDR: This mail in primarily relevant for Linux kernel regression
> tracking. See link in footer if these mails annoy you.]
> 
> On 29.03.23 13:25, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>
>> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
>> not CCed them to mails like this.
>>
>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217252 :
>>
>> #regzbot introduced: v5.15..v6.1.21
>> https://bugzilla.kernel.org/show_bug.cgi?id=217252
>> #regzbot title: media: Unknown pixelformat 0x00000000
>> #regzbot ignore-activity
> 
> Update the status, this was caused by a backport of a recent mainline
> commit to various stable trees.
> 
> #regzbot introduced: 50459f103edf
> #regzbot fix: media: usb: uvc: fill in description for unknown pixelformats
> #regzbot ignore-activity

Get this out of sight in the tracking, as it's not that urgent:

#regzbot backburner: only a warning, doesn't cause any trouble for users
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
