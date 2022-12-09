Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36324648722
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLIRA0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Dec 2022 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLIRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:00:24 -0500
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70B6311
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:00:20 -0800 (PST)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 0698C141383;
        Fri,  9 Dec 2022 17:00:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 7348720011;
        Fri,  9 Dec 2022 17:00:16 +0000 (UTC)
Message-ID: <a8f383e35a4194c5b137a787f2f0e133e11a80c5.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: warn when Reported-by: is not followed
 by Link:
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 09 Dec 2022 09:00:15 -0800
In-Reply-To: <c0f9e6d8-d402-df54-475d-0552dd5576dd@leemhuis.info>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
         <4af6cd7f0833f18e9eee8caba1913e682c5ec071.1670527774.git.kai@dev.carbon-project.org>
         <3953eb4913bf9b5610854624c4c632e710cd1ec9.camel@perches.com>
         <c0f9e6d8-d402-df54-475d-0552dd5576dd@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7348720011
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout01
X-Stat-Signature: hw7fcro58j5p4nwnxfaq7k51161gt61y
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182XctC+8KKGwuIl56b++vn9jT8kV/Ymcw=
X-HE-Tag: 1670605216-195453
X-HE-Meta: U2FsdGVkX1/Wf4/piGhYuePvRRf3VBCkfKNboBSk8R1D0ALByvEpR4qjlAoDPjTtsBUi2tcFxkSDDoNIOy1giQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-09 at 10:54 +0100, Thorsten Leemhuis wrote:
> On 08.12.22 21:21, Joe Perches wrote:
> > On Thu, 2022-12-08 at 20:32 +0100, Kai Wasserbäch wrote:
[]
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3144,6 +3144,20 @@ sub process {
> > >  					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> > 
> > I believe this use of '"$here\n" . $rawline . "\n"' to be a defect.
> > I think this should just use $herecurr
> > 
> > And the unnecessary space before a newline is an abomination ;)
> > 
> >   					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr]);
> 
> Well, that's existing code. Want me to add a separate patch that fixes
> both of these aspects up in that area?

Sure, thanks.

