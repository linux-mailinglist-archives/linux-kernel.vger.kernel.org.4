Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E70611E18
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJ1XZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJ1XZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:25:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693D7238255
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:25:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p8so10581042lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObN85DLQdgZMO86MzqaZ/TqagrT3Q9Ju5tvegmgHI0I=;
        b=hGXCSOI43CSIV//bKpLKBDXd0TEwH9iARtXBHF08sb/OcR1WyJB5RnsRo3JwH932Ol
         FjRRT8JuQq3/QebUDKWrKdjbrawXXp2b/NwpqUu0z4oW4Wzkn5beSAZA0HU+KFv83alC
         14Y038mtq8XFwZZ1MmxTFGT2BIA9HEzx9g4cZ8RklCMsBBTuCq1F2o15fWB3w42G1Txz
         9UVMLE1FrdpItFBdWADGHQ51oaaAu3bLTRko3oWODBlhM8yfWIJbcSCi05VLFo+HEWGu
         sLhfnkP9pGUHFKqQE+30CbriZPTzTqHUL6gUT1zFufPp62BZpestSZ5eBSsNqokh4g4J
         OvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObN85DLQdgZMO86MzqaZ/TqagrT3Q9Ju5tvegmgHI0I=;
        b=8Lz9wXUw4eWpdWYuLFN3Dh6PnMLXexDLgRX2MsupmNIDgGgZYxoJ92nWMrz5GzFL7G
         jw2Kiag6nF1v+LPD/DK+kor+9FY1kZ20QdARmMo7c+Ojz3b2x76w4/D1UMagES87bxeP
         R0i5JALQuRZlf0ahRhElOX+tA/ie6HsYnSuqB0SMqHzc446mHnzGmk1JwXEngZsg2MYu
         FQL5vTJzWT6sXboIpYw/Zi4eeEZlDPyyCvCXqMjaC7f8YwOd2Pe4H6g+3BW7UNbhlUis
         sZtZ+MaTGZNoozb0G/QyqVdMRu+ISjbtfQu4EzyT10jOuq/ZqKEIoOAVp4ufLkqoJR17
         Hrww==
X-Gm-Message-State: ACrzQf3KBm0IqQhNzk/+rS/zozpgrzhSRdiOD1G2oaZepcmuwgAArGmN
        hHj5bYgeTRt5g+FjIyObJpU=
X-Google-Smtp-Source: AMsMyM4Cj8vBAkl20Tai+tm54e/GLpR4218t0++Xzv2afKKVlEFG0QkeeHHpUKDKGs+4qJxTybh1xw==
X-Received: by 2002:a05:6512:3a8e:b0:4a2:f42:148 with SMTP id q14-20020a0565123a8e00b004a20f420148mr589700lfu.343.1666999543760;
        Fri, 28 Oct 2022 16:25:43 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s2-20020a056512202200b0049aa20af00fsm7064lfs.21.2022.10.28.16.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:25:43 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v9 0/6] Checkpatch cleanup in rxtx.c
Date:   Fri, 28 Oct 2022 23:23:21 +0000
Message-Id: <cover.1666995639.git.tanjubrunostar0@gmail.com>
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

v9: reorganized the changelog messages on this patch

v8: made commit messages clearer, unsuccessfuly

v7: made log messages less confusing

v6: fixed some errors on commit messages

v5: shortend changelog comments

v4: made some changes on the code

v3: fixed compilation errors

v2: tried fixing compilation erros unsuccessfuly

Tanjuate Brunostar (6):
  staging: vt6655: fix lines of code ending in a '('
  staging: vt6655: split long lines of code in s_uGetRTSCTSDuration
  staging: vt6655: split long lines of code in s_uFillDataHead
  staging: vt6655: split long lines of code in s_vGenerateTxParamete
  staging: vt6655: split long lines of code in some functions
  staging: vt6655: fix lines of code ending in a '('

 drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
 1 file changed, 324 insertions(+), 218 deletions(-)

-- 
2.34.1

