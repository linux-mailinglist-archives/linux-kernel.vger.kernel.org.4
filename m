Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F877085C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjERQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjERQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:18:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD43130;
        Thu, 18 May 2023 09:17:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so9599002a12.0;
        Thu, 18 May 2023 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684426678; x=1687018678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKIzA8OB0gilXLQ3wYoxY0i9z9L2Q2SdHoNduhfgknM=;
        b=PmPdJtWONd5ndRhu4uX2FqTKZFQjaR/onE8LgQ91YW2uSV7I+i+ScER16pPJa53JCS
         UlbSoMxwKX4d2UxCQHVm0kPhQZqP9dIuLCE3oVS4VS0RIvY9VjgEqchkjFTumehugKZh
         AyxLM7jkG4pbLmFlJU9z4K5Oaj1XdxiJLr8WBZ7yvexuXOzz7NIbYxMMzMXKHGx+LyXC
         5u20Rh/tfPwV1V5J/NjwS+aHNTHcOyuusDCncp6lw6IohpdpmlaM7J/ZlzlVylB6Fn1l
         deZK47bTGnPw6+C1nywTTSWSn+VxLPJwnCJ8xshbxPKp92gHOSso9yZxaTX11as3fJ2Z
         irzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426678; x=1687018678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKIzA8OB0gilXLQ3wYoxY0i9z9L2Q2SdHoNduhfgknM=;
        b=Ir2zV6o1FM3Z9tMdcIOEzKOlT7OwrujFf8iiI22WzR8V4RLOqlMh7/Jg2UWMYpU2i6
         vvrvQXSBvz3kVDQVtef8D7d9LpQlu+6cRGALDXPO5FDIKRuu0d4HeB5PHjEIqJ7cMoJY
         UoZNKiyuP7duS7Pd8dM4MRaTtc/m6XwJjKjToHPIa2e1HeJ7iCVNTiNYpffCaRO1OCST
         E9GFh4sLyg+OIx6wXPpXRc1ICpVGmqGbLqZN1TjJIAb6glNE7ujZkuyWzOXRDDih0Yor
         IjQ64YuC3c1nGI7GAeRCAR5Nq3DMQxmgecZFBzNIu8Dk0WhqCND6OkyoPKvFIlCpRv0J
         mRrw==
X-Gm-Message-State: AC+VfDz+tHjV1Q35S1ATcxOOZ8AAq/spCP4r3w+kluxQaa71wphpxLMh
        VcBQVzEPvEK8SgzGUebbxAbu+GwTyn8=
X-Google-Smtp-Source: ACHHUZ4LEJc9T9FQQkyLGKEd3RwnYKi5F+6HRNf1NaAzI6Wa3j1wcLKHcQnRrecyYkFuwd4NQa9e+Q==
X-Received: by 2002:aa7:da95:0:b0:50b:c456:a72a with SMTP id q21-20020aa7da95000000b0050bc456a72amr6359652eds.19.1684426677397;
        Thu, 18 May 2023 09:17:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-73e5-9e00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:73e5:9e00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020aa7c74e000000b0050bc13e5aa9sm756307eds.63.2023.05.18.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:17:57 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v1 0/4] wifi: rtw88: Add support for the RTL8723DS SDIO wifi chip
Date:   Thu, 18 May 2023 18:17:45 +0200
Message-Id: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
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

Dependencies:
- commit cb0ddaaa5db0 ("wifi: rtw88: sdio: Always use two consecutive
  bytes for word operations") from wireless.git is needed for patch 1
  from this series to apply with the exact line numbers. This commit
  is a runtime dependency on Allwinner SoCs (like it's used on the
  MangoPI MQ-Quad).


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
 drivers/net/wireless/realtek/rtw88/sdio.c     | 23 +++++++++--
 include/linux/mmc/sdio_ids.h                  |  3 +-
 7 files changed, 92 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723ds.c

-- 
2.40.1

