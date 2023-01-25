Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3B67B7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbjAYRHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjAYRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231145AB55;
        Wed, 25 Jan 2023 09:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1B1AB81B47;
        Wed, 25 Jan 2023 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CB5C433D2;
        Wed, 25 Jan 2023 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674666390;
        bh=a8yDym9PtaFsR6d2QkMhsN6o22KNSgm1+t3YLfXmmgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZYCLIr0Mf3j/LjiwrBWDd1Y+dp2pOXKyQMikX8wmvl/FSQq4XZmBsGmFu9PEzTmt
         TP3Bm/jDyxUE6wmoZWvCsqPbCCtIe8kelZ+njFxTPsAk/EJ9GBJ3/JIEIbuH6ZZ1uP
         DNMHPZC0WMHfAR3174FtbCHT/HGmWeuzn+tgqETg=
Date:   Wed, 25 Jan 2023 18:06:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5] usb: gadget:  add WebUSB landing page support
Message-ID: <Y9Fhk2A6/1XJgJ/0@kroah.com>
References: <Y86cy1AM4w5ju5A4@kroah.com>
 <Y9Ff3Np86AUK4b1k@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9Ff3Np86AUK4b1k@jo-einhundert>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 05:59:08PM +0100, Jó Ágila Bitsch wrote:
> There is a custom (non-USB IF) extension to the USB standard:
> 
> https://wicg.github.io/webusb/
> 
> This specification is published under the W3C Community Contributor
> Agreement, which in particular allows to implement the specification
> without any royalties.

<snip>

No, I can't revert the existing patch and then add this one, just send a
set of follow-on patches that fix up the needed things and I can apply
that as I can not rebase my public tree.

thanks,

greg k-h
