Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150BB65FE27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjAFJkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjAFJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:39:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8D17E39;
        Fri,  6 Jan 2023 01:31:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7F32B81CD3;
        Fri,  6 Jan 2023 09:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962C8C433EF;
        Fri,  6 Jan 2023 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672997497;
        bh=pmOPBYsdoU8C8Cg+g0Xq7F5/UqxY1GcvcUbUlcGlLiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6V2x0opcz4TnvcqLj+8o8pPeb/p/4cmDEvxcTiXZ9oc4w41dHphO6NHo7Q53wNns
         yAxTywhwG48rwFgK69xaxcNv8O7eLIY6qAhpNGBKQcMdmJ3LoAlpbomtGZx9Z8UneJ
         llaeknjvrZQVuyVE7oYgN6h/hqHWd2SIkO7J9sfDWCwuIVrToKBso+2ZO3KGfdL3+H
         6DdSYh3QtDYjde/0ys8a5xfFj15a/i8Zn6u1CItfSPi3WuSHEVwcmSWYOBzlRLGGtE
         bs1yxbAh3c2BA00xQZmezackjAjFz05IaW1lITPLHWcDxPBOcKvDtHufNjwEObpCJ7
         Fz9KO8Eg/d5/g==
Date:   Fri, 6 Jan 2023 09:31:33 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the backlight tree
Message-ID: <Y7fqdX8FPEZW32sM@google.com>
References: <20230106113509.5c101b53@canb.auug.org.au>
 <Y7fo+tMnkSndJNXV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7fo+tMnkSndJNXV@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2023, Lee Jones wrote:

> On Fri, 06 Jan 2023, Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > The following commits are also in the backlight-fixes tree as different
> > commits (but the same patches):
> > 
> >   44bbdb7e3a67 ("backlight: ktd253: Switch to use dev_err_probe() helper")
> >   c0e09423bbb4 ("dt-bindings: backlight: qcom-wled: Add PMI8950 compatible")
> >   73516cbcf8d9 ("backlight: pwm_bl: Drop support for legacy PWM probing")
> > 
> > Forgot to push out an updated backlight-fixes tree?

What's the branch name that you're tracking?

> Don't think so?
> 
> 88603b6dc4194 (HEAD -> refs/heads/backlight-fixes, tag: \
>   refs/tags/v6.2-rc2, 					\
>   refs/remotes/mfd/mfd-fixes, 				\
>   refs/remotes/leds/for-leds-next, 			\
>   refs/remotes/backlight/backlight-fixes, 		\

Ah, wait!  This is the old naming scheme.

I assume, despite the message above, you're tracking
'for-backlight-fixes', right?

>   refs/heads/mfd-fixes, 				\
>   refs/heads/for-leds-next) 				\
>     Linux 6.2-rc2

-- 
Lee Jones [李琼斯]
