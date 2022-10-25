Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A762260D2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiJYSG6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Oct 2022 14:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiJYSGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:06:54 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56DD20194
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:06:50 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 38ECE160525;
        Tue, 25 Oct 2022 18:06:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 0DFE160009;
        Tue, 25 Oct 2022 18:06:45 +0000 (UTC)
Message-ID: <8d8a291b5237750827d6847b29efde5b750a28f7.camel@perches.com>
Subject: Re: [PATCH] maple_tree: Update copyright dates for test code
From:   Joe Perches <joe@perches.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 25 Oct 2022 11:06:45 -0700
In-Reply-To: <20221025173709.2718725-1-Liam.Howlett@oracle.com>
References: <20221025173709.2718725-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: x3pqfrpkuzudiqryg8eh7b1frk4fojid
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0DFE160009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+LuUULebX2o5f9vPkA9HALl8S6jKtRFPk=
X-HE-Tag: 1666721205-604664
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-25 at 17:37 +0000, Liam Howlett wrote:
> Add the span to the year of the development.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  tools/testing/radix-tree/maple.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 35082671928a..3620c9e5f7c5 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * maple_tree.c: Userspace shim for maple tree test-suite
> - * Copyright (c) 2018 Liam R. Howlett <Liam.Howlett@Oracle.com>
> + * maple_tree.c: Userspace testing for maple tree test-suite
> + * Copyright (c) 2018-2022 Oracle Corporation
> + * Author: Liam R. Howlett <Liam.Howlett@Oracle.com>

Confused here.  Who owns the copyright from 2018?

And what happened from 2019 through 2021 ?

$ git log --stat -p -1 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa | grep -i copyright
+ * Copyright (c) 2018-2022 Oracle
+ * Copyright (c) 2018-2022 Oracle Corporation
+ * Copyright (c) 2018 Liam R. Howlett <Liam.Howlett@Oracle.com>

