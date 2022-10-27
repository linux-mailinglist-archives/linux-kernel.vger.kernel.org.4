Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B560F30B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiJ0I7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiJ0I7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:59:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87CEE37
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:59:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o12so1400293lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=enich8yCz31jib5vDHT9by/WtYR4B4iKdU6w4TTVNlj49RLa8wr/6n3Pjn7SUjk0oo
         IVT6UtzWHHOl/kT+zmyYgftGd4nCa9G5XxjodwnRsoaRxQm5OT02MA+YxsxO+00x7kqa
         cRwV5noqPv0o3KF6pH/avpDQrVdbCyzjYsIUL+/gVbqOthl1YT/Aj4UIsmbhshfngltc
         O98j77Kfo65lHchFeAeo/cMmt3HuLmo0EmsKa6CX1TRZnBhpTVSoT7kdK/2Vh9LPwHQ2
         5x+l6ymRVyrMiyEri8OX1/I0M/4ZxyZVSTPwUaLFV87Ba+bqbmvbX1Z6ZCUQKjzYgWiI
         pdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=BimepfUQIKNj6UJDTWClPV8GrBh5soxY5qyKCB/cO4Ahi6tLVoUUhA1flNBUZ0WxFe
         0CoI7uzX9coB3OWgio8I0hBfSBAbmskalG0hkeeSNRJQ8UZk8HtsMNGfXQDJ2WMpzZU8
         LHv4sQ0spVKJ6TmVRflC2LYMAoME+ssj8ojJ4xfzlfCzQs1B9pizGpPsPuFtXuGaDrRk
         5QWJPenuXYdHJjkePTYjRDpdJ3Pln9q43v0C0YqORvaQEjl87ix/rreOHVgsKibm4JbH
         wR9Apywd5ODtfy6ajCL8DYOuLCip5367DrBkkMPO/tstiXpGhqsElwvPQOj/uZWlkHaS
         GVqg==
X-Gm-Message-State: ACrzQf1mQ/Xt/vwuVFwjsQbcOXA3+KYOF9K6T2HQoxmMBz4IVLX1KsDz
        tugrUN4ylw5GedlEu/BOnHjYBjnMRPztqA==
X-Google-Smtp-Source: AMsMyM5zyPFvWw0yWMbDDHUcS6QNUOYuNPKchL/VrnkY4IrnMTJnHGz7Sv3s30wQDPGNxBcBqfX4gg==
X-Received: by 2002:ac2:4839:0:b0:4a4:4f4c:116 with SMTP id 25-20020ac24839000000b004a44f4c0116mr18204807lft.51.1666861169593;
        Thu, 27 Oct 2022 01:59:29 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id m3-20020a056512114300b004a050ddc4ecsm109892lfg.125.2022.10.27.01.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 01:59:29 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v5 0/6] staging: vt6655: a series of checkpatch fixes on the file: rxtx.c
Date:   Thu, 27 Oct 2022 08:59:02 +0000
Message-Id: <cover.1666849707.git.tanjubrunostar0@gmail.com>
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

v2: fixed a compilation error found by the kernel test robot and
recompiled the code

v3: tends out the error persisted in the second version. this version is
a correction of that

v4: did some corrections as recommended by Greg KH

v5: shortend changelog comments as recommended by Greg KH

Tanjuate Brunostar (6):
  staging: vt6655: fix lines ending in a '('
  staging: vt6655: refactor code in s_uGetRTSCTSDuration
  staging: vt6655: refactor code in s_uFillDataHead
  staging: vt6655: refactor code in s_vGenerateTxParamete
  staging: vt6655: refactor code in the rest of the file
  staging: vt6655: refactor code to avoid a line ending in '('

 drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
 1 file changed, 324 insertions(+), 218 deletions(-)

-- 
2.34.1

