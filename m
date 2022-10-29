Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F888612163
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ2I1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2I1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96CFFAA63;
        Sat, 29 Oct 2022 01:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB1760DFE;
        Sat, 29 Oct 2022 08:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20A6C433D6;
        Sat, 29 Oct 2022 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667032063;
        bh=QvXj1BCxefSJG8Han1wFrs6CanrWgeaMURoZXb/YyKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3a3db3xD8IjCsUMnb1p8xHYZrEjEvdIyO8BmajOaL4xkB73VinNsncDHaXlBbwy+
         LrsIAbDUxb/E4RTq+RbilqpzIBJFH3H2fiuXPtpi1DJZlvhLuh6r5D0D3tlCQMbO4f
         1ae6WNiQlCxAkx1aqqMFkImU6+V0411mdepvJi2Xq6bx7LJYP4YqIvICU3MflpYCUl
         rKcDqOkUt7yCDeB/37ow89Fl4eG7HyKPmrE9ZpwQGMgK1OhJ+ViNsGvIEYcjnueDfd
         CWS0bVvZ0YtfK3lrmG8z2BoZhknDkxFMpikoaHRT1PvSMSdhfV2wg6/JGjjEycaVqp
         Ng/X8OHNl8VQw==
Date:   Sat, 29 Oct 2022 16:27:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20221029082738.GS125525@dragon>
References: <20221024153720.5e387e34@canb.auug.org.au>
 <e111222f3c3157ad6c81022fa66e6cbc9072f9af.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e111222f3c3157ad6c81022fa66e6cbc9072f9af.camel@toradex.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 07:07:26AM +0000, Marcel Ziswiler wrote:
> Hi Stephen
> 
> On Mon, 2022-10-24 at 15:37 +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >   c9545754e9a7 ("arm64: dts: verdin-imx8mp: fix ctrl_sleep_moci")
> > 
> > Fixes tag
> > 
> >   Fixes: 1d8df9c74bff ("arm64: dts: freescale: add initial support for verdin imx8m plus")
> 
> Oh shoot, I guess Max referenced the commit from our downstream branch and while I checked the commit to exist
> on my end I missed it being a downstream one:
> 
> ⬢[zim@toolbox linux-toradex-imx.git]$ git branch --contains 1d8df9c74bff5d36d755324be1e695abf9cdeca8
>   toradex_5.15-2.0.x-imx
> 
> > has these problem(s):
> > 
> >   - Target SHA1 does not exist
> > 
> > Maybe you meant
> > 
> > Fixes: a39ed23bdf6e ("arm64: dts: freescale: add initial support for verdin imx8m plus")
> 
> Yes, Indeed, that must be the correct one:
> 
> ⬢[zim@toolbox linux-next.git]$ git branch --contains a39ed23bdf6ec7eb0f093b6ef0391e1f3d152f71
>   v5.19
>   v6.0
> 
> Sorry about that!
> 
> @Shawn: Can you fix this up or do I need to re-send anything?

Fixed.

Shawn
