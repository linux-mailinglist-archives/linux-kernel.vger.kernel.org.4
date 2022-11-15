Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F986291FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiKOGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKOGs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:48:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A55FBD;
        Mon, 14 Nov 2022 22:48:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC7161553;
        Tue, 15 Nov 2022 06:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07933C433D7;
        Tue, 15 Nov 2022 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668494935;
        bh=XNUvDzdINCDghyaN5qN1SpG+kgjyEl3yUValNgB8rlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6GXYa0YgJxpYdi9nSImclrFT7Ybqn6KiS00FcqAT1O2zkfm5XkxKcxlk+8E4BaYB
         Kxw+IqcjLuydCVZvWDU4bC9FCpF/TGLy43pKCDrBo3uTTLU6Ex+shXaIFp8pQ+nqCr
         E242RBVanX8aS5bkBSYorFtp/IDBU6pIRWWQ2Q2w=
Date:   Tue, 15 Nov 2022 07:48:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] headers: Remove some left-over license text in
 include/uapi/linux/hsi/
Message-ID: <Y3M2UxC+vpf9cgyU@kroah.com>
References: <4919073b3dee8ca7612989659d31b12f9c5491ba.1662897400.git.christophe.jaillet@wanadoo.fr>
 <20221114210155.anq5gkggfrvj6nki@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114210155.anq5gkggfrvj6nki@mercury.elektranox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:01:55PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Sep 11, 2022 at 01:56:59PM +0200, Christophe JAILLET wrote:
> > Remove some left-over from commit e2be04c7f995 ("License cleanup: add SPDX
> > license identifier to uapi header files with a license")
> > 
> > When the SPDX-License-Identifier tag has been added, the corresponding
> > license text has not been removed.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> 
> IIRC that was intentional, since the plan was to seek for an
> explicit Ack from the copyright holder when removing the text.

Did that ever happen?

> I've added Greg for clarification and hopefully the latest
> mail address from Kai and Peter.

It's fine to remove license "boilerplate" text like this, especially
when it is wrong (hint, is the FSF's address correct?).

thanks,

greg k-h
