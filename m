Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1D460D23A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJYRGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJYRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:06:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BB61119DA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g62so8416475pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRzwwEYr1S7EW5RlrN/bWb7MyYz9P2Ts/CC2UmzcrOs=;
        b=FSs99EDGOuesHAY4a9DEC5iuDnsa85TuPZA0tg6DDGLPwDCp8IAlVQt4tvwcC2+Rqu
         mI11UcquR62mNNgsWXRyFAyeNIe2iCLN6W7fvBg1Ea5OAGk+hWi+z5/CNoF+eT4sH8MO
         doQvigf1cjE/NpwcuffvE3uiHHLYtbPpUhmuOm4ilkSfGaLlOKBB+45kle+5G4+cUc2k
         8fSVTBfBxzYvw26NzBat6w6sBpGVFN6dD8rqkARWXIOurxJMXFYEw1HFGFzAO9pWK5kE
         XvJK/ejxQpO5XV0qyr4M9P1ZzhdFlgf1zw6OC77snPnyiTjz+3D9pvaREl2wYJ4DGuPI
         5gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRzwwEYr1S7EW5RlrN/bWb7MyYz9P2Ts/CC2UmzcrOs=;
        b=iioaeGxt0saohbmZbfV7PlTdifcaJoNH2usQ+fb8X4V0iyA9qH15I7KT+WqrGNAGnG
         95GiluLQAQBAfFN7zqEBRf4i5lQyIfPI9DCwTJyEsDAN2SkjEfoprcF1nHD1U5uNodbS
         WmEHvJwBePLseICXdy2YEs6uiA6W/bz4t0L4tgrTP786NP2quixzI0Q2CE7CqqMhz0C5
         +lMb2wHoL18P82SeXVIHGu95HmQv/l6uiyWvE8mVDhzYMkYkpOU7j7buFK0qmWXWRL3a
         rdhpyzIZIFN/6M8ekPX1Ye75QY5P66BVYbKM2vWbVWhleWoK5w4mhK9khpPf0sFuR+No
         0BXw==
X-Gm-Message-State: ACrzQf2JQnYonxoBIsx+IUyaczBRQHNWg1a+ubQ9yklLYqXeHmnQTlSd
        5cCqzyM989FVcinL8K3VTLYKSOt2oF0OZ1DL
X-Google-Smtp-Source: AMsMyM60iUi46jpRYtCN4RT6IdXEcQW+8/RTkXUZDMud+qf+ZECZVoDWRaunNxSig7SaDzbkqejSQw==
X-Received: by 2002:a17:903:40d1:b0:17f:4e94:b747 with SMTP id t17-20020a17090340d100b0017f4e94b747mr38191278pld.44.1666717588190;
        Tue, 25 Oct 2022 10:06:28 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id a1-20020aa794a1000000b0056bcf0dd175sm1592373pfl.215.2022.10.25.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:06:27 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v3 0/4] staging: r8188eu: cleaning up unused variables
Date:   Wed, 26 Oct 2022 02:06:17 +0900
Message-Id: <20221025170621.271903-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series cleans up unused variables in r8188eu
causing coccicheck warnings. 

Difference between this patch and previous patch is that this patch series
include making function rtw_sta_flush in r8188eu/core/rtw_ap.c
into void function.

Kang Minchul (4):
  staging: r8188eu: remove unnecessary variable in ioctl_linux
  staging: r8188eu: remove unnecessary vaiable in rtw_recv
  staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
  staging: r8188eu: make rtw_sta_flush to void

 drivers/staging/r8188eu/core/rtw_ap.c        | 7 ++-----
 drivers/staging/r8188eu/core/rtw_recv.c      | 3 +--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 drivers/staging/r8188eu/include/rtw_ap.h     | 2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 5 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.34.1

