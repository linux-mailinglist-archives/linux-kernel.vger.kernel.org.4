Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966660E117
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiJZMnX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 08:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiJZMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:43:21 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846071A21C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:43:20 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 1DF2CAB653;
        Wed, 26 Oct 2022 12:43:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id BBF7820024;
        Wed, 26 Oct 2022 12:42:31 +0000 (UTC)
Message-ID: <f56da5f58afe5d759d16c7bdf3f748b683dfef32.camel@perches.com>
Subject: Re: [PATCH] maple_tree: Update copyright dates for test code
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 26 Oct 2022 05:43:14 -0700
In-Reply-To: <Y1hR/RNpXB8O1sqZ@casper.infradead.org>
References: <20221025173709.2718725-1-Liam.Howlett@oracle.com>
         <8d8a291b5237750827d6847b29efde5b750a28f7.camel@perches.com>
         <20221025202305.pyzau7vzvkizqbir@revolver>
         <870346348d7c70f3d2e72a3f1abbb216f19cfb89.camel@perches.com>
         <Y1hR/RNpXB8O1sqZ@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BBF7820024
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 48aem6azbwwawz1xj5y8bp9zgtnwapai
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18f8ja1aq459jJZfQvn1y6RGbTKWSh8XZA=
X-HE-Tag: 1666788151-926598
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-25 at 22:15 +0100, Matthew Wilcox wrote:
> On Tue, Oct 25, 2022 at 01:40:19PM -0700, Joe Perches wrote:
> > Copyright reassignment not specified in commit message.
> 
> It's not copyright reassignment.  Liam has been an employee of Oracle
> for the entire duration.  It is fixing the copyright notice to be correct.

Perhaps.

But it would definitely be better if the subject and message matched
the change.

All the suggested commit subject and message states is

> maple_tree: Update copyright dates for test code

and

> Add the span to the year of the development.

The patch itself does not do that.

On its face, it's reassigning copyright, not suggesting the original
copyright owner was in error.

