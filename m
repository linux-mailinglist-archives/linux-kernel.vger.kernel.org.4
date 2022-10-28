Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131B4610A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJ1GfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJ1GfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:35:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ABB4E868
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:35:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j16so6694388lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=LGKirD4g4sEgrYlAgmBzFtanqc37blQX7pVANXmUEABnGRnY8Gnhu+snFNg0jtcOVA
         YaBIDYN6P3azAhOhFP2VFHhjH++1PB+BLGNftuxPleXdycA4aDS9YOLN+wChsscxxJZg
         1XaehjH+Yv1b3mAd5t6WkH4ESR7jAxsl/sa09FAuHpu+siIrk0paojW8++r4JVrNqFRP
         aJ0JnQadFy9vwd8QTTsYk+wBHMDzXzOTKqknORAPdgI0M1w6Y894G4VPoSlTzMORpha6
         eSyb3DkTxm6EE5lZtO56GyGv4uLxcIoZ1Iayal5BGHfuxU54yU9vYoaHb+Y7EwBeKXvB
         Js7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=kgd+DAGblpGqBVbbgmTM/ErgoKj/vw+qL9j/dXAAknp2Q2qs7Fck/y86NRbRT2qxXs
         V9nMiVkdvl3jlB3jx4g8tkYbimCztiUHpOUzwFzmJn6YgM4zCti09XNcIgQhk1BRhBeT
         suOoDm2+Ct1BBzjpNHazKibbpNj3ONwt7xOf45NKMgfmp1yYnmM6OwWdNPX/RF3+K5zM
         4ukxZ6IjIH4T0oiHUDrecV3QXu3Yp0x6O+ngc6GIt5vgA5VW0EZBUaGzms5vHIr+Yhoh
         d+fub2aC31JBg5TIag+XzPO/SBGylQzLKMW6NW7UdZLsrLzgmt21KkqJr1jU92gyYGYX
         KpvA==
X-Gm-Message-State: ACrzQf1o28ixQfuUAblrhoUYeQK3xO3CWKwYvaqvq2nEt93Qgn0iEyZg
        ODbUAZSlkf9L3WTcHh1V4vg=
X-Google-Smtp-Source: AMsMyM5ce5Dwx9A9W0LAtuDx5Y8cJ+Ijh5AUsBbrGsXPkOfIY1uAdZBBp/3xYcUPUMibJR8f9HbgFQ==
X-Received: by 2002:a05:6512:3049:b0:4a2:7daa:cca5 with SMTP id b9-20020a056512304900b004a27daacca5mr18575041lfb.44.1666938909326;
        Thu, 27 Oct 2022 23:35:09 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id y16-20020a199150000000b004aa8cae6889sm440210lfj.262.2022.10.27.23.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 23:35:08 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v5 0/6] staging: vt6655: a series of checkpatch fixes on the file: rxtx.c
Date:   Fri, 28 Oct 2022 06:34:59 +0000
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

