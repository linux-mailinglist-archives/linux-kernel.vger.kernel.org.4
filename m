Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18F5EC3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiI0NKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiI0NJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67217E2C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EE9F61964
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523FEC433D6;
        Tue, 27 Sep 2022 13:09:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nY8c4m6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664284167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZPP5PahCbJY5jGiCruWB3XwrKpCIDgkTFtW5rPCQtk=;
        b=nY8c4m6pbiX67e7lxXWDvjYm3OGXZTPS9yhS0MYqMpf5zzMIvrg6aHptPRHOkfbOzb4OD1
        dcIyVR631A9X+HhqXCQGH4kRcPuzAyQl2Zy9SvAw3SBIUB9TdezDR82uryD9bbCHzZTamd
        XEUWlmllkmeLsoothqluqcTNsTYu5BI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 61342710 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Sep 2022 13:09:27 +0000 (UTC)
Date:   Tue, 27 Sep 2022 15:09:21 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v4 3/3] m68k: generate new RNG seed on reboot
Message-ID: <YzL2AXQeVC4XvPPf@zx2c4.com>
References: <20220926113754.1256358-1-Jason@zx2c4.com>
 <20220926113754.1256358-3-Jason@zx2c4.com>
 <CAHmME9qLcfT5Mjw1cudhA-zGaLUubkPCTF7trw1ek40==BwumQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qLcfT5Mjw1cudhA-zGaLUubkPCTF7trw1ek40==BwumQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:13:01PM +0200, Jason A. Donenfeld wrote:
> Hi Geert,
> 
> On Mon, Sep 26, 2022 at 1:38 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Rather than rebooting into a system with no entropy, regenerate the RNG
> > seed before rebooting, so that the new system has a fresh seed.
> >
> > Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Laurent made a compelling case *against* this approach. So feel free
> to drop this 3/3 patch. However, 1/3 and 2/3 should still be
> committed.

For Geert's ease, I'll send a v5 with 3/3 dropped.

Jason
