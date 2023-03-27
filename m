Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E36B6CA7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjC0O3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjC0O3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:29:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C130FA;
        Mon, 27 Mar 2023 07:28:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pgnpR-00038G-H4; Mon, 27 Mar 2023 16:28:09 +0200
Message-ID: <e8ad8b03-70c5-03b5-3e48-61bf884ebb27@leemhuis.info>
Date:   Mon, 27 Mar 2023 16:28:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, de-DE
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
 <2f96048b-c580-625f-6fc7-06237292efe3@leemhuis.info>
 <bf7546ab-6c76-05b0-4539-f4aa854ffae9@tessares.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2 2/2] checkpatch: allow Closes tags with links
In-Reply-To: <bf7546ab-6c76-05b0-4539-f4aa854ffae9@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1679927295;124e5d06;
X-HE-SMSGID: 1pgnpR-00038G-H4
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.23 15:06, Matthieu Baerts wrote:
> Hi Thorsten,
> 
> On 25/03/2023 07:25, Thorsten Leemhuis wrote:
>> On 24.03.23 19:52, Matthieu Baerts wrote:
>>> As a follow-up of the previous patch modifying the documentation to
>>> allow using the "Closes:" tag, checkpatch.pl is updated accordingly.
>>>
>>> checkpatch.pl now mentions the "Closes:" tag between brackets to express
>>> the fact it should be used only if it makes sense.
>>>
>>> While at it, checkpatch.pl will not complain if the "Closes" tag is used
>>> with a "long" line, similar to what is done with the "Link" tag.
>>>
>>> [...]
>>>  
>>> -# check if Reported-by: is followed by a Link:
>>> +# check if Reported-by: is followed by a Link: (or Closes:) tag
>>
>> Small detail: why the parenthesis here? Why no simply "check if
>> Reported-by: is followed by a either Link: or Closes: tag". Same below...
>>
>>>  			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>>>  				if (!defined $lines[$linenr]) {
>>>  					WARN("BAD_REPORTED_BY_LINK",
>>> -					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>>> -				} elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
>>> +					     "Reported-by: should be immediately followed by Link: (or Closes:) to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>>
>> ...here, where users actually get to see this and might wonder why it's
>> written like that, without getting any answer.
> 
> I tried to explain that in the cover-letter but maybe I should add an
> additional comment in the code: checkpatch.pl now mentions the "Closes:"
> tag between parenthesis to express the fact it should be used only if it
> makes sense. I didn't find any other short ways to express that but I'm
> open to suggestions.
> 
> Now as discussed on patch 1/2, if the "Closes:" tag can be used with any
> public link, we should definitively remove the parenthesis here and
> probably below (see "Check for odd tags before a URI/URL") as well.

Well, ymmd, but if we go down that route I'd say this code should
suggest to use "Closes:" all the time (or primarily).

Ciao, Thorsten
