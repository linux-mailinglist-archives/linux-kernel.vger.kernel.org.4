Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6D6483F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLIOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:40:13 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC311B1F4;
        Fri,  9 Dec 2022 06:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=WxizpsozvUJDZRYXo5+Z68KQzX6Sn8wpZZpndtWMJGU=; b=saHF1yhhZ857poyGEPIsKZBbK2
        /dhnY3YJWdsX/CYQY17Yw1dRAIdby5fJiQQsesEWUDN5AIrmvN8diO8LdhvJROJ5Q8kaRNXkFkCiH
        fpZkSzdWY9QGjgM+wBGvyZx+15qS9Fp/ooPdUJ4e8im8RGS2znD3Ayili1bm+RxFDDi5QR2ajjlOZ
        afhUhBfSaSqHW1tM91Y/x1xRkygoiMlOePhIxnyT8IaCoEUw3u7xCoDDTjadsuqQI0pbFzhuY6iHA
        sbP8JgU/UREj0JDBed5nKpzNrWbCNl++b7prSh78w65Xvx1v4oqxj+TJhA1fmAg3PdzsQPM0r2H6l
        lcecWT8grPrB85kcgAXtCeS6ClrOuQpQq4zuuhZImM1P86sCV8tzFbeW7qbur0D8DhjPy/bSkxKh2
        5ri0Iuq3PTE36hjY6m/wKY/3OqcSAUrMXcA9D+lexsdzZckurSjzUefC1TxrQlRK4NR7EwGuBfeGA
        gT7IpeOwEh4dgb4C8n+GV0mjcwmmdHBCsiNZCcK07MV0uV3FIGOEiUo0dI/vfKVLto+IHz3S5WJ9V
        8Lof1LGPcT6lxafJr3oxDyUKQ/nn0UbFzABDBBZpQ+JSBS9hD/9eFw9g86Ey2/CGfDDhHCDJFJJM7
        enz27cMIm0BcsD8ixUljoFpDhWm+FQ/QzCEIwtliU=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Date:   Fri, 09 Dec 2022 15:40:06 +0100
Message-ID: <3078112.XLg7Fjt2ba@silver>
In-Reply-To: <Y5J4/5WGnG5Uxadg@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au> <6054083.7yRespAWZ4@silver>
 <Y5J4/5WGnG5Uxadg@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 9, 2022 12:53:35 AM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Thu, Dec 08, 2022 at 04:55:17PM +0100:
> > On Monday, December 5, 2022 11:41:55 PM CET Dominique Martinet wrote:
> > > Christian Schoenebeck wrote on Mon, Dec 05, 2022 at 09:40:06PM +0100:
> > > > Dominique, looking at your 9p queue, I just realized what happened here: I 
> > > > posted a v2 of these two patches, which got lost for some reason:
> > > > 
> > > > https://lore.kernel.org/all/cover.1669144861.git.linux_oss@crudebyte.com/
> > > > 
> > > > The currently queued 1st patch is still v1 as well.
> > > 
> > > Oh. Now how did I manage that one..
> > > Thanks for the catch, and v2 had the valid printf modifier...
> > 
> > You remember updating the 1st patch as well, right? :)
> 
> It looks up to date to me, e.g. zc is added at the end of the p9_fcall
> structure.
> (and these are the only two patches you sent, right? :D)

Mmm, that's the queued patch I see:
https://github.com/martinetd/linux/commit/298468c26c14682a5be80a6ec1b4880c8eb3b261

Which is v1 ('zc' is not at the end of the structure, and in v1 there were
multiple assignment in the same line like:

  req->tc.zc = req->rc.zc = false;

which caused code style checker to bark (as well as on the commit log which it
found too short). So in v2 it is:

  req->tc.zc = false;
  req->rc.zc = false;

And yes, only two patches. :)

> > In general, I'm sure nobody complains about extra noise like "queued on...".
> > Then it's also more likely for other people to get which patches are still
> > pending or unseen.
> 
> I usually apply the patch locally when writing a note about 'taking the
> patch for x' -- but the problem is my workflow is pretty manual to say
> the least (piping mail to base64, base64 to git am on another
> machine...); and I'm not always taking the time to run tests immediately
> so not pushing right away to -next, so I assume I took your patches
> early and looked back when testing after you sent v2 and they were there
> so did't notice :/
> 
> I guess I need to pull the tree back and script a reply from the last
> link or something; so you'll notice the reply is on v1 in this case?
> but it'll be a pain to get the subject back like e.g. pwbot does for
> netdev... hmm..
> I'll think about what I can do.

Well, workflows are quite different. Personally I always manually reply to
mailed patches once I queued them, so that people can verify and correct me in
case I queued the wrong ones. I never had the feeling to script that part.

There are also people that use tools to keep track of all incoming patches,
e.g. patchwork client (either the CLI tool, or the web interface):
https://patchwork.readthedocs.io/en/latest/usage/clients/

The advantage is that it can take care about submitted versions and you just
mark queued series as done. If you don't have an account it is read-only, so
you can view pending patches, their status, automatically apply them, but for
changing their official status somebody has to create an account for you:
https://lore.kernel.org/all/2915273.dLz0rCdnKo@silver/

There are various patchwork hosts. Not sure who is responsible for creating
patchwork accounts on lore.kernel.org.

The Redhat guys are using Patchew, e.g.:
https://patchew.org/QEMU/


