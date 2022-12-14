Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B264C4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiLNITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiLNIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:17:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92146260;
        Wed, 14 Dec 2022 00:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553CB61827;
        Wed, 14 Dec 2022 08:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E43C433EF;
        Wed, 14 Dec 2022 08:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671005860;
        bh=DyrR5uLniJcakq3aaNlWKhBtxbX1YlTMfuwTnQSG3zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrM2LC4N991DeCVFs2GSqHRss7lU/+GeVTAoimbt5MlPs+mf1lw5FBqycpmWd2GRM
         amc12NZawQeqn5jNX1neRyjWnYX+kvWD7m7QK/odv0g06P3iq0np6J225t5REanYSO
         gNpmwFJl7x5QaPGVg/YaaDoL2m3Qluds3eOLNbr4=
Date:   Wed, 14 Dec 2022 09:17:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     mka@chromium.org, dianders@chromium.org, albertccwang@google.com,
        raychi@google.com, howardyen@google.com, leejj@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] add vendor hooks for usb suspend and resume
Message-ID: <Y5mGoXdEIvLqHYnh@kroah.com>
References: <20221214070650.703793-1-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214070650.703793-1-pumahsu@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:06:48PM +0800, Puma Hsu wrote:
> In mobile, a co-processor can be used for USB audio. When the co-processor
> is working for USB audio, the co-processor is the user/owner of the USB
> driver, and the ACPU is able to sleep in such condition to improve power
> consumption. In order to support this, we need to create vendor hooks in
> suspend and resume functions, and also upload our implementations for
> reference.
> 
> Puma Hsu (2):
>   usb: core: add vendor hook for usb suspend and resume
>   usb: core: add implementations for usb suspend/resume hooks
> 
>  drivers/usb/core/Makefile              |  2 +-
>  drivers/usb/core/driver.c              | 36 +++++++++++++
>  drivers/usb/core/usb-hooks-impl-goog.c | 72 ++++++++++++++++++++++++++
>  drivers/usb/core/usb.h                 |  5 ++
>  4 files changed, 114 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/core/usb-hooks-impl-goog.c
> 
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog
> 

What differs from the previous submissions of this patch series that
were rejected?  Were the changes that were asked for from those
submissions resolved properly here?

Dropping patches on us every 6 months that were previously rejected with
no description of what changed is a sure way to get them rejected again
:(

thanks,

greg k-h
