Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182876B9BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCNQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCNQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C575BA9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E60EDB81A3E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35351C433EF;
        Tue, 14 Mar 2023 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678811950;
        bh=Vx7uM9fWMCpVMGWtFNryGdXdw31PgaYm7KlFHOU1CLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdEhbzs1kV/dXeAH8MDyev+OO5WZj8wqk/IU/cHy/kb7/5PhKl82ojWqOJtxBbPzf
         qsdLG7edz5/l9Z/ydeC8zhY/pxepnTtXd51i70E6sJmOGKd4DCmefjEIqX+939fh2s
         lBvgzLrmwLgNamx2QWQndUS0OgQLNKru5TfXyExY=
Date:   Tue, 14 Mar 2023 17:39:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBCjK2BXhfiFooeO@kroah.com>
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
 <64f9d3ca-268e-71ae-4a6d-b71315a8406e@gmail.com>
 <ZBCbJR2RVzc7Wr4g@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBCbJR2RVzc7Wr4g@aschofie-mobl2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:04:53AM -0700, Alison Schofield wrote:
> On Tue, Mar 14, 2023 at 01:07:59AM +0100, Philipp Hortmann wrote:
> > On 3/13/23 21:43, Kloudifold wrote:
> > > The sm750 driver had some functions named in CamelCase,
> > > which violates the kernel's naming convention.
> > > In this patch, I rename these functions to snake case,
> > > which is the expected style.
> > 
> > Hi,
> > please make the Subject more unique. Many patches could have this name.
> > Look for examples in:
> > https://lore.kernel.org/linux-staging/
> > 
> > Please use your full name consisting of a given name and a family name in
> > front of your email. Or is this not possible and "Kloudifold" is both?
> 
> Kloudifold,
> 
> It'll probably take a bit for the change, allowing pseudonyms, to become
> common knowledge. When the question comes up, you can just point to the
> latest update to Documentation/process/submitting-patches.rst as I've
> done below.
> 
> Phillip,
> I commented similar to you, and then discovered this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> 
> Pseudonyms now allowed.

"Known pseudonyms" are now allowed.  So that means that somehow I need
to "know" this is actually a pseudonym and that it is unique and so on.
As you are dealing with outreachy already, odds are you have to use a
non-pseudonym for them in order to track patches and payments and the
like, so please use the identifier you use with outreachy.

thanks,

greg k-h
