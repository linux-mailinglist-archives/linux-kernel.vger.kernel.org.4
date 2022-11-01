Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68E615162
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKASSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKASSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:18:00 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737015823
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:17:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h12so15364584ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19Xxsc9yxQk7AdY/KcLWGJoR0iY+GZN806fyiNbs/DQ=;
        b=qYgXgt0uWuPo0bMR3BYGYeXINK+f7aQU3fqeU9fMZiGuBOPp3VlJLPFP2yQod+17Gu
         zkOB4LQrKTTE2ZYaIjn9CDohWZ1/LtwzogE0CgJ6Kl7ZJLtSxDnsGMKrd83z/hwEpqQf
         VnhVZosM/EWl2w5fnO96frfoYySmGQ5An0fDAibmZxsSdY672Ka+tBB4DinVnA0NqZq1
         HyNCP4tCJfZbF/JB5m0BxmyGLsuj+fAjUk/rhT3nljRLk4y3e1YLkDBaOMdLlPA8RGBD
         dAZnGIG9/eb0fJ7N2feTHg7p32V5BgD6Bb1hVrznlOzuG+j0/s5LTjtX23fzHBF9LrAq
         C47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19Xxsc9yxQk7AdY/KcLWGJoR0iY+GZN806fyiNbs/DQ=;
        b=0qhI2MxJ8PIbmyX6UsmU7K1EGivllowvl7/35K2ZqcxsxO7uzJhwDS/co85YDFeZul
         YFMfcBAzD923Uihj+y4kdBkMaWkIwwKtqKoN/USNKGhkkrzxNOkKub8W6ZAd54eg7fvU
         YS/64AyzshZd6T9Z/ogIJ8LF7fQ/4nUqgqp05pgog9lfspWucwFT9v4tq9nI0C3/Azbk
         2jvf5dHFu0XyXu3ntmyX/tshVPGK1Hh3Jy62HQPnpjHF08EVIjf4SzH9tsARKAbA5vP+
         2LVwWCsWX66mcx2bNDpstc/8riaD7Mq/IT+7hJ8AEhL4YlKwyd73dBU56GPXCJfYFq1q
         Jx0w==
X-Gm-Message-State: ACrzQf3Jcb1sZMni3VLk9UVwF3Mh9cYBLRPmJN2Eg2ucPS9bREAr+bnK
        FALb+tEHrUr44qE56unXvfcZ1sNZKLhX5A==
X-Google-Smtp-Source: AMsMyM6LSPuRGyQoKi0EZ7AmX7s0fTDkbx/DgMxTG7eBZCESlkkWiVIWGIXv1jy1MwsYAEZdPMVQ5Q==
X-Received: by 2002:a2e:4802:0:b0:277:54e2:48b8 with SMTP id v2-20020a2e4802000000b0027754e248b8mr4905244lja.44.1667326677477;
        Tue, 01 Nov 2022 11:17:57 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id 190-20020a2e05c7000000b0026f9cb6d10fsm1850601ljf.45.2022.11.01.11.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:17:57 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v3 0/2] staging: vt6655: some checkpatch fixes in the file rxtx.c
Date:   Tue,  1 Nov 2022 18:17:47 +0000
Message-Id: <cover.1667326000.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes are focused on the function s_vFillRTSHead

v3: changed the function name from fill_rts_head to fill_rts_header as
head is conventionally used in lists

v2: changed confusing changelog messages

Tanjuate Brunostar (2):
  staging: vt6655: change the function name s_vFillRTSHead
  staging: vt6655: Join some lines of code to avoid code lines ending in
    (

 drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

-- 
2.34.1

