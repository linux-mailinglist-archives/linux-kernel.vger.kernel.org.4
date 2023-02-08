Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4640768EE86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjBHMHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjBHMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:06:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C94A1FB;
        Wed,  8 Feb 2023 04:06:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E421561156;
        Wed,  8 Feb 2023 12:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E961FC4339B;
        Wed,  8 Feb 2023 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675858005;
        bh=6sb43CTJMs35Ia7rJ1LCIwaaOvhNS0NqU4vISF25NJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ek6elGADG4qhqB3KFj6/+rVK7X4H+oB3ILzZ21eQMyndkNQyh0id+IzUez4PftmF5
         vsUVXg4DXJrgc6Al9cfdtTkj+JrMZlTzg0M/Er4eBNxqL5gIErmu2oFEmwQ1WoUTDm
         3tMVicrG92fAUlDYOlfRM0i1Zf5kGz4lp6wohsaA=
Date:   Wed, 8 Feb 2023 13:06:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
Message-ID: <Y+OQUpZFdplQUcdJ@kroah.com>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
 <20221104131031.850850-2-s.hauer@pengutronix.de>
 <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:32:51PM +0000, Paul Cercueil wrote:
> Hi Sascha, Greg,
> 
> I have a breakage in 6.2-rc* that I eventually bisected to this commit,
> on a Ingenic SoC (using the jz4740 musb driver) with ECM or RNDIS
> configured through gadgetfs.
> 
> When plugging the board to my PC, the USB network interface is
> recognized, but 'ip link' sees it as 'NO-CARRIER'. With this commit
> reverted on v6.2-rc5, everything works fine.

Ick, that's not good.  Can you send a revert for this?  Sascha, any
ideas?

thanks,

greg k-h
