Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5FB60682D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJTS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJTS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:29:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6341F524D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:29:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so806166lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHd+kYLnoLMJzlOa1AvEPHWMtdmlV4v96O1iU59rB/c=;
        b=DWaZ5n5r8nydxNOwYj7Jql9+EIXp7oN5RyS4aij28gWGCF6RR++CLg5SCQa4ESjBgA
         5ASUHZP2s1mw+XyKpZyRva4VmBYaBj6DMCeNOz4ty3lAKzVMHUIVWaAz4KTAk1VLo7YF
         6ZCdRR492NP6NnOBWtoGdtJ6mapakc0i0oGH7Tfic9LnzO5itOkeZfvtyVA9X+1NelbV
         ThnPHc3DmrRarLK6y+WgXxvlarvxc4Pj3WjrjaaNlz4a0bD6N2X+q+DqAubBOd8WxmNP
         BbG10e4lbwXP/wESBHmHAxw7hxssCO+I/4rPjW5CRS/Fuwk4jrhDK+zt4ss7OP3enR3L
         lfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHd+kYLnoLMJzlOa1AvEPHWMtdmlV4v96O1iU59rB/c=;
        b=Em/6tV9kuIbAfw8OLWST5IjJXRyqkQymhfdpz/oQdAlnQaDjKLKnMEOZpWiK3ce6k8
         f5II6vq74GAov6cOthr+aeDf+lRAR7mnjcOKVc3Zm8W5CFMePQ3QBYUUSak9tRMX1QdZ
         BSxFkEJ6g+90fj7PLdpuzqi1fWpcLw2FF/lPjn48A0kPtA2VjNsFF8wQnBMZ3oMfP/Cx
         unnAnQorLgDW/Iu7pqw7z2JEG6dsUtCDdzOSrTaIsjOM5lGIfO0TMcsnB2C4shY5PWDi
         BFYqklIKjrvbMqzsvLQkddn6mJ5VRrX1uq5FHJ5QkbheIiTNL82rVfr9g5A1vbzaW5q0
         kkLg==
X-Gm-Message-State: ACrzQf3BTGcQeTbnESrM0IktKLFy2uuKs7MplPtTBziOr/I0uaKqKrAR
        4/6XphyFnjZShCXtWHcYaSQ=
X-Google-Smtp-Source: AMsMyM59Yxx2meIfYZZoCi1MLGHaQ6LwrOUpGqkLQYvkxwRTITkmm4zOQz5sHwoH14WpHWy81F8UAg==
X-Received: by 2002:a05:6512:22c3:b0:4a2:7cd9:1f1f with SMTP id g3-20020a05651222c300b004a27cd91f1fmr5076718lfu.582.1666290546767;
        Thu, 20 Oct 2022 11:29:06 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id h10-20020a0565123c8a00b00497a3e11608sm2797216lfv.303.2022.10.20.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:29:06 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     forest@alittletooquiet.net
Cc:     greg@kroah.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 0/6] staging: vt6655: a series of checkpatch fixes on
Date:   Thu, 20 Oct 2022 18:27:40 +0000
Message-Id: <cover.1666288416.git.tanjubrunostar0@gmail.com>
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

The fixes are similar, mostly long lines splitting. I had to make
serveral patches to ease the work of inspectors

Tanjuate Brunostar (6):
  staging: vt6655: fix lines ending in a '('
  staging: vt6655: refactor long lines of code in s_uGetRTSCTSDuration
  staging: vt6655: refactor long lines of code in s_uFillDataHead
  staging: vt6655: refactor long lines of code in s_vGenerateTxParameter
  staging: vt6655: refactor long lines of code in the rest of the file
  staging: vt6655: refactor code to avoid a line ending in '('

 drivers/staging/vt6655/rxtx.c | 535 ++++++++++++++++++++--------------
 1 file changed, 323 insertions(+), 212 deletions(-)

-- 
2.34.1

