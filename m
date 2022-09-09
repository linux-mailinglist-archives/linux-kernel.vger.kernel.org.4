Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0EF5B2E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIIGGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIIGGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:06:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22152F7774
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE85BB822BD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DCCC433D6;
        Fri,  9 Sep 2022 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662703605;
        bh=7zGDU3BdHmCGK+cAAZcKUbBNWba3iuCoLKqtyl2YkKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwlFn8Vc8k1c3GicNVCJM6ZPQ4AEPqwnGqALd3wmuCXlNKSX/UtK3udbFz0MP0FU8
         nlq1VsEHpyM1DW68cppLDGeDxBsuH1s/a9L0xibzksW1W/Pyan4h0Tbck1HAnPvB2L
         CATfE0rcSPnvgY1dMU5AyhjuV1+SU+xHspm7nlXg=
Date:   Fri, 9 Sep 2022 08:06:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: fix potential memory conruption bug
Message-ID: <YxrX8tNR4uHCUWPT@kroah.com>
References: <20220909053038.33188-1-namcaov@gmail.com>
 <YxrTiN1OuJ2cbtrn@kroah.com>
 <CA+sZ8B_VtmUWnvvfWBUV1WVq_=gRid+6ffGRQwdxp+9DYcLDtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sZ8B_VtmUWnvvfWBUV1WVq_=gRid+6ffGRQwdxp+9DYcLDtw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Sep 09, 2022 at 08:01:29AM +0200, Nam Cao wrote:
> Hi Greg,
> 
> Just out of curiosity, how can we be sure that sizeof(unsigned int)
> is never 8 bytes? The C standard doesn't say anything about this, as
> far as I know.

Do you know of a Linux architecture that this is true?

Linux has a few more requirements than C does (i.e. an unsigned long has
to hold a pointer) so don't go by the C requirements please.

thanks,

greg k-h
