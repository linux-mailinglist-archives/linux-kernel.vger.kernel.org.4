Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908626522AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiLTOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiLTOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:33:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B16193DC;
        Tue, 20 Dec 2022 06:33:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DAB61476;
        Tue, 20 Dec 2022 14:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B691C433D2;
        Tue, 20 Dec 2022 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671546783;
        bh=tZNFDPg0mFgt2/Hth7zp3gZmrGcMTXVqX6ZJS/WH95Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XsbwpQRqt8TUNKDp7x/OKqlcn+PiqnMzvJr/9FDWudSRI/6F4sGTIsMEu/GX0PjGT
         wUj4KYqretKAIdfS5yu2U2qFIJZwg1ShMEIbWQc42fdilTA33SO4h0VfG6Zy6YLT+K
         i74/3ShapcDlGywloRgT4b/XFKzmdwUS+GMphLZy6I/4gPMASqYKC3hdVnLQHdW802
         LscNkFzymdT/FeXmt2leNsg0culb965SKl3GtGgCKyR6RwEubaBccaiXoGOKj7Hc5y
         wtb0k6msB9aFgxihYqGEwRg9H0C8EMPQOReZrMHfD17iazh4OQiWTkZ9w3blMTLskk
         v1Al7oxRy2UVQ==
Date:   Tue, 20 Dec 2022 15:33:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jingyuan Liang <jingyliang@chromium.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        seobrien@chromium.org, dtor@chromium.org, hbarnor@chromium.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: Add Mapping for System Microphone Mute
In-Reply-To: <20221213225328.3538581-1-jingyliang@chromium.org>
Message-ID: <nycvar.YFH.7.76.2212201532550.9000@cbobk.fhfr.pm>
References: <20221213225328.3538581-1-jingyliang@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022, Jingyuan Liang wrote:

> HUTRR110 added a new usage code for a key that is supposed to
> mute/unmute microphone system-wide.
> 
> Map the new usage code(0x01 0xa9) to keycode KEY_MICMUTE.
> Additionally hid-debug is adjusted to recognize this keycode as well.
> 
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

