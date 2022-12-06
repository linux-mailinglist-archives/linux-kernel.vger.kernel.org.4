Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF65643A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFBCn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 20:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLFBCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:02:40 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E3264D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:02:38 -0800 (PST)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 49DBFC06EF;
        Tue,  6 Dec 2022 01:02:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 7C70520028;
        Tue,  6 Dec 2022 01:02:02 +0000 (UTC)
Message-ID: <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Dec 2022 17:02:33 -0800
In-Reply-To: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7C70520028
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout07
X-Stat-Signature: h54ee8m6fzb9sg17tyi19rpxtchotdy8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+G6Y8S7iaYAr0zsjVeYXTVsbdrgFu5d34=
X-HE-Tag: 1670288522-14631
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-05 at 13:14 -0800, Andrew Morton wrote:
> Apparently MAINTAINERS is hard to read.  Please review?
> 
> Thanks.
> 
> Begin forwarded message:
> 
> Date: Sun,  4 Dec 2022 12:33:37 +0100
> From: Kai Wasserbäch <kai@dev.carbon-project.org>
> To: linux-kernel@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>, Thorsten Leemhuis <linux@leemhuis.info>
> Subject: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn about missing Link:
> 
> 
> Hey,
> Thorsten Leemhuis suggested the following two changes to checkpatch, which
> I hereby humbly submit for review. Please let me know if any changes
> would be required for acceptance.
> 
> NOTES:
> - checkpatch is rather long, so I might have chosen the wrong section to
>   add these two checks. Any better placement suggestion is welcome.
> - checkpatch implements custum versions of Perl core modules, that might
>   be an future area for clean-ups? Eg. right off the bat there is a
>   `uniq` implementation. List::Util (core module since 5.8.0 (5.7.3 to
>   be pedantic)) has a far better performing version in XS.

Maybe.  I don't know there are that many generic functions
that could be used.  You are welcome find some.

> 
> Cheers,
> Kai
> 
> Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
> Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
> 
> 
> Kai Wasserbäch (2):
>   feat: checkpatch: error on usage of a Buglink tag in the commit log

Why, what's wrong with a buglink reference?

>   feat: checkpatch: Warn about Reported-by: not being followed by a
>     Link:

I think this is unnecessary.

