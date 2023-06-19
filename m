Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49830735951
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjFSORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFSORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:17:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCF9C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:17:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25bf4b269e0so3125601a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687184237; x=1689776237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m462Io47RlCWBfDJCQFiCJnqNvxTLHRYWMF6j3UT8B0=;
        b=Ju6rdffIi4s6qEqyNIzu8niM8oNTnG/uxGon9J9yJLsdAboFnyUvOLZkm2VAGkd28j
         jpYhtbv4LmDpVqyiq+wq5Dep01gGsEkXNUBW93U/r2Ia7470KRRo1VwBogPKZxcuOsxC
         fN328Z2kg4U7T/G+1Jh7WkTrhwILEtmegjMJFaFR2assviRqYauOm9TrKLYWGIIF3Kcs
         aQOf+Q6a2zTlu3jGGvdXh4TUBois9K9qwxeAJkwiLoYDKUISG+UFdQOqJF8rZOAPJ+eG
         ReCPqBrGnU1e+tLqGjLEi2VIjc899vxQRmK2vbKZbodgv4yamLJYUQtVYJO1xMTicEkQ
         qSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184237; x=1689776237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m462Io47RlCWBfDJCQFiCJnqNvxTLHRYWMF6j3UT8B0=;
        b=NqH7730gyJAvexA9yt+YyEbLG6hwZd66ll4AIJean5/QhGKIPHyFd6ORhcguxSOuJb
         jDVhfUQmn0QMbZkIfsBKNzAbQn7MIEpb4agU9qK4/nS+3q7HBWdVZOUt4iMQChgmpa42
         s565TYe9sKZtz0ZU7iI+X2Q74ev9MhAkBwrgWIgoqc6dRyOPVVSDQm5rn1bodCxGUcd6
         VBCsq5qHyPrA0CEpCkeA6AaEDwP4ZjFC0H2gI82EN8c1khbDnndIiDP6FmE/v4k0kfoY
         KcpY+jg1tLzbJsuK0aRse0153sft/3+wTsVbEeFoBCGfUMFmO6koTzffugVii2PkjT86
         4GvQ==
X-Gm-Message-State: AC+VfDxL21WJeBCTF/d5w7o9n7N+LdzM5tC3CNP4O3IHDC5lndeGdcBD
        +RzXoDrseGvLZCfszKNQEd0=
X-Google-Smtp-Source: ACHHUZ65D/W4si0E5ycCXfvGbSLyoUtFQJnN9DnqBS592C87gg9tWtlIWCnWgouDRpUYEDW9bNc8vQ==
X-Received: by 2002:a17:90a:6f43:b0:25e:fb6d:ce68 with SMTP id d61-20020a17090a6f4300b0025efb6dce68mr5438247pjk.6.1687184237181;
        Mon, 19 Jun 2023 07:17:17 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id bo24-20020a17090b091800b0025edb720cc1sm3731946pjb.22.2023.06.19.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:17:16 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:47:11 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v4 0/4] Trivial code cleanup patches
Message-ID: <cover.1687183827.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables in struct rtllib_device to avoid CamelCase which is not
accepted by checkpatch.

---

v4: Rebase to latest staging-testing branch as suggested by Greg Kroah-Hartman  
    <gregkh@linuxfoundation.org>.

v3: The driver is split into 2 modules, calling the functions directly which 
    the v2 of the patchset does breaks compile. So reverting back to v1 of 
    the patch as suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>.

v2: Removed the variable and called the function directly instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.


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
2.34.1

