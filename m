Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9165A5FCCA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJLU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJLU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:58:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84031162F3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:58:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk15so27911438wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yChYi7VY+m+DrvJmTQkA623G7MkHEI7cjTtlZ46QtfY=;
        b=CkCgF7grnn+w8+bJItdlr661kAayCwQrlS+1aeGHuq8gYnnRJPF4HieHCXLTwkIxAe
         za1clmxoMWwnduh/3idXfTUGqPEKVqrvRPogJr3n5XAOOTxoYvFHMVhtrW9QH264fgeq
         uhrvppR1B0RREFnNav8Cwi3MIF9xutHLImxep1Xhfa8nj/XnrDC/h9k0OLGdSxNHqD3I
         SeTC8e4jOD25SbWO1gCS1HFk484iXCtsa3pus56MLJa/9cywbu6Eg2SAt4+6OxnzwUWb
         Bvsnhj2WgOE74hJH0Lu/GG/LhJr7Fp4cGSemlgZJhOOMJJRe1h2jn2CQHEVjfyFiGdHC
         wG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yChYi7VY+m+DrvJmTQkA623G7MkHEI7cjTtlZ46QtfY=;
        b=T6kXw6g8dEam8dIDEKmiVV9U3Nod1d3Lqx+7QmfvTngjEi3+fcKNGMSvUY+eVHRXDL
         ZBJzif2egifi3iFf9/6xuGtJdzBm3jhqwkNYwddHvTamnueHvI/LE8rzG23QT4al6/fB
         380DkZLVKMwgyevzyrbriZI6zG2rndrZuVqNSLCJDxCaY8hSfH7JR0wxP7D/gumjTD75
         hp6VOJhMn/HU2mENdkrVSoP5kXaRP2GyGevGn5mgYY4neBH+mythjC3UNWlP1pvelBpt
         bTv9cYWZQPUZl/YW38znGBHDnaJVbK/XJayGCF3v6ZsYtBjhIUjpc8staYf5hTljqZRT
         hTZg==
X-Gm-Message-State: ACrzQf0h5i4Emj5jluLQD+tHTVtqAS/BArInASVd9MpkAQnamZ65E4Mi
        FvRpxo59Wif4/SP434UKGZqHe8zsP1pZdkVs
X-Google-Smtp-Source: AMsMyM422fyj+uXPgmFq4xnogUGAlOP6esCzEZx+cp5eLgZoihGh9AQb+BkS3fDKY5tdNEUx8mNdGw==
X-Received: by 2002:a5d:46d0:0:b0:22c:de2a:23e with SMTP id g16-20020a5d46d0000000b0022cde2a023emr19942738wrs.12.1665608260619;
        Wed, 12 Oct 2022 13:57:40 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003c6cd82596esm3165443wmq.43.2022.10.12.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:57:40 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 0/3] Add devicetree support for max6639
Date:   Wed, 12 Oct 2022 22:57:33 +0200
Message-Id: <20221012205736.1231514-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds devicetree support for MAX6639.

Changes V3:
- correct fan dt property name
- remove unrelevent changes
Changes V2:
- Fix dt schema error.
Changes:
- Add fan-common dt schema.
- add dt-binding support for max6639
- add max6639 specific property

Marcello Sylvester Bauer (1):
  dt-bindings: hwmon: Add binding for max6639

Naresh Solanki (2):
  dt-bindings: hwmon: fan: Add fan binding to schema
  hwmon: (max6639) Change from pdata to dt configuration

 .../devicetree/bindings/hwmon/fan-common.yaml |  48 ++++
 .../bindings/hwmon/maxim,max6639.yaml         |  86 ++++++++
 drivers/hwmon/max6639.c                       | 206 +++++++++++++-----
 3 files changed, 286 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml


base-commit: 0cf46a653bdae56683fece68dc50340f7520e6c4
-- 
2.37.3

