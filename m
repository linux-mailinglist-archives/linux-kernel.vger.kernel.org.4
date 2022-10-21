Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D137607503
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJUKdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUKdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:33:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6582D25DAD5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:33:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id be13so4353143lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgAh3eOsehBHDRMN9LqNbEShmB7iObrHTkO9H5vd/vA=;
        b=kyo0932RUqFoS76pXGEb6enHdCW8tgABYyWI+add2taDA+ePymUB7IKoMR2iX68ai5
         Fn7wR1QcXLDfp+6hJ+iWUh8upP44qRHzChr+H/zjhUcvaDKtDmo7kB8zmTHbhlxYLd0e
         EJFHMZD25S7PHb9CF78GiK2abCsF+uqZM99Ytk6uMhKBvyG1btiMsr2rmErrI3oHAw+S
         d1TGNOU0D4bEaBIf+FRWcFRqGsetOH36xDK96Ru6J3C0IXzz82spi9ZtQVHAaSUgtwU7
         G0xagF0T+RRtY4WRijQ5L+75Wf51owiadfMWfjwgycuxTG16PZ4l2TCektxrRc6VdYcQ
         gELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgAh3eOsehBHDRMN9LqNbEShmB7iObrHTkO9H5vd/vA=;
        b=qlXqXY4MG17uvJVAoQeP8vkE1ulnFu0sTFvaIFuxPMaFAkuuIo8m9zvBpSBNPVLbZt
         1AwY5fhnidlk20SjAQ+zPkmV8eIadZnOoSzsRDERnki5Ro5lkSTiv2fouAddzyqLfz8q
         G2u3NkWve3KB1M6AdJ192CyXZWfE/iqgodmpcFz1vOk40ZEIWSxF7Rg2gSfAxxgxXaZ4
         uWTuUtF1FcpwOwR+A8GU7TtguSNjypFwxo8Q2x92FRsZUSLnFqEEOdLFelWD3gARIsck
         voKS6NKMcLSAHalOVQzj+/34mkHxD64YspI8jtsF74kYWg5dQh+/SX9NfaaZbUY0y5t/
         8WCQ==
X-Gm-Message-State: ACrzQf2CgDZdHGDKMNhHQjTOenVESZVZiXCS6RccGuDmGIvfZYjPEGzX
        f0beXZ6LVdzCYkOEtadwBTciJkN7kczV0/1o
X-Google-Smtp-Source: AMsMyM5H5HQi404bwAYD4Pr2ZzoQ3xkfQaC4zGB+6uor/t8JI/PCmKWwFsXrOfd154GUyjofYZDqow==
X-Received: by 2002:a05:6512:1052:b0:4a2:7f09:4f1f with SMTP id c18-20020a056512105200b004a27f094f1fmr6723174lfb.59.1666348413568;
        Fri, 21 Oct 2022 03:33:33 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id u12-20020ac258cc000000b00492d7a7b4e3sm3119775lfo.4.2022.10.21.03.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 03:33:33 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v2 0/6] a series of checkpatch fixes on the file: rxtx.c
Date:   Fri, 21 Oct 2022 10:33:04 +0000
Message-Id: <cover.1666347511.git.tanjubrunostar0@gmail.com>
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

