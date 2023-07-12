Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D747D750243
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGLJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjGLJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41272691;
        Wed, 12 Jul 2023 01:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B87615AE;
        Wed, 12 Jul 2023 08:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A04C433C7;
        Wed, 12 Jul 2023 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152386;
        bh=eGzPwps7QP573vuLEzNKuUASg+8IYHrXO/IrGczNtyM=;
        h=From:To:Cc:Subject:Date:From;
        b=dngCNmRvOgh+6E+uV+4k8pZXn0qi5KDB+r62UdKp//zGDWzj9MNbBIm+o4iEzwnGT
         9iUq9IHs5bxRXtBiS7CCHXV478uLWoWTcciR1Kr+FCyr21PK/Usrs4Mh06QqT6qHcd
         D+kS5k5/Fjm6JHDi6if8lqA1hz9PCTRpu4xtDqbS7ZgEwo/3Du445hGJP+qewV6HF3
         YFvgb06q/n082rmaBj/LPdx/upuXQuBwKuLQzRE1K9mChUT1SH7HxAFgEdE7SWCe+6
         H3fCgFmg5ig5N5WxTdh4mVGPUd246JhwiqI0W4bBsBGf1FM6OOoJoQasjmgdIFtsNZ
         5WIsKqlcfOx/g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/7] consoles small cleanups
Date:   Wed, 12 Jul 2023 10:59:35 +0200
Message-ID: <20230712085942.5064-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series to do some small cleanups, especially in vgacon.

Jiri Slaby (SUSE) (7):
  vgacon: switch vgacon_scrolldelta() and vgacon_restore_screen()
  vgacon: remove unneeded forward declarations
  vgacon: remove unused xpos from vgacon_set_cursor_size()
  vgacon: let vgacon_doresize() return void
  vgacon: cache vc_cell_height in vgacon_cursor()
  sticon: make sticon_set_def_font() void and remove op parameter
  fbcon: remove unused display (p) from fbcon_redraw()

 drivers/video/console/sticon.c   | 12 +++---
 drivers/video/console/vgacon.c   | 74 ++++++++++++--------------------
 drivers/video/fbdev/core/fbcon.c |  7 ++-
 3 files changed, 37 insertions(+), 56 deletions(-)

-- 
2.41.0

