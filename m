Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF06551B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiLWO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:56:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE691A047;
        Fri, 23 Dec 2022 06:56:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1B8EB820DE;
        Fri, 23 Dec 2022 14:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47336C433EF;
        Fri, 23 Dec 2022 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671807407;
        bh=qHfY0XUQ6jGaf6+6ji3OiIeEWQW3wFYAbnvzIIxCzLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HErUaAY8L4JH3P6jccurgovJDesb9mt8pfOXtH/cbEflD2tusdQOU5+lz0Lsy3xAX
         pkrlDj1C8rY7SsE1hS1OgZ0J/NE0c26Yl/PEtmN/WhVKZYFkm1MTQMFIiN4AueKgc0
         gjF+bUGPDI1roIe6QCiscdwOVzU2mxWFKj/YeI4I=
Date:   Fri, 23 Dec 2022 15:56:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Pavel Hofman <pavel.hofman@ivitera.com>,
        Joe Perches <joe@perches.com>, Julian Scheel <julian@jusst.de>,
        Colin Ian King <colin.i.king@gmail.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: usb: gadget: f_uac2: Fix incorrect increment of bNumEndpoints
Message-ID: <Y6XBrF1vLclcJm3w@kroah.com>
References: <1669193290-24263-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669193290-24263-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 02:18:10PM +0530, Prashanth K wrote:
> Currently connect/disconnect of USB cable calls afunc_bind and
> eventually increments the bNumEndpoints. And performing multiple
> plugin/plugout will incorrectly increment bNumEndpoints on the
> next plug-in leading to invalid configuration of descriptor and
> hence enumeration failure.
> 
> Fix this by resetting the value of bNumEndpoints to 1 on every
> afunc_bind call.
> 
> Signed-off-by: Pratham Pratap <quic_ppratap@quicinc.com>
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>

Who authored this, Pratham or you?

And why no "[PATCH]" in the subject line?

What commit id does this fix?

thanks,

greg k-h
