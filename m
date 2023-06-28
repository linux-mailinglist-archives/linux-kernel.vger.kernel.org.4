Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2C7415EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjF1P7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:59:45 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:38242 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjF1P7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:59:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAEAE6137C;
        Wed, 28 Jun 2023 15:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9457CC433C0;
        Wed, 28 Jun 2023 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687967982;
        bh=9HDeDUWJfVkDFTW/qa3ifB0pTrqbmJRmbZboAXIIsnI=;
        h=Date:From:To:Cc:Subject:From;
        b=PKYVYtIVZiGhbL+c+wDebTF6uCDhLBO+jq6OsCb5zkqmtzgW6rnCJDabWs5ipDmB3
         mOf6edRKL8PICvMmt7IEUuNYEsw4LjmPC0P9+4XeMBedU+JT9hcQSDLT8NTEWBVOMT
         b9x8vRfvVSO096YPiKK+2qslsqRDk3UmExNO+0UxUOwKUUVyjPrKMgXJLk7luXD+b6
         alHpBmjEE7DeEe/M2UP7LrEj2B7zzzSKPmYBMn+GDCpxQHlHLqt//UvXDCg041V8NU
         WBu5X89Jz7vptNTcW8JwHnb+1C45pe/QqZktvycybotqSLOFemVrztlBnZ5rXZFXsw
         2LP94Axt1tPjw==
Date:   Wed, 28 Jun 2023 10:00:36 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] flexible-array transformations for 6.5-rc1
Message-ID: <ZJxZJDUDs1ry84Rc@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.5-rc1

for you to fetch changes up to 1fa89cccd288cea4370ce08042b749b72ea8b059:

  media: venus: hfi_cmds: Replace fake flex-arrays with flexible-array members (2023-06-11 09:51:08 -0600)

----------------------------------------------------------------
flexible-array transformations for 6.5-rc1

Hi Linus,

Please, pull the following patches that transform zero-length and
one-element arrays into C99 flexible-array members. These patches
have been baking in linux-next for a while.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      uapi: wireless: Replace zero-length array with flexible-array member
      media: venus: hfi_cmds: Replace fake flex-arrays with flexible-array members

 drivers/media/platform/qcom/venus/hfi_cmds.h | 8 ++++----
 include/uapi/linux/wireless.h                | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
