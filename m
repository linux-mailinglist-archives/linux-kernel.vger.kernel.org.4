Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738EC609B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJXHMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJXHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC12167E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86DB76102D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB7C433D6;
        Mon, 24 Oct 2022 07:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666595533;
        bh=Ntq5RXZvhgEtLPdfejPjUVGqzgXXdFBH79ozKMla39s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciXy/Z8Sqkqv47tJsyyerSdTIJfUIkkffb7fh7epLBdpopWGFu46vXdpjdf8RXbsT
         eQmlkmLnEzjPzdSAGPP2mUEac+9OuymP/AiZR9WXbVmQq4kubV+SoiW8iTQ+098g9c
         VeYQv0DRl+cBgnN1ysRGg1bmM/NDY55O95BqWMc1+NacBkLnYFYT9fh+l3byd1H96g
         rQrDIDMskGuxVDmJxzS+qqiSDzjJHbO9hA0CFCH0pllEfjh5phL40iCdtBPEmwlryw
         ez70d+AI/hvPz/MtyPexPg8CzCS8xB/isuT6KN1PDAwMv9/NbkDukXWHFpaODCYEPg
         GYHv9cGQ2v2kw==
Date:   Mon, 24 Oct 2022 08:12:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Message-ID: <Y1Y6ycm1MdNbl1vg@google.com>
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
 <YzXe66n3IRbDBwxS@google.com>
 <Y1WaIfla5fE141ii@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1WaIfla5fE141ii@zx2c4.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022, Jason A. Donenfeld wrote:

> On Thu, Sep 29, 2022 at 07:07:39PM +0100, Lee Jones wrote:
> > On Mon, 08 Aug 2022, Andy Shevchenko wrote:
> > 
> > > Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
> > > definitions from DT") regmap MMIO parses DT itsef, no need to
> > > repeat this in the caller(s).
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/mfd/syscon.c | 8 --------
> > >  1 file changed, 8 deletions(-)
> > 
> > Applied, thanks.
> 
> Linus applied this already:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca4582c286aa4465f9d1a72bef34b04ee907d42e

Even better, thanks.

-- 
Lee Jones [李琼斯]
