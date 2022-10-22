Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8C608C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJVLGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiJVLF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE3550A0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 03:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C528F60AC1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D02C433C1;
        Sat, 22 Oct 2022 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666434217;
        bh=LCNEvIj2AqfcwpW4IRtS3tSSDlo/OMW9uwj0MrM2S7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Avz7XErowcjWX3gmUYau+s63zmMKW1qaaWLWtyItg4Tsm3j0eS5/LzgkSEOBQ64G
         QowsT2zIwoV6m2+fXCl22EojyNBeQrUffp6IKDLnKmW8jrhOIQe5tnyWu+cvWVWOf/
         5km4TXX2sZDkX+qSlSL6k1phtdgfTnH2bQGtNE20=
Date:   Sat, 22 Oct 2022 12:23:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, james.clark@arm.com
Subject: Re: [GIT PULL v2] coresight: Fixes for v6.1
Message-ID: <Y1PEpjH8aQHpTdZH@kroah.com>
References: <20221020214832.850389-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020214832.850389-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:48:32PM +0100, Suzuki K Poulose wrote:
> Hi Greg,
> 
> Please find a couple of fixes for coresight subsystem. I have addressed
> your comments from the previous post :
>   - Removed 2 patches that were not really critical for v6.1 
>   - Fixes tag is added
>   - Fixed git repo URL.
> 
> Please pull.
> 
> Thanks
> Suzuki
> 
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git  tags/coresight-fixes-v6.1-1

Much better, thanks.

Now pulled and pushed out.

greg k-h
