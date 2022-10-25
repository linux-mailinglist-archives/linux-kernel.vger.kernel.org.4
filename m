Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2076D60D7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiJYXhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiJYXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:37:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CDFB726
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bn35so10730191ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27VAIO94eRQO+RwOuEpnXhEC4l04Hlzg1oSuTTKX2ZY=;
        b=HXU+5uf9Cfca3x4Xl+h10Vwznw+kQ8kv0pgPkWjQV9jPXeYoLKHWA8ro1kiyqSXs5U
         7XVX4X/VXyUpZ9CqZsJZFe0JJcNh4sGGVNgCEOrcuqlXBpc3Sr1tBJsXN2IaRZqri9gy
         nGpvXW1g3AIIvcG4DXyJa6dT1kByeVTPHuDgq/tCkzrdYYimiIhxMwCyxaqsrpM8laLe
         kB7jgAthV9KQJucQB/UZmmNi3NgQnLnP7clY3K02mUaLOM5KKyKy4f0PPAm8JucV4G2O
         id/F1zntnXiS3Off+OMm75+ATLjBZLU0kutrnSqf+4FpyWxImLr7D0UYDaAoAQuL9xHz
         VpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27VAIO94eRQO+RwOuEpnXhEC4l04Hlzg1oSuTTKX2ZY=;
        b=nChsXo3LyN3TEAt4gxumzJFEeEy3Ks0d7YaZDwZ/qHog9KZbz1YE0iQSW26sU006b3
         E7UXyfdGohQUUVuSTnwWdjTfqGDkCmvEUeQCTMRRFUVmgBREKXjWggaM5T5pz2KrY4pp
         EDOBvrdW6Z/j8r2DFOjXwhdl7vMSrZaM5lp23aWUByLjrmqBJF7YlM9YNseuh/Y5Lg2f
         kQZ7aM16Ol2kI3UasS3kJ48GOxIqwIW2ZQE3HDNlbjpRRTH/etB9I6MeqLLQWUFif9+F
         X0lJJBl6FCTmCiVNHt4gorBm6GN7m256m6rFCtOJTSw9UkvyOKR+vc2Y5NYRJwa+IFnh
         3wfQ==
X-Gm-Message-State: ACrzQf2lGJSVjeN+FDRnjbC1Yu9+AEbahIbBrRKNKcJ/gMiUk+dp5A8b
        R7CKHFmFmC3vNI8fZyeXcRw=
X-Google-Smtp-Source: AMsMyM7aJBJclSLMtrGeBVGgE907guL4x24jScSExKWC8uCn/BsicsRuqJcKCzSQBjS5TzKykof/Pg==
X-Received: by 2002:a2e:9897:0:b0:277:fcb:f69e with SMTP id b23-20020a2e9897000000b002770fcbf69emr4262609ljj.48.1666741052865;
        Tue, 25 Oct 2022 16:37:32 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:32 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 00/17] staging: vt6655: a series of checkpatch fixes on the file: rxtx.c
Date:   Tue, 25 Oct 2022 23:36:56 +0000
Message-Id: <cover.1666740522.git.tanjubrunostar0@gmail.com>
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

The fixes are similar, mostly changing variable and functions names to
match the linux naming style. I had to make
serveral patches to ease the work of inspectors

Tanjuate Brunostar (17):
  staging: vt6655: changed variable names: wFB_Opt0
  staging: vt6655: changed variable names: s_vFillRTSHead
  staging: vt6655: changed variable name: pDevice
  staging: vt6655: changed variable name: byPktType
  staging: vt6655: changed variable name: pvRTS
  staging: vt6655: changed variable name: cbFrameLength
  staging: vt6655: changed variable name: b_need_ack
  staging: vt6655: changed variable name: bDisCRC
  staging: vt6655: changed variable name: byFBOption
  staging: vt6655: changed variable name: s_vGenerateTxParameter
  staging: vt6655: changed variable name: pvRrvTime
  staging: vt6655: changed variable name: cbFrameSize
  staging: vt6655: changed variable name: bNeedACK
  staging: vt6655: changed variable name: uDMAIdx
  staging: vt6655: changed variable name: psEthHeader
  staging: vt6655: changed variable name: s_cbFillTxBufHead
  staging: vt6655: changed variable name: pbyTxBufferAddr

 drivers/staging/vt6655/rxtx.c | 1062 +++++++++++++++++----------------
 1 file changed, 536 insertions(+), 526 deletions(-)

-- 
2.34.1

