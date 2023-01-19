Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D73673ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjASQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjASQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:29:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097315563
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:28:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r30so2389756wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=KyDTae+yIRm9B46y4fh6l6TTAmMj8UP4bhexXvaxQvg=;
        b=jQmM25167/Sn9MWbEEi7q8VYIVZHNgon8DyMdOgJCTr9GR1WuYLMkyIHkOf+KPaf6Q
         qUkEZ82pmtBBSKocFxUDWgHD0OLIUMPR1EBi2Pp2x6U/tWE78MhwQZ1aOjpJllx4k56D
         tzP70DHL16qp514tucSo9s9AKLuq4ILNJ+rd/Db75VCaEdppiC6BAW1rhdVXDlnNhRcx
         ikHz6B7jXfJ2J0qBCXWaUO6gE7SLOisgUfgM5dlPop+8KrIuII43CKJ2hodbxjViJD75
         VP3NOJq9R3x8U6WftOTdcYAQb7v3ufd3XyeFsCjpCS7tztVGs5XmspmRSVxb9lVHXtNg
         wSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyDTae+yIRm9B46y4fh6l6TTAmMj8UP4bhexXvaxQvg=;
        b=b8qoWFxaco6LM1WDkymxfap9zwazIsLcnCx2GvAxHs63sdGXR5q6xBFg0HIRjB3UPi
         7LCGCM7YcKboWPJ2ZPzBCg/x79i1ZGw9ysqMB0J91F4QZtCJ+onNNomhCNbSde2aeYyO
         934F3v6256ZoQXQs6kVuND4eqfsA6ru5VFdFMQzzViIPmez3VsaDWGTVn1cOTkiurbjW
         IA1GiJq22kYw2YyTVeDaV7KrT3tqHyqKN8Klc8hqA72ieqk8g/+ly4lqpC7SlCRFO6sQ
         euv5IjYMifVrHnqXBeQx09CKvmwuh1N3Q3A0scttuVc24pmmzB085W6YRPELO460h0ep
         Z7fQ==
X-Gm-Message-State: AFqh2kpopBZJdqSIQd2Wwhthn+GblFejMEAtX3pjTyKj+8VZrDwBZuU9
        48awX1xlU8ecRhCOkj/kIfhEVPFP+4Fym5nr
X-Google-Smtp-Source: AMrXdXv+CmLOrA89B0ZuZyKvu9Y6N46QigmiVMi0IyY1PCKErMDy0IN7Aid9IuYATD/a9LBe7hsUOQ==
X-Received: by 2002:a05:6000:689:b0:2bd:ffad:1bce with SMTP id bo9-20020a056000068900b002bdffad1bcemr11263798wrb.59.1674145736528;
        Thu, 19 Jan 2023 08:28:56 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm29008771wrw.91.2023.01.19.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:28:55 -0800 (PST)
Subject: [PATCH 0/2] Add MediaTek MT8365 SPI support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAMBvyWMC/w3LwQ5AMAwA0F+RnjXZMMHfdNPQhFlWXBb/bsd3eAWUs7DC0hTI/IrKFSts20DYKW
 6MslZDZ7reWDvheU/96FCToD4pXflGs86jD87RQAZq9KSMPlMMe63xOY7v+wFAMS4raQAAAA==
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 19 Jan 2023 17:28:48 +0100
Message-Id: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=zgfYtWJl6Qnh+hLsShyx1UnAkEV+3eaUlo+MkmgoDbQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjyW/GdVwaejjtWKRvxKzRFY+EaDyo/lXcw1dm3b7c
 BghChKGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY8lvxgAKCRArRkmdfjHURVPHEA
 CvuZFIUu1KDwRFFmDhM1p3ChGZDGxZhGCrp3BOOs7Mmoku/x9997da+lBrVEZ+5Kwpi4sm/2UV9W4g
 47uNrjzbVfOPUJDqFfJDKk/FMEo2t2LauRdVmOG6zNHUj2/XKa0CU8wt8vVQE4XxH9nvX0ewx+k8IX
 DyjnKgV7dwjYD0T1JNMB+8iSDiSTtbEdFBvEc0jrMZSPAJRGk8TJX00ttRwWWs8VTQ3LFgCKJb85Ix
 blfxbAAwqg6cvy//4jErY0QNhrPEIoLrbGLbOaekvOhKeopaWyIGZFVhLifWtCSNykjnb8umEqvz35
 ekvplHL+BK7TYjX+H0bGy4uhoRkTGKGl0210Tid45WkfpqX3CMQaMGHMzqzhQG5xPUc1VvL0DccZCS
 /Gbc/uXRyJCLhU5oVWCyYUNNi0SOKttpVw+ZJVfiO/NYXFAmBEKtROZx8L4I4SFoeTEEE1qo9B/+Ln
 Nm/3pD4ZOPHlsrzNFfDkOTIEaAsgSa3o0NvP0YQbJzZ4P6BVLSxAkHyGvVacrw05mNWdcbMw5gX000
 oYRe5+d9rpLg+UjuAIhtQRVD07hq4lsUxYu5PGVuQZc/qEwC0MElkgEJEnJc2uGK4RpPicKq99DW64
 9JEM8NsHRlfWoYA+SWcz1KF8CmEpMUUSIvb4XgLYXLI/n3UET3fz8Arn1Vkw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch series adds SPI support for MT8365-EVK board.
The SPIDEV is enabled, it can be used through the board pin header,
as described directly on the PCB.

This series depends to another one which add support for
MT8365 SoC and EVK board. Link [1].

Test:
- Loopback MOSI and MISO pins
- Issue the following command:
spidev_test -D /dev/spidev0.0 -v
- RX line should be the same as TX line.

Regards,
Alex

[1]: https://lore.kernel.org/linux-mediatek/20230101220149.3035048-1-bero@baylibre.com/

To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Alexandre Mergnat (2):
      arm64: dts: mediatek: add spidev support for mt8365-evk board
      spi: spidev: add new mediatek support

 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 24 ++++++++++++++++++++++++
 drivers/spi/spidev.c                        |  2 ++
 2 files changed, 26 insertions(+)
---
base-commit: 8b6cfcce3ce939db11166680a57253c39110f07e
change-id: 20230118-mt8365-spi-support-0d96bc55a4a0

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
