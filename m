Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A734C734178
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjFQNq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjFQNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12AA1BF9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DFDC60FDB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7ADC433C8;
        Sat, 17 Jun 2023 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687009579;
        bh=JY48Q9h8/zPsasO5RFQPKvoVzkgofY9CUa1T4CXsfmw=;
        h=Date:From:To:Cc:Subject:From;
        b=Kfj/Hu0DzPAof1+l7kgXMtgxOB7LduhDHyh+C+lKxEnvHQLkINUtdP5nPFmxdIUTL
         cvLgkVFdUUM7NkGbH/PZwO6m8AHbNBEQZgLil4hNScbD4fn5R0eqdBfSp9R+gBAgxJ
         72lM9aUHJoDPZp1aXFPpEGSCwFzjXPPcx/+HWjkk=
Date:   Sat, 17 Jun 2023 15:46:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fix for 6.4-rc7
Message-ID: <ZI25KRBpKGcP0wSf@kroah.com>
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

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.4-rc7

for you to fetch changes up to b3dad076a058916c443c93074dc3ee80baaff4ea:

  staging: octeon: delete my name from TODO contact (2023-05-08 16:09:33 +0200)

----------------------------------------------------------------
Staging driver fix for 6.4-rc7

Here is a single staging driver "fix" for 6.4-rc7.  I've been sitting on
it in my tree for many weeks as it is just a simple documentation
update, with the hope that maybe some other staging driver fixes would
need to be merged for 6.4-final, but that does not seem to be the case.

So please, pull in this one documentation update so that Aaro doesn't
get emails going forward that he can't do anything about.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaro Koskinen (1):
      staging: octeon: delete my name from TODO contact

 drivers/staging/octeon/TODO | 1 -
 1 file changed, 1 deletion(-)
