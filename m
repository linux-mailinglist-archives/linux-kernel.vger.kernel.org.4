Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502196803A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjA3CBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjA3CB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:01:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A791CAC1;
        Sun, 29 Jan 2023 18:01:23 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675044081;
        bh=SX4V673ceoT4XtSrmLtU1UuFNvbRxYXwSU5r9qNQ3VI=;
        h=From:Subject:Date:To:Cc:From;
        b=W/4ieVOYaPImUfOqdsoV99olzrDA97bNunmNIQsUaud4a+v/daLKbE5Wf13om/acN
         7OkSqJA31En1Zm6iuTC8UGcBhVtZjJq6TqvlWIRaommr8ysA7qMOyIzjhDlGBfeizE
         5XMOBMnq+9bv1MtEU76bV40xdeQkecqRwJrRGpy4=
Subject: [PATCH 0/3] dyndbg: add source file name to prefix
Date:   Mon, 30 Jan 2023 02:01:17 +0000
Message-Id: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO0k12MC/x2NzQrCMBAGX6Xs2UC6Ffx5FfGwab62C3GVBEUpf
 fcuHmdgmJUaqqLRtVup4qNNn+bQHzoaF7EZQbMzcWTumYeQf5bTHCYtMHkgREY8ny5ZcEzkVZK
 GkKrYuHhn71Jcviom/f43t/u27fWMbht2AAAA
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675044079; l=903;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SX4V673ceoT4XtSrmLtU1UuFNvbRxYXwSU5r9qNQ3VI=;
 b=gK5lX3gXfyVvJBcvul7L1wQ7lURATlRcyrtsELPwsPVMgaK1SUHuNMQOwqbbx3Inh9pzRH38v7mf
 SmMQxH7gAH1hg/rf9FoOdR3WdluHwY95s2Wblw9F341lsQw91d1p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dyndbg has no facility to print the source file name of a
debug statement.
Without the source file the line number is of limited use.
Also the dyndbg control file uses the filename as the primary index, so
having it in the logmessage makes the relation clearer.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      dyndbg: constify opt_array
      dyndbg: increase PREFIX_SIZE to 128
      dyndbg: add source filename to prefix

 Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
 include/linux/dynamic_debug.h                     | 4 +++-
 lib/dynamic_debug.c                               | 8 ++++++--
 3 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
change-id: 20221223-dyndbg-filename-02e0879dae4b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

