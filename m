Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3930E60B4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiJXSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiJXSCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:02:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C074BAB;
        Mon, 24 Oct 2022 09:42:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b12so32669827edd.6;
        Mon, 24 Oct 2022 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Ctdqg5j4nqQ/U0t6zhlv3WZWEIk/6dcA0neCwvrWg=;
        b=h0sOJYVi7ZklO1Whdk3U6NQAWCZQb4I9VsbUh+Zmr4gWgRqeivJXMwzIp4t7SEhcnE
         yWqY/COvaUYulI4ZmwwrqXV5TuTybbIi0mUGZ0CfTmVWhPw4fM5UXIjI5p+5+E25rU16
         zCPI6SrzyHAkDcXCorMD/SGIiaPBdttecWlsgJLXF0L4HOM6JNrm21QyqXV7KRR3SRdw
         jcdp7MN80Yz2Y85WKxe/LTKhp768CjiUMbKZhRfdflrJAbDfNu54umlt1IsM/gD5DwDu
         aiK9qdRJnkTooH4twDcrX2+r0vQAlTbodUKj9C232/WPnMC1MIPCClOyvFXidxk8Lplq
         i8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9Ctdqg5j4nqQ/U0t6zhlv3WZWEIk/6dcA0neCwvrWg=;
        b=rtcOpLKOkL73OiphfithSb/+0Bd5K4BZ6vMI5N8cfusMfNm+HFmSjfcEUKtZIlrblr
         r4Tr4qYUBxX5cVeVSXQgHZBjc5aDNNRvBZpsejcNq52Ff0yMEqE7q7h9qfEJe9AZZdA/
         oXfHeeb0/QBWTBmaTQHITn2svNpy39fXe63fZJePAHJjH9BHQRpP7iRT+uU4yc/7jnZ9
         dIxGp+cl8eonR+JjuxxlZm5hjSkl3UuCho5wjsrRDev0r8f7UIBP0JaBQLYJAy9tZQfC
         qK88pSS88Y2SEJ++JaE2j56Dmspi3VjtEql3N1/pmDTh5ZVisQWTT2+2TVEBZd3xXJ8a
         BqnQ==
X-Gm-Message-State: ACrzQf2pZm9+2ZBDPM+yxjnXdNnMzcMt4A7clGOSKghOsyW0yaQwPsky
        n59EqcVZKZJ2uEjsjJU8i0OE7B0VvreXTw==
X-Google-Smtp-Source: AMsMyM6OlCumPa4pUVoUHabvsgkVNryvyiZMRF2DnEeuewy0AkPgzR6nh/D1IoAursQrpc2m09cjgQ==
X-Received: by 2002:a17:907:94cf:b0:78d:38cd:afcf with SMTP id dn15-20020a17090794cf00b0078d38cdafcfmr28956678ejc.229.1666628819165;
        Mon, 24 Oct 2022 09:26:59 -0700 (PDT)
Received: from 1974459598.wifi.kn.vutbr.cz (nat-kn.net.vutbr.cz. [147.229.117.40])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709064d4e00b0078dd4c89781sm108186ejv.35.2022.10.24.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:26:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, jeffrey.l.hugo@gmail.com,
        Michael.Srba@seznam.cz, gregkh@linuxfoundation.org,
        elder@linaro.org, hemantk@codeaurora.org, mani@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [RFCv3 PATCH 0/2] Wiegand bus driver
Date:   Mon, 24 Oct 2022 18:26:48 +0200
Message-Id: <20221024162650.36587-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Thank you for all your suggestions and points.

I have realized that I have approached implementing the Wiegand bus
driver wrong. I have used the words 'GPIO controller', which made it
seem like there was a GPIO controller for which another driver would
be needed. What I meant to implement is a simple bit-banged Wiegand
bus driver.

There is no GPIO controller, instead the two GPIO lines are
controlled by the bus. They are utilized to send messages following
the Wiegand protocol and the bus driver should implement such
bit-banging. Now only a single devicetree entry is needed instead
of two as in the previous version - thanks to Krzysztof for
pointing it out.

The driver was based on similar drivers in the drivers/bus directory.
There is also an abstract API in include/linux/wiegand.h that
contains functions to write to the bus or set a particular format.
This API is meant to be used in drivers of devices communicating
using Wiegand protocol.

The user can write on the bus using a device file or change
the format and message payload length via sysfs files.

The driver was tested on NXP Verdin iMX8MP Plus.

With regards,
Martin Zaťovič

v1->v2:
Split the driver into a bus driver a gpio driver and an abstract API.
Fix issues pointed out in RFC

v2->v3:
Discard the bus driver. Implement new bus driver based on the gpio
driver(the gpio driver was actually implementing the functionality
of the bus).
Fix make dt_bindings_check errors.
Use devicetree properties for pulse_len, interval_len and frame_gap
attributes.

Martin Zaťovič (2):
  dt-bindings: bus: add Wiegand bus dt documentation
  bus: add bit banged Wiegand bus driver

 Documentation/ABI/testing/sysfs-bus-wiegand   |  20 +
 .../devicetree/bindings/bus/wiegand.yaml      |  75 +++
 MAINTAINERS                                   |   8 +
 drivers/bus/Kconfig                           |   7 +
 drivers/bus/Makefile                          |   1 +
 drivers/bus/wiegand.c                         | 509 ++++++++++++++++++
 include/linux/wiegand.h                       |  58 ++
 7 files changed, 678 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-wiegand
 create mode 100644 Documentation/devicetree/bindings/bus/wiegand.yaml
 create mode 100644 drivers/bus/wiegand.c
 create mode 100644 include/linux/wiegand.h

--
2.37.3
