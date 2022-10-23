Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8B6095F7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiJWUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJWUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:05:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DEC5B521
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:05:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w189so5939929pfw.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sPUPb6oRl7KEqD6mV4SRu4u5doWDjb3blZucpwF334=;
        b=n/6o2lGh9DT0UTU0OI91LTHKxInhidxtX42U/UHHdGpfGD1dvmoFK7+znOdm7d2eim
         Gt4PcxRDtV/rg0FOxugPT3Z+VT75Yk84whGAp9Z0HPH2FBRiLj+8iD9g7y4bQ7uNex5x
         rR6YC4+T4jhEccaYmgyuLXf4QX+WJ8j0qsMzt2mo7JGHFWcZHvsPM4JgGH6crl0veeCm
         I4QwJXr1gcmCfys7Q4L4GBAxsSuG2xjgQlQcn9Zp9oE7cuIs6W59wgelTH4cwFni2UOb
         0lPur2WFLtA+2T31jPxBy+gdKUeXk65Yjzrlueo2SDZJeIGCpGia1+LEolRGioLkKxpE
         8Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sPUPb6oRl7KEqD6mV4SRu4u5doWDjb3blZucpwF334=;
        b=yoI1N+HIxpY5XyWwVw3vswS+0h6V+KF3nf56Ok/xWhNhVxd0yG15UfCnuqOEwPzFcj
         Kj3W21cUjHRXP3ELtQas/0iGN7XIrAC4WKAwU3lsT5ondFrFHCZHwO7JX/E+GOMc+aUB
         bE5o81H6kpsEJEC0rw1GjNfWOIKyStC4kQtLwis3nB2OB/Pw5QB+DKC6eHnfIHBNcE0x
         A70niYy26tCQYJCnLsQUB6DjZsnQl7IVjJVke9HgIbh2ckp1hubZgzpBmFgM1JfsY6YQ
         VDSj7X3k2kLEJUEKCmJCSTWph6IFGgS/jsKaHfbhMjJpPTDcSt3vXw93UKDnNkwGm48q
         GqwQ==
X-Gm-Message-State: ACrzQf3TGrcgQ8sa3Z0a8qkewq6lGDIo50nO1QDeHYBRNa1gCeON4gcn
        jw8Fj3s/PpLejG9iawfM2dKR5kiZoBOrTDg2
X-Google-Smtp-Source: AMsMyM5dnunP5CXd5LNnMnemSewA8Nz4tf0FT3lhkKpCyI127u8FnW/CPxYORVuzCNrlsMBjUuug2A==
X-Received: by 2002:a63:90c8:0:b0:46e:cd36:adb3 with SMTP id a191-20020a6390c8000000b0046ecd36adb3mr9255961pge.487.1666555539477;
        Sun, 23 Oct 2022 13:05:39 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0056bc0578c7dsm1130649pfm.110.2022.10.23.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:05:38 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: cleaning up unused variable
Date:   Mon, 24 Oct 2022 05:05:28 +0900
Message-Id: <20221023200532.259276-1-tegongkang@gmail.com>
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

Kang Minchul (4):
  staging: r8188eu: remove unnecessary variable in ioctl_linux
  staging: r8188eu: remove unnecessary variable in rtw_recv
  staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
  staging: r8188eu: remove unnecessary variable in rtw_ap

 drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
 drivers/staging/r8188eu/core/rtw_recv.c      | 3 +--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 4 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.34.1

