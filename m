Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F67284FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjFHQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjFHQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:30:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EAC1FDC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:30:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so1445987a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241842; x=1688833842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JK6nUED3jU/yRq5Kxia5FQ+fi4P7t0pEwpfr3iX2Go=;
        b=SSUKz1jK9Qed9t+uRHaFgw0LA0tr/oknZHzTeub9Vqzp/NzBqntpHfr6v3zXDpEKi1
         LPJMzzZxsfB/77Xdxp4oUWCRR7sl7ibeHk2L+VJ6IB+SMfmIGOtaJRulnEL64DPClwzz
         ekLt0OMAizMxolBclwsuX5Tqz+1rs6ADmZaYo9fl0j+kWDuZV18toFs7/39EiAQg1GTl
         qK1ffa4v+rmFOKWgCqYMv4ML3vb4sFmzq+g29+/0HX6q+sJv5pCqnBb1fVqvl6AlpQKD
         N5Kd9sksfVKH1soJJ3x3Sc5n9RGrTH4vNhUlut8W3+rt9aFPrT4PBvKtP2ImF6/CpikE
         +HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241842; x=1688833842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JK6nUED3jU/yRq5Kxia5FQ+fi4P7t0pEwpfr3iX2Go=;
        b=JNZmPdZrb4FgaYKSmJBMtqOd+SMb1G0zmFJjoTM3wBb1zMhlYXFi/Tankn8xrW1RHB
         Z8qI8YQh5ZoH9CQDKwInzQKvppvmRqPeZh0uIqFwhQzIpvwqNW99yRwX1LB7gxr1ibfF
         kzedOUuWURP/On0YJ+M+vk8IW0Z9aUCrPOjcAy9xuCDQmfgX0WnVQOQfDVqHsfpIziKz
         FuwqNq2xwf84ek9DtpMbmP6XQk+DTcSW2MTRiwP6HDRAfg/G8S4/Q863+zhvIZcd0lrO
         SI7tTT4XNaUvkdyi1TogKS2yCL0KjcqPjGx5pF6E1WH84iCVfXypGC6+d0qztHGIp37j
         lbIw==
X-Gm-Message-State: AC+VfDzYaYlg/ZUQNRyvokf808yBiPYVm4wmKINRDLazpybRc3gvfI+J
        671raOjSp61QYwu1gGf4EKo=
X-Google-Smtp-Source: ACHHUZ6J3DH1PqULJJPmTRQ1btMyatdURfw3vUzdQur0Ka2JugVYB02NEIPk2c0MUUGZggvS5kS+vw==
X-Received: by 2002:a17:907:da1:b0:958:cc8:bd55 with SMTP id go33-20020a1709070da100b009580cc8bd55mr345832ejc.0.1686241841862;
        Thu, 08 Jun 2023 09:30:41 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0096a742beb68sm24919ejh.201.2023.06.08.09.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:30:41 -0700 (PDT)
Message-ID: <f8a10a00-c3e4-9749-789d-39fba7944646@gmail.com>
Date:   Thu, 8 Jun 2023 18:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/5] mtd: nand: raw: rockchip-nand-controller: fix nand
 timing default
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
Content-Language: en-US
In-Reply-To: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
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

Somehow not all NAND chips give a valid timing setting with the
nand_get_sdr_timings() function. Don't consider it as an error,
but fall back to the default value in order to continue to use
the driver.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index f56430f6c..e39431cfa 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -429,8 +429,10 @@ static int rk_nfc_setup_interface(struct nand_chip *chip, int target,
 		return 0;

 	timings = nand_get_sdr_timings(conf);
-	if (IS_ERR(timings))
-		return -EOPNOTSUPP;
+	if (IS_ERR(timings)) {
+		rknand->timing = 0x1081;
+		return 0;
+	}

 	if (IS_ERR(nfc->nfc_clk))
 		rate = clk_get_rate(nfc->ahb_clk);
--
2.30.2

