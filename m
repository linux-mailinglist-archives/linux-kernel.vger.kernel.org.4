Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B667704B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjAVPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjAVPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:43:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0E193DC;
        Sun, 22 Jan 2023 07:43:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 526ACB80B1A;
        Sun, 22 Jan 2023 15:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B805C4339C;
        Sun, 22 Jan 2023 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674402205;
        bh=8WzsFHHDpbnI6rQkXADCSUncCmvgumceV3IDytmWJCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXvzMb3mslhLcKdf5oMTWRS3+nyGpthX+0EKTOQ6TIwDp84jiLfWAEH7p1en38Hd+
         Hqyvoo8Dvrci5pgp/WiE0vu/2eW5uPgjx53eAWLaJhKAIeZgOs94iXoXjYH6z/eiSc
         K/TZ+fByvwSsiWO1G6DmXWylmzxPtKNxiZy2oWek=
Date:   Sun, 22 Jan 2023 16:43:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as UVC Gadget Maintainer
Message-ID: <Y81ZmhguW3F0eGOv@kroah.com>
References: <20221206113841.1359976-1-dan.scally@ideasonboard.com>
 <Y4+SxVzTywR3qHdg@pendragon.ideasonboard.com>
 <Y81RdyDX6SHGYc3W@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y81RdyDX6SHGYc3W@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 05:08:39PM +0200, Laurent Pinchart wrote:
> Hi Dan,
> 
> I've just noticed that neither linux-usb nor Greg were CC'ed on this.
> 
> Greg, could you pick this patch up ([1]) for v6.3, or should Dan resend
> it with the right CC list ?
> 
> [1] https://lore.kernel.org/all/20221206113841.1359976-1-dan.scally@ideasonboard.com/

Please resend it with the correct list :)

thanks,

greg k-h
