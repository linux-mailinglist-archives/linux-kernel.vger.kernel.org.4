Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26875C04DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiIUQ6L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Sep 2022 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiIUQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:57:31 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4918114;
        Wed, 21 Sep 2022 09:57:29 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id A3B5F1A0137;
        Wed, 21 Sep 2022 16:57:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 2BD0442;
        Wed, 21 Sep 2022 16:57:21 +0000 (UTC)
Message-ID: <9735b34d490b9774d883b8caf37ccb2e842cccfb.camel@perches.com>
Subject: Re: [PATCH v7] checkpatch: warn for non-standard fixes tag style
From:   Joe Perches <joe@perches.com>
To:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Date:   Wed, 21 Sep 2022 09:57:23 -0700
In-Reply-To: <20220914100255.1048460-1-niklas.soderlund@corigine.com>
References: <20220914100255.1048460-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2BD0442
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 5auhrq3z3n7q7kp4ym5irfo6dfcgippf
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/a4BkMAYN1IzZGlaMLaXwLXHNoKlMAuiE=
X-HE-Tag: 1663779441-445637
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-14 at 12:02 +0200, Niklas Söderlund wrote:
> Add a warning for fixes tags that does not follow community conventions.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Louis Peens <louis.peens@corigine.com>
> Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Joe Perches <joe@perches.com>

> ---
> * Changes since v6
> - Update first check to make sure that there is a likely SHA1 of some
>   minimum length after the fixes line.
> - s/fall in line with community standard/follow community conventions/.
> - Improve grammar, thanks Lukas.
> 
> * Changes since v5
> - Add support for --fix option for checkpatch.pl.
> 
> * Changes since v4
> - Extend test to cover lines with whitespace before the fixes: tag, e.g.
>   match check on /^\s*fixes:?/i.
> 
> * Changes since v3
> - Add test that title in tag match title of commit referenced by sha1.
> 
> * Changes since v2
> - Change the pattern to match on 'fixes:?' to catch more malformed
>   tags.
> 
> * Changes since v1
> - Update the documentation wording and add mention one cause of the
>   message can be that email program splits the tag over multiple lines.
> ---
>  Documentation/dev-tools/checkpatch.rst |  7 ++++
>  scripts/checkpatch.pl                  | 44 ++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index b52452bc2963..c3389c6f3838 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -612,6 +612,13 @@ Commit message
>  
>      See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
>  
> +  **BAD_FIXES_TAG**
> +    The Fixes: tag is malformed or does not follow the community conventions.
> +    This can occur if the tag have been split into multiple lines (e.g., when
> +    pasted in an email program with word wrapping enabled).
> +
> +    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> +
>  
>  Comparison style
>  ----------------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 79e759aac543..ddc5c9d730c3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3140,6 +3140,50 @@ sub process {
>  			}
>  		}
>  
> +# Check Fixes: styles is correct
> +		if (!$in_header_lines &&
> +		    $line =~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i) {
> +			my $orig_commit = "";
> +			my $id = "0123456789ab";
> +			my $title = "commit title";
> +			my $tag_case = 1;
> +			my $tag_space = 1;
> +			my $id_length = 1;
> +			my $id_case = 1;
> +			my $title_has_quotes = 0;
> +
> +			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
> +				my $tag = $1;
> +				$orig_commit = $2;
> +				$title = $3;
> +
> +				$tag_case = 0 if $tag eq "Fixes:";
> +				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
> +
> +				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
> +				$id_case = 0 if ($orig_commit !~ /[A-F]/);
> +
> +				# Always strip leading/trailing parens then double quotes if existing
> +				$title = substr($title, 1, -1);
> +				if ($title =~ /^".*"$/) {
> +					$title = substr($title, 1, -1);
> +					$title_has_quotes = 1;
> +				}
> +			}
> +
> +			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
> +							     $title);
> +
> +			if ($ctitle ne $title || $tag_case || $tag_space ||
> +			    $id_length || $id_case || !$title_has_quotes) {
> +				if (WARN("BAD_FIXES_TAG",
> +				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
> +				    $fix) {
> +					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
> +				}
> +			}
> +		}
> +
>  # Check email subject for common tools that don't need to be mentioned
>  		if ($in_header_lines &&
>  		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {

