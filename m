Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C05ED660
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiI1Hjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiI1HjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E5115A4D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:37:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2B461C2C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36008C433C1;
        Wed, 28 Sep 2022 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664350013;
        bh=bYAtlIPheExjzNKILutDM0jkkL3N6IktRpSohY/6ohE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbjCnVlL8DUXKXakDwSHyJBb5Zq4g/gFuh0tIbD5nfYHRNxna3IIjGhhkhXI1RLLB
         xOPdMp5UQH0mZziG3zfmWZAQsTMWRLdORh2sxj9aIB8D+Jr8mzYa2E+Of3wpl6nbYN
         ++gR9wvjJUXN4zGtSld9IarBdrGoxJLQ++G/YpPg=
Date:   Wed, 28 Sep 2022 09:26:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [GIT PULL] fsi changes for v6.1
Message-ID: <YzP3OtV4GerKDrYe@kroah.com>
References: <CACPK8Xf+F9JYQpbKHLPeey-DjQJBY-82KQ7XRyaOeMu_HhEBig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf+F9JYQpbKHLPeey-DjQJBY-82KQ7XRyaOeMu_HhEBig@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:54:58AM +0000, Joel Stanley wrote:
> Hello Greg,
> 
> Here are some FSI updates for v6.1. The hwmon changes have been acked
> by the maintainer.
> 
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v6.1

One of the commits in here is wrong, I get the following error:

Commit: bb70829cf3c3 ("hwmon (occ): Fix response length in checksum retry")
	Fixes tag: Fixes: c27b98ca0edb ("hwmon (occ): Retry for checksum failure")
	Has these problem(s):
		- Target SHA1 does not exist

linux-next should have also warned you about this :(

thanks,

greg k-h
