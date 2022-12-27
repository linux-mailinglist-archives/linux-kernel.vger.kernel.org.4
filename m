Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7096567D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiL0H0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiL0H0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:26:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B392C2F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:26:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D40D60F90
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30EEC433D2;
        Tue, 27 Dec 2022 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672125968;
        bh=AOJFSwK9Q17i4sr9UnfKIJSKmUMHPVexbzEarKXsvMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/w5mhDcdIAH77uRl7RtHJKT+KjtNTdjhnUihc/mLaWbli7qk50UKHyjDcGPkl/iE
         jkES39zqQrfk5fmGg08eZNzMl3chLLOrqunLoGm/0ty6H6bgQCwUOQVb5BCAjMT0xg
         WYIeApbGSoj+LGX9tNEuGqOMJdQkq3IaF4h0MZZo=
Date:   Tue, 27 Dec 2022 08:26:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     airlied@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] habanalabs/uapi: move uapi file to drm
Message-ID: <Y6qeDQY+X6ZRn3bi@kroah.com>
References: <20221226213227.26953-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226213227.26953-1-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 11:32:26PM +0200, Oded Gabbay wrote:
> Move the habanalabs.h uapi file from include/uapi/misc to
> include/uapi/drm, and rename it to habanalabs_accel.h.
> 
> This is required before moving the actual driver to the accel
> subsystem.

What requires this?  Isn't this going to break userspace code?

thanks,

greg k-h
