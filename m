Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467A86D3906
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDBQn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjDBQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:43:27 -0400
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5041EB54;
        Sun,  2 Apr 2023 09:43:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 3F8483F417;
        Sun,  2 Apr 2023 18:43:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CtEccJModFEV; Sun,  2 Apr 2023 18:43:19 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 131903F401;
        Sun,  2 Apr 2023 18:43:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 8B5FE93782;
        Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id V3Ezy4A6zUhb; Sun,  2 Apr 2023 16:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id D3F909376D;
        Sun,  2 Apr 2023 16:43:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se D3F909376D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680453793;
        bh=cgM57hJm5k2oui+gMMCv8ZY471CwtzcndNIPu6989Ds=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=mcQyqI7SP0xQ8pJ27+crN8V1MJw2iVrPRhFUnoHUcg9qz4gP3kdPMub7r3XudGyJG
         rLr9jNtFMELk/97K09AczhdFPhJQ7z7HNGKxj8Z5pn7HEnAXnLazzgANgeX+BhXvlz
         xWrFivxm8gL8lJz6qyP1J1sIiYF7ML765iKwxxlWKvHOL1VJxYtEtsvloxySLK3mHu
         X5oG5dmTjXpRWrbCvmxdCuYZmYrbsSEKvNVsS7I52w5vzhvJY+AOEt1U41bN/l0bDI
         C6oYbiaO/ZbshvLuwQF0qd3Z+gZb8SSPXr+lDymmaH67NNPI9Us/DyGHjVpPomS1mM
         JGNyCKDIPSS5w==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yuFgG64aUGIw; Sun,  2 Apr 2023 16:43:13 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 8212393767;
        Sun,  2 Apr 2023 16:43:13 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v2 0/7] iio: adc: palmas_gpadc: add iio events
Date:   Sun,  2 Apr 2023 18:42:40 +0200
Message-Id: <20230402164247.3089146-1-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The palmas gpadc block has support for monitoring up to 2 ADC channels
and issue an interrupt if they reach past a set threshold. This can be
configured statically with device tree today, but it only gets enabled
when reaching sleep mode. Also, it doesn't look like anyone is using it.

Instead of this one special case, change the code so userspace can
configure the ADC channels to their own needs through the iio events
subsystem. The high and low threshold values can be set for every
channel, but only 2 thresholds can be enabled at a time. Trying to
enable more than 2 thresholds will result in an error.

The configured thresholds will wake up the system from sleep mode if
wakeup is enabled in /sys/devices/.../power/wakeup.

The old platform data was removed.

Thresholds, events, and wakeup were tested on omap5-uevm board. It wakes
up from sleep mode when wakeup is enabled and a threshold is passed. A
userspace tool for monitoring events and adjusting thresholds can be
found at [3].

Patrik Dahlstr=C3=B6m (7):
  iio: adc: palmas: remove adc_wakeupX_data
  iio: adc: palmas: replace "wakeup" with "event"
  iio: adc: palmas: use iio_event_direction for threshold polarity
  iio: adc: palmas: move eventX_enable into palmas_adc_event
  iio: adc: palmas: always reset events on unload
  iio: adc: palmas: add support for iio threshold events
  iio: adc: palmas: don't alter event config on suspend/resume

 drivers/iio/adc/palmas_gpadc.c | 550 +++++++++++++++++++++++++++------
 include/linux/mfd/palmas.h     |   8 -
 2 files changed, 455 insertions(+), 103 deletions(-)


base-commit: 37fd83916da2e4cae03d350015c82a67b1b334c4
prerequisite-patch-id: 9b1f55610800b91b721d042bf7f33b58179237d1
prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0
--=20
2.25.1

