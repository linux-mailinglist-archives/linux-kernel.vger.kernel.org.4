Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C75FA659
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJJUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJJUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:32:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5457E02D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:31:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so20122597eje.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sBiK+vbAyImg9kEuDq6EBbSbwMid7160KaW98IfOhY=;
        b=cdRSLezFtOdO8YALIaPRVQR+XQW1p79fMWkbZFN9ICu1ECnnoksUPF9nqCT/X9FiJP
         0vvDb7nFi50ybvml5q33Zg88xApolUxe3rbZkjT3r5EOR1uJ8dahsSMCJl38T+5vxxwE
         CAQWW3Ric1u+ykiZCq9+02NWyphwlWymd7Chs+wuvMbFf5CAx2dKK0Evfz9LLwB+MdBa
         MomXgcSIkpyV4DCRlFHcwsGNELb3e0MbNuTuw4cUi7Bl/rz6w5DTzLcrXE0bnp38Iqow
         azeAp3Vgyd+5zJb8uLSzaDMDmLSU7IkQhLnENERailKtXk1FIYJhmVUJr5RDjixN40tx
         +tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sBiK+vbAyImg9kEuDq6EBbSbwMid7160KaW98IfOhY=;
        b=zXQsfzLa3jwrYCyqum2YkVMV8JJ3/IyCxPVb8w+e/uf/YDGctLsTbHiImYYS7oSjCU
         yvNK3DIy9PUBJ96UDQ+cMwWa8sg00u1H5B0Kt3ZXlGaoQHVujYzCaDFrPF6zpyvTkEIe
         HVXPBNt8LfPwH6Wk/yeKkOBFZ4cw51AO/53bV+0oI1sFwGcvsTOqZ+IkF/tAGV/z492/
         RDZFKio2h9hysFuhycrB1xJ1lrxeXhhl641S7zMconvZwFTusHiDncgmae+onox7E5ER
         Www2pYRQfB+luJvtDbby43eVkOF5CqBej5qPLt8JGWVGVOfPHo3GnYxMDXUfpEIW9hMm
         dNiA==
X-Gm-Message-State: ACrzQf24MDQ+X9I+Erj4lkBLPkii3sw4bdUeMqTR5ijv4t2XcFKYkARN
        tBmpkFtjcAzdCwCSW0v16WTxtppjX5cQKSsf
X-Google-Smtp-Source: AMsMyM4d2rMBdNHaz+Zh/0HPCNcWkACpXQQ+Am4CB+z+mYMSQwLFAuOl/l+a6MoIGR7+x4taORYK9g==
X-Received: by 2002:a17:906:7310:b0:782:cfd4:9c07 with SMTP id di16-20020a170906731000b00782cfd49c07mr16962842ejc.708.1665433872099;
        Mon, 10 Oct 2022 13:31:12 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7d612000000b0045720965c7asm7670385edr.11.2022.10.10.13.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:31:11 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 0/3] Add devicetree support for max6639
Date:   Mon, 10 Oct 2022 22:30:43 +0200
Message-Id: <20221010203046.3673663-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds devicetree support for MAX6639.

Changes:
- Add fan-common dt schema.
- add dt-binding support for max6639
- add max6639 specific property

Marcello Sylvester Bauer (2):
  dt-bindings: hwmon: Add binding for max6639
  hwmon: (max6639) Change from pdata to dt configuration

Naresh Solanki (1):
  dt-bindings: hwmon: fan: Add fan binding to schema

 .../devicetree/bindings/hwmon/fan-common.yaml |  77 ++++++
 .../bindings/hwmon/maxim,max6639.yaml         | 116 ++++++++
 drivers/hwmon/max6639.c                       | 251 +++++++++++++-----
 include/linux/platform_data/max6639.h         |  15 --
 4 files changed, 381 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
 delete mode 100644 include/linux/platform_data/max6639.h


base-commit: 0cf46a653bdae56683fece68dc50340f7520e6c4
-- 
2.37.3

