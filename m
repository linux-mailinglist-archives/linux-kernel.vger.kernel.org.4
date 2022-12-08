Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E86474F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLHRXK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 12:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLHRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:23:07 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BDC2981F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 09:23:03 -0800 (PST)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id A3EEDA08F0;
        Thu,  8 Dec 2022 17:23:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 9CD1920011;
        Thu,  8 Dec 2022 17:23:00 +0000 (UTC)
Message-ID: <6f7ae389b64b83918ba624d107d8fa49883df540.camel@perches.com>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>
Date:   Thu, 08 Dec 2022 09:22:59 -0800
In-Reply-To: <ba953e75-d069-47e8-a467-217d4c600f5b@leemhuis.info>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
         <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
         <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
         <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
         <bba95554-19a0-d548-d63c-811b229cbca0@leemhuis.info>
         <d64338a1-e708-dd1f-4d9c-3b793754a8fa@leemhuis.info>
         <b76cd99552c135629ab8e52d3e929916c7965a14.camel@perches.com>
         <9958a748-2608-8ed2-6e8f-2f3291286271@leemhuis.info>
         <15f7df96d49082fb7799dda6e187b33c84f38831.camel@perches.com>
         <ba953e75-d069-47e8-a467-217d4c600f5b@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9CD1920011
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: hwn5yzwfcr1k8hiowuujf4s37gxgtnod
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18MgA23XWJTc9ZheseU0SHZePT6VOa4v7Y=
X-HE-Tag: 1670520180-603961
X-HE-Meta: U2FsdGVkX1/L3mppc/KgrWAFbydmTcQJ+k1ivUi6RmNun+GsuXTKEHDGCxDWNV9RhrrnEP9AKzC8IwKA5KvHPQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-08 at 14:18 +0100, Thorsten Leemhuis wrote:
> On 06.12.22 10:21, Joe Perches wrote:
> > On Tue, 2022-12-06 at 09:50 +0100, Thorsten Leemhuis wrote:
> > > On 06.12.22 08:44, Joe Perches wrote:
[]
> > > > To me most of these are in the noise level, but perhaps all should just
> > > > use Link:
> > > > 
> > > > $ git log -100000 --format=email -P --grep='^\w+:[ \t]*http' | \
> > > >   grep -Poh '^\w+:[ \t]*http' | \
> > > >   sort | uniq -c | sort -rn
> > > >  103889 Link: http
> > > >     415 BugLink: http
> > > >     372 Patchwork: http
> > > >     270 Closes: http
> > > >     221 Bug: http
> > > >     121 References: http
> > > >     101 v1: http
> > > >      77 Bugzilla: http
> > > >      60 URL: http
> > > >      59 v2: http
> > > >      37 Datasheet: http
> > > >      35 v3: http
> > > >      19 v4: http
> > > >      12 v5: http
> > 
> > > Ha, I considered doing something like that when I wrote my earlier mail,
> > > but was to lazy. :-D thx!
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -3250,6 +3250,13 @@ sub process {
> >  			$commit_log_possible_stack_dump = 0;
> >  		}
> >  
> > +# Check for odd prefixes before a URI/URL
> > +		if ($in_commit_log &&
> > +		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^(?:Link|Patchwork)/) {
> > +			WARN("PREFER_LINK",
> > +			     "Unusual link reference '$1:', prefer 'Link:'\n" . $herecurr);
> > +		}
> > +
> 
> One more thing: That afaics would result in a warning when people use
> things like "v1: https://example.com/somewhere", which some people
> apparently like. Those imho are not considered tags, hence I'd say we
> allow them, unless you disagree.

I'd say no as almost all of those are when patches contain
references to previous patch submissions that should instead
be below the --- line.  Perhaps there should be a separate
warning for those v<n>: uses saying to move them below the ---
but there really aren't many uses.

Most of the v<n>: style prefixes are from git pulls/merges.
Redoing the git log grep with --no-merges shows that fairly well.

$ git log -100000 --no-merges --format=email -P --grep='^\w+:[ \t]*http' | \
  grep -Poh '^\w+:[ \t]*http' | \
  sort | uniq -c | sort -rn
 103958 Link: http
    418 BugLink: http
    372 Patchwork: http
    280 Closes: http
    224 Bug: http
    123 References: http
     84 Bugzilla: http
     61 URL: http
     42 v1: http
     38 Datasheet: http
     20 v2: http
      9 Ref: http
      9 Fixes: http
      9 Buglink: http
      8 v3: http
      8 Reference: http
      7 See: http
      6 1: http
      5 link: http
      3 Link:http
      3 IGT: http
      3 0: http
      2 Website: http
      2 Schematics: http
      2 RHBZ: http
      2 Reported: http
      2 MR: http
      2 Links: http
      2 LINK: http
      2 Link:  http
      2 Bugs: http
      2 BUG: http
      2 2: http
      1 v5: http
      1 v4: http
      1 V1: http
      1 v1:http
      1 Twitter: http
      1 tree: http
      1 tool: http
      1 tests: http
      1 tasks: http
      1 Source: http
      1 SoM: http
      1 scctc: http
      1 Reproducer: http
      1 reliable: http
      1 Related: http
      1 Reference:http
      1 oscca: http
      1 Mesa: http
      1 Lore: http
      1 Links:http
      1 ink: http
      1 in: http
      1 IETF: http
      1 here: http
      1 Examples: http
      1 bz: http
      1 Bug:http
      1 AlsaInfo: http

