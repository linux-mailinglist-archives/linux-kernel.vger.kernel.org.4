Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2925FA3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJJTEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJJTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:04:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB36B86E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id fn10-20020a05600c688a00b003c6c44a1c8eso707wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVJWb8LinkHQCCL3OEMPLofWcYqIXePWNOhHjmWLRqw=;
        b=NMOPm+dvHYdIom1uWR30BlxD5xKPHp+URKzsDbLi0b+cd/lseiSgTFgRpP7zG0zIDX
         rqhvGSWQinjGCDQ60/8+cVoKDU0B+jQ+n10ooZje+bwF627Ef/BLTifB2cyPprhw509u
         gFbVaQUzn3Rx17DhEFfmzqJW81hhC6Dsa3wd2mtn+5sxErs88gauW2G25Up2sOntAbPc
         cpai/fnXxEbVc45g9Iub4XciRpc71VYMXKgEG7164rDXHS7yS/7pK7YwmAkrMW9dSDEt
         RQJwZBbrquL0U0/c/o6hSegJpe+hbQyr4tFfB5rDANJKSf9vbf3cI68e7RT5Q2YwNXVk
         Mv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVJWb8LinkHQCCL3OEMPLofWcYqIXePWNOhHjmWLRqw=;
        b=O9sB+2lz32WZbKM1l1tTxic8URi8pPcKp5QtE9Rv7cQfgHz3tsvCL0r+x8xiVvhE5H
         nvmgv90rBGmjnguPBh/8kuRIeE2CFA92RU7+xKTuJsMn6xdoRi7CLVBhvodxatPrLsb3
         Grozx2Y1pKLN5qDIoyJAdP57yJFrNI+wcuIhwaUjRmI9nOw+QSgZuy9W73CZN5mAv2Qk
         wH+GkV0gPqsMizBOtoUcyAjijm4O1b9btVQAs9zd4YyLwOFEBRfEb7P1VkptL+6xt7Yi
         vD93ewQTc7e/++Z9UD8nkNIq48EsHHAXVO5iaL/bgBjTq3B/wgrlf06tP4j0vUHcFI0W
         1xHw==
X-Gm-Message-State: ACrzQf1C7ZORT69qOQkYA1Tz0JJmEl1UowOziLPiRofCC3FFXU+zrBAV
        VEw605SRdPUwiGs3kj/qAQ4=
X-Google-Smtp-Source: AMsMyM79HAzMq1nShbl86qRMhpja4H1oxvkb1fEOsl/iKIKOjZoCR3cLtws2+rMNHRdT/SA/XfftRA==
X-Received: by 2002:a05:600c:6885:b0:3c4:de24:638 with SMTP id fn5-20020a05600c688500b003c4de240638mr8616264wmb.183.1665428683164;
        Mon, 10 Oct 2022 12:04:43 -0700 (PDT)
Received: from localhost.localdomain ([176.61.123.135])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003b3365b38f9sm10753380wms.10.2022.10.10.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:04:42 -0700 (PDT)
From:   Dragan Cvetic <dragan.m.cvetic@gmail.com>
To:     philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.m.cvetic@gmail.com>
Subject: [PATCH 0/3] staging: r8192e: Rename macro defined in rtl_dm.h
Date:   Mon, 10 Oct 2022 20:04:36 +0100
Message-Id: <20221010190439.13131-1-dragan.m.cvetic@gmail.com>
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

Rename macro definitions to avoid CamelCase which is not accepted by
checkpatch.

No test performed on HW, just build.

Dragan Cvetic (3):
  staging: rtl8192e: Rename RateAdapt..., RxPath...TH_low, RxPath..._TH
  staging: rtl8192e: Rename RateAdap...20M, RateAdap...40M, VeryLowRSSI
  staging: rtl8192e: Rename WAIotTHVal, RegC38_TH

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 14 ++++++------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 22 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    | 16 +++++++-------
 3 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.25.1

