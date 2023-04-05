Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A636D89C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjDEVsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDEVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:48:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43F7210E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:47:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-93b8c095335so6726166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731277; x=1683323277;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iehfqAb2+mLggzs2gHVsdI0okskRQgfHIl/m02R70JY=;
        b=dua4/AN7bMNF1xUf0vNDOYp3Q7eM8C514AFsYpdUZ1hu3mo+CojQH1Lmof+w1xDn+W
         k+Al0fnEDp2gxzbbYZsUvqW4oCweX+SpYm5O/lnAUrVsLCYWvYtyy73ldX1+dRFvxCRX
         MjuL280E7SOYpaAHlDwiRN+5/jUslZI0mJ3h/cl6XR+OY9XA0aHn9q4haZWo3/8tKoJ5
         MVciGlxMpHo0HE7tK01rCT9CEY389h9Ww/sN/VlFGn7tEE/cGwgmj5nb/2yHvFXg+Kox
         elsJ5EZnnjba/Bm949bhACuWYIm/qW7Bw20K2EYXAA2/UeCsyLGF8UXbM3hOx6U6w4Mk
         IFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731277; x=1683323277;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iehfqAb2+mLggzs2gHVsdI0okskRQgfHIl/m02R70JY=;
        b=d4ZjoGRX+j5QQTEFjqKY0JYuDq9IlCXIuDhwLMVPgwRMYOiL3c7pOY5Csni21EEH8J
         Fd4pjelEEG8gkMZLPkvxJlkLYOhcXlPU0VurpRfzyyQTNbF9e0xCf53aBuqwfzsOaO2y
         gwcBkS4NMYT39WcAFZ850T+74vZ+femTwuMrHzgml1jHMw4LN1+KaW9Z8A9Yc2dPU/qf
         AuXnoRSQ1cZ8vG7WphSTxI0dzhP4uG6JgVS5V1DfB67Us+6cFCVKxDTOIKzCNm9iRINC
         KSLRYzuAJkoFm5fazgVlR+qZB4zj0gq7SUv8joMPwYFUBLXvquz/gSMhjY4uPmbRz4ON
         NUJQ==
X-Gm-Message-State: AAQBX9eoKeEXoUxFIrkF1brxE/9ZOMNudl12ljyFzQ8a7oK6YPFW1hL5
        A/1O5HSypY/NJj6kpagoLBAwH9NWKpE=
X-Google-Smtp-Source: AKy350Zzs6jn9VX0EaR/JVOLwxEruJGkn/HztJ6+kLrbv3qiyjK82l75KwxRCI6xahKLzdZgAKzMeQ==
X-Received: by 2002:a17:906:208a:b0:947:bff2:1c2b with SMTP id 10-20020a170906208a00b00947bff21c2bmr2756156ejq.1.1680731276603;
        Wed, 05 Apr 2023 14:47:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id sz22-20020a1709078b1600b00948da767832sm3573447ejc.152.2023.04.05.14.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:47:55 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:47:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: rtl8192e: Remove unused code for hardware
 rtl8192se
Message-ID: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro IS_HARDWARE_TYPE_8192SE and unused function
_rtl92e_dm_init_wa_broadcom_iot. Remove a double check for hardware
rtl8192se. Remove unused variables.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (5):
  staging: rtl8192e: Remove macro IS_HARDWARE_TYPE_8192SE
  staging: rtl8192e: Remove unused function
    _rtl92e_dm_init_wa_broadcom_iot
  staging: rtl8192e: Remove one of two checks for hardware RTL8192SE
  staging: rtl8192e: Remove unused local variable irq_line
  staging: rtl8192e: Remove unused variable RF_Type

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  6 ------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 18 +-----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c  |  2 --
 drivers/staging/rtl8192e/rtl819x_HT.h        |  3 ---
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 6 files changed, 1 insertion(+), 32 deletions(-)

-- 
2.40.0

