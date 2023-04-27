Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D76F09DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbjD0Q3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbjD0Q3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91683187
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C29863E39
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2274C433D2;
        Thu, 27 Apr 2023 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682612942;
        bh=XZF7rkD3tBrnTswpeGqOedBAaX6ToccLovjvqP70ot0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mISsIuFBpTVzipEGqfPSEtNuTHu3utEq/eKwuZ/HVOLN9x2AkYfrLbgBMcINYFIM5
         UwOkhrZ1fQrR+q0l94+UsaWG7Z0VbgKULtTwhtuGLxnj6AhzfV7PayLkazza/8dP5/
         uxrDPVhDwQwDVVOBDfjc2VV69C7fdhIlP4rJ9MbXApyarHWh2BE1Jr57TTlyXGzFR8
         HvzsdqX3abwwiRsc9mjiQw3bhvw/BAs88we/CH8fOBU4wJ6c8HAUB40LS7eCLWkZzY
         tSS/qxZctwFri5PTgWD255J23+XKLj8G1wUxCRXPdapy3e+Y2rmb+wjSNseypBlCTs
         26iT6+8J1yujg==
Date:   Thu, 27 Apr 2023 17:28:58 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: wm831x: Use maple tree register cache
Message-ID: <20230427162858.GA620451@google.com>
References: <20230419-mfd-wm831x-maple-v1-1-e03e39d7bb0b@kernel.org>
 <20230427151134.GW50521@google.com>
 <d01e8784-5fb8-41e5-bbdd-8983f559c4f0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d01e8784-5fb8-41e5-bbdd-8983f559c4f0@sirena.org.uk>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023, Mark Brown wrote:

> On Thu, Apr 27, 2023 at 04:11:34PM +0100, Lee Jones wrote:
> > On Tue, 25 Apr 2023, Mark Brown wrote:
> > 
> > > regmap has introduced a maple tree based register cache which makes use of
> > > this more advanced data structure which has been added to the kernel
> > > recently. Maple trees are much flatter than rbtrees, meaning that they do
> 
> > Applied, thanks
> 
> Note that the maple tree support for regmap has only landed in Linus'
> tree during the current merge window, I wasn't anticipating this being
> applied until -rc1 due to it being sent after the merge window opened.

It's been applied to for-mfd-next-next which will become for-mfd-next
*after* the merge-window closes.  IOW, it's due for v6.5.

-- 
Lee Jones [李琼斯]
