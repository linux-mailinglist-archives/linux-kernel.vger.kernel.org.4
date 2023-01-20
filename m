Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423BC675865
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjATPUm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Jan 2023 10:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjATPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:20:37 -0500
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B3DA135
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:20:31 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 436D040EA0;
        Fri, 20 Jan 2023 15:20:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id EC03580012;
        Fri, 20 Jan 2023 15:20:27 +0000 (UTC)
Message-ID: <a3278d71ff653fc4560004041e88b85aa6c317d0.camel@perches.com>
Subject: Re: [PATCH v4 0/3] checkpatch.pl: warn about discouraged tags and
 missing Link: tags
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 Jan 2023 07:20:26 -0800
In-Reply-To: <cover.1674217480.git.linux@leemhuis.info>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
         <cover.1674217480.git.linux@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: EC03580012
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: mq45ssaa1wyt6wzwy3si8sioxcdijxum
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+InloTelwLFOCX7E3izLiKAlfPYfGM9Zs=
X-HE-Tag: 1674228027-382225
X-HE-Meta: U2FsdGVkX1/XdT+PMeAPR0BitOZi+Yc1azXnLLWH6Oz1GZEs+Y2/cnA2Pbn7Z/DJwFkWAbhJslfEO5ItZ9vfCg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-20 at 13:35 +0100, Thorsten Leemhuis wrote:
> Hi, please consider the following checkpatch.pl patches for review.
> 
> The first two changes make checkpatch.pl check for a few mistakes wrt to
> links to bug reports Linus recently complained about a few times.
> Avoiding those is also important for my regression tracking efforts a
> lot, as the automated tracking performed by regzbot relies on the proper
> usage of the Link: tag.
> 
> The third patch fixes a few small oddities noticed in existing code
> during review of the two changes.

Hey Andrew.  Please forward this patch series upstream.

Thanks, Joe

> 
> Ciao, Thorsten
> ---
> v3->v4:
> - address review feedback from Joe (do not allow leading spaces in
> matches, check if Link: is actually followed by a URL in one go,
> and use m{} for matching https://)  (Thorsten)
> - catch Reported-and-tested-by as well (Thorsten)
> 
> v2->v3:
> - address review feedback from Joe (grammer fixes, use of $herecurr, use
> of --no-merges in commit log quote) (Thorsten)
> - warn when people try to add version information to the commit log
> using code suggested by Joe (Thorsten)
> - add a patch to make existing code in a nearby area use $herecurr where
> it should, which Joe noticed during review
> 
> v1->v2:
> - add commit messages explaining the reasoning (Thorsten)
> - approach the usage of wrong tags with an allow list as suggested by
> Joe (Thorsten)
> 
> Kai Wasserbäch (2):
>   checkpatch: warn when unknown tags are used for links
>   checkpatch: warn when Reported-by: is not followed by Link:
> 
> Thorsten Leemhuis (1):
>   checkpatch: use proper way for show problematic line
> 
>  scripts/checkpatch.pl | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4

