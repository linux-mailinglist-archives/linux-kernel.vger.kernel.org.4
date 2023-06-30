Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7E7433A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjF3Ef1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3EfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952D01BCC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22D0761657
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ECAC433C8;
        Fri, 30 Jun 2023 04:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688099723;
        bh=jOSdY00epdMCVNDrzwFmvJ7SMc5VHY1cqBQXCGrpKwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTdPotVH0XNKzdhWdIyQpRUaDhfqbB0jq/5wyIaIge8J1cDjNJUIsgHOiuZU5CImU
         y5u7AFbn5a8CMWC1DytFFOQ36cicsCnnh24QK/EhYT8nP9A0UJZ/pnUnXTbE1RBqyP
         fKbQOIz9p6+2OoxdX7fKSBv8TbHSRzzDVVmb/1ROe0qCAiNfkvwZPrRvaAuPXb2tk3
         aW14r/Sv9MdeXJXKrx/0UHA9B139AY100+o9VIWnxzKVH7zWnzmsIjJ1IV7RGa61pC
         HY52Qmluj7NrA9ZImAPPWfZXwgQeuqKV/SBwgmmnNcx5wr93WSEP6/2wsnXlcyyZ94
         QbOsonRUEIOQw==
Date:   Fri, 30 Jun 2023 07:34:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>,
        Yuwei Guan <ssawgyw@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] memblock: small updates for v6.5-rc1
Message-ID: <20230630043430.GQ52412@kernel.org>
References: <20230627084058.GM52412@kernel.org>
 <CAHk-=wgkp6Cp_vNaJ02KGWwR6aj2JA5rMcTo505cuN__gknYfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkp6Cp_vNaJ02KGWwR6aj2JA5rMcTo505cuN__gknYfQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 04:40:59PM -0700, Linus Torvalds wrote:
> On Tue, 27 Jun 2023 at 01:41, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.5-rc1
> 
> Nope, nothing there.
> 
> I see the for-next branch, but no tag with that name, and no other tag
> with those contents.
> 
> Forgot to push?

Hmm, looks like it :(
Pushed now.
 
>                Linus

-- 
Sincerely yours,
Mike.
