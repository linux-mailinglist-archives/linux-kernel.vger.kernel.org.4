Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2865B6960
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiIMIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiIMIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:20:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A58DF91;
        Tue, 13 Sep 2022 01:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 554F4B80E2C;
        Tue, 13 Sep 2022 08:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88429C433D6;
        Tue, 13 Sep 2022 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663057203;
        bh=TEylVWteutplzRDZNKcNV4P4jQnWfzKPaih/IHRvPp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKJdrSd1gvSamev5AtCFi3G9Y67eavx0ZP4qIwRKW/HRoNR4vsErC2EKgGO0pV77O
         /FUpyukSwjwb+Gz8IhFoBwvHzVfwKXbVjhMoXQmAVVxkkSEQydM/KX9g/kYVsAfRy7
         R0tNxWPaH947NAO/Smpr4+vvoaqht+cLRpGARBSU=
Date:   Tue, 13 Sep 2022 10:20:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Zyngier <maz@kernel.org>, kernel@pengutronix.de,
        linux-spdx@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] SPDX tags for copyright
Message-ID: <YyA9S9KD47D6Hoce@kroah.com>
References: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
 <YyAPsqKNSwdHccLj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyAPsqKNSwdHccLj@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:05:54PM -0700, Christoph Hellwig wrote:
> On Fri, Sep 09, 2022 at 12:38:48AM +0200, Uwe Kleine-König wrote:
> > Hello,
> > 
> > for Debian packaging having SPDX license tags already simplifies
> > creating the required copyright documentation considerably. Another
> > information that is needed for Debian packaging is the copyright
> > information. There is an SPDX way for copyright information, too. The
> > second patch converts scripts/kallsyms.c to that mechanism as an example
> > to maybe discuss if we want to do that in the kernel.
> > 
> > While the SPDX-FileCopyrightText is officially a free-form field, I
> > suggest to just stick to the format
> > 
> > 	(<year> )?<copyright holder>
> > 
> > to simplify machine consumption even further.
> 
> Adding the linux-spdx list and Linus.  If we go with this format
> (which doesn't sound bad), we'll clearly need to document the format
> we want, and that people should use it.
> 

There is a well-agreed-apon legal format for copyright lines already,
and those lines should be fine in the comment text at the top of the
file.  No need to mess with SPDX-FileWhateverTagWeWant type of stuff
here at all as all of our tools can easily find those lines if they
really want to extract the copyright information.

SPDX is great for license declarations, let's stick with only using that
for now until we finish the whole kernel and then maybe we can worry
about adding additional meta information if it's really decided it can
benifit anyone.

For now, copyright lines don't seem worth it to me, just leave them in a
comment block please.

thanks,

greg k-h
