Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86EC5EEB01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiI2BeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiI2Bd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:33:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D911E0E1;
        Wed, 28 Sep 2022 18:33:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u92so4329655pjh.3;
        Wed, 28 Sep 2022 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A78/h1Yexl7Q/hTxPF37Ok/UONpxdO8dwh6yuAvjHaE=;
        b=NNLGLEC/GijEfGayOwrdysIhBGUN6hZimivsHLoPSIXzx7CHRS8+TYcFftyeoMVVgV
         AlQRuf3NXs64o+Z472U+3zrYYM12aXQ0mZyEwb97haD48mls9exboEHKV20BK5hP4WI7
         3wVNCsE68ZR/5S3Jkiu4Bh9iBtueQ19SYjMDUsah3FFuKBeGCYYbbnIhZUFCKfe+6/e8
         Y6SqA9h3TQD7uC6ZaGmmMXOk0T7UCkk2qUun2e5p4psmg4TKILBKLUMaetlPLmgUOsd0
         ka3Cecj93snUkuIorTJAAb3tOFa9GsBNXJI/+QnXVqdPP1B5caLfD5UxcTvK59EpXCdj
         qAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A78/h1Yexl7Q/hTxPF37Ok/UONpxdO8dwh6yuAvjHaE=;
        b=C8S68HWezjxcyruC+Qb3F6XJvvgqhusYIBitkDe4D6vwmYaM3WwoLQ5rMGWpFeCTjw
         S351vUR6vxFuBkYEp+eLWaZCPXJy8lv58U5D/uZUSzgv6K7oW0VMKrIoE6f4ngypieKb
         iYbMbqgO4DguPVmKzfonYMpaW18iQXGm+/1DY+dDIGGXb8S8J/m3baLpUblvzJ6+WPdZ
         lji7IcWPBr1dEizk1la3+0cjI4FdSEVLhHNaeEIVggm44nh6WJckBEossOBjyzU/QbXW
         JYdL2D8ZkTHOG5DYBFJL9U1XGjrZN3u3yaAjD+/4iHg9XFT/c8GbToxcbgsGPJZjX4QF
         aLYw==
X-Gm-Message-State: ACrzQf1ImQaFFBjpDvNdkwjmT7lU365++NO67HI/zurbu1SDuzgnIvlY
        g3D2TuYc4LsCO0YWoo/irru7WNcubF0=
X-Google-Smtp-Source: AMsMyM4wIjgz2FTKS0abEguNm0kAB61a/hyGThRFcFbfCfPZ0jHRtBscxBjoOlEpM22JvQVfP7Arig==
X-Received: by 2002:a17:902:d70e:b0:178:2d9d:ba7b with SMTP id w14-20020a170902d70e00b001782d9dba7bmr916995ply.90.1664415230256;
        Wed, 28 Sep 2022 18:33:50 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902ca0300b0016f85feae65sm4385587pld.87.2022.09.28.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:33:50 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: bletchley: enable emmc and ehci1
Date:   Thu, 29 Sep 2022 09:31:30 +0800
Message-Id: <20220929013130.1916525-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
References: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
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

Enable both emmc-controller and emmc nodes for storage soultion on
bletchley, and enable ehci1 node as second storage plan.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index f5986f5909cd0..a619eec70633a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -1046,6 +1046,18 @@ &ehci0 {
 	status = "okay";
 };
 
+&ehci1 {
+	status = "okay";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+};
+
 &pinctrl {
 	pinctrl_gpiov2_unbiased_default: gpiov2 {
 		pins = "AD14";
-- 
2.31.1

