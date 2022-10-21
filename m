Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6AA60789C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiJUNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJUNiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:38:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BEA275199
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:38:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk15so4816046wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbUGLzx95uGCyDlhKABUDk0TwFKBK1rRFm9Lq1bvWhQ=;
        b=Cztud/XNPRfILkeYrDGH7fD8D/44agAxp7x2SuaOpkBbOzEm6vowqmYgkH9gRN8SqA
         KXTP5EooRHITXkNczVUXmVGX0rB4DmcteoTH3TdIMK8RcY6G5bkyXWnMb7ADnVLkmeq8
         N9XNz2l2tmiwNlyFHz1FFxVKOmYSTeMLrtGqs7TwTEchbAJ/rVmxqMqt1cU1PLrNx6rN
         T3lM6BneGF/FoKJuZUXw5qP5M/o9Vj5O8xiT4NThcFernyw0cj5aha9bvCprmpFEslc3
         61ye4j09ZLyS5AvzUaOqtFHAPWq8qMvP94x5xP8n/73306oLNumKYfgG64lbRXcUWSGZ
         FkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbUGLzx95uGCyDlhKABUDk0TwFKBK1rRFm9Lq1bvWhQ=;
        b=i/ummB83yXS6NvFtwuFsRaO8uIMjrUngkihJSBrCzjq6vfx8UD7v7vtZ1Toir+VwUo
         56flX8khBGvNAPGK0WVGF6ssRJBIXxH/1qnZWMLBUKuQ1cOkER0JNO/nXst8zZuMEr+d
         NhsH3SndmZ6QyidAV+SwxFxbnWWGIHG0YfQn4FCl2wQ36nwuxnRv/PnHt/CotiTcoLnM
         fEzIrFFhA9dT+cMw7Q5Zhw430qRkS0FhsHDSqGSLNbLwTnUhR6iLiZKLFB8q+DncbLAZ
         uwkoMPXZqZK+md6yVp8OltThe4tZl+oBcEkZuURc5j51PAy2moPfYxTM8seCXUp5b5Zd
         qyGA==
X-Gm-Message-State: ACrzQf2CgGjUhmZlCRAQYlo26UmLYPPWNPMHiRV+uL/SZIY5Pes3AIH4
        N2Dyk8wUu59+zHQOtOchAEAXld5WKQoysT0j
X-Google-Smtp-Source: AMsMyM7qEGEFybZQ/s1vwsv5EnaCGOXvocUhKwgK8vrYIiDHjtFPPAIasFVplw2SF1mw3CbgefYa2w==
X-Received: by 2002:a5d:42c7:0:b0:236:4ddd:3576 with SMTP id t7-20020a5d42c7000000b002364ddd3576mr4144203wrr.289.1666359485075;
        Fri, 21 Oct 2022 06:38:05 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l35-20020a05600c1d2300b003b477532e66sm10462313wms.2.2022.10.21.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:38:04 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        neil.armstrong@linaro.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/2] usb: serial: add support for CH348
Date:   Fri, 21 Oct 2022 13:37:56 +0000
Message-Id: <20221021133758.1881904-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The CH348 is an octo serial to USB adapter.
The following patch adds a driver for supporting it.
Since there is no public datasheet, unfortunatly it remains some magic values.

It was tested with a large range of baud from 1200 to 1500000 and used with
success in one of our kernel CI testlab.

Regards

Changes since v1:
- use a data structure for encoding/decoding messages.
- check if needed endpoints exists
- fix URB leak in ch348_allocate_status_read error case
- test for maximum baud rate as stated by datasheet

Corentin Labbe (2):
  usb: serial: add support for CH348
  usb: serial: add myself as maintainer of CH348

 MAINTAINERS                 |   5 +
 drivers/usb/serial/Kconfig  |   9 +
 drivers/usb/serial/Makefile |   1 +
 drivers/usb/serial/ch348.c  | 738 ++++++++++++++++++++++++++++++++++++
 4 files changed, 753 insertions(+)
 create mode 100644 drivers/usb/serial/ch348.c

-- 
2.37.4

