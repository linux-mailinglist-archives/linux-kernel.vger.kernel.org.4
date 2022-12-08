Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B40647A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLHXyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHXx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:53:58 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C126ACE;
        Thu,  8 Dec 2022 15:53:57 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 34CC2C01E; Fri,  9 Dec 2022 00:54:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670543646; bh=fVFAqawFttj8I80f5N81FfPuX+mDk6lIwOx2zqsllNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjE801cYXAhzQivJ/K9KGtOzD2Aj7tLnm1ZAGT1Ontk1wiZm/uuNvP8epI8FuQdgT
         8/G9xQwKV3LmxwES0P2I5UsN619RVq3KxjABaRAJiTqgvs0cgPU47lo1tN9EUqSXdJ
         Muyjt3WujLLwVdeTVvLXAmaLnrLlw3Khzq/B9o5E2/BpDhzeUvTWPgh+6U8uO5Ysl7
         l0flRI44+xckc9t1hrrX7IeEMbOeRZpHcT/vL4IAWlLseHD4buS/5s5fwDoB2kDWzx
         1sI7OZ1TtuV9qjSCzenLhJXtEONBG4n3krCwyzFMmk8yfC4DKlu1Q30mKamGBs6ZUo
         dtw0pGG8HHxTg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7C4D6C01B;
        Fri,  9 Dec 2022 00:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670543644; bh=fVFAqawFttj8I80f5N81FfPuX+mDk6lIwOx2zqsllNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zlGIkKZJPL156WFoM5KfGnYy13Mu3ruM7Z/GtbUlz4hM9WIszmrz5gywlw2MN2Cl0
         y7yNyNiLpRepSmTWn382TQL+tY/01dv9fX/XptJHwxaVWIfezqHRiU7FL1D8yj8TvI
         qXthArLiWtHdy13bsekNrEBNHa9NHEE3ERztaxr08rK6nIplQ28TgbJANBENywvRIl
         tfj3U/WJfMhWWqYAxWaoZ9ESbatithwpN4h1GPKN4aG4s0VgBpCti7XE1P9ZHsk8gw
         7ufi7/uFu7lyX7tQJtZMwDqxPh+z+U6MknWqltyOFAOreVaabsvbLvu4N7dj/IJ8ig
         Fj2tK0nXI1dAA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 7b43bc40;
        Thu, 8 Dec 2022 23:53:50 +0000 (UTC)
Date:   Fri, 9 Dec 2022 08:53:35 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Message-ID: <Y5J4/5WGnG5Uxadg@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au>
 <3823616.UlgstfPZBx@silver>
 <Y45zsz71RfXbySDq@codewreck.org>
 <6054083.7yRespAWZ4@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6054083.7yRespAWZ4@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Thu, Dec 08, 2022 at 04:55:17PM +0100:
> On Monday, December 5, 2022 11:41:55 PM CET Dominique Martinet wrote:
> > Christian Schoenebeck wrote on Mon, Dec 05, 2022 at 09:40:06PM +0100:
> > > Dominique, looking at your 9p queue, I just realized what happened here: I 
> > > posted a v2 of these two patches, which got lost for some reason:
> > > 
> > > https://lore.kernel.org/all/cover.1669144861.git.linux_oss@crudebyte.com/
> > > 
> > > The currently queued 1st patch is still v1 as well.
> > 
> > Oh. Now how did I manage that one..
> > Thanks for the catch, and v2 had the valid printf modifier...
> 
> You remember updating the 1st patch as well, right? :)

It looks up to date to me, e.g. zc is added at the end of the p9_fcall
structure.
(and these are the only two patches you sent, right? :D)

> In general, I'm sure nobody complains about extra noise like "queued on...".
> Then it's also more likely for other people to get which patches are still
> pending or unseen.

I usually apply the patch locally when writing a note about 'taking the
patch for x' -- but the problem is my workflow is pretty manual to say
the least (piping mail to base64, base64 to git am on another
machine...); and I'm not always taking the time to run tests immediately
so not pushing right away to -next, so I assume I took your patches
early and looked back when testing after you sent v2 and they were there
so did't notice :/

I guess I need to pull the tree back and script a reply from the last
link or something; so you'll notice the reply is on v1 in this case?
but it'll be a pain to get the subject back like e.g. pwbot does for
netdev... hmm..
I'll think about what I can do.

-- 
Dominique
