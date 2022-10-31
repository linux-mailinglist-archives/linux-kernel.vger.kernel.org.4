Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A907C613CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiJaRz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiJaRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:55:25 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF96330
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667238914; bh=W1cVkV3qn3Pg2/HJ80BRN4V9ycnBObxFgx7ZbvxxI20=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=YQm5J/smB2pHkI+WIASMCbAve6zPtBqFpZuF5iHwIjZbcP0eKvCT8FgEhF1WElD4/
         u4BMDLQPCYUG0SANBHnsubZ5NTBRtT8T8SzqpkYKDEvQXTNGsinWGGu2efnN8CeCki
         /PElmdDoR3aAdu4MHdtDptTUkB7WdRqJaOTDrYMo=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via [213.182.55.206]
        Mon, 31 Oct 2022 18:55:14 +0100 (CET)
X-EA-Auth: p3LF/zqOYKvJZGpBzZ/5JwgezmRpgKmoLiBSzVGEiUono7kTpDRrdYrQ0kPJ3AOSTCkNrWe0eDdRM/X98akJkz02DL61eXrX
Date:   Mon, 31 Oct 2022 23:25:14 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: rtl8192u: unused code cleanup
Message-ID: <cover.1667237959.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary or unused code.

Changes in v2:
   Patch1:
      1. Revise patch log to explain impact of the patch
         Suggested by gregkh@linuxfoundation.org
   Patch2:
      1. Review other similar macro defines and clean those up as well.
         Suggested by gregkh@linuxfoundation.org
      2. Revise patch log to explain impact of the patch
         Suggested by julia.lawall@inria.fr

Deepak R Varma (2):
  staging: rtl8192u: remove unnecessary function implementation
  staging: rtl8192u: remove redundant macro definition

 .../staging/rtl8192u/ieee80211/ieee80211.h    | 67 -------------------
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  6 --
 .../rtl8192u/ieee80211/ieee80211_module.c     |  3 -
 3 files changed, 76 deletions(-)

--
2.30.2



