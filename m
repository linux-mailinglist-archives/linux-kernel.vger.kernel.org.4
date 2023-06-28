Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671CA74163D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjF1QV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:21:29 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:53498 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjF1QVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:21:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE5861380;
        Wed, 28 Jun 2023 16:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB6EC433C0;
        Wed, 28 Jun 2023 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687969284;
        bh=Tp99MO2k+ZLSH5pz1emmkmRkqkS3s8Oude+aUKsQs8w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nq62hDU2Vnnn0l0pBNP5Z+9XgBElYbPWfgQSoCa5NsOhW4ulkXgLvpPgHpDxq9yBg
         GiwPSpweNUA9B9VPTl6j5x8qUmmLJ+NkpRTJGekrsBAcDZ/CvRExn6965TGsew/vG+
         DJzkkE7cdfkJpgwPWqQSCDMi9Ik15EG5sUhPXX1V+QVhIov1uKyLmw6EpcuwWGG/pI
         3k90bpfKt8EQzQElRHSlhApBXXH91UMewMqibont15pZ994Ugjrv4wu3F9RKYlrcpb
         esgD0m7W/Vmr+su6Qm0EFPeVLiP78ZHEi8V5u06YEl/kxKuN8AbWQZCB2ZnNE+gDJ4
         T6wPNW/sQMWOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E80ACE39D5; Wed, 28 Jun 2023 09:21:24 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:21:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v6.5
Message-ID: <38f30730-3099-45fd-a38b-d3e2fc679737@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
 <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
 <fcc987bb-4ce4-4816-a909-cffa4c3f24ff@paulmck-laptop>
 <ZJw26orq0ZLEOL9q@ziepe.ca>
 <9b1a620a-975a-490f-b9ee-6aea7c8effe0@paulmck-laptop>
 <ZJw9EsEzQbo3pj0C@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJw9EsEzQbo3pj0C@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:00:50AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 28, 2023 at 06:46:50AM -0700, Paul E. McKenney wrote:
> 
> > The revert meant that 0-day didn't see -rcu without the single-argument
> > kfree_rcu() definition.
> 
> 0-day is also supposed to run on your branches, not just linux-next,
> at least it does for my trees..

It did complain back in February, but for whatever reason has not
complained about the lack fo single-argumen kfree_rcu() since then.

							Thanx, Paul
