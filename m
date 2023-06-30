Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A669743FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjF3Q2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjF3Q22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA282D63;
        Fri, 30 Jun 2023 09:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2AC16179E;
        Fri, 30 Jun 2023 16:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A1EC433C8;
        Fri, 30 Jun 2023 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688142506;
        bh=leLKl0DAy07tgyn34hWxkdY6pUyriDCgyyG0mnmq5Bw=;
        h=Date:From:To:Cc:Subject:From;
        b=g3kk6HwKWNVj8V8WtQeqoGpNWcT6lPWX/Mb4lXm7FjH9GhYdNEJkqmdrEDRu3ojAC
         RAE3tvQTMHAj9To3ssZ35wph74E/3H6CVinLig6IGfZXOtG+zEp+VFSbU12pw/ssg2
         24NfE0lISIIwNtci2rD8wZNyPa8h0TnJFp3nr9D3IlP5D2oPAfyhlFRrt+0bM6DiaC
         Cn+0uDAphhs/PUthcn9NWDr9pbBvH/zREzKyqlAvSadY/P0EOGzRRtgj9iWkeAvWF2
         XBBGYXp7Ua4onnO6QQesSWqXbOdO+GUeL5+2CwyQHB602/pBnJQ99+FvRMPEbhPZSc
         SEb+bsaZh++cA==
Date:   Fri, 30 Jun 2023 10:29:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL v2] flexible-array transformations for 6.5-rc1
Message-ID: <ZJ8C4PtPrxr6LTA7@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.5-rc1

for you to fetch changes up to 40ca06d71d60677a8424798610c97a46e4140a21:

  uapi: wireless: Replace zero-length array with flexible-array member (2023-05-28 19:07:48 -0600)

----------------------------------------------------------------
flexible-array transformations for 6.5-rc1

Hi Linus,

Please, pull the following patch that transforms a zero-length array
into a C99 flexible-array member. This patch has been baking in
linux-next for a while.

Also, this addresses a build failure with Clang[1] by fixing multiple
-Warray-bounds warnings in drivers/staging/ks7010/ks_wlan_net.c[2].

Link: https://linux.kernelci.org/build/next/branch/master/kernel/next-20230524/ [1]
Link: https://github.com/ClangBuiltLinux/linux/issues/1851 [2]

Thanks
--
Gustavo

Changes in v2:
 - Remove media-venus patch from the pull-request.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZJxZJDUDs1ry84Rc@work/

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      uapi: wireless: Replace zero-length array with flexible-array member

 include/uapi/linux/wireless.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
