Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC54634808
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiKVUXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiKVUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:22:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B98310575
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e11so13575096wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8i8Ipy6e9EKnirhuKed8s+GaNFjxjeq0jc/RxwiVws=;
        b=cRYWlRsrLr0AK/raSDdYZUhJdK+ib6bobYo0SjYJDCQPbu34yWBSBniQwZv6ZGPBUd
         IJwgkxOQmhwNSutx8Ffie1dCi7lrC4OvmX3uNbgz2d0ak72v8loRwaqNQvTMONL1xdzq
         BpdLu+9L+F0FNRnmP+qP4YNRYefxkD+EFlkHBxtXt3I+yzbS/kfktXH5KpldQQ1Xk7lk
         bURKNYzKH8F5o1X5YzinanXLgZYdrVavgngcqvc85162kBE+r7ly37dq6SQEmTWKRwAV
         liYIIdv5WWf0WbbTXaS0HRCjQ35X+154NijX7nmlYGFahtFi3FRyRya4FxGdo+CHNcuP
         Lalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8i8Ipy6e9EKnirhuKed8s+GaNFjxjeq0jc/RxwiVws=;
        b=YFbg73ZhjOsOM/tZzmdfI7vlWSRsdbs8geZpf0sL2TGgNdSW1nDmRbkVLT0UXsAqCC
         swxOlqof786C79WlMwVbLkup3uyaKjQu2SXGcp+qNahAFhD4ORqFsJJM9/bfOkmbmEQX
         xFTQsrHKNQTvsOkOcNrJwW7T/JbnFfImYaEMnjTi1E5pnAS5Q9/+rKq5mXey9CweNcwX
         M0uTMs+MBOVbIVKoho/f+UMRkbBum+SuJ7imCSq4C8Tj6ji7KUO6Bj8zf+g8HdVNm0ek
         S/tH4MJsKbjxbkMmJWC2WoITdBTqtl4AGk+SmFR+vrmshaG5rgx0ADuWQOOG+DoEIdSC
         4unA==
X-Gm-Message-State: ANoB5pm1/kL4w9UURwq40EBgR4kIXVt4eYV47aJm5Q7k4Bp0iMrpPKln
        quTRnGBOZSEujPGRUJJiPsblBw==
X-Google-Smtp-Source: AA0mqf768lJWDWWCUzyPm+qh8nliolOQq9GX56oOXkr+y+1mrRH2cwGoFElfLTHxX0mlHfaQYGjxyw==
X-Received: by 2002:adf:ee84:0:b0:241:e3b9:388a with SMTP id b4-20020adfee84000000b00241e3b9388amr2813920wro.252.1669148572717;
        Tue, 22 Nov 2022 12:22:52 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:53ef:17fc:fb98:916b])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm25718555wmg.46.2022.11.22.12.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:22:52 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH 0/3] arm64: arch_k3: Removed ti mailbox and sci select
Date:   Tue, 22 Nov 2022 21:22:42 +0100
Message-Id: <20221122202245.449198-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the automatic selection of the TI message manager and the
TI sci protocol drivers from ARCH_K3 to allow module build support.
Set these 2 drivers as ARCH_K3 for the default selection.
Tested on a TI AM62x SK board.

Nicolas Frayer (3):
  arm64: arch_k3: Removed ti mailbox and sci select
  mailbox: config: ti-msgmgr: Default set to ARCH_K3 for TI msg manager
  firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci driver

 arch/arm64/Kconfig.platforms | 2 --
 drivers/firmware/Kconfig     | 1 +
 drivers/mailbox/Kconfig      | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

