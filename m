Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B572C926
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjFLPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbjFLPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:01:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB718CC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:01:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d6aa3758so814067166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582061; x=1689174061;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrjIaSswtTyEY7Z8qdbgtXftw/wW1klcn/CpxmtkX3c=;
        b=MoV2QEdO3zATE97Mvg8ltny6qdqArDowpHJ8EY5BBTGq7VSxNV6B3GamkBWpiZS+8t
         stSc29yAUb4awRgsYYXV7YSTR9hZCQD9ak5fZVowQfL1PPN/nzvARWjoQBLbcSqAS6LG
         67fANOGUc/tNyL1WvzgzdIxUewkgq8pDTwkQagZ06TTqPTUQeLLTEbgI3I5hZlipXo42
         3yziw4GhShnQ6Lg/Cv/jlwjurvWNKnQgJhKXqym7acLF+NVH4fhZ7vSJ9nkhFjRdoRtY
         aj/DHXiXC0YDv7IPBdRpIWqujinu9a/yU4SzLooRU+h6TXBi8fqoC9fB53TWBjwSlXYJ
         zgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582061; x=1689174061;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mrjIaSswtTyEY7Z8qdbgtXftw/wW1klcn/CpxmtkX3c=;
        b=Cml8HKppPhfGRHi9pHXOdZhrB6sv/7nhwxACKnP+d3bU26PvVz2q7inuDhoZsqCVcg
         0AIifbeZcHCvIl8e1RGm6LuwBzNnccxl6y5MB8f1HJIA3SizOUomEdj7zyLJLSXbxV1U
         hcwVdMtgQZCqL2c96IemcYilqYyQojD+v2mtVczXkG/7DIRz2Lj/8a6CBM8M5zmTgL/9
         yt9hIc0TQOd/+GrtrMHjWtb7MwbdplxEEtmS3hXLCUVdmQ+fB+tfxSLPxhxHaKrqXxd7
         B5lP04GSjGLSVBg5zFCDttK6aCpGU1tEUW69r72VZHgOZnee8eadOE9UOYDuNjbXzVYp
         Tibw==
X-Gm-Message-State: AC+VfDxNbbAHKEZYPmpf39Rt/PcE69jAPeHUXicwA5knzP/1FzzK1zQw
        aJjM6aMQv3rVJeHGrxbfUxs=
X-Google-Smtp-Source: ACHHUZ5blwfhznY7HEehsUI5LMmuOJwU7N2BdDI1xQ2Y0yJXTUUc4FAlxBZNIkv7qM1VODcBabS/9w==
X-Received: by 2002:a17:906:730b:b0:973:bcf6:1d4 with SMTP id di11-20020a170906730b00b00973bcf601d4mr11632209ejc.76.1686582060941;
        Mon, 12 Jun 2023 08:01:00 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709061ec300b00973f1cd586fsm5420857ejj.1.2023.06.12.08.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:01:00 -0700 (PDT)
Message-ID: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
Date:   Mon, 12 Jun 2023 17:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/5] Fixes for Rockchip NAND controller driver
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie contains various fixes for the Rockchip NAND controller
driver that showed up while testing boot block writing.

Fixed are:
  Always copy hwecc PA data to/from oob_poi buffer in order to be able
  to read/write the various boot block layouts.
  Add option to safely probe the driver on a NAND with unknown data layout.
  Fix default timing.
  Fix oobfree layout.
  Add missing chip ID.

Changed V2:
  Add tag
  Add manufacturer ops
  Reword

Johan Jonker (4):
  mtd: nand: raw: rockchip-nand-controller: copy hwecc PA data to
    oob_poi buffer
  mtd: nand: raw: rockchip-nand-controller: add skipbbt option
  mtd: nand: raw: rockchip-nand-controller: fix oobfree offset and
    description
  mtd: nand: raw: add basic sandisk manufacturer ops

Paweł Jarosz (1):
  mtd: nand: add support for the Sandisk SDTNQGAMA chip

 drivers/mtd/nand/raw/Makefile                 |  1 +
 drivers/mtd/nand/raw/internals.h              |  1 +
 drivers/mtd/nand/raw/nand_ids.c               |  5 +-
 drivers/mtd/nand/raw/nand_sandisk.c           | 26 ++++++++++
 .../mtd/nand/raw/rockchip-nand-controller.c   | 52 ++++++++++++-------
 5 files changed, 64 insertions(+), 21 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/nand_sandisk.c

--
2.30.2

