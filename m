Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61459648A02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLIVYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIVYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:24:47 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F8183AE;
        Fri,  9 Dec 2022 13:24:46 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A12FAC01C; Fri,  9 Dec 2022 22:24:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670621095; bh=8idFISxUhB94azisdhlrhLxmBwNy73YtIohXetuVRB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2oOFAxxaE8Hzsf4kr9ReGEINHNgNRV06lV2hjUZSnP2bmfExbEz/uUwrh4t696u3
         iTjBNNbhBqW/x8unYlHigHNmgJOyLVpvfJkw/reVoE8L29L5u/Tz4W4dKfADbQuTZ2
         cs+6HRbCbJBMfFparExr+00t8WLJuYhLTIXzTuZyoGof3ftpzvaKPSY0moKbfB4hVH
         R+aa3/27eGdZrfjjz4j6Qki/VtrOuI24/ey5Gpkx4bBFXGcvjE2XsXLFqysxxGYHgD
         Ho4Oy7dNWJY3dZSPoBvMmRidOyWkj0zBmO06C4xojZr8NNV68K1EVP80wvMuHE4AeA
         iUc65AioKZ2Mw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id EFE87C01B;
        Fri,  9 Dec 2022 22:24:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670621095; bh=8idFISxUhB94azisdhlrhLxmBwNy73YtIohXetuVRB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2oOFAxxaE8Hzsf4kr9ReGEINHNgNRV06lV2hjUZSnP2bmfExbEz/uUwrh4t696u3
         iTjBNNbhBqW/x8unYlHigHNmgJOyLVpvfJkw/reVoE8L29L5u/Tz4W4dKfADbQuTZ2
         cs+6HRbCbJBMfFparExr+00t8WLJuYhLTIXzTuZyoGof3ftpzvaKPSY0moKbfB4hVH
         R+aa3/27eGdZrfjjz4j6Qki/VtrOuI24/ey5Gpkx4bBFXGcvjE2XsXLFqysxxGYHgD
         Ho4Oy7dNWJY3dZSPoBvMmRidOyWkj0zBmO06C4xojZr8NNV68K1EVP80wvMuHE4AeA
         iUc65AioKZ2Mw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id d4e1c3f4;
        Fri, 9 Dec 2022 21:24:41 +0000 (UTC)
Date:   Sat, 10 Dec 2022 06:24:26 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Message-ID: <Y5OnimhNCFGVYvrq@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au>
 <6054083.7yRespAWZ4@silver>
 <Y5J4/5WGnG5Uxadg@codewreck.org>
 <3078112.XLg7Fjt2ba@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3078112.XLg7Fjt2ba@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Fri, Dec 09, 2022 at 03:40:06PM +0100:
> > > You remember updating the 1st patch as well, right? :)
> > 
> > It looks up to date to me, e.g. zc is added at the end of the p9_fcall
> > structure.
> > (and these are the only two patches you sent, right? :D)
> 
> Mmm, that's the queued patch I see:
> https://github.com/martinetd/linux/commit/298468c26c14682a5be80a6ec1b4880c8eb3b261
> 
> Which is v1 ('zc' is not at the end of the structure, and in v1 there were
> multiple assignment in the same line like:
> 
>   req->tc.zc = req->rc.zc = false;
> 
> which caused code style checker to bark (as well as on the commit log which it
> found too short). So in v2 it is:
> 
>   req->tc.zc = false;
>   req->rc.zc = false;
> 
> And yes, only two patches. :)

Ah. . . what did I just say about applying patches in my local branch
for testing later, they correct one is just sitting there but wasn't
tested/pushed yet :/

(if you care, I'm using my 9p-test branch for that, but it's not sent
sent to -next obviously)


> Well, workflows are quite different. Personally I always manually reply to
> mailed patches once I queued them, so that people can verify and correct me in
> case I queued the wrong ones. I never had the feeling to script that part.

Yes I usually do write a note about it when I take the patch locally,
but in this case I think I just applied the patches for checkpatch
(indentation looked off without being sure it'd complain) and didn't
intend to queue it; then came back later and "oh they're here, thanks
past me!" (incorrectly)

I guess at this point the problem comes back down to not running
tests/pushing to next immediately; if I finish automating that part I
think this kind of errors wouldn't happen as non-pushed patches wouldn't
make sense...
Well, it's been rare enough but still worth thinking about safeguards
imo, there's usually a reason for v2 patchs so getting the v1 in even
occasionally is bad :-D

-- 
Dominique
