Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19838605A77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJTJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJTJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:03:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E331B1960B8;
        Thu, 20 Oct 2022 02:03:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q19so28903475edd.10;
        Thu, 20 Oct 2022 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xaQSKWVE6qiruRKoc8l3Jo2/FxtS7lXQP1OjBQL4RMM=;
        b=kUmjEk4ZQUk4+YGNsUmKOxDXcS40zP3tI1LKysIXI+VhsQMt49TnX5mflLP/gaw06t
         dcgJ6ZyDFAgEvPOdvAhssoTMZIBAXVVQPDA9KnobElvmtyu8No0ws/YE2IWBgkWShprD
         m1+xt3o2zp9bg6zMO5pxfgNnOhAORA+J3GGIroc7x5/FOs5LGUgOWDJ4ijxdw9lS/EGB
         47TWrex2A8kRFo0AKxBAi9mfYotXvCNnPUW44ahaCNJCFnhgBgb3RVG9cpK1BeFuWAaS
         V/CU4bKYj2G9w0d7FeAK02bBVexbPFaMqp2TgpGPA3Ho6IjIzFQAcVIEo5Kz3muxjbBB
         j1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaQSKWVE6qiruRKoc8l3Jo2/FxtS7lXQP1OjBQL4RMM=;
        b=Ka/xo/Nig30U9OP6cdS/TAqsL2QuTKbFFZK9O3bujVnNujiFSWgZz/SbMGUBEiSOsf
         zrEEvEUcv8CE15v2WZ4BdMAPdMy8oKQOHxIehSSpeJs8QhH1SNbKdXYo5wnaV1fEXy3x
         uG7WJ8kq31YkgquUNVBT8ARCnG8qc/dRaqC4HXCVq7/wk+GEXWZ3Ks7RxZxQvjL8nMIC
         +QA28rBO98TOMVRJ+vUwfhl6noKCes7xn9nuwNO/efxS1emIhdWDOnY2yLXskOqCGpKp
         ERMriEaivgkRFQ1rN6s+EqOG5/tX10nxJXMM0ccGRKAJZ+JVx3j/z/jI5of3/deDDdsV
         6Flw==
X-Gm-Message-State: ACrzQf1GfT3+iWhRprd6ctlIh+6CgFZgFQ73U1iNeazj6APy6YrPMNMN
        O8ba82xRNMSaVjhk9EN09Tw=
X-Google-Smtp-Source: AMsMyM42dIMLClo5njgoA0SGJ31JL5Bd2FWq7LsxARdzkoKd95Hy8B/f8z7uTey7yJlfWUWGsj09+A==
X-Received: by 2002:a05:6402:524a:b0:45c:e2c6:6ef7 with SMTP id t10-20020a056402524a00b0045ce2c66ef7mr11624214edd.421.1666256588053;
        Thu, 20 Oct 2022 02:03:08 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007933047f923sm1668381ejf.118.2022.10.20.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:03:07 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v2 0/5] Support more parts in LTC2983
Date:   Thu, 20 Oct 2022 12:02:52 +0300
Message-Id: <20221020090257.1717053-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the following parts:
 * LTC2984
 * LTC2986
 * LTM2985

The LTC2984 is a variant of the LTC2983 with EEPROM.
The LTC2986 is a variant of the LTC2983 with only 10 channels,
EEPROM and support for active analog temperature sensors.
The LTM2985 is software-compatible with the LTC2986.

Also, remove excessive allocations on resume.

V1 -> V2:
 * add Fixes tag
 * add patch that fixes the regmap_bulk_write() call with stack allocated
   buffer
 * add patch that refines the binding in preperation for adding new
   parts support to it
 * do not use stack allocated buffer for writing the EEPROM key

Cosmin Tanislav (5):
  iio: temperature: ltc2983: allocate iio channels once
  iio: temperature: ltc2983: make bulk write buffer DMA-safe
  dt-bindings: iio: temperature: ltc2983: refine
  dt-bindings: iio: temperature: ltc2983: support more parts
  iio: temperature: ltc2983: support more parts

 .../bindings/iio/temperature/adi,ltc2983.yaml | 378 ++++++++++++------
 drivers/iio/temperature/ltc2983.c             | 206 +++++++++-
 2 files changed, 434 insertions(+), 150 deletions(-)

-- 
2.38.1

