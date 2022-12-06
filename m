Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4F643AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiLFBUH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 20:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiLFBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:20:03 -0500
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC461F63E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:20:02 -0800 (PST)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 4104BA053A;
        Tue,  6 Dec 2022 01:20:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 083A42F;
        Tue,  6 Dec 2022 01:19:58 +0000 (UTC)
Message-ID: <d75ca7a3de87fb211a216de169e4394e79a82a7d.camel@perches.com>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 05 Dec 2022 17:19:58 -0800
In-Reply-To: <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
         <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 083A42F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: w33rbwrd4t6q5si4sg6iz93zhsqmdoxd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+qc+dyZOtQx4O+ReY0kMcXk2x19E1Ap0o=
X-HE-Tag: 1670289598-276003
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-05 at 17:02 -0800, Joe Perches wrote:
> On Mon, 2022-12-05 at 13:14 -0800, Andrew Morton wrote:
> > Date: Sun,  4 Dec 2022 12:33:37 +0100
> > From: Kai Wasserbäch <kai@dev.carbon-project.org>
[]
> > - checkpatch implements custum versions of Perl core modules, that might
> >   be an future area for clean-ups? Eg. right off the bat there is a
> >   `uniq` implementation. List::Util (core module since 5.8.0 (5.7.3 to
> >   be pedantic)) has a far better performing version in XS.

> Maybe.  I don't know there are that many generic functions
> that could be used.  You are welcome find some.

uniq isn't used in checkpatch since

commit 52178ce01335d9d76611c3a5198b8778cb9b03f5
Author: Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri Feb 26 15:08:26 2021 +0530

    checkpatch: add verbose mode
 
and could be removed.

