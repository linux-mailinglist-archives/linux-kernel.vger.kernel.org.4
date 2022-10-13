Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B95FD1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJMA4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiJMA41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BCDFAA7F;
        Wed, 12 Oct 2022 17:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E07FB616C2;
        Thu, 13 Oct 2022 00:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D289C433D7;
        Thu, 13 Oct 2022 00:42:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c+qkRwcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665621760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7iZS76qLB4/W9rx4TIV+v+RwhBtEPQjc2lWus9dwRc=;
        b=c+qkRwcvbWT+fd/TLlyAsH4ndXksGM7Hc9/K1Gdk7r/LEkx5ZdIWKUWHXqRBW0BRNN5sq9
        Np4NQ9+yabCSrYIojm18Yy+2L0pNJdUrEr8KIf+c3nNFa3r3aSKaHIz7wfp6xAq+XSjQkv
        ehnt1OpIhGTKi0gWB7A0xw9Z4MkjzIo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e99f50a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 00:42:40 +0000 (UTC)
Date:   Wed, 12 Oct 2022 18:42:34 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/19] crypto: x86 - standardize not loaded prints
Message-ID: <Y0de+gl0irG+eNpT@zx2c4.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-19-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-19-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:30PM -0500, Robert Elliott wrote:
> Standardize the prints that additional required CPU features are not
> present along with the main CPU features (e.g., OSXSAVE is not
> present along with AVX).
> 
> Although modules are not supposed to print unless loaded and
> active, these are existing exceptions.

Another comma splice. But also, don't do this. No need to clutter dmesg.
`lsmod` is the job for this.

Jason
