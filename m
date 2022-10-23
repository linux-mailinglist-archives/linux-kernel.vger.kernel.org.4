Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F666095E5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJWTqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJWTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:46:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573074A815
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1367FB80DC8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDE3C433C1;
        Sun, 23 Oct 2022 19:46:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UdxZSM4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666554405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y0ZtGIAjlnW/1qS8N0HiLUg6JrEpw7SLT9bZdx5XukY=;
        b=UdxZSM4FyDLGBiSeluKhh9ZA0OFc8ErkGlDdtQPyhXi+NAaQyeUHtaE8gtaEJNGlmRr9cg
        HUCr9EsSDZTTuDKFavQ+yTX7+Iu1GpptRCnuay7nbR7fJ8NVHJLwsCi/vXfE5Idhl9x9Vf
        O/ZN4oNBEjGZNALdfbJi3rZsDOKDoz0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ce4d4ca7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 23 Oct 2022 19:46:45 +0000 (UTC)
Date:   Sun, 23 Oct 2022 21:46:41 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Message-ID: <Y1WaIfla5fE141ii@zx2c4.com>
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
 <YzXe66n3IRbDBwxS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzXe66n3IRbDBwxS@google.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:07:39PM +0100, Lee Jones wrote:
> On Mon, 08 Aug 2022, Andy Shevchenko wrote:
> 
> > Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
> > definitions from DT") regmap MMIO parses DT itsef, no need to
> > repeat this in the caller(s).
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/syscon.c | 8 --------
> >  1 file changed, 8 deletions(-)
> 
> Applied, thanks.

Linus applied this already:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca4582c286aa4465f9d1a72bef34b04ee907d42e
