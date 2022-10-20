Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1160590A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiJTHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiJTHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:53:04 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E79118796
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666252343; bh=IDxcId1QkT7hrlZDNW6yFY1xSb80oaphOlu0dv7CxTI=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=lULIsknrK7h2gT9YSw6Nm7OI6qDBJNaWDtmoTnvq+RnIemTK9mZQTe/RZq14dxb6r
         OgJz/2frvCHR49bUiKqFQjJRsAmGj5fkEBWOEgLXouZI2Z0uCCdQadVFffeaq1t8Co
         wQaOoA1DlBc93A+EijkoCmh5oZwnBpyP1DW2Vgg0=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 09:52:23 +0200 (CEST)
X-EA-Auth: uFKiTbVSLLsHOwrxlJNQ2/+NSGS5G7jnaBTa8x7mBmImRrJp0lk6jBMqryZJI0j9MRaoSFmWWw2fYjCJRTbnH+fb9yrP12mX
Date:   Thu, 20 Oct 2022 13:22:17 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v3 00/10] staging: r8188eu: trivial code cleanup patches
Message-ID: <cover.1666249715.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address different kinds of checkpatch complains for the staging/r8188eu module.
The patches are required to be applied in sequence.

Changes in v3:
   1. Patch 4: Extend the __constant_htons to htons change to other files of the driver.
      This was suggested by philipp.g.hortmann@gmail.com
   2. Patch 4: Spelling mistake corrected as pointed out by joe@perches.com
   3. Patch 5 through 10: Included in this version. Additional clean up patches.

Changes in v2:
   I incorrectly labeled the first revision as v1 instead of v2. So,
   following change recorded under v1 is actually changes for v2. Feedback
   provided by philipp.g.hortmann@gmail.com
      1. Improve language / grammar for the patch descriptions
      2. Further improve code reformatting

Deepak R Varma (10):
  staging: r8188eu: use Linux kernel variable naming convention
  staging: r8188eu: reformat long computation lines
  staging: r8188eu: remove {} for single statement blocks
  staging: r8188eu: use htons macro instead of __constant_htons
  staging: r8188eu: correct misspelled words in comments
  staging: r8188eu: Add space between function & macro parameters
  staging: r8188eu: Associate pointer symbol with parameter name
  staging: r8188eu: replace leading spaces by tabs
  staging: r8188eu: Put '{" on the symbol declaration line
  staging: r8188eu: Correct missing or extra space in the statements

 drivers/staging/r8188eu/core/rtw_br_ext.c     | 122 +++++++++---------
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |   2 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  36 +++---
 drivers/staging/r8188eu/core/rtw_recv.c       |   8 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  14 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |   2 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |   2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   2 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   4 +-
 .../staging/r8188eu/include/Hal8188EPhyReg.h  |   4 +-
 .../staging/r8188eu/include/osdep_service.h   |   4 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |   6 +-
 .../staging/r8188eu/include/rtl8188e_spec.h   |  18 +--
 drivers/staging/r8188eu/include/rtw_cmd.h     |  52 ++++----
 drivers/staging/r8188eu/include/rtw_io.h      |  28 ++--
 .../staging/r8188eu/include/rtw_ioctl_set.h   |   4 +-
 drivers/staging/r8188eu/include/rtw_mlme.h    |  22 ++--
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  12 +-
 drivers/staging/r8188eu/include/rtw_recv.h    |   4 +-
 drivers/staging/r8188eu/include/rtw_xmit.h    |   2 +-
 drivers/staging/r8188eu/include/wifi.h        |  12 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |   6 +-
 22 files changed, 181 insertions(+), 185 deletions(-)

--
2.30.2



