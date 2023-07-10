Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597874DE97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGJTv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGJTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0CC1BF;
        Mon, 10 Jul 2023 12:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E8F611BC;
        Mon, 10 Jul 2023 19:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CDFC433C8;
        Mon, 10 Jul 2023 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689018703;
        bh=NXlbhj/0cxgH0ijFVF/EaGRYBQvflqeLcwwZA4/SIPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oN1TkI7ZXaoq0KTpySKiSK/s908C0xnNLG1SvQplQx/czSaY3eWHSip+bIPQRoc1D
         4Dv65d6rXWMzB6m7nKCS6EcehhLtZDNJqfeYNn3o1ht/2rZWB0qQeRnNgD/c+vMV3t
         W+GJoj+PG8cwrQGc4/KQJDudoatitcxCk7xy5hI8=
Date:   Mon, 10 Jul 2023 21:51:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
Message-ID: <2023071002-phrasing-tranquil-49d6@gregkh>
References: <cover.1689008220.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689008220.git.linux@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:10:10PM +0200, Thorsten Leemhuis wrote:
> This is a RFC and a bit rough for now. I only set down to create the
> first of the three patches. But while doing so I noticed a few things
> that seemed odd for me with my background on writing and editing texts.
> So I just quickly performed a few additional changes to fix those to see
> if the stable team would appreciate them, as this document is clearly
> their domain.
> 
> If those changes or even the initial patch are not welcomed, I'll simply
> drop them. I'd totally understand this, as texts like these are delicate
> and it's easy to accidentlly change the intent or the meaning while
> adjusting things in good faith.
> 
> At the same time I might be willing to do a few more changes, if people
> like the direction this takes and want a bit more fine tuning.

I do like it, many thanks for taking the time to do this work, it's much
appreciated.

If you resend the first 2 as a non-RFC patch, I'll be glad to queue up,
the last one needs some more work as mentioned.

thanks,

greg k-h
