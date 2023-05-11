Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521046FE855
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjEKAJV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 20:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjEKAJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:09:18 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151BE49EB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 17:09:17 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 04DD380447;
        Thu, 11 May 2023 00:09:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 034B32E;
        Thu, 11 May 2023 00:09:12 +0000 (UTC)
Message-ID: <bbd9b0263860f98ff5792898c3e682b3cceb51ec.camel@perches.com>
Subject: Re: [pseudo-PATCH] sort MAINTAINERS file
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 May 2023 17:09:10 -0700
In-Reply-To: <fb4fa92a-eabe-10b8-fffd-7ffc8a70404b@infradead.org>
References: <fb4fa92a-eabe-10b8-fffd-7ffc8a70404b@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 034B32E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Stat-Signature: zppqnjqcrg5wn1zdx4efwrdfp8o8me1u
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1975iCYppDbFN+J8FBFke2PmiNmD/bmlnM=
X-HE-Tag: 1683763752-612251
X-HE-Meta: U2FsdGVkX1/vD2Fvn7czr2+t1YZCyC5TFktWtvUlquMndId/XUJUyH9Eric5SuC6b0RR1EIZVgis2PbBb69aJw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-10 at 17:01 -0700, Randy Dunlap wrote:
> Hi Linus,
> 
> Please run scripts/parse-maintainers.pl to sort the MAINTAINERS file.
> It has gained more than 100 out-of-order entries since it was last sorted.

And if you do, please use the --order option too.

> Thanks.

and thanks.
