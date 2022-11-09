Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E436622D50
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiKIOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiKIOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:18:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC5186C3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:18:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E9ACB81EF2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E1DC433C1;
        Wed,  9 Nov 2022 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668003498;
        bh=GlHtbsXNpec5UMsRv71sb8jBMCuQn8cZcypfmUe0w0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mt9IqnLeCTQZrOpxt/UkzKTMGOPLF7UIfhpglwTA+qXhza8T8h+t9vC1n5IjSmPdc
         8llXXdBXcgvaSKGqnKiffeJyy1kh23tSHmhNpod9kPNQQVzKVAqp+kXJQGy1ddOQu+
         FHe0ZOSNshtlY08m5zTRrs1z/nQziBx8nxEbO3iE=
Date:   Wed, 9 Nov 2022 15:18:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Accessiblity: speakup_bns: specifying the default driver
 parameters among the module params
Message-ID: <Y2u2plss5ykqwa4S@kroah.com>
References: <20221022185600.3989-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022185600.3989-1-osmtendev@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 11:56:00PM +0500, Osama Muhammad wrote:
> This is an enhancement which allows to specify the default driver
> parameters among the module parameters.
> 
> Adding a default variables to the speakup_bns module
> allows to easily set that at boot, rather than
> setting the sys variables after boot.
> More details can be found here:
> https://github.com/linux-speakup/speakup/issues/7
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> 
> Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Please do not put a blank line between these here.

And is this a v2 patch?

I have a bunch of patches from you, but I can't tell which ones is the
latest ones, and which to drop.

Can you send these all as a patch series so that I know the order in
which to apply them, and to be sure that I have the latest versions?
I'll drop all of your pending patches from my review queue now.

thanks,

greg k-h
