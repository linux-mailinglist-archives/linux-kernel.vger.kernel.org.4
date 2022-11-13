Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB59A626DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiKMEex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMEeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:34:50 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C2112AFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:34:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v7so5200559wmn.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCKi5GtHXbTVBeDHqx5uVf+WaRYOSHhlcuCz5nUTI7s=;
        b=LUIEkpaW+Hkt+An3AxiBlimQsNY4+/jgONzEafi3nIDQwAZYiPDsnb5HS92/eYKGJz
         JpPb34lkNOjkFxpKw0DuJh1umGT4oZzjuGtlz1/0E5E56bnr7ceG1wNGlexkRE0cw7r9
         g8wyM3y5rzns0EQfpg1z3TsZCa6qf7r77OA/QM08IJrC0UXRnYIvsVrrectgaTV9cBGo
         puXgzStE2Dp6taDP7zrpbqLcu9m83fAl65rLlKdhpyZK5O4x1aSO26r8MYtJ9BczFMI8
         LkIKABTChEJIsGffpqvkXuY9JwhN3vDwmxqhTQc8Pc8P7uo21Y8KvX1PNtEz9s+z/SDg
         8e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCKi5GtHXbTVBeDHqx5uVf+WaRYOSHhlcuCz5nUTI7s=;
        b=PoiMQwvbEhIa34bzk2GU4ZY7QebwOkOePolQfPl1ELptDx+DBHUDDgqGRNHNN1dWra
         aLhB6ZKIevceY5c33xZZ6Ia2ccmTC+XWwAw3M1y0anksc8dW8c6WgA9zCaFJCCM+HDVV
         iHg/X5vOSIk3Aw1j8glf+s+hjM6fRxulauV3IK/gKaW9RSGwJ97Z0A1ONUlr1cZCiTMq
         u1ChLFS2+at15NL63K8SGgZB/8+hbffFnc+QLmT0brkzYPJ1GvTkhJ78lS84S14Pi1QW
         LRvNgdei8FaZqMGM799YIiwNaS8yddAJllRA/9CCWgjsMISL7g/LK/71swVjED7fZ/bs
         qodA==
X-Gm-Message-State: ANoB5pkpvWNHtdbAkQD5yMuHWPTzMRsXG31H2AYVdTxJ75KMd6jVQ6Gn
        rOO4Fcfw+IcAaQCwe3/fIbq7U50Tl8k=
X-Google-Smtp-Source: AA0mqf5FlalJlXDjf96E1LlH1uqOWzttrqBz79j8k07gV96iiAYWqwVeIuQ6CGHa95txIA6NVTCtiw==
X-Received: by 2002:a05:600c:54c3:b0:3cf:70a0:f689 with SMTP id iw3-20020a05600c54c300b003cf70a0f689mr5058976wmb.161.1668314087339;
        Sat, 12 Nov 2022 20:34:47 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id d8-20020a1c7308000000b003cf7928e731sm8382491wmb.9.2022.11.12.20.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:34:46 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:34:44 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Rename variables in rtl819x_HTProc.c
Message-ID: <cover.1668313325.git.philipp.g.hortmann@gmail.com>
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

Rename variables to avoid CamelCase which is not accepted by checkpatch.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (10):
  staging: rtl8192e: Rename bTxDisableRate.., RegMaxLPSAwa.. and
    bTxUseD..
  staging: rtl8192e: Rename Regdot11HTOper.., bSupportM.. and
    PowerSaveCo..
  staging: rtl8192e: Rename Regdot11TxHT.., dot11HTOpera.. and
    RegHTSuppRa..
  staging: rtl8192e: Rename pPSC
  staging: rtl8192e: Rename RFInProgres.., bEnableHT and RegChannelPlan
  staging: rtl8192e: Rename LinkDetectInfo
  staging: rtl8192e: Rename bNetPromisc.., IntelPromiscu.. and
    bPromiscu..
  staging: rtl8192e: Rename bFilterSour.., CCKPresentAt.. and
    ResetProg..
  staging: rtl8192e: Rename InterruptLog, RxCounter and bHwRfOffAction
  staging: rtl8192e: Rename pHTInfo

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  40 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  40 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 168 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  12 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  72 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  42 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  46 +--
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |  20 +-
 drivers/staging/rtl8192e/rtl819x_HT.h         |   2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 376 +++++++++---------
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |   2 +-
 drivers/staging/rtl8192e/rtllib.h             |  44 +-
 drivers/staging/rtl8192e/rtllib_module.c      |   6 +-
 drivers/staging/rtl8192e/rtllib_rx.c          |  34 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     | 170 ++++----
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  16 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |  78 ++--
 18 files changed, 585 insertions(+), 585 deletions(-)

-- 
2.37.3

