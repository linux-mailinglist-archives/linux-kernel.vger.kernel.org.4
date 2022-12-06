Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4628A6441AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiLFK7H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Dec 2022 05:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiLFK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:58:47 -0500
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BC2229E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:58:46 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 4695CA0799;
        Tue,  6 Dec 2022 10:58:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id BB94080013;
        Tue,  6 Dec 2022 10:58:41 +0000 (UTC)
Message-ID: <a16d39ff8a0d61c929b518572798920a13c82bd1.camel@perches.com>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>
Date:   Tue, 06 Dec 2022 02:58:40 -0800
In-Reply-To: <8434c30b-52f5-2c23-cce4-8d66393f7635@leemhuis.info>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
         <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
         <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
         <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
         <bba95554-19a0-d548-d63c-811b229cbca0@leemhuis.info>
         <d64338a1-e708-dd1f-4d9c-3b793754a8fa@leemhuis.info>
         <b76cd99552c135629ab8e52d3e929916c7965a14.camel@perches.com>
         <9958a748-2608-8ed2-6e8f-2f3291286271@leemhuis.info>
         <15f7df96d49082fb7799dda6e187b33c84f38831.camel@perches.com>
         <8434c30b-52f5-2c23-cce4-8d66393f7635@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: BB94080013
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: xpohh99tty74tqydu1aijao3joz5i1pw
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18ZsopGCvT7QD0spE1WExlqH/8tcDUopKI=
X-HE-Tag: 1670324321-503898
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-06 at 11:06 +0100, Thorsten Leemhuis wrote:
> On 06.12.22 10:21, Joe Perches wrote:

> > I'm not sure that "Patchwork:" is a reasonable prefix.
> 
> /me neither
> 
> > Is that documented anywhere?
> 
> Couldn't find anything.

I knew that.

btw:

there are a _lot_ more uses of Link: with patchwork content than
Patchwork: prefix uses, so maybe just "Link:" should be accepted.

$ git log --format=email -i --grep "patchwork" | grep -i "patchwork" | \
  cut -f1-3 -d'/' | sort | uniq -c | sort -rn | head -10
  25789 Link: https://patchwork.freedesktop.org
   7160 Link: http://patchwork.freedesktop.org
   4109 Patchwork: https://patchwork.linux-mips.org
    777 Patchwork: http://patchwork.linux-mips.org
    372 Patchwork: https://patchwork.freedesktop.org
    200 https://patchwork.kernel.org
    154 Link: https://patchwork.kernel.org
    116 [1] https://patchwork.kernel.org
     76 https://patchwork.ozlabs.org
     33 http://patchwork.ozlabs.org

> LGTM: I did some tests and it seem to do the right thing. Can we have
> your Signed-off-by: for that snippet?

It's your patch, I'm just suggesting...

cheers, Joe
