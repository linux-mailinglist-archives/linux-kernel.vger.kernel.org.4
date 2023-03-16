Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B08C6BCAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCPJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCPJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:22:26 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DFD4ECE0;
        Thu, 16 Mar 2023 02:22:24 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pcjoR-00025p-AV; Thu, 16 Mar 2023 10:22:19 +0100
Message-ID: <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
Date:   Thu, 16 Mar 2023 10:22:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1678958545;61ef5160;
X-HE-SMSGID: 1pcjoR-00025p-AV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.23 18:44, Matthieu Baerts wrote:
> Since v6.3, checkpatch.pl now complains about the use of "Closes:" tags
> followed by a link [1]. It also complains if a "Reported-by:" tag is
> followed by a "Closes:" one [2].
> 
> As detailed in the first patch, this "Closes:" tag is used for a bit of
> time, mainly by DRM and MPTCP subsystems. It is used by some bug
> trackers to automate the closure of issues when a patch is accepted.
> 
> Because this tag is used for a bit of time by different subsystems and
> it looks like it makes sense and it is useful for them, I didn't bother
> Linus to get his permission to continue using it. If you think this is
> necessary to do that up front, please tell me and I will be happy to ask
> for his agreement.

Due to how he reacted to some "invented" tags recently, I'd think it
would be appropriate to CC him on this patchset, as he then can speak up
if he wants to (and I assume a few more mails don't bother him).

> The first patch updates the documentation to explain what is this
> "Closes:" tag and how/when to use it. The second patch modifies
> checkpatch.pl to stop complaining about it.

I liked Andrew's `have been using "Addresses:" on occasion. [...] more
humble [...]` comment.  Sadly that tag is not supported by GitLab and
GitHub. But well, "Resolves" is and also a bit more humble if you ask
me. How about using that instead? Assuming that Konstantin can work with
that tag, too, but I guess he can.

I also wonder if the texts for the documentation could be shorter.
Wouldn't something like this do?

`Instead of "Link:" feel free to use "Resolves:" with an URL instead, if
the issue was filed in a public bug tracker that will consider the issue
resolved when it noticed that tag.`

[s/Resolves/Closes/ if we stick to that]

Side note: makes we wonder if we should go "all in" here to avoid
confusion and allow "Resolves" everywhere, even for links to lore.

> [...]

Ciao, Thorsten
