Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A809C63125A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 04:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKTDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 22:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKTDD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 22:03:28 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BE0B4818;
        Sat, 19 Nov 2022 19:03:27 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id k2so4808146qvo.1;
        Sat, 19 Nov 2022 19:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3ZLtBm0Tp52wW3OyBwZ0ioH8NSv4clGJ5jYAcXM5gw=;
        b=XHDKLERdcxFQ0lj0gT0uZxwu/30BC7yb/XW6E+bvfB5MqpvtemUHXVenGrZ/H8UD8m
         P1D8qSou4V8iZ/nb82QcjeYKIQWDT3DfuC+lUH0clTpnLTtZ4EhRuIuK/gerPGMoENER
         lxA5ixluy2/+I+nE1skdJ4Mcj1rgCAkz8ELXA31uWvdxWyRMNekFpvN0xg5Ajkm5kKNX
         2AtLgk4zTjPCLoAFwVQfqdNf83tkROZSvy0PNgHd9UdQ7bnDahNs3v1zEPxCLC0CuvyD
         0k696xdq77fINUaDo773/xsFooXsdiwyhXW7DdRlQRnqQtj9naoYVpIMvVsmEoaegfRg
         1rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3ZLtBm0Tp52wW3OyBwZ0ioH8NSv4clGJ5jYAcXM5gw=;
        b=yhnxrqdSspYGKCnrpWlfx3cVnuDqDGoLnjZlWS6geSwF/n+u9q+ClIB9wFed0hvPGW
         TrThGYDh3uLMhNShGIijNqhEKuVY2Q+lCuh3cjOY8eKeB3ax/1PcOkuuxvx1FPoBEtZY
         Hrov7tj9OuFfZFwRY4uscJ09rDQ8JDtQA0sP0aJOnlBCWRFLKujVccaUPEz09vFGv0Sc
         TTmUALTGcyQctJ7CPoE2/YGQAyGRfDtnyNW+M7Fk3kJ9gOFnNIyG11kS+h1oKrfnAnMP
         wqo81+vB1B8gL33aCoJf/rGAhM0NDjCz32WYdAPOhlqJ0LBgz9+kxq3gUTDc7avn49i1
         eyfA==
X-Gm-Message-State: ANoB5pnPWQ9Ww5NmZj/XoWYsvuw3PsD0ZKKMuJIOy0ZEK39+hxq2RjZy
        4BYemWYSg7yvAPP1Ls5AHbRfRbKu5qE=
X-Google-Smtp-Source: AA0mqf4m7Lsl7R1/c+qcevJF27vxxJNFNsEdhENVdw12h2UnaJTbrRt2vFdFr6ld4C5IWuljGIdplQ==
X-Received: by 2002:ad4:5343:0:b0:4b1:8165:58da with SMTP id v3-20020ad45343000000b004b1816558damr12706647qvs.30.1668913406515;
        Sat, 19 Nov 2022 19:03:26 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b0039cc47752casm4522423qtg.77.2022.11.19.19.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:03:26 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 3/4] clk: lmk04832: drop superfluous #include
Date:   Sat, 19 Nov 2022 22:02:56 -0500
Message-Id: <20221120030257.531153-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
In-Reply-To: <20221120030257.531153-1-liambeguin@gmail.com>
References: <20221120030257.531153-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iwyu warnings: (new ones prefixed by >>)
>> drivers/clk/clk-lmk04832.c:15:1: iwyu: warning: superfluous #include <linux/debugfs.h>
>> drivers/clk/clk-lmk04832.c:20:1: iwyu: warning: superfluous #include <linux/uaccess.h>

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202107110620.926Sm95z-lkp@intel.com/
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/clk/clk-lmk04832.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 3a5961fe604d..7e01370fb6d4 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -12,12 +12,10 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/gcd.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/uaccess.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
-- 
2.37.1.223.g6a475b71f8c4

