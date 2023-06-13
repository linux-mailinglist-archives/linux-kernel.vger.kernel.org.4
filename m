Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E700172EA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjFMSOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjFMSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF44419A7;
        Tue, 13 Jun 2023 11:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 843DC6395A;
        Tue, 13 Jun 2023 18:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC10CC433D9;
        Tue, 13 Jun 2023 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680083;
        bh=fjT4gpdjI8bzfc0kSPvWLMcKfBFEaXgHEzlFBmmWqkQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YPBwCeRUs39kxlaLzdOB3U/bmTyHUsAgwUCs8NioF14TZY5ElTAYwBY3aLoc8t+wS
         e7bjbenC0hl1zrZBBwEJynjtkv3y8YHI3Y0EL41PdFbkLqqmFNzGbNGIRl/VZnFsYI
         CEwTLDbyKWuoN9nk3I/ejgmZ+2WowJN20sz99hVWF4I8TU1yLWxTHyDtznWvx7r7qp
         Vri8t/fEYXoWjE2p8JoArbh5O2YE0NPTL2eCwWxwE7P/vGrX8992LrfTUUX5KaU5v4
         52tJPG2/TK+wz8hZw12VOptpVSyRZhteeSItM9u2L0OhNiloXN3I+k9XVhutsfKh78
         0Uq9DJwQX5BaA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64961BBEAD1; Tue, 13 Jun 2023 20:14:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Closing down the wireless trees for a summer break?
In-Reply-To: <87y1kncuh4.fsf@kernel.org>
References: <87y1kncuh4.fsf@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 13 Jun 2023 20:14:40 +0200
Message-ID: <871qifxm9b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Me and Johannes are planning to take a longer break from upstream this
> summer. To keep things simple my suggestion is that we would official
> close wireless and wireless-next trees from June 23rd to August 14th
> (approximately).
>
> During that time urgent fixes would need go directly to the net tree.
> Patches can keep flowing to the wireless list but the the net
> maintainers will follow the list and they'll just apply them to the
> net tree directly.
>
> The plan here is that -next patches would have to wait for
> wireless-next to open. Luckily the merge window for v6.6 most likely
> opens beginning of September[1] so after our break we would have few
> weeks to get -next patches ready for v6.6.
>
> And the v6.5 -next patches should be ready by Monday June 19th so that we
> have enough time to get them into the tree before we close the trees.
>
> What do people think, would this work? This is the first time we are
> doing this so we would like to hear any comments about this, both
> negative and positive. You can also reply to me and Johannes privately,
> if that's easier.

I think this sounds reasonable, and I applaud the effort to take some
time off during the summer :)

One question that comes to mind is how would this work for patchwork?
Would we keep using the wireless patchwork instance for the patches
going to -net in that period, or will there be some other process for
this? I realise the setup we have for ath9k is a bit special in this
regard with the ack-on-list+delegation, so I'm obviously mostly
interested in what to do about that... :)

-Toke
