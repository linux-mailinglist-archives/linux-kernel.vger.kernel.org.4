Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C36C6F75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCWRi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCWRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:38:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A39A3B213;
        Thu, 23 Mar 2023 10:37:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pfOsH-0000nY-V0; Thu, 23 Mar 2023 18:37:18 +0100
Message-ID: <a9c2fa30-569b-e69a-fb06-3dc093538b53@leemhuis.info>
Date:   Thu, 23 Mar 2023 18:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, de-DE
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <87a60frxk0.fsf@meer.lwn.net>
 <d233a796-1cb8-a9b3-5a50-043dd2f98b3e@leemhuis.info>
 <87edpomtzn.fsf@meer.lwn.net>
 <165bd284-580d-df03-ab04-f5214b1e6be4@leemhuis.info>
 <87jzz7creg.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <87jzz7creg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1679593041;9e1f8453;
X-HE-SMSGID: 1pfOsH-0000nY-V0
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.23 18:24, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> I currently can't really see the need for another book/top-level
>> directory and to be honest it's by far my least favorite solution among
>> the options on the table.
> 
> Well, it was just an idea that crossed my mind as I was thinking about
> this stuff...it doesn't appear to have inspired a lot of enthusiasm.

Yeah, looks like it, but was definitely worth mentioning and thinking
about.

>  So
> never mind that for now, I guess...I reserve the right to come back to
> it in the future once we're getting overwhelmed by these things :)

:-D

>> I'm taken back and forth between the other two options (e.g. put the
>> text in Documentation/admin-guide/ or
>> Documentation/admin-guide/tutorials/). Maybe I prefer the latter a
>> little bit more.
> 
> Let's just put it in admin-guide, I guess, though the fit feels a bit
> awkward.  If we get more tutorials, we can make a separate section in
> index.html, I don't think we need another subdirectory there at this
> point.

Okay.

> Did you have further tweaks, or should I take v3?

No further tweaks, so feel free to apply it as it is.

tia!

Ciao, Thorsten
