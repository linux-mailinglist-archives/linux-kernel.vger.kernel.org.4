Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0416CB6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjC1GRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjC1GRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84126A3;
        Mon, 27 Mar 2023 23:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A15AB81900;
        Tue, 28 Mar 2023 06:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A94C433D2;
        Tue, 28 Mar 2023 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679984202;
        bh=UGy2gfM48qzHQSnn4f+tThuMOt94NHOOU4nsfiZf8pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4ckZ0Athxb/QiMOX/1N0+58S2rqu0IDyxWxWFC9JqHEFzQKdeKvYrRI40qTLssza
         qfiODIK89kc8Dn465F+a9U3djSMX2Vm3l2w0hSfBYo4EOJ99ZfDe0vSJDW5I857oY7
         ZNhMXhwD8PWmBGGq8rv2h4Ztm5j6TbcU52l8F0Kpe7eOpmbJ8f+EAS0CRbfyQkfgJ2
         4M06NqEJXD1nTBs3ApvIq8GuxCTy6B4Va4RnJ9gqQVq6JTz7IkhcEgZmM+M/kMa9ix
         EX18qRpQMz3q4JDg1h6cHYzv9O+UAPsdOIJSDkeLCGAi7ox8E7fNCCW1b7iqJ4crrm
         nYa3FOptEwzZw==
Date:   Tue, 28 Mar 2023 14:16:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb tree
Message-ID: <20230328061636.GQ3364759@dragon>
References: <20230328131110.6049c4ce@canb.auug.org.au>
 <ZCJ62nDO3PocFPeP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJ62nDO3PocFPeP@kroah.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 07:27:54AM +0200, Greg KH wrote:
> On Tue, Mar 28, 2023 at 01:11:10PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commit is also in the imx-mxs tree as a different commit
> > (but the same patch):
> > 
> >   fcd3f50845be ("arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb")
> > 
> > This is commit
> > 
> >   989e2ee399cd ("arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb")
> > 
> > in the imx-mxs tree.
> 
> Thanks, I can revert this in the imx-mxs tree, but it should be fine
> when Linus merges so I doubt that is needed.

My branch is not stable anyway, so I'm dropping the copy here.

Shawn
