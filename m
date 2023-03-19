Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CAB6BFFDC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCSHte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCSHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:49:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881FA17CC8;
        Sun, 19 Mar 2023 00:49:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so9495429pjp.1;
        Sun, 19 Mar 2023 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679212151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDmKMfZRvdGTqS2YjpCHycz2mr/bwWb55BHOr40VzVw=;
        b=Uikflf21LoGQOuteV4ayhUyn0iQyYz0tnQEITezuEDbBxagF83vXzoSQ3vCrCMT8pD
         0ArNozhIkVXe/LmguBr6RkFQD6eTvnXTQzkA3bkWBVehzF2gHz6l2sLMJpbMoJGDR2zr
         4ExEHmTfBxedMiFsGOanyrfjHANBOe77txws0V5IT297orfxPWMJ2V/ajSplBZYU6RXe
         hBver8mdc2F+QwYhkktPaGqL/9JS4p9OHYpfg222j2sasl2ovGNlc9EXWQrWqlsAFP0X
         AklOksJGwhnMt1tNU7Jt1454iHT7TCbU9WvdRKxVDpHTVwOZYqCBgI2h7MnabuV5Htsr
         CMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679212151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDmKMfZRvdGTqS2YjpCHycz2mr/bwWb55BHOr40VzVw=;
        b=fjH/zk1Wzthub09lOVNXSjjbVh1n7qTmmpWZ/mj2l8Z+QxkUTuG2Pn8eLJjB0rVwMh
         g26aYvi0v2M4OwWTJZ+poud4g3XDSGus/FZgr+3hdVOEih9XomjEXsiLbCqVsUIyNfrI
         UfWnyZiuRN5gBhb04aHpt4NE1P4RcbwBRSarl94cV5HRj83/Y2BKQ4OqIW9pljkUBqur
         uULJeEbF/rLMLWzJ1ZPBC4Zog34wvaJW7KphH5fO5r1lZvzuVO05WS72QNMnK15UUuiJ
         DsYM04TyOuG2kPavN4HGUXkGXQbcq64h3L8PawyNEEqJ6fupJOEWlomOrdGp48KBAKT3
         X3HQ==
X-Gm-Message-State: AO0yUKXcDgS/Yx+LBCmiQe5Jty+RkwFSXQIWptMvwuoM6VeMv5qErj70
        r7whk7LGsNLR6qxmnjpduSs=
X-Google-Smtp-Source: AK7set9r1PJM+UDP4DEy+/qi0WLwDAu/7wmKLUGtYka4LtoxDlg+mUygQBIcBw4C/Yegck7oft0XXA==
X-Received: by 2002:a17:903:4111:b0:19a:b6bf:1df6 with SMTP id r17-20020a170903411100b0019ab6bf1df6mr11472096pld.20.1679212150970;
        Sun, 19 Mar 2023 00:49:10 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902989300b00186cf82717fsm4296616plp.165.2023.03.19.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:49:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CEFDB10667B; Sun, 19 Mar 2023 14:49:06 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, Lee Jones <lee@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 0/3] Documentation fixes for MT6370 RGB
Date:   Sun, 19 Mar 2023 14:49:00 +0700
Message-Id: <20230319074903.13075-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=620; i=bagasdotme@gmail.com; h=from:subject; bh=INgo8UAcDlgThAL83Kqu0+jtw7xGVPRobpAiN6s6OPE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCli+/KWz13l1TR9qpjWxwrxNVF3P7xi1kqbsnxZbuQU/ t0H+Gr/dpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAi7PMYGZ5P3/v54+sWyw43 no6o6cs/vv3BWP687JJo7ZlDVUXKWusZGf6KGyvNqWvS01j+QWvW5WM+PlYnpV2nH9q/51aYTXL 5DDYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot recently reported htmldocs warnings on documentation
for MT6370 RGB LED. So here are the fixes.

Bagas Sanjaya (3):
  Documentation: leds: Add MT6370 doc to the toctree
  Documentation: leds: MT6370: Properly wrap hw_pattern chart
  Documentation: leds: MT6370: Use bullet lists for timing variables

 Documentation/leds/index.rst           |  1 +
 Documentation/leds/leds-mt6370-rgb.rst | 42 +++++++++++++-------------
 2 files changed, 22 insertions(+), 21 deletions(-)


base-commit: 4ba9df04b7ac66d2d000ed7ae2d8136302d99a57
-- 
An old man doll... just what I always wanted! - Clara

