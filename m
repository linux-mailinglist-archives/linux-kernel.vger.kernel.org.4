Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B22713A2F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE1OvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1OvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:51:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70325B2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:51:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2566ed9328eso391781a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685285476; x=1687877476;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTBDrtvbwG5vBWWTp3u4n6lRUh0XUADBgJi72l1DPeY=;
        b=KgcjvYCH0v9lluWR0fOm7SBQzLjC/jDMjgj9ba4R0trr3cl3Is+pBREY697oTt/Kz0
         C0KkiOywNiIU4jyfZgsgqBqFfiroRWjiOnT10IOco/VsLFwSkXLH+HlTJr5298IFJrbY
         HUn+iAcIgWxyN9Hzbh9ofEh/xGWDplbbfiulJqpp+wXrwKIe39OE4dMCcvraUTvrtBHA
         awdp+OuRZ9Ak0gVmaYNT4EFkCKrjeAFnMEkN7x/XvFjSzac6Od2h012sH0nVh02SW0PY
         42KJ/8DYM11oM7tmn4aOqEaxYm9JXPOUjvmwAnQAKeVfQR5fIUPomnhodc7vvq9Z7mn/
         G7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685285476; x=1687877476;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTBDrtvbwG5vBWWTp3u4n6lRUh0XUADBgJi72l1DPeY=;
        b=AkCHzrGgG7LY09J47KS1np2TCvvCqv9+mIkAA6iKmZaMs3kpv0G41zjZNrgQXAg0MR
         1LKXq1OyJt8nhgia9w9sZIILJbCaAF4Dlx+FvyEwVMpqPZuT5vtfiybN264/7StmgXoo
         mR3SJWuC2rJ2YBa24hFJyBrJ9npcbWHhhoug67MAKWfFeWYDSY8bxv6j29s0CB0g3XGY
         8EmqjDqpRC9Hi7s6SB0SUBJUxTYi/cYc68yPeD+CVV95S7q+hCzPfaPjEwz0o/0kmHFR
         KcbuzzBTH5N29IyLMX06JOEattrFQgYn1xRDru7k6gUYEOYNj+JnYAUPXl3dTBzQ5BV/
         sYNA==
X-Gm-Message-State: AC+VfDyKSbYoyp7QM7/XiaE1kAZCK3Os1/YFOuzbvDFXhg4Uh91EuNY4
        TS2v5VR0YcCGYekKSgVMwDQsFKuOuW0=
X-Google-Smtp-Source: ACHHUZ7m17KPc4HJ7Ql676huTbgjFVHOYqs5IzuDPLICaR9efiaPXroj++Y07JuTlPAvo4pit3FMGA==
X-Received: by 2002:a17:902:f686:b0:1aa:f78d:97b7 with SMTP id l6-20020a170902f68600b001aaf78d97b7mr10776102plg.46.1685285475754;
        Sun, 28 May 2023 07:51:15 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.199])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b001ae6e271327sm6408137plh.1.2023.05.28.07.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:51:15 -0700 (PDT)
Date:   Sun, 28 May 2023 20:21:11 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Trivial code cleanup patches
Message-ID: <cover.1685284727.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables in struct rtllib_device to avoid CamelCase which is not 
accepted by checkpatch.

Yogesh Hegde (4):
  staging: rtl8192e: Rename variable SetWirelessMode
  staging: rtl8192e: Rename variable SetBWModeHandler
  staging: rtl8192e: Rename variable LeisurePSLeave
  staging: rtl8192e: Rename variable InitialGainHandler

 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  8 ++++----
 drivers/staging/rtl8192e/rtl819x_HTProc.c      |  4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 12 ++++++------
 drivers/staging/rtl8192e/rtllib_rx.c           |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      | 12 ++++++------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  6 +++---
 7 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.25.1

