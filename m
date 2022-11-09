Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB383623617
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKIVvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIVvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:51:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562816551
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:51:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 187-20020a1c02c4000000b003cf9c3f3b80so2195674wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iMYADahNRMz+BK4j5B8SILP6qEihete8xrXHT4Brv0=;
        b=EB4h4lOaOXb+d4nw4ML10k66onCvQcpKVRCNbXcDIOwA/78VwEFvd3hwI6ofuaWhkx
         gmApBQvLVdsG8LH89yIjK8ZDTt+f6SKBwtBf88f9AT3FRbNytlC29bRoYekl9DutGlvI
         HNVLeSc3FIstSigqR8c2DH6FVD4htFNhTOyx47OZSToQMO8eKxh1IZP2k7daM99ohA19
         +nbjufUT18ETP1qSBjUrA30fqoLNy68AlO7ykfeRBA91f2ZcbimymWge8t9BfjzMdxjd
         +D+7OGqlvRMti+k2kFiSbAFB65rseLlHyuvTnb4JOIxe9mZm3kTdAQ9PhIzbFsLilTgp
         WiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iMYADahNRMz+BK4j5B8SILP6qEihete8xrXHT4Brv0=;
        b=0ghvqgYn4MjrOvPXH89e4Q1pKsXmN/Der4BOqds1pGG/boaucGesy+U5saaCAxDpYc
         FNslS0PuWWyOVg1feWtZOCYFtN3WmAL9LFb3Uw8GZaN0ifCrqMZubb6mQHzBX70aPiyA
         k9ezx41N+vEQ2IzZ8Gb4a/gMXebW4ykaaqmzNb6uwqkh51TB0Hr+aic/dHbe6KnafL+Y
         FRl9AKfOU/njTi2zDkZOV+PfIkuJ/AxloF2dhdWOTnsCWafnzjhqNmvRSwHiH8C7nPyB
         G9xUdBXJBVhee+IMFsDSTmADu8a/qsSBOUoxBGFPTWKihA52LmrRlwDGtuoKHOGh9si3
         OU4g==
X-Gm-Message-State: ACrzQf1uEIG2H7AYzvT+VJE3L0kTG8iNW4KJ3HzkzZCfTkwpoNVgUNJA
        qB8HMZ0B/zS8Wcqs2X+PmOg=
X-Google-Smtp-Source: AMsMyM64e7N9vTQ5GbK5YX1rMTTB5vqC7LBO/O1eNCnZMS0ROu8+Iq5wX2DGxCdymlXos2qcgRXN3g==
X-Received: by 2002:a1c:7418:0:b0:3cf:703a:4f0c with SMTP id p24-20020a1c7418000000b003cf703a4f0cmr36462474wmc.63.1668030698735;
        Wed, 09 Nov 2022 13:51:38 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:51:38 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Osama Muhammad s <osmtendev@gmail.com>
Subject: [PATCH 00/15] Accessiblity: speakup: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:50:53 +0500
Message-Id: <20221109215108.7933-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This patch series is an enhancement which allows to specify the default driver
parameters among the module parameters.

Adding default variables to the speakup modules
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7


Osama Muhammad (15):
  Accessiblity: speakup_soft: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_apollo: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_audptr: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_bns: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_decext: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_decpc: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_dtlk: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_dtlk: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_dummy: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_keypc: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_dtlk: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_spkout: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_txprt: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_acntpc: specifying the default driver parameters
    among the module params
  Accessiblity: speakup_acntsa: specifying the default driver parameters
    among the module params

 .../accessibility/speakup/speakup_acntpc.c    | 38 +++++++++---
 .../accessibility/speakup/speakup_acntsa.c    | 37 +++++++++---
 .../accessibility/speakup/speakup_apollo.c    | 46 ++++++++++++---
 .../accessibility/speakup/speakup_audptr.c    | 42 ++++++++++---
 drivers/accessibility/speakup/speakup_bns.c   | 36 ++++++++---
 .../accessibility/speakup/speakup_decext.c    | 44 ++++++++++----
 drivers/accessibility/speakup/speakup_decpc.c | 48 +++++++++++----
 .../accessibility/speakup/speakup_dectlk.c    | 45 ++++++++++----
 drivers/accessibility/speakup/speakup_dtlk.c  | 50 ++++++++++++----
 drivers/accessibility/speakup/speakup_dummy.c | 53 +++++++++++++----
 drivers/accessibility/speakup/speakup_keypc.c | 29 +++++++--
 drivers/accessibility/speakup/speakup_ltlk.c  | 53 +++++++++++++----
 drivers/accessibility/speakup/speakup_soft.c  | 59 ++++++++++++++-----
 .../accessibility/speakup/speakup_spkout.c    | 43 +++++++++++---
 drivers/accessibility/speakup/speakup_txprt.c | 45 +++++++++++---
 15 files changed, 524 insertions(+), 144 deletions(-)

-- 
2.25.1

