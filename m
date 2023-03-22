Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B76C4D80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjCVOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCVOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:23:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC57D9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:22:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t15so17259523wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494974;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7X/sea70dluHDkMLiSPr+5a4l7Uo9ZKTt0hyEIsAVaQ=;
        b=CFMsmld2enyOg6yWooL32HVlSN8I4gSHSC6f9QaYYDjX03DMpN0XncjRLMbR2oPipt
         5FCG1CqmyL2X6r9+Y6Xf1XDWcFWOXVzbmqro6ye2ILtfc2HEumap9opV5D9kamWkKYIb
         sVyG9Up40+/8tGaXG7FBn9zo2RsrN8WuFufim/HRRwIuthwvm6eiKYLJYjUVJzL4EGnj
         GWjdz/Py2gRJeklfMRvy4fg8+4Pv683VhnZz9QjWwWx8hg1zHhM7W0X+IaexHg8iXCxT
         B6xUu5IMqSt0v7FuS3qIXI5hrKCNDp2nAkVHfGbLQu+1RXj3ycNe5fsTe+FZvZAarRLJ
         wMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494974;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X/sea70dluHDkMLiSPr+5a4l7Uo9ZKTt0hyEIsAVaQ=;
        b=UsWEXqwDP55DBGmPuQ2TNq8xKDEBbIhpODY5XfDNWqL3sGNBUB9lj8Q2T2/4zp9r8/
         cRXBma/njLfyEzFbP07g+aVFS8cGLgvuApgDOpx8gnSK1U6RTVmJCsBpL+5MWf51dkEX
         M4TXZ83gJkh1rkS6YkkhbzApSJ/3uznWE2yPWLGxeZ1aD4e/1dEHKZGFOe7CbC1vrIHJ
         mQ0rk65JAePCUAtNNVxnLFqdgdlR4LOtT33klwQGOJJKFm+cdJzRSEKiRAPhVXQmqbcD
         ZvMDqM719W/2T3N+QxO+QHpHuT48qjS/9aLk20FiHgmfWATTTDBxDt5kLTbW1/aw9df2
         tiWQ==
X-Gm-Message-State: AAQBX9cOXO9HJlrtzj4OV28OUW5NEU4C82coiyy42Kt5sjLmeB6yBgQW
        mnk43qtPbvHGXlfLn+HTe+Nis5wMv1yOKZZM
X-Google-Smtp-Source: AKy350ZEGoUrD+C7SMSCbODr+7cMWRowBX3EGFPCLpYLlHEDQrhzowPfhIswpi2gf4T4eGo1469hKQ==
X-Received: by 2002:a5d:4570:0:b0:2d8:908c:8fa0 with SMTP id a16-20020a5d4570000000b002d8908c8fa0mr20154wrc.9.1679494973614;
        Wed, 22 Mar 2023 07:22:53 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d6a8f000000b002d743eeab39sm7210957wru.58.2023.03.22.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:22:53 -0700 (PDT)
Date:   Wed, 22 Mar 2023 19:22:50 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: remove extra blank line
Message-ID: <ZBsPOk3TgQTfNAAK@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra blank line reported by checkpatch script.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/most/dim2/dim2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 21d1c9f24c3d..9fa665c4038f 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -989,7 +989,6 @@ static int rcar_gen2_enable(struct platform_device *pdev)
 		writel(0x04, dev->io_base + 0x600);
 	}

-
 	/* BBCR = 0b11 */
 	writel(0x03, dev->io_base + 0x500);
 	writel(0x0002FF02, dev->io_base + 0x508);
--
2.34.1

