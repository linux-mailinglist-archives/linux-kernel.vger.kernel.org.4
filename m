Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1A735C20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjFSQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFSQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:22:55 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA77E60
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:22:53 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5607cdb0959so387288eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687191773; x=1689783773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dBZ4QE3iHZ2NqaoR/mbbh84ypRmb1ClG886OJW8OOA=;
        b=JPctqpk/k4DOgnE5DJdIZ1VK2Qu5L8ICLwX17bvGkAccLb/f9teMUmaFA+nVdNbSAr
         lC3qXg2ny1vtOtJhLZC+38UlOOJ+S1LxtFq9pX6RG3tPwn+TflOAucFuhLIk3DHMNOfl
         fmi1DwXfbJrw2Ripmy8919WOj7UvLon4bcRQG07yCvoErIl5ksV2dGcTbLM8/LZQJYck
         Zw6x1+pXu+yLhJ9Pg+gLmNtxqWO+B/rDd9lPjL3t95kkFqYIJd+qTmgoRhMCb7KBoimy
         m44EaM2lJnwn2ib0KZYosCg6rrv6tJU7oNZf7DJldnFIKd+azJQXMJ6IUX8YIbgAyAOb
         NyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191773; x=1689783773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dBZ4QE3iHZ2NqaoR/mbbh84ypRmb1ClG886OJW8OOA=;
        b=NLGycij2sEiGgsbRThF3k3ow67Ms9URPoH7B9LYkqWj/nkuS1stkEn9ENftk2Nt4qq
         sWxlN6pKQbKLnYCH+MZxXbSoGkWh1HcfKZwMc+Sf/EE2SslQiE8BV6hHByOcajhesykS
         4xh/XNpa2qY6VDSpGCc6HtqC53UE1sANIk1umtm0LLbgFZRXXOf/rT9WZpY/Hu58shDS
         /VyA1IBrY+Tf5YM41Ga9YMaSd92T5V9TVFSZKdGlvI5Wq0dReP4IMdNioojsovhY/sWL
         +J0rt3U6TkHu4sVJ9GqqK3VWWJrHbUJST5xVL/nrVZ86hi/U5lMOWzkLQwRTRxbyswuG
         xY9A==
X-Gm-Message-State: AC+VfDxH1oPYZKm/ui2DN8I/tytlnrb1SuvP0tOF8slGSvKQBJOHN1Lp
        NGJf1ptFifmUhRn41zcgIII=
X-Google-Smtp-Source: ACHHUZ6RBh7MoPUIKifmx/4+vl5ryIe2Zirj7C2/QmQdiz9P7UWQdKqmpaa7hxLgfEy2EX1eolO2PA==
X-Received: by 2002:aca:2115:0:b0:39e:b834:1853 with SMTP id 21-20020aca2115000000b0039eb8341853mr4514837oiz.33.1687191772986;
        Mon, 19 Jun 2023 09:22:52 -0700 (PDT)
Received: from redkillpc.. ([49.207.216.186])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a1a4200b0025f09822d7csm62997pjl.24.2023.06.19.09.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:22:52 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: [PATCH v6 1/2] axis-fifo: use devm_kasprintf() for allocating formatted strings
Date:   Mon, 19 Jun 2023 21:52:44 +0530
Message-Id: <20230619162246.33007-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZI/5H+GZU6/2osGT@redkillpc>
References: <ZI/5H+GZU6/2osGT@redkillpc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In various places, string buffers of a fixed size are allocated, and
filled using snprintf() with the same fixed size, which is error-prone.

Replace this by calling devm_kasprintf() instead, which always uses the
appropriate size.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
V5 -> V6: Split into api change and name change commits
V4 -> V5: Remove the dev_info() and use a unique identifier for dev name
V3 -> V4: Split into warning fixing and cleanup commits
V2 -> V3: Fix smatch warnings from kernel test robot
V1 -> V2: Split into logical commits and fix commit message

 drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7a21f2423204..7d8da9ce2db8 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -816,10 +816,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
-	if (!device_name)
-		return -ENOMEM;
-
 	/* allocate device wrapper memory */
 	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
 	if (!fifo)
@@ -857,7 +853,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
 	/* create unique device name */
-	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%p", DRIVER_NAME, &r_mem->start);
+	if (!device_name) {
+		rc = -ENOMEM;
+		goto err_initial;
+	}
 	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
 
 	/* ----------------------------

base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
-- 
2.34.1

