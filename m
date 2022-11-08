Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F34621B74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiKHSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiKHSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:09:14 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6060713D5C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667930940; bh=iuvGxOIDRO88JDlGc//G/Az/Iuh80f0UrN5ARntwZtY=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=eGBlkMYmjjCDBdJMPGroEsjnvcLogx/kIRvxUPGy46qjY5L1GLquiluCRhJEAIWM5
         aGhbodlBGHuU5YEPgMQNmtxjFqu+7akBtaOye9roQLZFCG4SP/3neHkSboKSo/sjVd
         VL/sXFF1gm9VvWzdY7+znjUp2QKjJFOS5Q0aNA5Y=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  8 Nov 2022 19:09:00 +0100 (CET)
X-EA-Auth: ZVnd9t000U5esX0AyLUXYyF3GVeNm/AQyiWaa86pSGgUzIhdUJ6HbxPdb//g39KFFpFDK7Jiju99M/eQMtXIlps9z0gOdQe5
Date:   Tue, 8 Nov 2022 23:38:55 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1]  staging: rtl8192u: unused code cleanup
Message-ID: <cover.1667930291.git.drv@mailo.com>
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


Changes in v5:
   1. Earlier patch send did not work as expected. The emails did not thread
      well. Hence resending as v5.

Changes in v4:
   1. Resubmit patch set with the remaining only patch. Update patch subject,
      version and patch sequence number to avoid confusion.
      Suggested by gregkh@linuxfoundation.org.

Changes in v3:
   Patch-1:
      1. Already accepted and applied to the stating-testing tree. Hence not
         included in this patch set now.
   Patch-2:
      1. The patch caused staging tree build to fail due to EXPORT_SYMBOL
         conflict. Fixed the issue caused due to deletion of 2 macros.
         Correction and re-submission asked by gregkh@linuxfoundation.org

Changes in v2:
   Patch-1:
      1. Revise patch log to explain impact of the patch
         Suggested by gregkh@linuxfoundation.org
   Patch-2:
      1. Review other similar macro defines and clean those up as well.
         Suggested by gregkh@linuxfoundation.org
      2. Revise patch log to explain impact of the patch
         Suggested by julia.lawall@inria.fr


Deepak R Varma (1):
  staging: rtl8192u: remove redundant macro definitions

 .../staging/rtl8192u/ieee80211/ieee80211.h    | 61 -------------------
 1 file changed, 61 deletions(-)

--
2.34.1



