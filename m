Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C885E648719
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLIQ5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Dec 2022 11:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLIQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:57:44 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F77F60F2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:57:40 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 54C7C1212E6;
        Fri,  9 Dec 2022 16:57:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 1205319;
        Fri,  9 Dec 2022 16:57:35 +0000 (UTC)
Message-ID: <eacf69e190c33005ca101bc0711aae1f0d44f3ba.camel@perches.com>
Subject: Re: [PATCH 1/2] checkpatch: warn when unknown tags are used for
 links
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 09 Dec 2022 08:57:35 -0800
In-Reply-To: <35f626fb-9524-a7e3-664f-1b3150fe08c8@leemhuis.info>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
         <869badb999d4021dd6efd792f53fc2859257c350.1670527774.git.kai@dev.carbon-project.org>
         <a7de235e15dbba2df9eb7ef82750ea8b6eae2b7b.camel@perches.com>
         <35f626fb-9524-a7e3-664f-1b3150fe08c8@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1205319
X-Stat-Signature: pti39ydhfkd7kqc1qb446rkmapro7s51
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18sBkSySnw2w0/BkVm/46tCGVH1IHyQMMk=
X-HE-Tag: 1670605055-368619
X-HE-Meta: U2FsdGVkX19HnUivsU3P83LBoAizrmk3K3ueecGF2gVqAQHj9290cIdHOAs6lEWv1WV0fQWa+hGEr8GGAGJTag==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-09 at 10:33 +0100, Thorsten Leemhuis wrote:
> I'd say
> this is the point where this really warrants a Co-developed-by: that
> mentions you (and thus a Signed-off-by: from your side, too), don't you
> think so?

No.  I think it's just being a good maintainer and offering advice.

I'll ack it when it's submitted and I don't have any other comments.

cheers, Joe
