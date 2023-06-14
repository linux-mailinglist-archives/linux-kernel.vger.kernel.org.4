Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F18730811
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjFNTWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjFNTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C7F2727;
        Wed, 14 Jun 2023 12:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C8B643F2;
        Wed, 14 Jun 2023 19:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A389DC433C0;
        Wed, 14 Jun 2023 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686770515;
        bh=pWxo7CHRl3J5qYPfbEQrjT3qEyGFaT8teEK3o66lcUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dK0Dd7N/nvm9sa9sQ6YFqPCE0djK6abYGeOfqLaAE7OvmGz472hivmfCUPjdts4TH
         lWlT7vbAcHHsUMba1vj+8aUrfOxPIj68Q1yX2s7UvyUY5mCfQP7WS3UtfxCqlW8fVp
         C8v2z7HoXukO577ZJcuHlEaFxVfrq+Mo4O2xL5s+pHCFhnK0eWnPV3RWQnRF6kZon3
         viVaPiKK9VKLFz5Y5pyaArOm/Lqmy0MkToDVJeYvh4xAEImO9OHI3Sdz7LvsD0djg6
         ScEJyEIMlSNvmOehWIE4H3La7znDRQ1o9Vucgt7AyMCnEO1RGlOr9htW/N7lK6Q7D/
         EG2L3x/IxylAw==
Date:   Wed, 14 Jun 2023 12:21:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Toke =?UTF-8?B?SMO4aWxhbmQt?= =?UTF-8?B?SsO4cmdlbnNlbg==?= 
        <toke@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: Closing down the wireless trees for a summer break?
Message-ID: <20230614122153.640292b9@kernel.org>
In-Reply-To: <87a5x2ccao.fsf@kernel.org>
References: <87y1kncuh4.fsf@kernel.org>
        <871qifxm9b.fsf@toke.dk>
        <20230613112834.7df36e95@kernel.org>
        <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
        <20230613195136.6815df9b@kernel.org>
        <c7c9418bcd5ac1035a007d336004eff48994dde7.camel@sipsolutions.net>
        <87a5x2ccao.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 18:07:43 +0300 Kalle Valo wrote:
> But do note that above is _only_ for -next patches. For patches going to
> -rc releases we apply the patches directly to wireless, no other trees
> are involved. My proposal was that net maintainers would take only fixes
> for -rc releases, my guess from history is that it would be maximum of
> 10-15 patches. And once me and Johannes are back we would sort out -next
> patches before the merge window. But of course you guys can do whatever
> you think is best :)

Ah, good note, I would have guessed that fixes go via special trees,
too. In that case it should indeed be easy. We'll just look out for
maintainer acks on the list and ping people if in doubt.
