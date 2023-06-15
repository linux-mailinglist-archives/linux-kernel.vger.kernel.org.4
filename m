Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B95731F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjFORcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjFORcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:32:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F8271E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:32:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso11050054e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686850349; x=1689442349;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJxuaJ5691h/k4UcTAuN0XDw63vuAh/dneyBNjCjVmY=;
        b=mV/e0OUTEj46icDsVr+JRbtP4EPO9HzVPEwP6B2e4JDKoPWX3NXfgikVpy+7wg2NbD
         8V28anN5XJveBeXd0RgY9vPuEF6TN0Cqam02EPVxvzB5pxFuLp3AbYeS76tZawInOIj9
         KfctomLfGfGYOd2X/XsNVfPd+G8HUmPVxTxg0ImRuLMoRfGGJQ7j6WjP38I5BylB+A+V
         LosWW2IqnTnrq3ogF/+DAYkkRxAm8QGNNJo1EdpLM6Cdg5oqwkbmtPwEt3Iy90YmWpVA
         Zpr+3HkzSgtohniS0LFHzVhyvY91mzUP3v9ZMhqVHIC4cJnqsY7R3vwvI0FEjG6movI5
         8PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850349; x=1689442349;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJxuaJ5691h/k4UcTAuN0XDw63vuAh/dneyBNjCjVmY=;
        b=ekRGX/fLe/52QbSIxNHciq7GRcKrQpbJpOOxHKBnt8QIbN0tw0Wto+EwQQQV88JckV
         7fNdZf0oTuduKAAU/xTm7EV9pJC8DbIF65ixMwuLChyGTlE8+mEB3kaOTzqF9tXvvl9z
         6dr8E8thLi4DS9uI23Dk0s8MoJCSEGLZLqERyxuwimUy6uV48qcyK21rqCBSkZq3EHr9
         cspmNa/s96Z2Enu1DvKW8mHBLvW6YfEru61McibrkDqRTfcsx0h3kQBKDYBtuXi9bctv
         ippwuzlDkQH1TXqWxcUimnxgL8m6A6TnScKVVJK18S0bxnS9m/LhufzgoOKWWghJWaBw
         004w==
X-Gm-Message-State: AC+VfDygxXTzEzL1tDIXUnrGUEJrdc2f3lTXHu8mylHHdHMTVWM+bOXB
        +N3VRNYM8ZATNdoZ7H6+jNQ=
X-Google-Smtp-Source: ACHHUZ6FZpgcNvW6Qi5ZSZdhqz1y/N8G1DHAib7CyXk9nmboV+EfYS5w6LkFk00Y5fDNCee33DChSA==
X-Received: by 2002:a19:ca5a:0:b0:4f7:b640:fa43 with SMTP id h26-20020a19ca5a000000b004f7b640fa43mr2399794lfj.38.1686850348704;
        Thu, 15 Jun 2023 10:32:28 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s24-20020a1709060c1800b00969f25b96basm9570398ejf.204.2023.06.15.10.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 10:32:27 -0700 (PDT)
Message-ID: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
Date:   Thu, 15 Jun 2023 19:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 0/3] Fixes for Rockchip NAND controller driver
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie contains various fixes for the Rockchip NAND controller
driver that showed up while testing boot block writing.

Fixed are:
  Always copy hwecc PA data to/from oob_poi buffer in order to be able
  to read/write the various boot block layouts.
  Add option to safely probe the driver on a NAND with unknown data layout.
  Fix oobfree layout.

Changed V3:
  Change patch order, layout fixes first
  Change prefixes
  Reword
  State that patches break all existing jffs2 users

Changed V2:
  Add tag
  Add manufacturer ops
  Reword

Johan Jonker (3):
  mtd: rawnand: rockchip-nand-controller: fix oobfree offset and
    description
  mtd: rawnand: rockchip-nand-controller: copy hwecc PA data to oob_poi
    buffer
  mtd: rawnand: rockchip-nand-controller: add skipbbt option

 .../mtd/nand/raw/rockchip-nand-controller.c   | 52 ++++++++++++-------
 1 file changed, 32 insertions(+), 20 deletions(-)

--
2.30.2

