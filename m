Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4973C72C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjFXGvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFXGu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBEE1BD6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09DE6028D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8178C433C8;
        Sat, 24 Jun 2023 06:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687589454;
        bh=PgkM/agWEzkV5O8q2f8AerxnNjt83yq2Cif+ksBuT5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ph5Uo/SAaykbjmUcgRS/wlzuFsMU1uMQRfZwB5NDJ8cC4jrons60SFAoMRCL+DKmo
         +r9labIhdk+E+RSuEvDFHDkomAWbmhAZrUNd/kmFQw99RUisxchMaaJMtzlDzcpk5c
         o0B3L4GBvp3CUBhkaVcdPZiC3yzX8ULXySiNxdLw=
Date:   Sat, 24 Jun 2023 08:50:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eperi1024@gmail.com, hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH v2 0/5] Fix some checkpatch issues
Message-ID: <2023062422-anchovy-hazy-0996@gregkh>
References: <20230621184635.25064-1-franziska.naepelt@gmail.com>
 <2023062306-reload-squeezing-633a@gregkh>
 <2d1ba862-961c-ec91-3a28-7f2f221b90d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1ba862-961c-ec91-3a28-7f2f221b90d4@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:20:42PM +0200, Philipp Hortmann wrote:
> On 6/23/23 10:18, Greg KH wrote:
> > On Wed, Jun 21, 2023 at 08:46:35PM +0200, Franziska Naepelt wrote:
> > > This is a series of patches to fix some trivial checkpatch issues. Not all
> > > issues have been fixed. I intend to submit another series to fix more stuff.
> > 
> > None of these apply to my staging-next branch :(
> > 
> 
> Hi,
> 
> this is the repo and branch I use:
> 
> git remote show origin
> * remote origin
>   Fetch URL:
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> ...
> git branch -a
> my branch: staging-testing

Please note that this branch will get rebased at times, so be aware of
that and know how to handle it properly.

thanks,

greg k-h
