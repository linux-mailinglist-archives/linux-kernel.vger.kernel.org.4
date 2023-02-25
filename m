Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B376A2A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBYPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:14:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5218150
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7068560B02
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 15:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75502C433D2;
        Sat, 25 Feb 2023 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677338038;
        bh=iXe9UKYQCjH23vFQPemL2RFAUw1tB3l+ph5INkEIzBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrpiS8jPWygvS7YSuDKxRAUk3DdlIN+v/kNRJejXeHJoadep2S5UHaOHGZxxIX8U5
         dbotEu9CxA3EeXVss3pR0eJov+3svu8c3n1kfI21v+D+fgMCM5K+F0kUeIutxYgfxi
         2RoLFJ/XvyqwCilcnqeSkkOeuvg2MEQ8IFB9j7D4=
Date:   Sat, 25 Feb 2023 16:13:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Regression in probing some AMBA devices possibly devlink related
Message-ID: <Y/oltFrnnMI17IOY@kroah.com>
References: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
 <CACRpkdb5dWOqRZpjcmx0M4H_REcZ+K6zY0tPz0K-hH9o_Ybd+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb5dWOqRZpjcmx0M4H_REcZ+K6zY0tPz0K-hH9o_Ybd+g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 04:06:48PM +0100, Linus Walleij wrote:
> On Sat, Feb 25, 2023 at 3:28 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > I have a boot regression for Ux500 on mainline, but bisecting mainline
> > isn't quite working for misc reasons :/
> 
> I however managed to revert Gregs entire branch for driver core
> with:
> 
> git revert -m 1 a93e884edf61
> 
> And this makes the regression go away, so I'm pretty sure it has
> something to do with the device link patches.

Does the fix at:
	https://lore.kernel.org/r/0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be

resolve this?

thanks,

greg k-h
