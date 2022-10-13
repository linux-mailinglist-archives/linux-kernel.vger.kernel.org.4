Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322505FD1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiJMA5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiJMA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:56:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F11912EA50;
        Wed, 12 Oct 2022 17:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBF29B819F4;
        Thu, 13 Oct 2022 00:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC800C433C1;
        Thu, 13 Oct 2022 00:40:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AxF3Tq6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665621628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Asm9MBLS+botogQZ/FFMhMOW1mrjXnJOZtQKrw9zO24=;
        b=AxF3Tq6KVwQJv1chN52W8VMHdA5numR81A1Ot5phsYxCaz/kHF8Lg/vhfMcIi0iEl0DFXJ
        YMK5p6T+sDVrAtGt/ctS/IobY2QRpJlXIgBTAwWtN36gYBivREmiuEmDkEjJUb+3HfnwIy
        H+XMbl4ND2dqx/T235yKo1xKFPuLtMg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8b2d37e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 00:40:28 +0000 (UTC)
Date:   Wed, 12 Oct 2022 18:40:24 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/19] crypto: x86 - print CPU optimized loaded
 messages
Message-ID: <Y0deeOOtipkIHAGo@zx2c4.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-17-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-17-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:28PM -0500, Robert Elliott wrote:
> Print a positive message at the info level if the CPU-optimized module
> is loaded, for all modules except the sha modules.

Why!? This is just meaningless clutter. If the admin wants to see what
modules are loaded, he uses `lsmod`.

Also, what's special about sha?

Anyway, please don't do this.

Jason
