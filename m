Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E49D63BFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiK2MVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiK2MVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:21:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83A05D69C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BFF8B8129F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07CDC433C1;
        Tue, 29 Nov 2022 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669724492;
        bh=UtWdIJ+QWDhqOVKIAsZAxsznnb09kFrTGmZAfFh4M3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afieyV2Gs56Zso8ktTVjY8iqxPFBXYqFaCSw70+zX6qNey7soYRNUr8SPenHT1F3S
         ucLlHBIa1W/dyWVwwSasXvClrzUtIxVpvzC1WJffOt6Zy68XKDiBVYCU2qjuWSOFZz
         ck3rFSFicucaRYOAT3/Kg7SH/OKEdgGeKzbksyTA=
Date:   Tue, 29 Nov 2022 13:21:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 6.2
Message-ID: <Y4X5PMmb2Sq4vOVq@kroah.com>
References: <20221123155313.GA545312@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123155313.GA545312@ogabbay-vm-u20.habana-labs.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 05:53:13PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 6.2.
> 
> There isn't any fancy stuff to talk about. There are some minor features and
> enhancements, but most of the commits are multiple bug fixes, refactors, etc.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 210a671cc30429c7178a332b1feb5ebc2709dcd6:
> 
>   Merge 6.1-rc6 into char-misc-next (2022-11-21 10:05:34 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-11-23

Pulled and pushed out, thanks.

greg k-h
