Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7B60941F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJWO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJWO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:57:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9A5C97B;
        Sun, 23 Oct 2022 07:57:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so8165812wmr.2;
        Sun, 23 Oct 2022 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5N970xLEDqJdJWYY9u+esmQAZbPzXuz4v0lBTGeL7gI=;
        b=Us+2SC+vgzvovV5/vrRo1YZQE9myy0R2LEpEag5Wv4SVx03oi+JgRIcIA37EeSdcVR
         mr+1XjDVCdRZu1n+S6QCYLIk5L014PjmqdZOa1gbcBBs4z+AZ8Uj24kEKEaW0WsghnZw
         g/38o4K6TtxWrVuWo1HHPZGMH3aaBlT5gdyqswXLbrFCyvNvhnx6tjIarELDlAuNKHoM
         4UtnAMOrsX4K2F6QEqjkBK4Yz/3aHmhbeE/1PwZD+3/nDh5+om0LLDsU3iLBEBPxazTH
         JCIzuNCjzbc3rABz7g7++X4MYYrtu0pACpYkgZR3KBq8eTkL8HCE8iypjJuaihv6voCJ
         usTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N970xLEDqJdJWYY9u+esmQAZbPzXuz4v0lBTGeL7gI=;
        b=mYloidtfQkua5fEgAbN8BmWY0UeI8xxa5wwkOiUmBWtduStfDTWJdKaK2Zs0deBjlo
         VXTzAy5PX1/ZopeCS9h3bk6qSYeEpVJNJUl7wQvVq1Hc4+ffn7g2KVLAstu0Q8r62FnI
         22CIDvUdEZkXXUMbi8dz1gGa54dOEVOgufuYDoNAhIeYDyVPuAWB86+5EBdp+OJSVgJr
         ZDdYuUuQP95gt8WQDj2KT+6jFWKeRd+P4dh5k6rfMnEt21A/jL1sv+uS0mwgMkjnR3sb
         F6h87dxZbqBlrulQAWXGyS/lnnZ/vT3EHsYv9M87IcEctWOo17NtFDKaJJ0a6OiMgEdj
         QkDg==
X-Gm-Message-State: ACrzQf0MecAMFqvMVqx+EQvLGGYZN3XXgZQv/qd/v0w0Cy7NPO0zABlP
        RIC8tW2pmh6vkbJhbkSpmig=
X-Google-Smtp-Source: AMsMyM6GM6lQttmKPWFkHc3/nspixgQvUJqM4+/klmp9IODFfN5LgygB/74btqrG6jctv8Y0X7ibdQ==
X-Received: by 2002:a05:600c:4e8a:b0:3c6:da7c:8d71 with SMTP id f10-20020a05600c4e8a00b003c6da7c8d71mr37231818wmq.16.1666537022619;
        Sun, 23 Oct 2022 07:57:02 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id l1-20020a7bc341000000b003b497138093sm8219656wmj.47.2022.10.23.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:57:02 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Add support for X1000 audio clocks
Date:   Sun, 23 Oct 2022 15:56:48 +0100
Message-Id: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
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

The first three patches of this series modify the Ingenic CGU driver to
allow the X1000's I2S divider to be modeled as a PLL clock. This is not
really true -- it's just a fractional divider -- but doing it this way
maximizes code reuse and avoids the need for a custom clock. (Thanks to
Zhou Yanjie & Paul Cercueil for the idea.)

The last two patches actually add the X1000 SoC's audio clocks.

Aidan MacDonald (5):
  clk: ingenic: Make PLL clock "od" field optional
  clk: ingenic: Make PLL clock enable_bit and stable_bit optional
  clk: ingenic: Add .set_rate_hook() for PLL clocks
  dt-bindings: ingenic,x1000-cgu: Add audio clocks
  clk: ingenic: Add X1000 audio clocks

 drivers/clk/ingenic/cgu.c                     | 45 +++++++++---
 drivers/clk/ingenic/cgu.h                     | 17 +++--
 drivers/clk/ingenic/x1000-cgu.c               | 69 +++++++++++++++++++
 include/dt-bindings/clock/ingenic,x1000-cgu.h |  4 ++
 4 files changed, 120 insertions(+), 15 deletions(-)

-- 
2.38.1

