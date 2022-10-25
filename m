Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92A60D5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJYUlM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Oct 2022 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiJYUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:40:52 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4565FA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:40:23 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 8A7AA140843;
        Tue, 25 Oct 2022 20:40:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 0E4872E;
        Tue, 25 Oct 2022 20:40:04 +0000 (UTC)
Message-ID: <870346348d7c70f3d2e72a3f1abbb216f19cfb89.camel@perches.com>
Subject: Re: [PATCH] maple_tree: Update copyright dates for test code
From:   Joe Perches <joe@perches.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 25 Oct 2022 13:40:19 -0700
In-Reply-To: <20221025202305.pyzau7vzvkizqbir@revolver>
References: <20221025173709.2718725-1-Liam.Howlett@oracle.com>
         <8d8a291b5237750827d6847b29efde5b750a28f7.camel@perches.com>
         <20221025202305.pyzau7vzvkizqbir@revolver>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 1c8tkkoj6qoci163my3wdu9puwomyez7
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0E4872E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+8eeXnOhGHkDyW6tnSPVg6SbBSEeAicPM=
X-HE-Tag: 1666730404-425776
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-25 at 20:23 +0000, Liam Howlett wrote:
> * Joe Perches <joe@perches.com> [221025 14:06]:
> > On Tue, 2022-10-25 at 17:37 +0000, Liam Howlett wrote:
> > > Add the span to the year of the development.
[]
> > > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
[]
> > > @@ -1,7 +1,8 @@
> > >  // SPDX-License-Identifier: GPL-2.0+
> > >  /*
> > > - * maple_tree.c: Userspace shim for maple tree test-suite
> > > - * Copyright (c) 2018 Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > + * maple_tree.c: Userspace testing for maple tree test-suite
> > > + * Copyright (c) 2018-2022 Oracle Corporation
> > > + * Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > 
> > Confused here.  Who owns the copyright from 2018?
> 
> 2018 should have also been oracle on this file.  Note the email
> address.

Noted.  It shows you as the copyright holder not Oracle Corp.

You are reassigning copyright yet the commit message merely shows
additional "span".

> > And what happened from 2019 through 2021 ?

When work on a object does not occur during a year, it
should not be included in a copyright "span".

> Development continued which is why I wanted to extend the date to a
> range.  I also presented the maple tree and spoke to a lot of people
> about it.  Also a pandemic, I hear.

Not a reason for copyright changes, but whatever...

> > $ git log --stat -p -1 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa | grep -i copyright
> > + * Copyright (c) 2018-2022 Oracle
> > + * Copyright (c) 2018-2022 Oracle Corporation
> > + * Copyright (c) 2018 Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Right, this is what I am correcting.  I'm not sure what you are getting
> at here.

Just inconsistency.
First shows only Oracle, second is Oracle Corporation.

>  Did I do something incorrect with trying to fix my mistake?

Copyright reassignment not specified in commit message.

cheers, Joe
