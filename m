Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BCB6EDB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjDYFMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02C83CB;
        Mon, 24 Apr 2023 22:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39054614B0;
        Tue, 25 Apr 2023 05:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1FCC433D2;
        Tue, 25 Apr 2023 05:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682399538;
        bh=e+5pBIG9ZCreZChuRW8NpnnKMK4kVj6h0Q9BwcdUO6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLW4ihj6ONnqmEf7FmSz7jDLFiF3np1+qR6BGToOM5/9mE0b2B85MBTx80vXpYKRw
         o4Yaw1Da5mqG9LeSezMbpciLcto7LZ7bI1mRwbJM8rf94Nv6SyiZAH6Vol2px2T5xr
         TGb2IxthourIesKCWc4YxgqU2mK/F0fLhiJzUSVQ=
Date:   Tue, 25 Apr 2023 07:12:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liang Yuhang <lihuya@hust.edu.cn>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] usb: dwc3: remove dead code in dwc3_otg_get_irq
Message-ID: <ZEdhLyEw_x49zZKp@kroah.com>
References: <20230425015532.13622-1-lihuya@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425015532.13622-1-lihuya@hust.edu.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 09:55:32AM +0800, Liang Yuhang wrote:
> platform_get_irq() only return non-zero irq number on success, or
> negative error number on failure.
> 
> There is no need to check the return value of platform_get_irq()
> to determine the return value of dwc3_otg_get_irq(), removing
> them to solve this problem.
> 
> Signed-off-by: Liang Yuhang <lihuya@hust.edu.cn>
> 
> ---
> v1 -> v2: change name to real name
> ---
>  drivers/usb/dwc3/drd.c | 5 -----
>  1 file changed, 5 deletions(-)

Why is this a RESEND?  And why is it resent?  You changed something from
v1 to v2, but that does not mean it is a resend.

Note, I STRONGLY encourage people to get experience by working in
drivers/staging/ first, before going out to the rest of the kernel and
dealing with fast-moving subsystems.  Perhaps try that first?

thanks,

greg k-h
