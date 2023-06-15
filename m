Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A77730CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbjFOBrg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 21:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbjFOBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:47:35 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F46EB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:47:33 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 2B4BD16088B;
        Thu, 15 Jun 2023 01:47:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id CBC4B2000D;
        Thu, 15 Jun 2023 01:47:28 +0000 (UTC)
Message-ID: <b777a049b3817c7eee364310aac89470e9ea882e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the excluded
 check list
From:   Joe Perches <joe@perches.com>
To:     "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, corbet@lwn.net,
        david@redhat.com
Date:   Wed, 14 Jun 2023 18:47:26 -0700
In-Reply-To: <20230614164955.1319870-1-michael.j.ruhl@intel.com>
References: <20230614164955.1319870-1-michael.j.ruhl@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: CBC4B2000D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: b9uxyspq5n5sdmbcbspta5sfxr4ynmwg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18XIq4JwacEh1PSc0XItlP0ZZP1B5154U0=
X-HE-Tag: 1686793648-32441
X-HE-Meta: U2FsdGVkX1/Hy1a/Dfgib0iq6BaNK0VsCAoZhNH82HXYafPFwpdcUr/mru/9ndGhVJgC2argvhq8Up/Vba1KIlbt+B/O3Ae1vSQ6rdnDmGPH8jwQKuN9M43VfqTm/D4SiCMrwu+5SWN+nBB+tBcp1SZK2veU+KN7lHto29tIuWJWpHf7niZpYd0cECKw4SdzYA/rDHyMNWcxZ42S1DthLYfreIunjO4iS+w6f+fKSkNa06q1XCZLUtnafJJHkEovhjG/bqqyqmmtMHx9ZWKkIBXxyy1j4eXc/jvPeJ5OAGzRqazP/1wU6ogbGvKs15q2jeOdmwpvOPd6aaUfkbjlyDrH+HXhW5S3
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-14 at 12:49 -0400, Michael J. Ruhl wrote:
> GEM_BUG_ON is usually compiled as WARN.  You have to change to
> debug configuration to get this to be BUG.
> 
> checkpatch flags this a WARN level issue.
> 
> Since this is a i915 local debug macro, allow its use in checkpatch.pl.
> 
> Fixes: 69d517e6e210 ("checkpatch: warn on usage of VM_BUG_ON() and other BUG variants")

Not a "Fixes", just an additional check

> 
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b30114d637c4..d3ddde4cd63e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4821,7 +4821,7 @@ sub process {
>  		}
>  
>  # do not use BUG() or variants
> -		if ($line =~ /\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
> +		if ($line =~ /\b(?!AA_|BUILD_|DCCP_|GEM_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
>  			my $msg_level = \&WARN;
>  			$msg_level = \&CHK if ($file);
>  			&{$msg_level}("AVOID_BUG",

