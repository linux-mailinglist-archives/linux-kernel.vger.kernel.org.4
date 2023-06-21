Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB417383FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjFUMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFUMlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7529B;
        Wed, 21 Jun 2023 05:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D206961565;
        Wed, 21 Jun 2023 12:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C71C433C0;
        Wed, 21 Jun 2023 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687351268;
        bh=DZSExkiX6hNfOHTfdDuzGK8ZdCX4lnUUnK2J7dMOUyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MP6ON4LX5x1YO+jm9xe37M2+BR0KvVuOFIetp+vJFmVGqCmlGqCSC2ECcGFcMPpeH
         UCe95/ErbIS0rbfNZGWuouXPuzHTGHFAv/Y+b95SsJYv+wUfV6j+g0nKsNQ8+WfYHj
         O1gsGvmN88YOgxyq7cTUrTlmJa3Ey0ChiqEY6t9Q=
Date:   Wed, 21 Jun 2023 14:41:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Message-ID: <2023062144-hefty-why-305d@gregkh>
References: <20230620212502.GI286961@mit.edu>
 <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:51:19AM +1000, Finn Thain wrote:
> > You appear to have a very different model of how non-profits might 
> > approach the Linux kernel --- could you go into more detail about why 
> > they might want to contribute to the Linux kernel, and how we might 
> > encourage them to contribute more engineering effort?
> > 
> 
> Sure. Here's a recent example, in which a not-for-profit volunteer might 
> have been granted an opportunity to work upstream: 
> https://lore.kernel.org/all/129c9d5e-213a-80c9-092e-dc1dcf38ae3e@linux-m68k.org/
> 
> The driver in question may may not be commercially viable, but that 
> doesn't matter, if the intention is to foster new maintainers and increase 
> the talent pool. And the problem ostensibly being addressed in the Linux 
> Contributor Maturity Model is a shortage of maintainers.

I would NEVER recommend ANYONE picking up obsolete hardware and trying
to get it to work to maintain the driver if NO ONE is actually using the
stuff.  That should not be for a not-for-profit to maintain as
obviously, no one uses it.

It's up to those that need/use the code to help maintain it, don't ask
not-for-profit groups to maintain and support code that no one uses,
that's a sure way to waste resources all around.

So that's a good example of how our ecosystem works properly, if no one
needs the code, it gets dropped.  Don't ask for it to come back without
real users who are invested in it please.

thanks,

greg k-h
