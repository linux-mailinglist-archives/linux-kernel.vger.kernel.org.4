Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532D764C548
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiLNItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiLNItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:49:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBF319014;
        Wed, 14 Dec 2022 00:49:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CB81B81103;
        Wed, 14 Dec 2022 08:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A1C433D2;
        Wed, 14 Dec 2022 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671007739;
        bh=QSGvunYcJRNVyeLLqbAWJmdEG4zavxjUnpwOdm3ncP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0H3gnYRxDaESjD8B7CSzc17LY3CLOnpwoT3yn9Q9hfz6SBPucXG9MTWOuJZBEhgx1
         WMfwkbRFYcyIKRWoECvvq0VAkCm/Q8I7Ynj7eoa0d0lUbRmWYXwNVIj4NbkhnvKxYd
         FbRf0ebQiRQjfazSoAcYG+IWvSc3/kHJ50492SQ4=
Date:   Wed, 14 Dec 2022 09:48:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     mka@chromium.org, dianders@chromium.org, albertccwang@google.com,
        raychi@google.com, howardyen@google.com, leejj@google.com,
        hch@infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] add hooks for usb suspend and resume
Message-ID: <Y5mN+MLD/8oBU1Ay@kroah.com>
References: <20221214081456.714859-1-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214081456.714859-1-pumahsu@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 04:14:54PM +0800, Puma Hsu wrote:
> In mobile, a co-processor can be used for USB audio. When the co-processor
> is working for USB audio, the co-processor is the user/owner of the USB
> driver, and the ACPU is able to sleep in such condition to improve power
> consumption. In order to support this, we need to create hooks in suspend
> and resume functions. We also upload our implementations for reviewing.
> 
> Puma Hsu (2):
>   usb: core: add hooks for usb suspend and resume
>   usb: core: add implementations for usb suspend/resume hooks
> 
>  drivers/usb/core/driver.c              | 36 +++++++++++++
>  drivers/usb/core/usb-hooks-impl-goog.c | 72 ++++++++++++++++++++++++++
>  drivers/usb/core/usb.h                 |  5 ++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/usb/core/usb-hooks-impl-goog.c
> 
> ---
> Changes in v2:
> - Remove the wrong input in the Makefile
> - Change description in commit message
> 
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog
> 

My review comments on v1 still pertain here.
