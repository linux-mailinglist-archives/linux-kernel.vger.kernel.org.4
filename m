Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B26D125E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjC3Wna convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 18:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjC3WnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:43:25 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED651113E2;
        Thu, 30 Mar 2023 15:43:17 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 41579140304;
        Thu, 30 Mar 2023 22:43:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 8664F20028;
        Thu, 30 Mar 2023 22:43:09 +0000 (UTC)
Message-ID: <da9d8c2174e0813be2e0e6b31129e90fddaa128e.camel@perches.com>
Subject: Re: [PATCH v3 3/4] checkpatch: allow Closes tags with links
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
Date:   Thu, 30 Mar 2023 15:43:08 -0700
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v3-3-d1bdcf31c71c@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
         <20230314-doc-checkpatch-closes-tag-v3-3-d1bdcf31c71c@tessares.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8664F20028
X-Stat-Signature: o7s8y4yexe96pcmeht83bc8k1kmp4ytc
X-Spam-Status: No, score=0.0 required=5.0 tests=FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1839bgV7wydgfXH7bCqxQ9k9vhrNnfor3U=
X-HE-Tag: 1680216189-513749
X-HE-Meta: U2FsdGVkX1+lgCVmV5KU3BNZtM6xwIk2/vlX9i6ZiIMH3ZU0YFPXMf/3WNcfaIuPazErrbphMTyQUkRCP/L9PA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-30 at 20:13 +0200, Matthieu Baerts wrote:
> As a follow-up of a previous patch modifying the documentation to
> allow using the "Closes:" tag, checkpatch.pl is updated accordingly.
> 
> checkpatch.pl now no longer complain when the "Closes:" tag is used by
> itself or after the "Reported-by:" tag.
> 
> Fixes: 76f381bb77a0 ("checkpatch: warn when unknown tags are used for links")
> Fixes: d7f1d71e5ef6 ("checkpatch: warn when Reported-by: is not followed by Link:")

I don't think this _fixes_ anything.
I believe it's merely a new capability.

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/373
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> v3:
>  - split into 2 patches: the previous one adds a list with all the
>    "link" tags. This one only allows the "Closes" tag. (Joe Perches)
>  - "Closes" is no longer printed between parenthesis. (Thorsten
>    Leemhuis)
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9d092ff4fc16..ca58c734ff22 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -620,7 +620,7 @@ our $signature_tags = qr{(?xi:
>  	Cc:
>  )};
>  
> -our @link_tags = qw(Link);
> +our @link_tags = qw(Link Closes);
>  
>  #Create a search and print patterns for all these strings to be used directly below
>  our $link_tags_search = "";
> 

