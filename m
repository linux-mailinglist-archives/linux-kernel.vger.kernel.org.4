Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476FD6D4E40
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjDCQog convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDCQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:44:34 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FF186;
        Mon,  3 Apr 2023 09:44:33 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 9C5BB1C6141;
        Mon,  3 Apr 2023 16:44:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 9479F20028;
        Mon,  3 Apr 2023 16:44:24 +0000 (UTC)
Message-ID: <f0014730875502c9f2117c2438de0c69512c7d0a.camel@perches.com>
Subject: Re: [PATCH v4 0/5] docs & checkpatch: allow Closes tags with links
From:   Joe Perches <joe@perches.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
Date:   Mon, 03 Apr 2023 09:44:23 -0700
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 9479F20028
X-Stat-Signature: xiw3fm8z4miy48d6eqzcbjbqgzde5eap
X-Spam-Status: No, score=1.0 required=5.0 tests=FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18AYvRZzAR1q2Hs1tsatw9ueURLajfnrEs=
X-HE-Tag: 1680540264-872236
X-HE-Meta: U2FsdGVkX1/wd3gCN3YdpSrEWSShFEzMbxSNJyksnDiVxWzTQo/h9bnPyZkSS+eShrwZBtgchjaYMYK2b1QT8Q==
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-03 at 18:23 +0200, Matthieu Baerts wrote:
> Since v6.3, checkpatch.pl now complains about the use of "Closes:" tags
> followed by a link [1]. It also complains if a "Reported-by:" tag is
> followed by a "Closes:" one [2].

All these patches seems sensible, thanks.

Assuming Linus approves the use of "Closes:"

Acked-by: Joe Perches <joe@perches.com>

> As detailed in the first patch, this "Closes:" tag is used for a bit of
> time, mainly by DRM and MPTCP subsystems. It is used by some bug
> trackers to automate the closure of issues when a patch is accepted.
> It is even planned to use this tag with bugzilla.kernel.org [3].
> 
> The first patch updates the documentation to explain what is this
> "Closes:" tag and how/when to use it. The second patch modifies
> checkpatch.pl to stop complaining about it.
> 
> The DRM maintainers and their mailing list have been added in Cc as they
> are probably interested by these two patches as well.
> 
> [1] https://lore.kernel.org/all/3b036087d80b8c0e07a46a1dbaaf4ad0d018f8d5.1674217480.git.linux@leemhuis.info/
> [2] https://lore.kernel.org/all/bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info/
> [3] https://lore.kernel.org/linux-doc/20230315181205.f3av7h6owqzzw64p@meerkat.local/
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Note: After having re-read the comments from the v1, it is still unclear
> to me if this "Closes:" can be accepted or not. But because it seems
> that the future Bugzilla bot for kernel.org and regzbot would like to
> use it as well, I'm sending here new versions. I'm sorry if I
> misunderstood the comments from v1. Please tell me if I did.
> 
> Changes in v4:
> - Patches 1/5, 3/5 and 4/5 have been added to ask using the "Closes" tag
>   instead of the "Link" one for any bug reports. (Thorsten)
> - The Fixes tags have been removed from patch 4/5. (Joe)
> - The "Reported-by being followed by a link tag" check is now only
>   looking for the tag, not the URL which is done elsewhere in patch 5/5.
>   (Thorsten)
> - A new patch has been added to fix a small issues in checkpatch.pl when
>   checking if "Reported-by:" tag is on the last line.
> - Link to v3: https://lore.kernel.org/r/20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net
> 
> Changes in v3:
> - Patch 1/4 now allow using the "Closes" tag with any kind of bug
>   reports, as long as the link is public. (Thorsten)
> - The former patch 2/2 has been split in two: first to use a list for
>   the different "link" tags (Joe). Then to allow the 'Closes' tag.
> - A new patch has been added to let checkpatch.pl checking if "Closes"
>   and "Links" are used with a URL.
> - Link to v2: https://lore.kernel.org/r/20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net
> 
> Changes in v2:
> - The text on patch 1/2 has been reworked thanks to Jon, Bagas and
>   Thorsten. See the individual changelog on the patch for more details.
> - Private bug trackers and invalid URLs are clearly marked as forbidden
>   to avoid being misused. (Linus)
> - Rebased on top of Linus' repo.
> - Link to v1: https://lore.kernel.org/r/20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net
> 
> ---
> Matthieu Baerts (5):
>       docs: process: allow Closes tags with links
>       checkpatch: don't print the next line if not defined
>       checkpatch: use a list of "link" tags
>       checkpatch: allow Closes tags with links
>       checkpatch: check for misuse of the link tags
> 
>  Documentation/process/5.Posting.rst          | 22 ++++++++++----
>  Documentation/process/submitting-patches.rst | 26 +++++++++++------
>  scripts/checkpatch.pl                        | 43 ++++++++++++++++++++++------
>  3 files changed, 70 insertions(+), 21 deletions(-)
> ---
> base-commit: 7e364e56293bb98cae1b55fd835f5991c4e96e7d
> change-id: 20230314-doc-checkpatch-closes-tag-1731b57556b1
> 
> Best regards,

