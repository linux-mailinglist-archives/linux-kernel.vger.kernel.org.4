Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8740F66B3C7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjAOUTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAOUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:19:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6C12F16
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:19:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u19so63643853ejm.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4G80CZkEtDJ5S8nHN2azZRr/qBNRSSzTfZc/Vq/ilM=;
        b=iuJpBybHuMlWTqaA2THUY8UH5zLu5bYXFfK+MLnSqBqQD3FXmHnRU4KYn5oryl75iA
         i/YpfDS2JFjOtTZQEjKK6IlZxrPtdnshy7X+gUfy7r1erDLO7//+FyTUoKA/mrk8CVD1
         FLx8C55Mp49mEtH5ssB7D5EZTQWB3lmzjnnh0iNQzP2A1FvrThv2Zvqtas1n8S4xwT6p
         LW2bz9JG5v3BksIOqJxfqVsCeumGBAfZ7y5t4bVujV+5QE6IvwA2OH6juaquALx5KRkI
         w0JbaRYVQro8QC7JlhNwdwg98z7YP5nEQMJUm4yVipBiKQm3dATpiPtI80W2rFbYgIyy
         rt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4G80CZkEtDJ5S8nHN2azZRr/qBNRSSzTfZc/Vq/ilM=;
        b=Z5/MucQRpUgAeqYQD4ZJ8OxSixAvN7PAAacUDm5cCkxLwKaA8E+W3KBp6yzirRjmaa
         zj72gnYhrPR/4QrdrRDZD88eZewAhJiBAUiSd69N1LSVWk3oQA4wYNg3MIQNawKBg80y
         oEYnKlsHiDaJm6W8lyVnUuwjdQgLUqRox42xFS3MLvyd9rc7RWQ1ivQ4W0lmpxGzDEyr
         MkUtBo7kyVX6sKL0X1+G8bD7FSH+XXRiLup4exFgZ8gXz4ulu0I3KPoPeeYXqZielifQ
         k1F0ds3cloMxfxKAn5V7/mLtH7KhQSNHekUDTCls2RC9Yprobkt6K/SShnLU8DoM0hxB
         J8mg==
X-Gm-Message-State: AFqh2kqqYfBy8ALH6sCWR1opZVTMhZM5ustu16iu9n2Gt8bLFR4eP7yg
        AsbRqk8IWqS2kSdzypsggCOBQOBHm4w=
X-Google-Smtp-Source: AMrXdXvWkZnCqKSawa+yWFdf6lcM288lPoTwtYAOjylBJu4j+yCdv+doI5wXP74gEclActakL9+xmQ==
X-Received: by 2002:a17:906:d109:b0:870:839d:224f with SMTP id b9-20020a170906d10900b00870839d224fmr362331ejz.4.1673813956454;
        Sun, 15 Jan 2023 12:19:16 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b007a9c3831409sm10966129ejd.137.2023.01.15.12.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 12:19:15 -0800 (PST)
Date:   Sun, 15 Jan 2023 21:19:14 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Rename variables from r8192_priv
 start with bDynamicTx..
Message-ID: <cover.1673812849.git.philipp.g.hortmann@gmail.com>
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
  staging: rtl8192e: Rename bDynamicTxHig.., bDynamicTxL.. and
    bLastDTPF..
  staging: rtl8192e: Rename bLastDTPFlag_Low, OFDM_index and CCK_index
  staging: rtl8192e: Rename Record_CCK_2.., Record_CCK_4.. and
    DefaultIn..
  staging: rtl8192e: Rename rateCountDi.., ContinueDif.. and TxCounter
  staging: rtl8192e: Rename bResetInPro.., framesyncMo.. and
    nCur40MhzPri..
  staging: rtl8192e: Rename SetBWModeIn.., SwChnlInPro.. and
    ThermalMet..
  staging: rtl8192e: Rename CrystalCap, EEPROMLegacyHTT.. and
    EEPROMCrys..
  staging: rtl8192e: Rename EEPROMTherma.., EEPROMAntPw.. and
    EEPROMTxPow..
  staging: rtl8192e: Rename EEPROMTxPower.., AutoloadF.. and
    SilentReset..
  staging: rtl8192e: Rename EEPROMTxPower.., AutoloadF.. and
    SilentReset..

 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |   4 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  92 +++++------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  52 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  10 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  60 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 144 +++++++++---------
 6 files changed, 181 insertions(+), 181 deletions(-)

-- 
2.39.0

