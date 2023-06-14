Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614A072F983
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbjFNJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbjFNJkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9165212A;
        Wed, 14 Jun 2023 02:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3568E618EA;
        Wed, 14 Jun 2023 09:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FAAC433C8;
        Wed, 14 Jun 2023 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735545;
        bh=3dwGe7NBdzXEbIELVlW6d1uX67nXdWAeWyq/2PZLMRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vySnYjmakgnaf6AEEztSRXrsR3h8XSRiPnxGet/fxNQPrrELN8Ig1s40OlktoLCcm
         sOt2QWc8Xmb0xLit2YUDQw+0neV/yqbbB0D8Kk897ARFpHoua6P7DviRmpg3mHMcsZ
         z7HUAMqyHFiEOWWq7CTcmDsplknix2T6ax52xWZA=
Date:   Wed, 14 Jun 2023 11:39:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Closing down the wireless trees for a summer break?
Message-ID: <2023061447-sneezing-engraved-e7a1@gregkh>
References: <87y1kncuh4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1kncuh4.fsf@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:22:47PM +0300, Kalle Valo wrote:
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

Sounds reasonable to me, have a nice vacation!

greg k-h
