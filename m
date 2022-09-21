Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9722A5BFFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiIUO0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIUOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B058E9A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E762C62BD7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FE2C43158;
        Wed, 21 Sep 2022 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663770356;
        bh=12QiFBmOyJ89p2Lurx71OACbYpe4WdDJdnaFhJFquc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDiovnCbMyyVU83/dekCfvkZpqjjUSGC/bexanmAY9dcOF5zhu3I/HsXF94YGfeTs
         SjGHoBDXhXKA2VZgPC7fNn/z1qVjqvi3oeY9yphO3Be9lH4vM/uBwcG/vPvyxzyyr6
         ZRWl2mCK+N4+P75fFgMuUmRIK8I0iMWFbrp/tChI=
Date:   Wed, 21 Sep 2022 16:22:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 6.1
Message-ID: <YyseIrh23g0WDj1s@kroah.com>
References: <20220921112108.GA212106@ogabbay-vm-u20>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921112108.GA212106@ogabbay-vm-u20>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:21:08PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 6.1.
> 
> This is a fairly quiet pull request that mainly contains additional debug
> support (added trace events support) and new uAPIs to retrieve device
> information.
> 
> And, as usual, there are multiple bug fixes, refactors, etc.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit ceecbbddbf549fe0b7ffa3804a6e255b3360030f:
> 
>   comedi: convert sysfs snprintf to sysfs_emit (2022-09-09 10:37:52 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-09-21

Pulled and pushed out, thanks.

greg k-h
