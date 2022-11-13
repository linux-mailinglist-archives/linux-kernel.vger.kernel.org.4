Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA92627003
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiKMOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 09:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKMOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 09:11:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE72BE17;
        Sun, 13 Nov 2022 06:11:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63270B80C73;
        Sun, 13 Nov 2022 14:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297D4C433D6;
        Sun, 13 Nov 2022 14:11:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bcqpeBQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668348702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1J62+ynSE9Alcf2NcxpAWpkNh4uJLuCMy3vCWo2LFjc=;
        b=bcqpeBQwrQH1iSV9ZsrfqS/OWmG8xIh+1lu530xEfvg2szj+mcYMK1rr7Ahd57pktcvxVc
        tDkBy01pGyqUIdTz29opxVHJpJTVhvXGVYNT61R8OAYARc41Iqw2ZvYAvTyUG6xm6uC2my
        qBzdTlAcQXBbpTTJfBWBAv9QXdgMWRI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 032cc457 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 13 Nov 2022 14:11:41 +0000 (UTC)
Date:   Sun, 13 Nov 2022 15:11:38 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hw_random: use add_hwgenerator_randomness() for early
 entropy
Message-ID: <Y3D64rIXFfRoSCne@zx2c4.com>
References: <20221106150243.150437-1-Jason@zx2c4.com>
 <202211132159.cd70b1c0-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202211132159.cd70b1c0-oliver.sang@intel.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 09:48:46PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed WARNING:at_kernel/kthread.c:#kthread_should_stop due to commit (built with gcc-11):
> 
> commit: cea83a6b31856293ceab2c6ebab7843322fe105e ("[PATCH v3] hw_random: use add_hwgenerator_randomness() for early entropy")
> url: https://github.com/intel-lab-lkp/linux/commits/UPDATE-20221106-230344/Jason-A-Donenfeld/hw_random-use-add_hwgenerator_randomness-for-early-entropy/20221106-044656
> base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/char-misc.git 30a0b95b1335e12efef89dd78518ed3e4a71a763
> patch subject: [PATCH v3] hw_random: use add_hwgenerator_randomness() for early entropy

A bit late. v4 was posted a while ago now.
