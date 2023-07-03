Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3614745F5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGCPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGCPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF1E43;
        Mon,  3 Jul 2023 08:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA42C60DDE;
        Mon,  3 Jul 2023 15:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AF2C433C7;
        Mon,  3 Jul 2023 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688396504;
        bh=0LlMTP/ss0qe/BwBBjUV7dxASlPdSFAkRzzV0NudEmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPGV3awB3NhNVOFw8hQI2a/tdVua3RI6YifZsvgfbQml+EYIEpQeJyO/mnnSRPQOR
         BDl+TsJAth0Qy8SuUrnYgWI0cQ4cYU6I5OLnDfrUkqvvQoqFLrXTDejxiJ4Xua1QEe
         NMRdbH2zzlFylgfGXWUNBAJA+H9qWVehApJcM074=
Date:   Mon, 3 Jul 2023 17:01:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, corbet@lwn.net, workflows@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: security-bugs.rst: update preferences
 when dealing with the linux-distros group
Message-ID: <2023070320-nutty-elitism-0e6c@gregkh>
References: <2023063020-throat-pantyhose-f110@gregkh>
 <202306301113.FA8FD533@keescook>
 <2023070323-sloppy-panama-4868@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070323-sloppy-panama-4868@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:00:51PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 30, 2023 at 11:14:05AM -0700, Kees Cook wrote:
> > On Fri, Jun 30, 2023 at 09:14:20AM +0200, Greg Kroah-Hartman wrote:
> > > Because the linux-distros group forces reporters to release information
> > > about reported bugs, and they impose arbitrary deadlines in having those
> > > bugs fixed despite not actually being kernel developers, the kernel
> > > security team recommends not interacting with them at all as this just
> > > causes confusion and the early-release of reported security problems.
> > > 
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Yeah, this is good. It might make sense to explicitly detail the
> > rationale in security-bugs.rst (as you have in the commit log), but
> > perhaps that's too much detail.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for the review.  I'll keep this as-is as it's the content of the
> file that matters in the end.

Ok, that didn't come out well, let me try again.  Let's leave the text
as-is for now, thanks.

greg k-h
