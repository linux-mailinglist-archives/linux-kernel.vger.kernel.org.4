Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3663961233E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJ2NRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2NRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:17:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD26CF78;
        Sat, 29 Oct 2022 06:17:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j12so7121973plj.5;
        Sat, 29 Oct 2022 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g04ee0HphqFzosV+F5fBEaDnPcHUqbW/sFQYscbMOo4=;
        b=cgjMdG6MEsmiqYblD4knpeZR/WA3RkYTWzA7AZuTLM/1bOmwJAn/4Bzgb7rm6RNsuR
         vMdnkyJzaYNx2kKfl95AUU5WTPnYpfCY9hdQmCYTs93xAAW/iEhl5VxK2lrIR12+gAwT
         tfJ2304w8mNsFgXornNBYpnIh/KGGmuOtnaT8zr7kLJCg/OpKBaQLHRlIwqINFK9l2gx
         WbpzXGAn7/ozG6p7ROylpIyIBaDBACWtqU7+ykeHLeDyGpf1quelHGtcUd0VSBTouoME
         hAVcjj9FYy8TMddZb0wclFOUoEAYgAkHBI0sWYYs4rVVFWaTMMkNrfGyXnIwL5Xt8W+t
         VpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g04ee0HphqFzosV+F5fBEaDnPcHUqbW/sFQYscbMOo4=;
        b=XfRIRD6uacK7AsbRxs1Muk/q9c2vOKavTaW9Xl7S8FS2pnne8rHHQ4oGSaG5wuoW8T
         aNSA/Vkv24nWHajggjPV217hdaOOKoQbWuo4Tx6crzdS4MRMtZIV4EkC4EEDsE+nVMes
         1LXuilbX3IU7SW0oWmhxHC2JWIjhYqkg/rVNtBMW2rnev0CXyc2u6xKtay9VxF/cD6Up
         TsJ5sGzXTFdTtNdjjoN0kbWt1canhwAlNW55BtyCpuSrDLnhYbYCNV+uBXH/C1/A42nB
         3XEhUyfb2aK9k/ZHKZ1NJ/OyG78eT9QD9vKNNYxPuW695kkYTk4sH5Q5d9OlPQnRzBPi
         HsOA==
X-Gm-Message-State: ACrzQf0FNKQ6+TBSfsF4db+riLPehMW2HanCFnMhxc1zp+ZuW/9l1Rlx
        hi9mFnY4sj8PLefniZ7c6MIwk5yx1guvr1o5
X-Google-Smtp-Source: AMsMyM5DIMyXNXq1ow1WUNMOi0Iji1S7puxZbqMnPiVIoB03+5PyO5G18hiaPkxSIHGUTZ9ErKeGcA==
X-Received: by 2002:a17:90a:fa42:b0:212:f0d3:2ff4 with SMTP id dt2-20020a17090afa4200b00212f0d32ff4mr4755504pjb.104.1667049463128;
        Sat, 29 Oct 2022 06:17:43 -0700 (PDT)
Received: from debian.. (subs03-180-214-233-19.three.co.id. [180.214.233.19])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b005622f99579esm1187439pfh.160.2022.10.29.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 06:17:42 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] MAINTAINERS: drop few inactive maintainers
Date:   Sat, 29 Oct 2022 20:17:32 +0700
Message-Id: <20221029131734.616829-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=548; i=bagasdotme@gmail.com; h=from:subject; bh=8iIY2mtCrdFuMDanbYZmMfsW1yeqkwuHLgNWhJMIF80=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmx6i++6LRMlF9zTCPyzvX8NufbIZEzRbOfBzvf1TJcukzn +6aIjlIWBjEOBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExkaw7D/xSnwEf/vrNVrWyo/WcQun wa98al+yIP6/o2xvqaz3OfZsbwT5G9muGm17oHFy2WXDQKOGsZYJ2uU2wrPO38USGhXc3JTAA=
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

As soon as I sent review replies in recent days, I noticed that my
emails to few maintainers bounced. I discovered that they weren't active
anymore, so let's drop them from MAINTAINERS so that people won't send
emails to them and get bounced.

Bagas Sanjaya (2):
  MAINTAINERS: remove Thomas Sailer
  MAINTAINERS: drop Liam Mark and Laura Abbott

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)


base-commit: fd8dab197cca2746e1fcd399a218eec5164726d4
-- 
An old man doll... just what I always wanted! - Clara

