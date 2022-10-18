Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167F603146
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJRRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJRRAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:00:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC15EE08E;
        Tue, 18 Oct 2022 10:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCE5AB8206C;
        Tue, 18 Oct 2022 17:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05476C433D6;
        Tue, 18 Oct 2022 17:00:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mMmvBy6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666112428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJEhn0FZkEy7ERnPpVq7NsjGDJYzLySY4oAdXCAtR50=;
        b=mMmvBy6aOM3ohEAqbCtrEzALiyfnFJ6zLAHHR0NVI70ZJo/D128xFErDzTpnWf1LGeX3AE
        GkbPdxxhncABwiEDTNRiwtekavdFuDuSevB5xfPdrH0gtJN5VHpn0cOPxqenNI8I7R5XvK
        JhYKKEbnCl0H6Zx1zL/EQ9GvkCOhC8U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6113814d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 18 Oct 2022 17:00:28 +0000 (UTC)
Date:   Tue, 18 Oct 2022 11:00:26 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] siphash: Convert selftest to KUnit
Message-ID: <Y07bqnZVrA9FO03z@zx2c4.com>
References: <20221018100510.never.479-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018100510.never.479-kees@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:05:46AM -0700, Kees Cook wrote:
> Convert the siphash self-test to KUnit so it will be included in "all
> KUnit tests" coverage, and can be run individually still:
> 
> $ ./tools/testing/kunit/kunit.py run siphash
> ...
> [02:58:45] Starting KUnit Kernel (1/1)...
> [02:58:45] ============================================================
> [02:58:45] =================== siphash (1 subtest) ====================
> [02:58:45] [PASSED] siphash_test
> [02:58:45] ===================== [PASSED] siphash =====================
> [02:58:45] ============================================================
> [02:58:45] Testing complete. Ran 1 tests: passed: 1
> [02:58:45] Elapsed time: 21.421s total, 4.306s configuring, 16.947s building, 0.148s running
> 
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I'll queue this up. Thanks for the conversion. Appears to work well.

Jason
