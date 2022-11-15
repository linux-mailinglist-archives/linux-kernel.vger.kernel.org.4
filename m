Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B325F6295EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbiKOKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiKOKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:33:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476AB9F;
        Tue, 15 Nov 2022 02:33:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83E8C615E3;
        Tue, 15 Nov 2022 10:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8EBC433D6;
        Tue, 15 Nov 2022 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668508429;
        bh=z3C8Lxh7Zezo4ONT2Be5LDhSXxJnc6YhGNw4jZ5CYsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBpCiJtD2YAlFsMAH5kg6YzNA1T/FIdMOxxLQ/Xplnjxu6wksKtC4g6zME8rGRACj
         5/nrppyNNdMC9widv5MVSRMaeIDu5hmIjAZwJ6KY0KrfmjX50nMM8AIuTRCRiS5bx2
         2DVzqQ7oyiGC8kLZGC6kRO78tUD2K7Wt/l54BS/U=
Date:   Tue, 15 Nov 2022 11:33:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ye.xingchen@zte.com.cn
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn
Subject: Re: [PATCH] usb: ehci-orion: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <Y3NrBvIV7lH2GrWz@kroah.com>
References: <202211111433143392243@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211111433143392243@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:33:14PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

You did not follow the rules when using a tool to find and fix problems,
please read the documentation for how to do so correctly.

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Your email is showing up as being invalid, and spoofed, please work with
your domain to properly handle verified email otherwise it will not be
able to be accepted.

thanks,

greg k-h
