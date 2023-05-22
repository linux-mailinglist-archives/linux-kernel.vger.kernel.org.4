Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1770CADD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjEVUYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEVUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:24:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663BAA;
        Mon, 22 May 2023 13:24:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510eb980ce2so78551a12.2;
        Mon, 22 May 2023 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684787082; x=1687379082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujd+z3hoj5H8e61WA/1gzrYNE6nhrLEh77YJmVujUS4=;
        b=rxc5Yg0TTi8HrrOvLx7ukiU/0uNnoYlhDLNp6HK8K1P2LcTsdzObcOj4p75ffeRFu8
         5Tl3fHeaWbMAKEyVYPFadpufUEHZbKhwaZR2JpSsCAQ0OI+P/POXy5lHJwW1SmhznOn2
         n0baJlnwWn4bShf0Mt2x/1uAJmNl4r044c8jYQpWqsvfPPcZzMtjVpVfO/q8jHCNnxg6
         1BUgSphwbsr7mQkWJhLXD9zF19Hb8+isrqHarB3lHR8IHkMSSIi6KKOhUMBDDED6arF1
         D5fZ4VP5Jr6csBVjZPlSzy9tswOMIhIMuT4XQCOHRk43Foh5tPdA37oV7huaLTcEZtNF
         ltHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787082; x=1687379082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujd+z3hoj5H8e61WA/1gzrYNE6nhrLEh77YJmVujUS4=;
        b=l4Wepyg1aA6sGTwJzXnzLwVZS3ukN5BeAFbt6kkiU1B3rYTtpblhLVriFU7JxXY4Rx
         our7jof2HPFsdxtscRWd6/c99XKUajbrpNsunGi9TUH3gqju1Rf12ICvl/AHtr3Z02g3
         D6y/4nUYAjU0bbH9MKjvz9i4Ex+T/XXwp/p1YQ7658MwwJb2OMu/7HDbbp12Yc9/hYGs
         yAaGu8QLj1l1oLtuCfZlJBwlsYm2JafrYajdxoVIxCutRmHVxLLT59Gg40F9CRkUShN6
         GeJpmAuwm+7k5khKs7HG/U18cgz20MIm8eSq2QsCY+MVkaSSRgErTsSaf4GLoHdG3qZe
         UGcg==
X-Gm-Message-State: AC+VfDxyElY/+3GlcCy0MFkb5/Ownj/k3rVNw7t3tUsC9I3EhME4S9DV
        tshzw/mLbx7P3WnvuGGtrS7vgmRDT1Y=
X-Google-Smtp-Source: ACHHUZ6K7+lIiZ5wytJHp+G+6GaQDT6hZ+QuuOlm7sjQTsIL6roJgW17qy2PNAICN/gWiNQjB9J5iw==
X-Received: by 2002:a05:6402:b0f:b0:50b:f8f7:f8d8 with SMTP id bm15-20020a0564020b0f00b0050bf8f7f8d8mr9021503edb.36.1684787082156;
        Mon, 22 May 2023 13:24:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c459-f400-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c459:f400::e63])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056402184200b0050d56dffc93sm3265031edy.12.2023.05.22.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:24:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v2 0/4] wifi: rtw88: Add support for the RTL8723DS SDIO wifi chip
Date:   Mon, 22 May 2023 22:24:21 +0200
Message-Id: <20230522202425.1827005-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the RTL823DS SDIO wifi chip.
It builds on the SDIO support which was recently merged into the rtw88
driver.

With the initial rtw88 SDIO support code the aim was to support these
older (802.11n) chips as well but we didn't have any way to test that.
Overall we spotted all corner cases in the vendor driver except one:
On these older chips REG_SDIO_RX0_REQ_LEN should only be read when
REG_SDIO_HISR has the REG_SDIO_HISR_RX_REQUEST bit set. Patch 1 adds
support for that.

RTL8723DS comes in two variant and each of them has their own SDIO ID:
- 0xd723 can connect two antennas. The WiFi part is still 1x1 so the
  second antenna can be dedicated to Bluetooth
- 0xd724 can only connect one antenna so it's shared between WiFi and
  Bluetooth
Thanks to Ping-Ke for these insights!

This series adds the missing SDIO ID and renames the existing 0xd723
SDIO ID (which we previously added) with patch 3. The rest is straight
forward: patch 2 adds support for parsing the eFuse and patch 4 wires
everything together by creating a driver for the RTL8723DS.

In my own tests on a MangoPi MQ-Quad I get the following results in
iperf3 (with the device being better placed than my RTL8822CS):
- RX: 48 Mbit/s
- TX: 33 Mbit/s
Also Larry Finger reports [0] that he has a user (with the rtw88
driver changes backported to support older kernels) that has
successfully tested RTL8723DS support.


Changes since v1 at [1]:
- rebased on top of 6.4-rc3 which comes with commit cb0ddaaa5db0
  ("wifi: rtw88: sdio: Always use two consecutive bytes for word
    operations")
- added braces to the new if condition in patch #1 as suggested by
  Ping-Ke (no functional changes but it makes that code block with
  the long comment easier to read/understand)
- collected Ping-Ke's Reviewed-by (thank you!)


[0] https://lore.kernel.org/linux-wireless/88e0c4a3-eec7-e44d-6f95-6f2e7f7cbbb5@lwfinger.net/
[1] https://lore.kernel.org/linux-wireless/20230518161749.1311949-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (4):
  wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
  wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) efuse parsing
  mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
  wifi: rtw88: Add support for the SDIO based RTL8723DS chipset

 drivers/net/wireless/realtek/rtw88/Kconfig    | 11 +++++
 drivers/net/wireless/realtek/rtw88/Makefile   |  3 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  9 ++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  6 +++
 .../net/wireless/realtek/rtw88/rtw8723ds.c    | 41 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/sdio.c     | 24 +++++++++--
 include/linux/mmc/sdio_ids.h                  |  3 +-
 7 files changed, 93 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723ds.c

-- 
2.40.1

