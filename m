Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B0268AC68
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjBDVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:02:03 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9C206AE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:02:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n13so8553453plf.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB/Qps2n5FU8gGN0b/9Pv86YkLdPOFzR3ElFkAw9ORM=;
        b=atChneryxz9wx+iwqKLunyY0KcIBDHI7/1z66hyPf0P7ZV0LY5DTPGJZFTuBhqmqJy
         TWzH6IvVwDdmq/10vk82Stlpqv0nO/8jLzJF/sgkLWN8BLol2rd5BSVmzD8nUZO6BUg1
         DbjpfdQjbs8LzpZfuA4AtTntIbo42Tw3eAtbgeF8cdF11CbJj8BpI2LC7BlrDtikkDb8
         9LvGLdsGqrHOvWv0XgSX/rRXIcg4lbwO63IjufwT2TthzNBXev7Ir3RY9F7Xd1PdO0wU
         BfGgl0gZwx0ACjJng4MkJIimZDiGVhdSfR5nFTfqNZ8lrRXCVIrkjcVOFi9o9YyewpCB
         av7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hB/Qps2n5FU8gGN0b/9Pv86YkLdPOFzR3ElFkAw9ORM=;
        b=3GZvvAtRA58bcGug7YVD54K3kq11VTbY00zjiQTCXwrwvqyD/mjJxJchYaGnJSYswe
         H626M3MzDQXdrVXmosS/kvCHZx4+MLsQmv+ArnudoOubRQRjzU5C1vBRJxJWNzhTLJOg
         M3sUB/kAUCmU3r0tm/sEpkcctYhopEli54T2pCeaBR3RoEwfUXQ7mW2rysFmbD3DNoL4
         qGCwEB1ERMnuAJALkVphzovHvQ46oExp/gLT3S6gB5vOV1WUZ4zNnTGxkWSGN5M+r9mD
         3s3gSbRYgjngAJi/hT7z11/o0aEmMZQ096wPLmziN5ci6IV3FsvbNvVlRPpJO5Lpo4uq
         2qEw==
X-Gm-Message-State: AO0yUKVOSvsbxEuZ95JWgz992iSQWUB/NYovRzdYHDwxMOD+4F6ZNjYC
        Lj/OSBaIovr2AoDMepNBEqSXImFYXBjVZCB5
X-Google-Smtp-Source: AK7set8x0p/1l1J51gXmKbQOso8ElQ9NZOWpp7DtCrK0HX3tD1Dih79HplrtTGDQEq4hU6v5zQ2Fyw==
X-Received: by 2002:a17:902:c702:b0:196:64bf:ed86 with SMTP id p2-20020a170902c70200b0019664bfed86mr11994768plp.62.1675544522155;
        Sat, 04 Feb 2023 13:02:02 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709027ec100b001960cccc318sm3849534plb.121.2023.02.04.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 13:02:01 -0800 (PST)
Message-Id: <cover.1675497326.git.daniel.beer@igorinstitute.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Sat, 4 Feb 2023 20:55:26 +1300
Subject: [PATCH v3 0/2] Two bug fixes for tas5805m codec driver
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Andy Liu <andy-liu@ti.com>, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of patches fixes two issues which crept in while revising the
original submission, at a time when I no longer had access to test
hardware.

The fixes here have been tested and verified on hardware.

Changes v2 -> v3:
  - Resubmit with cover letter

Changes v1 -> v2:
  - Fix issue reported by kernel test robot

Daniel Beer (2):
  ASoC: tas5805m: rework to avoid scheduling while atomic.
  ASoC: tas5805m: add missing page switch.

 sound/soc/codecs/tas5805m.c | 131 +++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 41 deletions(-)

-- 
2.38.1

