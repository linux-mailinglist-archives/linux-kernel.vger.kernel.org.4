Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1A5B7FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiINDtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiINDs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:48:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224C6EF3F;
        Tue, 13 Sep 2022 20:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DB3AB811FE;
        Wed, 14 Sep 2022 03:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E966FC433C1;
        Wed, 14 Sep 2022 03:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663127334;
        bh=855EMhqG1F4Yb2lULbhbBeru9HWHtEAnJPYMA3ndzwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdfAdmLK3701NSj4dsjukqEnEYr6a9XbGsva8cRebxG2/eCbE1Op4FkiIFkgxYtZ0
         8TSXHYb/aWFcPxWmKw5SaIr+g5mI2dpwJNqp9uMspNPtVznUbWr7W6EgI7sc84NcjO
         PJ1PonsKhAQPfk/rAb2yiXv0NnFpUkreC27hvg0wlq9G0XEEqqI6rTQq/RYWR8K65X
         NOpCbSmDzWX+x9u3iUNDTI+8lZSJCuzFrrGJPxxlcrMNmEleVI6YyIIRWX+I59EmW6
         9JBiz6VLzCOjY5NRynpjkkoaxdN39s9RU58H7YyCIu6NH/OBQIO0cWx7+MB4yzu9hq
         bOnp4JPTvcpIA==
Date:   Wed, 14 Sep 2022 11:48:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20220914034849.GI1728671@dragon>
References: <20220913201557.2513488f@canb.auug.org.au>
 <CAJ+vNU2naFP=X1B3HwPCRez7Phft3OGA0sM6TMZUXJ78S5s6Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2naFP=X1B3HwPCRez7Phft3OGA0sM6TMZUXJ78S5s6Aw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 10:08:16AM -0700, Tim Harvey wrote:
> On Tue, Sep 13, 2022 at 3:16 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > In commit
> >
> >   c1f84a75babe ("arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation")
> >
> > Fixes tag
> >
> >   Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400
> >
> > has these problem(s):
> >
> >   - Subject has leading but no trailing parentheses
> >   - Subject has leading but no trailing quotes
> >
> > Please do not split Fixes tags over more than one line.
> >
> 
> Stephen,
> 
> Sorry, that was my fault with my editor's word-wrap getting in the
> way. I will be more careful in the future.
> 
> Is there anything that I can and should do at this point to result this one?

I fixed it up.

Shawn
