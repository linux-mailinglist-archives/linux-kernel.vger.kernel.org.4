Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD26752AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjATKk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjATKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:40:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF60AD28;
        Fri, 20 Jan 2023 02:40:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42EDBB823C5;
        Fri, 20 Jan 2023 10:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C8DC433EF;
        Fri, 20 Jan 2023 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674211253;
        bh=2ZGSvY3CLi11wQbJac1BOjTQjag/1Cacp1ae51bYeOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ly56sUDd4ZzuOTyiOyOxEqqSIJp4NFPS71znFRVQLuPqZ8ispU48m0gAuANk4RKgx
         rfDmFS3sQS0jouKLaMxmAHxggck0tuA6m82TTYv4Ejugw9/UvTh6LVft95ArZ5eV1W
         lCKOFQmKizm57lajmpwYAgJzA0TIILVUh8EMnqP8=
Date:   Fri, 20 Jan 2023 11:40:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.2-rc
Message-ID: <Y8pvrYml/wFDPHet@kroah.com>
References: <20230120102856.1199868-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120102856.1199868-1-djakov@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:28:56PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains fixes for the current cycle. The details
> are in the signed tag. It has been in linux-next during the last two
> weeks. Please pull into char-misc-linus when you have the chance.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.2-rc5

Pulled and pushed out, thanks.

greg k-h
