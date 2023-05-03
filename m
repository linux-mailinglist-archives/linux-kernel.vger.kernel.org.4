Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE976F5F77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjECT4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894CB7DA0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC2060DBD
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40230C433D2;
        Wed,  3 May 2023 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683143765;
        bh=inXYG25XNMxCThfqdns/inVWUVeH622IrEawgu1mqtU=;
        h=Date:From:To:Subject:From;
        b=evnu2ZYiJtnIgpBfj6NG9CPF1dRdsWCXB2Ddsz4zQ+HJcH6ibqW80/nOmO2DLc4h1
         +RkV5edJxfZiYw9Uvc+kRECVxLVY4jeu/FEtF8+rFDbMOhXTPgQtlssoqTsLToH/+9
         hbZYqmJUsIAC+1E1etNt6u0M/TqE8mqDHhOm889B6VrdcSjV0R+kkjyGBaU9ieyBru
         GoRZ9gFlqMaltumg8NOpCywfU4Ddw9RUywvN/gk0vRJ5poB296BJL3Y+obWNJgCe9/
         pRdIJuuDuLniyotB9QpuhDDNzq7co/g8+J2DniZ/E8/oi7x+LJ8cRUTBbYqwa8+Bpo
         XET/QBVudkYcA==
Date:   Wed, 3 May 2023 12:56:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 16.0.3 uploaded
Message-ID: <20230503195603.GA262195@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 16.0.3 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

As with 16.0.2, this release includes a fix relevant to the Linux
kernel, which you can read about here (thanks to Ard Biesheuvel for
helping debug and Nick Desaulniers for the fix):

https://github.com/llvm/llvm-project/commit/012ea747ed0275c499f69c82ac0f635f4c76f746
https://github.com/ClangBuiltLinux/linux/issues/1837

This issue is not super widespread but as always, I recommend using the
latest stable release of a piece of software whenever possible, so
consider using 16.0.3 in lieu of older 16.x releases. However, I
have shuffled the tarballs to a subdirectory to allow older versions of
these toolchains to be downloaded with more ease, which can be helpful
for tracking down regressions in warnings or code generation:

https://mirrors.edge.kernel.org/pub/tools/llvm/files/

Cheers,
Nathan
