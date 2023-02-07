Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80768DFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjBGSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjBGSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:16:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61F03CE04
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:16:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so3524069wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKb3TZUek2HqmZm24nIdjxpAgxRn7zyw1dpq0C4JxaM=;
        b=UADcJhenEukdNJPsH4qL18yi0P8qdk4xW5PT23pPNSbkWqV2fdU+ExgcHN9jLTd5DJ
         5fiolyeCDgJDw+J6dr9i1xrq+dhNYimAEUHjzRQBM+gGSoxqeefSAcFAwLWd+YspprIB
         Jaca/QMdvdf7XUIZ/wRobwyhVYfUtEv1KXSxt1EtduJGnmSpv5j1ccmgrI+18xlZPPgG
         1snABnIaRsElD24rZJ1AaReHKcKj9SzWjg0vTC3ebPt/XDLuo9Wouv0ybOL/J1V1jD5W
         jdQpjSKGZqsGUNIDJpoOEH/zZmMCq8Ycpy8fXyE3Ra0Talslh01bI3KC9OtIB8+qPljh
         Kfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKb3TZUek2HqmZm24nIdjxpAgxRn7zyw1dpq0C4JxaM=;
        b=3ELTXUxD/xI1icx3N9H8aEHjirjbxa+uorQVOHQfbp6miCbvnKZoDWzSbT+uEAfrdJ
         XvtqGUblEMWeb2XbZq05/KjPDMQPjS/0cNrXWjf8mQQIsiNJVL2wFO823P+/yxehI6YK
         ksNTQtc1BhmBn5VkzGfeDP64ufEWZpg8cmOVqmshkW3NPArSq5+Krs6DVkcrGjENkHxy
         KFw2+dvsS+5PHEDQuLVwTNzDHRcuhmKVEwIf4DJiLlRQax53ysPWzIJ7LkR/AKY9fbeZ
         7C/IZyXom1Zu8nuAui6P4Ll42MYfa7MmSrPnmfnXumDsekYm6ydp79e32PPaLwRY9Xpx
         qZyg==
X-Gm-Message-State: AO0yUKVsytDCKN29zAvwWCGbi33W97IoSEaMnMQSOKhsAl2d5CywA9++
        GuSQR43qRa0HRvYZA6HAYxw=
X-Google-Smtp-Source: AK7set8ATmtKImeOQFkQuVpNj8JmYvU2ELUB1+tOeaIgJOI9rzZF5uMA/mUPeFVIXerXL3FERcortg==
X-Received: by 2002:a05:600c:1c1b:b0:3dc:4234:fe89 with SMTP id j27-20020a05600c1c1b00b003dc4234fe89mr5185724wms.2.1675793773412;
        Tue, 07 Feb 2023 10:16:13 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003db0ee277b2sm19706599wmb.5.2023.02.07.10.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:16:12 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:16:09 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Rename constants and variables from
 rtl_dm.h
Message-ID: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constants and variables mainly from rtl_dm.h to fix checkpatch
issues as CamelCase, missing spaces and double line breaks.
Remove dead code in case of double definition.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (10):
  staging: rtl8192e: Rename AcmHw_ViqEn, AcmHw_VoqEn and
    ANAPAR_FOR_8192PciE
  staging: rtl8192e: Calculate definition of MSR_LINK_MASK
  staging: rtl8192e: Remove blank lines in r8192E_hw.h, rtl_core.h and
    ..
  staging: rtl8192e: Rename MacBlkCtrl and remove double definition
  staging: rtl8192e: Rename OFDM_Table.., CCK_Table_.. and
    RxPathSelecti..
  staging: rtl8192e: Rename RxPathSelectio.., RateAdaptive.. and
    RateAdap..
  staging: rtl8192e: Rename RateAdaptiveTH.., VeryLowRSSI and WAIotTHVal
  staging: rtl8192e: Rename Enable, cck_Rx_path and SS_TH_low
  staging: rtl8192e: Rename diff_TH and disabledRF
  staging: rtl8192e: Rename DM_RxPathSelTable

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 22 ++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 15 ++-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  3 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 96 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    | 37 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c    |  2 +-
 8 files changed, 82 insertions(+), 97 deletions(-)

-- 
2.39.1

