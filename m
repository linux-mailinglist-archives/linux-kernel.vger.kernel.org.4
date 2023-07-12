Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79274FF85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGLGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E51DC;
        Tue, 11 Jul 2023 23:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68653616E0;
        Wed, 12 Jul 2023 06:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE302C433C8;
        Wed, 12 Jul 2023 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689144139;
        bh=x7wMConmigIj9mOclj5V8pL1d89dDfSqPUBhATMvdEA=;
        h=From:To:Cc:Subject:Date:From;
        b=DsIX7Ee5MgTxaGZ/FZjadu8VNC+Etloc2UvsJWsv9ZkE4LtYOkXhgjlbzAsdc8UhF
         rqjQbWYli7VLPsjZgbxwqhBCsiji3ry+7Ckv/X5pdcus+e8jsKfnS/eBQXDVkkkJn3
         7Fg9g5r7pM+XTYkzOr25pM+xiVVeYZdZXGpoJBxb+8uPc2nO4VB+SGDjyLRpmozyW+
         mvHmFUUEa+4cUk/U1sq7a39m9bd+KdA2AKTwjSy7jp62NFx/ygNFPvk6T6C9299Rki
         unABlSEC7qh476YN7tPd8Hx4ylUbmtPmWrlj3CLJvYG3DMrAB5jr5/olZqjtOas0wg
         OhRBpCoFkGkDQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/4] tty: n_tty: couple of random fixes
Date:   Wed, 12 Jul 2023 08:42:12 +0200
Message-ID: <20230712064216.12150-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small series of minor fixes/cleanups in n_tty.

Jiri Slaby (SUSE) (4):
  n_tty: drop fp from n_tty_receive_buf_real_raw()
  n_tty: simplify and sanitize zero_buffer()
  n_tty: pass ldata to canon_skip_eof() directly
  n_tty: make many tty parameters const

 drivers/tty/n_tty.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

-- 
2.41.0

