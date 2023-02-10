Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9B691C75
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjBJKM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBJKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:12:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6CB635A1;
        Fri, 10 Feb 2023 02:12:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bu23so4526089wrb.8;
        Fri, 10 Feb 2023 02:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTCrw7yKDyNO1TL5ejMFnwYsZD8GBVrOoqwYTjfQtmU=;
        b=bCsFMz0TmvqBgNzhQtdKQb/Wlds2xKS76yA4DGwNlgPFfXozHaJZbXwzkFSaKWoLhB
         /T6gQUb/ubgu9FIbYe2ScSwJBgEvoxfUJjNyn488OeK7hCehj33RnQZP4qbGWUUlfF86
         psUi9wVguJ5yQ0u0sDr7Czu4XlJTKyfJLQvcQ5/o8HhrZNfa2kbTkOwAUye84PaitaW3
         +RVRhCNu/pAmHMfGdZHJtyDErXf0u6lz3wyVVFi30D8csbJOvOPCBcKUMLjnj+FWAafb
         Dx5MmyAXXpfuyN0YqoJuHUwWk8rsIsaOuy3bdvd8hZ8SJkt3xi17tBGnalL7/yV4sKsn
         oZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTCrw7yKDyNO1TL5ejMFnwYsZD8GBVrOoqwYTjfQtmU=;
        b=1h3506FXnBosK+PfbpKGh6r4pZ4eaqM/4WlVAbvnKkmZ9ZVw96SQGrJlc0Mo4Pysba
         CVrF26JaMbEhotLD/jy2TyK7PMoljw4xJzqL4Hsg0EYcepvv2lDf4MrlDGFngi5L7otK
         3pf3sOd8AZYV7BPDjDgWHszYk7j/ocYyI524J+ww1boYNXzs3oDdaCdmoGzQhi1hhEe+
         OGcsmH5YyEN1Yx0im5e7OjVKqysXj/hGyjMWUi2u2gH8c2UlOhWWV/CfANGE9WYd+QaC
         szVM8nWu53mUN90PZSPVaQKY2CiQrI9VPVRwBAh7X7B8dqfN7rx60+l1RJodzIRvzSZT
         n9qg==
X-Gm-Message-State: AO0yUKX+4z5/EyS5kjU4dChRoUx+VK8dGMT2Sp/EY6fmIgVijtkXY/VE
        iFCysQNUIeQ2G97+Ea8eGdE=
X-Google-Smtp-Source: AK7set9kvcPD1pWbMNwpXuAYzw/Inas9vlQX1mEuaq0KEApY+guH4ebYizeBM2LvMK9XWcYF98IUJg==
X-Received: by 2002:a05:6000:118b:b0:2c5:4b7f:c4e0 with SMTP id g11-20020a056000118b00b002c54b7fc4e0mr901591wrx.57.1676023974903;
        Fri, 10 Feb 2023 02:12:54 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b002c3ec35f360sm3157203wrr.56.2023.02.10.02.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2023 02:12:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Unknown Tuples from SDIO mmc device
Message-Id: <6F44C9E3-12A9-49EF-B462-6CC2667FDD5A@gmail.com>
Date:   Fri, 10 Feb 2023 14:12:51 +0400
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks, I see this in dmesg from the SDIO mmc device on an Amlogic =
S905D
based set-top box (running Linux 6.1.11):

SML5442TW:~ # dmesg | grep mmc
[    0.367575] meson-gx-mmc d0072000.mmc: Got CD GPIO
[    0.367728] meson-gx-mmc d0074000.mmc: allocated mmc-pwrseq
[    0.438107] mmc0: new high speed SDHC card at address aaaa
[    0.439663] mmcblk0: mmc0:aaaa SL16G 14.8 GiB=20
[    0.445720]  mmcblk0: p1 p2
[    0.463812] mmc1: new HS200 MMC card at address 0001
[    0.465304] mmcblk1: mmc1:0001 8GME4R 7.28 GiB=20
[    0.470109] mmcblk1boot0: mmc1:0001 8GME4R 4.00 MiB=20
[    0.473747] mmcblk1boot1: mmc1:0001 8GME4R 4.00 MiB=20
[    0.477168] mmcblk1rpmb: mmc1:0001 8GME4R 512 KiB, chardev (242:0)
[    1.253756] meson-gx-mmc d0070000.mmc: allocated mmc-pwrseq
[    1.331767] mmc2: queuing unknown CIS tuple 0x01 [d9 01 ff] (3 bytes)
[    1.341857] mmc2: queuing unknown CIS tuple 0x1a [01 01 00 02 07] (5 =
bytes)
[    1.346197] mmc2: queuing unknown CIS tuple 0x1b [c1 41 30 30 ff ff =
32 00] (8 bytes)
[    1.347097] mmc2: queuing unknown CIS tuple 0x14 [] (0 bytes)
[    1.351373] mmc2: new ultra high speed SDR104 SDIO card at address =
0001
[    2.170379] fsck: /dev/mmcblk0p1: 174 files, 16383/65501 clusters
[    3.042438] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data =
mode. Quota mode: disabled.
[   11.897414] ath10k_sdio mmc2:0001:1: qca9377 hw1.1 sdio target =
0x05020001 chip_id 0x00000000 sub 0000:0000
[   11.897451] ath10k_sdio mmc2:0001:1: kconfig debug 0 debugfs 0 =
tracing 0 dfs 0 testmode 0
[   11.897992] ath10k_sdio mmc2:0001:1: firmware ver =
WLAN.TF.1.1.1-00061-QCATFSWPZ-1 api 5 features ignore-otp crc32 7746e551
[   12.115387] ath10k_sdio mmc2:0001:1: failed to fetch board data for =
bus=3Dsdio,vendor=3D0271,device=3D0701,subsystem-vendor=3D0000,subsystem-d=
evice=3D0000 from ath10k/QCA9377/hw1.0/board-2.bin
[   12.125611] ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A =
crc32 544289f7
[   13.399691] meson-gx-mmc d0070000.mmc: unaligned sg offset 1100, =
disabling descriptor DMA for transfer
[   13.449279] ath10k_sdio mmc2:0001:1: htt-ver 3.32 wmi-op 4 htt-op 3 =
cal otp max-sta 32 raw 0 hwcrypto 1
[   13.533081] mmc2: queuing unknown CIS tuple 0x01 [d9 01 ff] (3 bytes)
[   13.543521] mmc2: queuing unknown CIS tuple 0x1a [01 01 00 02 07] (5 =
bytes)
[   13.548428] mmc2: queuing unknown CIS tuple 0x1b [c1 41 30 30 ff ff =
32 00] (8 bytes)
[   13.549378] mmc2: queuing unknown CIS tuple 0x14 [] (0 bytes)

I=E2=80=99m not a coding developer (only light device-tree hacking) so I =
can=E2=80=99t quite
follow the code in drivers/mmc/core/sdio_cis.c

What=E2=80=99s needed to make the unknown tuple(s) known?

Christian=
