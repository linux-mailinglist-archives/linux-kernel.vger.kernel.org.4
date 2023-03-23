Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B556C721B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCWVEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C55E9;
        Thu, 23 Mar 2023 14:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13C04B82251;
        Thu, 23 Mar 2023 21:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB18EC433D2;
        Thu, 23 Mar 2023 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679605437;
        bh=s0qiIm7I/VHyfumO8JsVX4FErKUCS+Lp4X/oi6opOuE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M3HQSnF7t4/k+nTTuYK8e2v1DO/iO5RUEspNscbBCzluzfa94KuFUwqUjwj2ci4L9
         IX45/FlqfKseDjnACN4L3Hoj5GZI/4M5qvgIemLvt+jwtrgbMlsi/0bfPkUFtZM6QZ
         vEDliWzk/8bcMrJ5o+pn84mqoO9D6mDFW6gyNxKO3Tnlgl1wlhdl0IoeX+oUTUACsj
         bHXm/+0LwQj4BYn+DBudd9xxaPf4RvpTUzAllZPzvB//OKSx1H9/W4hUo8JLXFAhtk
         gTJe+AP0Fvu/A+IwnIt851ZzZWAaNdoM+UIlHsa5N/cjYwzKIBx1ajlVYdGEIjT+V5
         KjhFccwq9DISA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 322961540398; Thu, 23 Mar 2023 14:03:57 -0700 (PDT)
Date:   Thu, 23 Mar 2023 14:03:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <e448fcdb-56ba-4c58-8562-059409c1716d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230323144411.0edde523@canb.auug.org.au>
 <43b7534f-15ee-4cd7-a205-fa16fdb1ab14@paulmck-laptop>
 <20230323124135.a3c436d8b29dec5bddf47f34@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323124135.a3c436d8b29dec5bddf47f34@linux-foundation.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:41:35PM -0700, Andrew Morton wrote:
> On Wed, 22 Mar 2023 22:11:12 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > >   ce5e77e7b2cc ("instrumented.h: fix all kernel-doc format warnings")
> > > 
> > > in the mm tree)
> > 
> > Andrew, do you want to keep this one, or would you rather that I carry it?
> 
> I dropped my copy, thanks.

Thank you!

							Thanx, Paul
