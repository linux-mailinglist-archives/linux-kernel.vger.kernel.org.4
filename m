Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA488678D30
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjAXBRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAXBRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:17:08 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059B32E4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:17:07 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 89310824E0;
        Tue, 24 Jan 2023 01:17:05 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674523027;
        bh=ndWwOc/VdtWwtRrsE2YLgjtGP0+7wjN34C9aLo+9wLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N86yyzfIqdwtmC9OUlGBOalX9dZkZ1NFI3WgMgAzjgvU87ZwK3EKziCYmpItcTjDW
         X97bWUL08gMPb2lhpXnEQQ33RzGr4ZJbAsb+1jumhtsbQirYu4MIrmDMxnRgOFZWdt
         atCjRDyWtJ6g07sqSntx8m2eVUM8/qWJlTlfH4W3z5EDdgMydKF7q88/T/E7OKkcNR
         7gcX2ErX2ELEMmepHPUfR3v59twb4rZBGTkpJ+gUEgrJXh00jDeUxmKOYOCO7HXRM/
         OY9ORYmft8XiiGWIxJXcPZ8y6fuQZR3GyUwDS2jyI+qEC38HEtyX/X255QldvFSgGa
         YWxDHZirzAg6Q==
Date:   Tue, 24 Jan 2023 08:17:01 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH RFC] tools/nolibc: Add gitignore to avoid git complaints
 about sysroot
Message-ID: <Y88xjSd2ZIpVIeHd@biznet-home.integral.gnuweeb.org>
References: <20230124004707.GA318943@paulmck-ThinkPad-P17-Gen-1>
 <Y88u+KnrxjrC+NBe@biznet-home.integral.gnuweeb.org>
 <20230124011257.GC2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124011257.GC2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:12:57PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 24, 2023 at 08:06:00AM +0700, Ammar Faizi wrote:
> > On Mon, Jan 23, 2023 at 04:47:07PM -0800, Paul E. McKenney wrote:
> > > Testing of nolibc can produce a tools/include/nolibc/sysroot file, which
> > > is not known to git.  Because it is automatically generated, there is no
> > > reason for it to be known to git.  Therefore, add a .gitignore to remove
> > > it from git's field of view.
> > 
> > Yeah, I hit the same "git status" complaint and have a pending patch
> > for that too:
> > 
> > https://github.com/ammarfaizi2/linux-block/commit/89bfe86a03c173863de12.patch
> > 
> > ^ I'll drop this one.
> 
> Actually, why don't we take yours?  Either way, I have to change something
> per your feedback below.
> 
> No hurry, send it along when you normally would have.

OK, I'll keep it then. Will send it together with my other patches later :-)

Thanks.

-- 
Ammar Faizi

