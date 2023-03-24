Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26766C85AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCXTNe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 15:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCXTNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:13:30 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC541E9C0;
        Fri, 24 Mar 2023 12:13:28 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 572AA1A0A8F;
        Fri, 24 Mar 2023 19:13:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id B70072002A;
        Fri, 24 Mar 2023 19:13:21 +0000 (UTC)
Message-ID: <d24f2eca8f2a858b48ad0e019e58e0e5098be5c3.camel@perches.com>
Subject: Re: [PATCH v2 2/2] checkpatch: allow Closes tags with links
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
Date:   Fri, 24 Mar 2023 12:13:20 -0700
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
         <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: ueoppisyctp79ob1ykz11ezkamktrpmg
X-Rspamd-Server: rspamout06
X-Spam-Status: No, score=-0.0 required=5.0 tests=FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Rspamd-Queue-Id: B70072002A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/rnsL3jh5b7vFnhiq2EJ20FSC9CMS8VTU=
X-HE-Tag: 1679685201-138756
X-HE-Meta: U2FsdGVkX18Y6PQUWshUibiJaAB9uJGTc2IJEjKdh4MImApySznRV2uLAUg0dKV2BKT0GKvCRKciITt6cxVeVw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-24 at 19:52 +0100, Matthieu Baerts wrote:
> As a follow-up of the previous patch modifying the documentation to
> allow using the "Closes:" tag, checkpatch.pl is updated accordingly.
> 
> checkpatch.pl now mentions the "Closes:" tag between brackets to express
> the fact it should be used only if it makes sense.
> 
> While at it, checkpatch.pl will not complain if the "Closes" tag is used
> with a "long" line, similar to what is done with the "Link" tag.
> 
> Fixes: 76f381bb77a0 ("checkpatch: warn when unknown tags are used for links")
> Fixes: d7f1d71e5ef6 ("checkpatch: warn when Reported-by: is not followed by Link:")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/373
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  scripts/checkpatch.pl | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd44d12965c9..d6376e0b68cc 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3158,14 +3158,14 @@ sub process {
>  				}
>  			}
>  
> -# check if Reported-by: is followed by a Link:
> +# check if Reported-by: is followed by a Link: (or Closes:) tag
>  			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>  				if (!defined $lines[$linenr]) {
>  					WARN("BAD_REPORTED_BY_LINK",
> -					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> -				} elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
> +					     "Reported-by: should be immediately followed by Link: (or Closes:) to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> +				} elsif ($rawlines[$linenr] !~ m{^(link|closes):\s*https?://}i) {

Please do not use an unnecessary capture group.

		(?:link|closes)

And because it's somewhat likely that _more_ of these keywords
could be added, perhaps use some array like deprecated_apis


>  					WARN("BAD_REPORTED_BY_LINK",
> -					     "Reported-by: should be immediately followed by Link: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> +					     "Reported-by: should be immediately followed by Link: (or Closes:) with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>  				}
>  			}
>  		}
> @@ -3250,8 +3250,8 @@ sub process {
>  					# file delta changes
>  		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
>  					# filename then :
> -		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
> -					# A Fixes: or Link: line or signature tag line
> +		      $line =~ /^\s*(?:Fixes:|Link:|Closes:|$signature_tags)/i ||
> +					# A Fixes:, Link:, Closes: or signature tag line
>  		      $commit_log_possible_stack_dump)) {
>  			WARN("COMMIT_LOG_LONG_LINE",
>  			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> @@ -3266,13 +3266,13 @@ sub process {
>  
>  # Check for odd tags before a URI/URL
>  		if ($in_commit_log &&
> -		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link') {
> +		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link' && $1 ne 'Closes') {
>  			if ($1 =~ /^v(?:ersion)?\d+/i) {
>  				WARN("COMMIT_LOG_VERSIONING",
>  				     "Patch version information should be after the --- line\n" . $herecurr);
>  			} else {
>  				WARN("COMMIT_LOG_USE_LINK",
> -				     "Unknown link reference '$1:', use 'Link:' instead\n" . $herecurr);
> +				     "Unknown link reference '$1:', use 'Link:' (or 'Closes:') instead\n" . $herecurr);
>  			}
>  		}
>  
> 

