Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668BF606DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJUClM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJUClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:41:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F661B232E;
        Thu, 20 Oct 2022 19:41:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pq16so1197474pjb.2;
        Thu, 20 Oct 2022 19:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7qTx0k1id+tqPtrpykfViuJRNlwvqXtqIFSsgug6r4=;
        b=jb6+eMMfeAlOFfvR6HBFBnIUEKd66s8sfoCn1SS236FS6ogTGYFAQimh1lfZiL++XA
         DK2ZPy3sW7JuPOHLqzHfqXaAE3jTu0kTcqINtCP7oZzyRmNkWRJkImDh7SSVLw2s75/W
         MJqj5Mwxe3WKSt7MzJPP39mtiCKI2b8TJbHkzufBmaNUQPGvgjmlEcDuR5jkGWUvY1SK
         gY3P3dg0xaTO/Jr+ctaIe1QpD5gZ+bDRdYaR+4aLwd9TW8Q1YAt7JtiRFUykVAjY5TYx
         KbqYCEmR+egPBnlphsnRUIYCg4mYGrnqsgXUp7qsVNaFoNUialIyT7NElTwDa0H/Kf5s
         anxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7qTx0k1id+tqPtrpykfViuJRNlwvqXtqIFSsgug6r4=;
        b=P92epzXNTmcVDtCOOkMbCp4onukyakC88shqy3SxM5R2USaRhA/8c7+9c/kD7Xw3VC
         PaFjs7f/wjwzb3FpdkvojMmMq7jbKXtkWZ0HWDSENa7OEcOdq28S76a3UTPjg2SKxUGB
         CF7LvH6QHkNVLoA6/mSmxHFiER/8ex+chJrzJ9//TqejIYmXngVv6u22uiigy46Xqcpk
         UF2OrR52hcC4uhDC+61fHECNvoDo7pjBa72NlGvxB1cnlWwGn64c3VNPVI84BVXXIrYZ
         gMzIf11RzwdoLh0UBHoXfOGroDznLB9y4+3Be9LZ4lOpS4XfU/eFVfgODavSEE2TXS/V
         5NGg==
X-Gm-Message-State: ACrzQf35z9Vq0p8181irOWiFqdVZQBKPwolahRM3Y2Dj1ygKlbH1s3mQ
        WULPlY/R0WWz192D0IUTrSZ/NYfxmQY=
X-Google-Smtp-Source: AMsMyM4F6P4Q2y0fMHWd/2HcgUfqbJuYGK+P0AQlvZmPa2lVfx/+4B89c3o9JWroPUArSnnXUA92EA==
X-Received: by 2002:a17:902:ccc2:b0:178:29e1:899e with SMTP id z2-20020a170902ccc200b0017829e1899emr16995154ple.114.1666320065326;
        Thu, 20 Oct 2022 19:41:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:b022:150a:a87e:ab3a:9736])
        by smtp.gmail.com with ESMTPSA id a19-20020aa794b3000000b0053e42167a33sm14033023pfl.53.2022.10.20.19.41.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 19:41:04 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for Richtek RT6190 36V 4-wwtich regulator
Date:   Fri, 21 Oct 2022 10:40:57 +0800
Message-Id: <1666320059-17544-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

The RT6190 is a 4-switch Buck-Boost controller designed for USB power delivery
(USB PD). It operates with wide input voltage range from 4.5V to 36V, and the
output voltage can be programmable between 3V and 36V. It implements peak
current mode control mechanism to deliver up to 100W power with the
programmable constant voltage and constant current output. It also has built-in
charge pumps for driving external low-cost N-MOSFETs to control the power path.

Since v2:
- Rename binding filename to 'richtek,rt6190.yaml'

ChiYuan Huang (2):
  dt-bindings: regulator: Add bindings for Richtek RT6190 regulator
  regulator: rt6190: Add support for Richtek RT6190 regulator

 .../bindings/regulator/richtek,rt6190.yaml         |  77 ++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt6190-regulator.c               | 495 +++++++++++++++++++++
 4 files changed, 584 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
 create mode 100644 drivers/regulator/rt6190-regulator.c

-- 
2.7.4

