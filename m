Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2F68E460
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBGXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:25:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594F23EC5E;
        Tue,  7 Feb 2023 15:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8A1260F1F;
        Tue,  7 Feb 2023 23:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F41C433D2;
        Tue,  7 Feb 2023 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675812324;
        bh=AR2pEKDIfUJskNCYRtCKnrlFqI4/lLWDKa2t6eNDDv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xahk0p/4XtVZEn3Bf3v4sLdoZBdJ2IplfP4tTHeO7KoJa3n4fgPwQoTtMynPoU3Y1
         MzfjfeZV8X4wJllEXNlLLXzDNnSYoLcRuKvP1svDoM2jBmQPMsKBYVO5g+0CIW9cJy
         vVTYfqFv9+msrdO02+34nClFJv0Qip9O/ldEpcdFRvKcq+xctWPoh06HdPopggvP9U
         Zs3U33I+BHE/rb684A28QNx/8hTSmbt8r1/20+sbQOYyvbHQWVZ+3BqRD+zDoj+ohR
         rCtq+vTn1rNxwV1E7HSby1gx04g4slWm9+BT24zvuAyg5xEwwY/V+By9yTX+sAEeB6
         caH5BLgJkOYQw==
Date:   Wed, 8 Feb 2023 01:25:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tpmdd tree
Message-ID: <Y+Ld3zUy6AJGTePo@kernel.org>
References: <20230127095942.4269e21d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127095942.4269e21d@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 09:59:42AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   8a1719d664fb ("certs: don't try to update blacklist keys")
>   6e7dadceca39 ("KEYS: Add new function key_create()")
>   b4c45ccd5fcb ("certs: make blacklisted hash available in klog")
> 
> are missing a Signed-off-by from their committers.
> 
> -- 
> Cheers,
> Stephen Rothwell



Thanks, fixed.

BR, Jarkko
