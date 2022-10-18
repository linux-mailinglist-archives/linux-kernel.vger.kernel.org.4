Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F766031C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJRRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJRRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CAD1AF16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD7D6168D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FB7C433C1;
        Tue, 18 Oct 2022 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666115375;
        bh=rSSB9EzlH3hW6nEAiCKYzmvYhNoeyNCystI8hL3jnyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J33anJQltcC+MDubNmYbVj02VACOIsN5Ni9X/IZpz7BqbkXTd3KMuQ/5aN5EYPaTe
         6JfWLFEQbW4Za2+S7VeZfd663aa9maq4rn3sxpuwh8izdlTqUHG2zQXN3fnm0OpNl2
         kDtRhTFpjkHw4NT37WLAI7JrW6LO+BJTMrx76ghs=
Date:   Tue, 18 Oct 2022 19:49:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rts5208: Replace instances of udelay by
 usleep_range
Message-ID: <Y07nLWIEKR1cCkIg@kroah.com>
References: <Y07OcqPNjSihOByt@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <Y07dExeWY5lXgKLr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07dExeWY5lXgKLr@kroah.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 07:06:27PM +0200, Greg KH wrote:

<snip>

For some reason you sent this only to me, which is a bit rude to
everyone else on the mailing list.  I'll be glad to respond if you
resend it to everyone.

thanks,

greg k-h
