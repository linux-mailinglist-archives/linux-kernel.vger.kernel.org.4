Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12EA741F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 06:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjF2ELP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 00:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjF2ELI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 00:11:08 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D9B1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:11:06 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 0D1651C8DAA;
        Thu, 29 Jun 2023 04:11:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id BAFE92000D;
        Thu, 29 Jun 2023 04:11:01 +0000 (UTC)
Message-ID: <f316a9d3b9f9d65e6b5542bcd8550ac3b63cbbe2.camel@perches.com>
Subject: Re: [PATCH] checkpatch: don't take signature to be part of the
 commit SHA
From:   Joe Perches <joe@perches.com>
To:     Ahelenia =?UTF-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Jun 2023 21:11:00 -0700
In-Reply-To: <cmhc6xudksabuza2jrhgs5yg2a2xbohadyyazitg6463uskhjp@enclcjvmbx4r>
References: <cmhc6xudksabuza2jrhgs5yg2a2xbohadyyazitg6463uskhjp@enclcjvmbx4r>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: 3cz7mb43i4y1qh5szigsippx7cnmm958
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: BAFE92000D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TmBqH45dMurvUt3xbkP2O1TaJ4wxIEjg=
X-HE-Tag: 1688011861-732657
X-HE-Meta: U2FsdGVkX19tvomSc1t9wH2618i9NNLu/pXHB7veTLtOKv/rJuTlkSOZMn24f6pW2XmKrliIoYAqP0bg4R94jvpqakiJIRTxi0NdS1TrDvUQBu63qsgzsse0DAwxOt/VwqUU9fc1tMEvOAMthxq0bE5JL9fF2TSuFv/UhCuIeRJXxA2jey30B3crINkL7JXSgsiez94Z9ktY2RPQKe696Tu3vU8uDIELu8njjkzzakPsHe++WcVGijrEWaJT6Vx9hLWmWMrqZPT7PEU9l+cFM6+EXJU+/Yf5VrMt6m15UI3LqxxLFSUfnSc24j5l7HkPt8EzO15wseao8ahNFmDfVrZE4IR2LPWK/NvJy0/S0Fk4BAQxZDQsfaQWdI/UveELBE88SRyjWPivl+unPHsJ/h3KowOi5XOt+AqWoWn4cTB0apiD0B0OByTs8OetubNBSrdco2Vd4NPAORb8Qv/IeQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-28 at 22:35 +0200, Ahelenia Ziemiańska wrote:
> I had just received:
>   $ scripts/checkpatch.pl 0001-splice-always-fsnotify_access-in-fsnotify_modify-out.patch
>   WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: gpg: Signatu (":35 CEST")'
>   #25:
>   Fixes: 983652c69199 ("splice: report related fsnotify events")
> 
>   total: 0 errors, 1 warnings, 60 lines checked
> 
>   NOTE: For some of the reported defects, checkpatch may be able to
>         mechanically convert to the typical style using --fix or --fix-inplace.
> 
>   0001-splice-always-fsnotify_access-in-fsnotify_modify-out.patch has style problems, please review.
> 
>   NOTE: If any of the errors are false positives, please report
>         them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> This fails when the Fixes:ed SHAs are signed, since the output is
>   $ git log --format='%H %s'
>   gpg: Signature made Wed 28 Jun 2023 19:05:02 CEST
>   gpg:                using RSA key 7D69474E84028C5CC0C44163BCFD0B018D2658F1
>   gpg: Good signature from "наб <nabijaczleweli@nabijaczleweli.xyz>" [ultimate]
>   gpg:                 aka "наб <nabijaczleweli@gmail.com>" [ultimate]
>   gpg:                 aka "nabijaczleweli <nabijaczleweli@gmail.com>" [ultimate]
>   53307062b2b644dc0de7bde916d6193492f37643 splice: fsnotify_access(in), fsnotify_modify(out) on success in tee
> or
>   $ git log --format='%H %s' 983652c69199
>   gpg: Signature made Tue 04 Apr 2023 15:57:35 CEST
>   gpg:                using EDDSA key 408734571EA70C78B332692891C61BC06578DCA2
>   gpg: Can't check signature: No public key
>   983652c691990b3257a07f67f4263eb847baa82d splice: report related fsnotify events
> 
> The fix mimicks what was done in commit f24fb53984cf ("perf tools: Don't

mimics

> include signature in version strings"): just don't ask for the
> signatures being validated.
> 
> With this, my patch passed validation.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> Grepped through for /log /, /show /, and /git_command/, and this
> is all I found. Unsure if there's other git executions that need
> to be fixed, tho.

Not sure either but perhaps these should be in some
negative options variable like:

my $git_log_no = "--no-show-signature --no-merges --no-color";

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -1164,7 +1164,7 @@ sub seed_camelcase_includes {
>  	$camelcase_seeded = 1;
>  
>  	if (-e "$gitroot") {
> -		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
> +		my $git_last_include_commit = `${git_command} log --no-show-signature --no-merges --pretty=format:"%h%n" -1 -- include`;

		my $git_last_include_commit = `${git_command} log ${git_log_no} --pretty=...

etc...

