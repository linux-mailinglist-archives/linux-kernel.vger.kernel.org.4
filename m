Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7D5F0B40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiI3MEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiI3MD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:03:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D081178A0B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04AFDB8271D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AB9C433C1;
        Fri, 30 Sep 2022 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664539432;
        bh=sIFh66kGRGOzIZJH6xT/ZH9cQTL5hpcUPHrtYoCpfwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReSOll+DUgdUynM4RosLHr+56AZFTdWX20IBjBkdzPW537Ub2k5H5T/MlDxjNod9V
         UtNBoXrmUIYsX6lImZ+e6pQbL5i1FVUpd8QBRioJ9vdfKYzeS9VTa61+g3pELvuLSe
         3LgMNB/fzo1rVDdi4eL6OQkFS2JTD4zhMb1sNt4c=
Date:   Fri, 30 Sep 2022 14:03:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [GIT PULL] fsi changes for v6.1, second try
Message-ID: <YzbbEdePYqDCPhJY@kroah.com>
References: <CACPK8Xf8FrRmiZphxF1eoqcE_0CVOsxSv9SmUGHrfdKH6p0oRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf8FrRmiZphxF1eoqcE_0CVOsxSv9SmUGHrfdKH6p0oRA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:09:36PM +0000, Joel Stanley wrote:
> Hello Greg,
> 
> Here are some FSI updates for v6.1. The hwmon changes have been acked
> by the maintainer., and the commit with the incorrect Fixes line has
> been merged into the patch that it fixes.
> 
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v6.1-2

Much better, now pulled and pushed out, thanks.

greg k-h
