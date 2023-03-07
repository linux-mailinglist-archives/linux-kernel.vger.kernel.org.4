Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F06AD98C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCGIuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCGIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:50:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4554AFC6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:50:09 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i34so49266266eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678179008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7pqtykxNAHfKk3ftPnpaownpFSnpgV4knCvwnISbJY=;
        b=I/bVjZS2F+kmcvTTkU9tLOwZVISBmrFUKaeW38tzAwYtZHTXLshMtSUHlJJ0tlso/A
         qsCvoZV6EiGggenLszHoGIoA7pkdwTQqvvF75W8pqb4P/AZoe6+BxQOedwWwznu7Fs3v
         dSXFJNL71rSyv9rQrQZf5/HD0RLsMshQFTuZtLhfBpS9cSXRzOtG3+94TXloONnVWHCl
         pzsBEKjLBums4Z8kYhZ+Zvmpe/5F1bn+mJRY6LzPyui9oqXkRQccEzAyB8Q54dKiBGLl
         s9e2V+otekmC3eOJtfsN2qsrTF+drHv6zFE2RHBqanG+nllGBdZmKKr2FmhLUjjzuKD5
         g4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7pqtykxNAHfKk3ftPnpaownpFSnpgV4knCvwnISbJY=;
        b=S69/Q1ilIcuLQCtGKktBbWgs1UtGcxM+08Zl9C1pQTfzSKtmRKrd3l7ElOcUn89GJG
         LrUKdGFq/wRjR8IbjOnYfYHqoS/JCkJPVr24DsVtjtrM5kiJ+TVsMnmq+Nk70Uf07ilY
         YgWfMwNeJjUthHHjxq/SChaHqUEiSy8KY/wJqo4zDB5JJe3tfVhksfsnSaboPbl05mbK
         JD4iNTYyIUWop6QNdNexAQgSDX/wEklh8K4angHycYyoMFrBY7DEfhmNa+RV7gGehbFK
         +Q+JXulvObAlWR6JyMF+/eV4s2jnuTvxF2yPu6arKMZwT+EQbq9tpboHzzz0hRNyajdz
         p+XA==
X-Gm-Message-State: AO0yUKWTvub/NO50xeyxZefW6XnEv9lzn4yNFZgNVSB3yKyU7UaBDVxN
        sxWDDLPzEjpUrtLQED+fSWg=
X-Google-Smtp-Source: AK7set9LPrU9voO8OIMQUg2zuD+0YE2Nrohxl3lbTAcVbNZyW2+QnWJZdexsEVVwtR90793/56qLAQ==
X-Received: by 2002:a17:907:6d12:b0:8b1:3131:76e9 with SMTP id sa18-20020a1709076d1200b008b1313176e9mr18373189ejc.46.1678179008275;
        Tue, 07 Mar 2023 00:50:08 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbe7.dynamic.kabel-deutschland.de. [95.90.187.231])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b008ef42f9cf48sm5707402ejd.82.2023.03.07.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:50:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: two simple cleanups
Date:   Tue,  7 Mar 2023 09:50:01 +0100
Message-Id: <20230307085003.5025-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains two simple cleanups.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (2):
  staging: r8188eu: busetkipkey is boolean
  staging: r8188eu: bgrpkey_handshake is set but never used

 drivers/staging/r8188eu/core/rtw_mlme.c        | 1 -
 drivers/staging/r8188eu/core/rtw_recv.c        | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c        | 2 +-
 drivers/staging/r8188eu/include/rtw_security.h | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.39.2

