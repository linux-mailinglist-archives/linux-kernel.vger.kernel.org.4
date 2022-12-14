Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4F64C4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiLNIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbiLNIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:20:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B979E0B2;
        Wed, 14 Dec 2022 00:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C45D5CE17F3;
        Wed, 14 Dec 2022 08:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866F6C433EF;
        Wed, 14 Dec 2022 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671006023;
        bh=oni1IZ4JM4S5eVTK11CpVi1ygUZSu5z3E+XCAYdaQwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+S3zNFLBhOqJRqkaWA63xQMQKGrrzcqURDUVc7P4zJkrLqXRkJm0XawOXiWzeji+
         gmX4OqXYB72Kh1TYDzq2wNkxSmozqQB1MuTXcmQlUcuNMGUjKPzQTRwgR10f19ORJb
         1nlW4SR7vh4lvzd1lh3KC9/muHyvQXQwgnnCGLr4=
Date:   Wed, 14 Dec 2022 09:20:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     mka@chromium.org, dianders@chromium.org, albertccwang@google.com,
        raychi@google.com, howardyen@google.com, leejj@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: core: add vendor hook for usb suspend and resume
Message-ID: <Y5mHRC8E9nZMtVSV@kroah.com>
References: <20221214070650.703793-1-pumahsu@google.com>
 <20221214070650.703793-2-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214070650.703793-2-pumahsu@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:06:49PM +0800, Puma Hsu wrote:
> Add the hooks that vendor can design and bypass the suspend/resume.

As Christoph said, there is no such thing in the kernel as a "vendor
hook".  That is a Google-only thing that was created for their Android
kernel for various reasons.

For obvious reaons, we can not take the same type of thing here, as that
makes no sense at all (and neither do you want us to.)

As explained each time this patch set has been sent in over the years,
the full implementation of a new callback must be submitted with the
patch series, otherwise it HAS to be rejected.  And again, you want this
rule in place, otherwise you would not even be able to use Linux for
your systems.

thanks,

greg k-h
