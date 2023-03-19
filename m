Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABDE6C06AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 00:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCSX4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 19:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCSX43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 19:56:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55731CBDA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC59BCE0FF7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB87C4339C;
        Sun, 19 Mar 2023 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679270181;
        bh=BWdGCWEp2yVl8tNAZDFTX192dcSZglyJrUGCKfp8zK8=;
        h=Date:From:To:Subject:From;
        b=rfs6Du/aMqUksUzpTcx5DAfEM5doC+x+ofKA9a5oe3FV4Sypo3z+LKQhjgSmYWm0Y
         UA6Ic72XLXznyAXZ5IhdIVzyMCe7q8pHB6aEm+rRh8HuNhOFoVWav2ZNw5mpyA3Brb
         NC+Zd8f4DX+vNvGfGdWkZ0NJGlMfpslm885Jby4j+FUssFUD9MmlE2pjy4O/SMtNCf
         +sQDjI+2BPTjoohL0kLlHQOQjz3/oHOfxUzfAeQlPND7wIWj1dz1C8rupreyImbosZ
         IejrtKCxZ49byqMqs0s/U0dUSHnYvi1GHSzKDQmzKM2YM+YoAbpdVnb8z9PGT7U/TT
         8T3+Ar79eD1aw==
Date:   Sun, 19 Mar 2023 16:56:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Slim and optimized LLVM toolchains for building the Linux kernel
Message-ID: <20230319235619.GA18547@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

To make building the Linux kernel with clang/LLVM easier and more
accessible to people (since distributions tend to only package one
version at a time and it may be old or have bugs that have since been
fixed), I have uploaded some slim, profile guided optimized LLVM toolchains
to my section of kernel.org/pub:

https://mirrors.edge.kernel.org/pub/linux/kernel/people/nathan/llvm/

The landing page should have all the relevant information but if I need
to clarify or expand on anything, I am more than happy to do so.

Due to benchmarking the compilers against the kernel during PGO, they
can handily beat distribution versions that have not been optimized:

https://gist.github.com/nathanchance/8d1abed70077ac92cb198ef32389072e

I aim to keep these up to date with the latest stable versions of LLVM
as they are released (so 16.0.0 will be replaced with 16.0.1 when it is
released, etc).

Cheers,
Nathan
