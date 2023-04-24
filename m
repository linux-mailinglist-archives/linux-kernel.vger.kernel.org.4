Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC26ECFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDXOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDXOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E305B88;
        Mon, 24 Apr 2023 07:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4F2624EC;
        Mon, 24 Apr 2023 14:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68011C433D2;
        Mon, 24 Apr 2023 14:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682345190;
        bh=c5XwOsT/jznsaZ291+3HfQGUzpPmI9gg5/1E5d2NrDM=;
        h=Date:From:To:Cc:Subject:From;
        b=ZN29mNNztiqL8X0+htscsxDO/aXZREecxhQgz3zmj5d1SjPcjicZQyYQDsOuCj+vr
         ULXuCOzGrU6ava4Z4sfKu09qqQCpRnihE0JqYFwW6QWIYLv7Bz0XxSFD3efieHHa5w
         7geQhCWepjSsLvrUsvGY5fc8yuR1jmHEWPxQSncynQEWNtZlrt/jLZzlA8Uj4ZV5da
         S/RptaD72fDG6qDcFNn/39ZvuEQujCm4MyvsI7RGH1jTYPxtt0Q4xO2EWUezakfNlK
         88Eh7hiKZaqgBilMmzuBN1Li8ibyFjujWVt3lXe5ncVzXiESxsRcS2j7AnhorD9bgM
         cIe6DPoSrPRFA==
Date:   Mon, 24 Apr 2023 08:07:19 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] flexible-array transformations for 6.4-rc1
Message-ID: <ZEaNFzLag13mLxOL@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.4-rc1

for you to fetch changes up to 00168b415a60cec7558608efb4fc50f2a73daae2:

  uapi: net: ipv6: Replace fake flex-array with flex-array member (2023-03-30 14:06:56 -0600)

----------------------------------------------------------------
flexible-array transformations for 6.4-rc1

Hi Linus,

Please, pull the following patches that transform zero-length and
one-element arrays into C99 flexible-array members. These patches
have been baking in linux-next for a while now.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (3):
      ASoC: uapi: Replace zero-length arrays with __DECLARE_FLEX_ARRAY() helper
      drm/vmwgfx: Replace one-element array with flexible-array member
      uapi: net: ipv6: Replace fake flex-array with flex-array member

 drivers/gpu/drm/vmwgfx/vmwgfx_so.c | 2 +-
 include/uapi/linux/ipv6.h          | 2 +-
 include/uapi/sound/asoc.h          | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
