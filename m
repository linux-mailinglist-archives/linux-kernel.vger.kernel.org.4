Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F288B5F7E8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJGUQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:16:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616312C88B;
        Fri,  7 Oct 2022 13:16:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so8765831wrp.10;
        Fri, 07 Oct 2022 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GdA86H2J4kLcpG71LMOT1m1RWdu089GydfZUniA0kLY=;
        b=bcXHkbMyR+54Z+k64xKSHfe9ZSQkZzCXYdeO3YYclr5TV4g5ymibKYFwfAZfv7fxfh
         OQcHcfU92oCpBXsOQRndtr/Fasj9/ocBNvE4i2tOVeUEtvCEUJgUo/+uyFAxSh6CrQ9h
         7leYsI71o5ybbDF8Yvl5i2Jh64hpHQvI8VbV6nYQHOctnccch2QvxsAxJ3WQlTEJqubx
         /egdE01g3m3Mz9AvupxBocE7LpiJhLtsoG9kd0x5uHD9p+ZudcQrZ15Tk8HNSTNZlHFV
         vN+a7gskH8tTqLKEWp7+BOdlbx1krswGBQ2G+D9G+OaSW0kzm+vW8KygekYeDeHmPdH8
         P9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdA86H2J4kLcpG71LMOT1m1RWdu089GydfZUniA0kLY=;
        b=xgbDMalg8PFXO4YjVilooqfcXXCfHjLdDr+ntYpy8MaatKUL5BEDQGpnd1cgcYzkXq
         h+JswFnTUcFEAT/tlLTRn4QUtXxuRdwII0i2owv/5LeHgAcOyPSBJuyYAb2WtfYruAnx
         jQ4T+7+OFch+/ntiR/erKyVbUnYqpSGihVDOb0UovBRDwkIklA43t1DuHAP/z4stq9Bw
         aY0WGtEdNMObEL7zdEr0kHdQpICV6N0T6hHRjcL242YlFNxAQDctoDB+Ju0E21lfkMxp
         f5JrbH2RGff8TuuS7z5/fVWwyzZewShZ+D1cuu0bGI1KcYwKr86TBkjzUS2SOVI/TBAS
         C8yw==
X-Gm-Message-State: ACrzQf0yq/w3y+WSYRywGnPCDznUlTp3Mu7J8TvRacX3t5x7JU7HNDOf
        WKRSH84OagbscIRAzl2Mt/A=
X-Google-Smtp-Source: AMsMyM7Sz8XPXf/QXyxR1mcsg1u32gLI0Q5z77krirAUpHhoIuVjSY1KRO8sU1vIPwuqiYkiSGZTSQ==
X-Received: by 2002:a05:6000:1887:b0:22e:5026:42c3 with SMTP id a7-20020a056000188700b0022e502642c3mr4328554wri.687.1665173809524;
        Fri, 07 Oct 2022 13:16:49 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y17-20020a5d4711000000b0022e47b57735sm2768624wrq.97.2022.10.07.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:16:49 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] csky: Kconfig: Fix spelling mistake "Meory" -> "Memory"
Date:   Fri,  7 Oct 2022 21:16:48 +0100
Message-Id: <20221007201648.2755133-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a Kconfig option description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index adee6ab36862..100f5eb2313e 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -269,7 +269,7 @@ menuconfig HAVE_TCM
 	bool "Tightly-Coupled/Sram Memory"
 	depends on !COMPILE_TEST
 	help
-	  The implementation are not only used by TCM (Tightly-Coupled Meory)
+	  The implementation are not only used by TCM (Tightly-Coupled Memory)
 	  but also used by sram on SOC bus. It follow existed linux tcm
 	  software interface, so that old tcm application codes could be
 	  re-used directly.
-- 
2.37.3

