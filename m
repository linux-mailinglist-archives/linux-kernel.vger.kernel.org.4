Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C09633C11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiKVMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKVMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:08:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3069F2A71D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:08:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DD70B81A09
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E080C433D6;
        Tue, 22 Nov 2022 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669118914;
        bh=i1/B8KPOq23+jpieWztQH/1k9du0dfBH3YUJ5icWXhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5pt4jZNb0tafaiF3Oqmnp2OXIsR9giOzMApVEjLuUsPGiNAWtye6goFu2yhJr79V
         5PNO2nrbA8KuUnfmXOVWEvT3bG8QucY2Fx3Tsq5aSewEVF2uaxYTAAa9Si0VYkmN7S
         uNZ9TOSry6g2zVi0RPJUIEDzodSy0YblvpYmleLE=
Date:   Tue, 22 Nov 2022 13:08:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: call set_lan_gain for receiver config
Message-ID: <Y3y7v1WAumU1o5na@kroah.com>
References: <Y3kONX7KhQ1GX9QW@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3kONX7KhQ1GX9QW@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 10:41:17PM +0530, Deepak R Varma wrote:
> Value for the LNA gain is captured from the user as part of the struct
> pi433_rx_cfg, however, the corresponding function rf69_set_lna_gain() is
> never called to set it. Include a call to this function as part of
> setting up the rx configurations.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 3 +++
>  1 file changed, 3 insertions(+)

How was this change tested?

thanks,

greg k-h
