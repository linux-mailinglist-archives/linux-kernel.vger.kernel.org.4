Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E795BB76D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIQJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIQJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54912624;
        Sat, 17 Sep 2022 02:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6685A6130F;
        Sat, 17 Sep 2022 09:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A81C433C1;
        Sat, 17 Sep 2022 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663405793;
        bh=Q3qqCoQjiW2j4y7AAaYMP+IZhK8MSfspKAxLuttV6/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wWPWQEeExryEEmtd0MMA1e1++Ihig6rT5aEplfjFSCFz/iemew3U52DfqH03ulX4C
         24T5o5yRk2B/m2Ai4TDQmIxjdbkNk/cyXF3fpbIb6TKpY/s8Xwl4EIOmVO9WuEjNDX
         2DtkGeI19w69mq2GI5zafD/nz0o2WTOHef8F4GaQ=
Date:   Sat, 17 Sep 2022 11:10:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: general protection fault in gs_start_io
Message-ID: <YyWO/M02ppD7xdzc@kroah.com>
References: <CAB7eexJLw1dAjzFCOp4UzW7h4Vv-NLtUcy6Q+4kk7eOP69w+gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexJLw1dAjzFCOp4UzW7h4Vv-NLtUcy6Q+4kk7eOP69w+gw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 08:47:17PM +0800, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
> triggered.

Great, please send a patch to fix this so that we can get it resolved.
Otherwise we will just have to put it on the very-large-pile of other
syzbot-found bugs at the moment...

thanks,

greg k-h
