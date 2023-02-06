Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC568B9AC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjBFKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBFKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:16:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F25A1;
        Mon,  6 Feb 2023 02:16:53 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mc11so32647246ejb.10;
        Mon, 06 Feb 2023 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj0iJ9zJndmf6HAIt6XGl1Fw/U6CT/Qa0nnBg5oFCNU=;
        b=hdQYMwAbQvxI1WGT//tDVozvUgpX5yddF8Wg6KFQdiqJa2pZAMGaDQsONpF/FIVTDy
         rUOUJdZdFVWxELBAc9qMJqere11Lp6K9wMvBEVpU3bVtmnRUEIWBzDjuW8XWvSOuH9CK
         mv7B6UxrA5g3OUn20mZ3Xg0B2xtwzowtwQec9kBlyWOx/8WZzSXb77geyRUVmoT5JTyW
         tR9jV2fLi/v+gnw1qEzXKmzT99LBanM7VXJbUUFVGhHxVF1e9vLZlcnza9NBzsSvlTCk
         0homvUbrEyHotUs+s24DaCCFEZcgfmM6oJWpzoNPSXvtj+9eAxbfNgyDLsQD7k+9Rc3B
         WvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zj0iJ9zJndmf6HAIt6XGl1Fw/U6CT/Qa0nnBg5oFCNU=;
        b=Ez1HjRrmrdki3fZOm1+OsANh+gsIPhXTsYzZ6dUNqSB9Gaalj9qkeNNGipfb8ct9PX
         3Kuy5tQQG18gHijWdVR9V8AC/DvUiLzfmwyE36pkgq/nG8Zi5WnKZNX61OaFh1W+PHlD
         GYezUwVPF6Dshox5ctSWXQ+VOpqAeqFLD5bEp9cffGfYm5mCSiLZDRzj9oztSLpBPTPG
         VXiYqvIlbMdBosfrrsh/1NGHBNkbdFZzDX7qetNUudnHULodnN8VntIWRlEQ2ur3UtwM
         Pau6F6YWtJQ3qVu02rR0bHVtgVvKzSynPjeb2PNG/rG3cTIxtad8mE5zT7A2Lu25aRuP
         YCYg==
X-Gm-Message-State: AO0yUKVnyy63ROwOl3l9fK1p7uARQZ6GB6Xjrc6oQuChkeE6Xwl0xDU0
        ivs7+STTAG1b6EibNcjckIk=
X-Google-Smtp-Source: AK7set+3bQWTUHdtQKp9Mb9+4ujtU4ZdfHrkX6p+49wHbaqo1A9Gaqcpd5rfSUXqObjvuZrPZvzb4Q==
X-Received: by 2002:a17:907:1dc2:b0:888:a29:b645 with SMTP id og2-20020a1709071dc200b008880a29b645mr17866345ejc.64.1675678612300;
        Mon, 06 Feb 2023 02:16:52 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008847d7ed37bsm5285983ejc.100.2023.02.06.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:16:51 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: wdehoog@exalondelft.nl
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: [PATCH 0/2] nvmem: brcm_nvram: use buffered nvram data for cell values
Date:   Mon,  6 Feb 2023 13:16:40 +0300
Message-Id: <20230206101642.22720-1-wdehoog@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Words from Willem-Jan de Hoog:

On OpenWrt 22.03.3, Asus RT-AC88U does not boot anymore:

  UBI: auto-attach mtd4
  ubi0: attaching mtd4
  ubi0 error: 0xc04f0b3c: PEB 0 contains corrupted VID header, and the
     data does not contain all 0xFF
  ubi0 error: 0xc04f0b4c: this may be a non-UBI PEB or a severe VID
     header corruption which requires manual inspection

The problem seems to be that brcm_nvram_read accesses its (mapped) io
memory. When doing so the correct data is read but after that the
mtd/ubi process fails to work.

The bcm47xx_nvram.c code has buffered the nvram data so the cells value
can be read from there.

v2: Fix the wrong author information.

Willem-Jan de Hoog (2):
  firmware: bcm47xx_nvram: allow to read from buffered nvram data
  nvmem: brcm_nvram: use bcm47xx buffered data

 drivers/firmware/broadcom/bcm47xx_nvram.c | 14 ++++++++++++++
 drivers/nvmem/brcm_nvram.c                |  8 ++++++++
 include/linux/bcm47xx_nvram.h             |  6 ++++++
 3 files changed, 28 insertions(+)


