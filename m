Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD486D1E14
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCaKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:34:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E56A58;
        Fri, 31 Mar 2023 03:34:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1piC5D-0002Be-5M; Fri, 31 Mar 2023 12:34:11 +0200
Message-ID: <7d8cae85-5d0a-599e-cc48-0d06db27d9fe@leemhuis.info>
Date:   Fri, 31 Mar 2023 12:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US, de-DE
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
 <2194d19d-f195-1a1e-41fc-7827ae569351@leemhuis.info>
 <cf5a3e73-c97d-4f98-80d7-4bcc68eb557a@spud>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 0/4] docs & checkpatch: allow Closes tags with links
In-Reply-To: <cf5a3e73-c97d-4f98-80d7-4bcc68eb557a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1680258860;efe5fe62;
X-HE-SMSGID: 1piC5D-0002Be-5M
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.23 12:08, Conor Dooley wrote:
> On Fri, Mar 31, 2023 at 11:39:22AM +0200, Thorsten Leemhuis wrote:
> 
>> -Please check the link to make sure that it is actually working and points
>> -to the relevant message.
>> +If the URL points to a bug report that is fixed by the patch, use 'Closes:'
>> +instead.
> 
> This is not specifically a comment about your additional diff, but this
> sprang to mind (again) while reading it.
> I have been wondering if this sort of thing will lead to inconsistency. 
> Reports sometimes report more than one issue at once. Other times a
> patch that is (intentionally) not a complete fix for the problem.
> Using Closes: in those cases is not really true, as it does not close
> the report.
>
> Having a series of N patches, each of which purport to close an issue,
> also doesn't seem quite right.
> The word Closes has a meaning and "forcing" the use of Closes: for
> reports implies meaning that may not be present.
> 
> I suppose it is true that just because documentation or checkpatch says
> to do something, doesn't mean that you **have** to do it but I don't
> want to be the one on the Rx side of a rant...

Yeah, maybe checkpath.pl should allow a "Link" after a "Reported-by" for
cases like this, then developers could save "Closes" for the patch that
addresses the last of the issues the report is about.

OTOH checkpatch.pl currently just prints a warning, so developers could
ignore this and do the above already now, as you say. Guess it depends
on how often we expect "one report with multiple issue" to happen.

Maybe this is an indicator that we are on the wrong track in general and
should not do any of this and just stick to "Link:".

Ciao, Thorsten
