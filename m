Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7998627867
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiKNJBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiKNJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:01:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887439C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B7460F43
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACFFC433D6;
        Mon, 14 Nov 2022 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668416489;
        bh=96Xf4fFzAMINvQ7fegCe4HJSNs8KVrmSIakllOcZjjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQgVi7j1f7hplu4VTm6TgfjS8XRNvo333FA9CuIv5u/Q1OrswH5+SXMqfHkoUhjOF
         Jos1yvBrpvNxoquZA02ndkgFs0X0oaSG49OY+96FQ+luTuSXoE4pJaSFcj0jTNIqQn
         h+42/dV0dmigyv225LZl3Kas3D/8tU+5NmNk1v59pjCMYGWBPzIV9nxai3U1ocJgG3
         BQAr0J1EMnKfZsm3rv7kviVt4Ks6f6ZUtPUPKZIauTUX9b4a+jayOy8drEfBmBWnnk
         EmD33qyC+33S4v+T9E08UMOm0FixPv/6XXo4tNOgM6a1t+EHfx63FYQSpmPZAICBhD
         z+E8lk26LQNLQ==
Date:   Mon, 14 Nov 2022 09:01:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [patch 01/10] mfd: timberdale: Remove linux/msi.h include
Message-ID: <Y3ID5NSuk7/BhcED@google.com>
References: <20221113201935.776707081@linutronix.de>
 <20221113202428.312137892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221113202428.312137892@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2022, Thomas Gleixner wrote:

> Nothing in this file needs anything from linux/msi.h
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/timberdale.c |    1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
