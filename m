Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704D7682BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjAaL4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAaL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:56:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0964C0FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75A72CE1D90
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544E2C4339B;
        Tue, 31 Jan 2023 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675166195;
        bh=SUjjKNVGYoJNzkFK4HEiUT1I/gZ4NrVEFa/GbUInxYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJneS1uY5kHtj58oD03uXdztgNr9TdQK/sSPIu5yUJozGe6DOHZWLpDr3OPpWRj2L
         LTUKyufVQ8nU65FiXhPmi0dWlGGpm6uYeRvrDu70624MSpoI8m0DV0kZw/LIKzfAMk
         7r3cobA0LM+4Dr8JrR5/oOR8qIp94txrLeZEpyIw=
Date:   Tue, 31 Jan 2023 12:56:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ioana.ciornei@nxp.com
Subject: Re: [PATCH] bus: fsl-mc: don't assume child devices are all fsl-mc
 devices
Message-ID: <Y9kB8F3Nls8d1Koi@kroah.com>
References: <20230127131636.20889-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127131636.20889-1-laurentiu.tudor@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:16:36PM +0200, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Changes in VFIO caused a pseudo-device to be created as child of
> fsl-mc devices causing a crash [1] when trying to bind a fsl-mc
> device to VFIO. Fix this by checking the device type when enumerating
> fsl-mc child devices.

What changes?  What commit id does this fix?  Does it need to be
backported?

And what type of "pseudo device" is being created?  Why would it be
passed to this driver if it's the wrong type?

this feels wrong...

thanks,

greg k-h
