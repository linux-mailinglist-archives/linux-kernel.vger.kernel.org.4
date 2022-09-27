Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2015EBB66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiI0HU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiI0HU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29650A0319;
        Tue, 27 Sep 2022 00:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2346162A;
        Tue, 27 Sep 2022 07:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BAAC433D6;
        Tue, 27 Sep 2022 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664263255;
        bh=FnPY5SFTb2LXLv1UD9l9CqwE9yHAMgltzFqzmKnQSUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XE78cblGyZbxIhpbPJqRoDs0lCgt3gCc/ff5eqipERIbLK9Py5fng0GAtrFqY+Ezm
         /b6GZGFen33pdvbKHn2OIHwSs8MBqp0/jvv7fCAshGwP/Oba8pn9g7pjChvaQyPTg6
         89MxJMGyTe20iVrDBnSqKgdR9U1yFITB2a/7GW48=
Date:   Tue, 27 Sep 2022 09:20:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: Re: [PATCH] Documentation: NBD_REQUEST_MAGIC isn't a magic number
Message-ID: <YzKkVKZXqt0gS2kZ@kroah.com>
References: <20220927003727.slf4ofb7dgum6apt@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927003727.slf4ofb7dgum6apt@tarta.nabijaczleweli.xyz>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:37:27AM +0200, наб wrote:
> It's part of the line protocol, same as in commit 82805818898d
> ("Documentation: NBD_REPLY_MAGIC isn't a magic number")
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> Based on driver-core-next where the main 18-patch series
> of magic-number.rst trivial cleanups landed ‒ I'd missed it then

Thanks, now applied.

greg k-h
