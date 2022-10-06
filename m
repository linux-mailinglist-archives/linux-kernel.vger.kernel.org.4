Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE55F6E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiJFT0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJFT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:26:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928BFF229;
        Thu,  6 Oct 2022 12:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFFD2B8217B;
        Thu,  6 Oct 2022 19:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A084C433D6;
        Thu,  6 Oct 2022 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665084363;
        bh=SWN3c1N2i17Oor7GLoDa7xCK+GAkdthttvFiuHhjth0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdkzhlGRl1IZSM4GPFP0dUXuqimdexxUKdl4kXd/FhiNw0Fb9837NUdVv9N0SVd/T
         +h2g1QOFc1TKP9oNPP84kJhlaIvd676jF9PZwn7TgiB0SPeb4OpQsrim85uXoeab/s
         Xh4Hu6PsgGNsxDxdWbf48JxdDWXDzaUi+pH4aLzQ=
Date:   Thu, 6 Oct 2022 21:26:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>
Subject: Re: [PATCH] usb: ehci-orion: Extend DMA mask to 64 bit for AC5
 platform
Message-ID: <Yz8r8w54FDGD4DaF@kroah.com>
References: <20221006095257.6934-1-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006095257.6934-1-vadym.kochan@plvision.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:52:57PM +0300, Vadym Kochan wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>

For obvious reasons, I can't take patches without any changelog text.
Nor would you want me to do so.  Please read the documentation for how
to write a good changelog text.

thanks,

greg k-h
