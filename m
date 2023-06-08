Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B6728061
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjFHMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjFHMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FFE198C;
        Thu,  8 Jun 2023 05:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 060156189A;
        Thu,  8 Jun 2023 12:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3BDC433EF;
        Thu,  8 Jun 2023 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686228461;
        bh=gErihSfNJN9neIvqIaF2kUO0JNhwiIF/H2BlcHXmEW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4KuxEX1m+b0j8MnDpsbYkU2mRDx71qQNZIlxN+SwRb5imZmdLgwqNCixb4O39FBM
         eC9pblP/Zx+tdICJyWEwicLrBG9xPCkFMwyEOlfI5GFk0es7CrVSBF210um+ZZSxVk
         8C5smU7Olfiru0SoY+2BVjJuxvCDTq/K5KCgeYPFn457/lrHlSPir7rAcfIobNJpgP
         2ivzWd5kCgG5w8uq55Ai/X5c0Bu2BMvREW53yfU+SIRboksar9N/+Q0vOOQ4L8xD7Z
         RBZbap1rhE53O7+yS7QeHNvnoaI8mVaGP5Paub0sENFcWxqZUP09uiMhRoFM0t5lLL
         PcCJqoP5FeYmw==
Date:   Thu, 8 Jun 2023 13:47:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] LEDs fixes for 6.4-rc5
Message-ID: <20230608124736.GJ1930705@google.com>
References: <ZHte5sPkB6-D-94G@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHte5sPkB6-D-94G@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Jun 2023, Johan Hovold wrote:

> Hi Linus,
> 
> Here's a fix for a regression in 6.4-rc1 which broke the backlight on
> machines such as the Lenovo ThinkPad X13s.
> 
> The patch has been acked by one of the maintainers who suggested someone else
> should send it to you:
> 
> 	https://lore.kernel.org/lkml/20230602091928.GR449117@google.com/
> 
> Please pull.
> 
> Johan

Thanks Johan.

-- 
Lee Jones [李琼斯]
