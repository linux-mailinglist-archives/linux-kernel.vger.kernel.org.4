Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602B05B8795
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiINLxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiINLxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:53:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367DE7CB78;
        Wed, 14 Sep 2022 04:53:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so14213789pjl.0;
        Wed, 14 Sep 2022 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=zNTAPmubHkNZqERn8Ow0wjaXzc3lyqgqXMfCavEhJtY=;
        b=XtZV7oNVYofg92Yb3OX3u7WO49325wE9x86I1EwJeDLpMyFVEI6aWEHF+F2CxM6zGf
         d7b12ga77Yj10JAHy0RwKk6n+LzdcRI5lQKuI7JxBf9FPUhR6iDIdFQ3N61h64hS5Q51
         BcS19VL8tkNUrGVXN06aoxuBoXoxyNRSrgQw+71JKgx0E7RCkiKjC9J5ks0alNkEJsCE
         MaISpyXyfwKEldUldBEkOfhk3+wDXC1fj3EQmnZavxwK/dgQ1lR8cKAbI3w5XdnUu9Q6
         AKb/Bu5LNiuiNRtkZG0SwJ1EZnU9yAuEP4ejK8/L/5S9Z02Y/ambZRUlZtjwLioRqRIj
         vMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zNTAPmubHkNZqERn8Ow0wjaXzc3lyqgqXMfCavEhJtY=;
        b=N1U35fPGpqWEdQgblWMDdbVZiyeJUsBl73ZHEkhSLtYN3fhVpLZlyVETAUcRlvg7bh
         VA2XJUC9m3UXpHHJYhwe/0jR0feqS6a7D0b6lDwVi6EIg3d5Y+u5hNFrJxcCaYYDuNL5
         RHnESva4+t4HFzHKHjHcRI3IzJO16jnusEXKFob3TMmwICSvvYn2+dnQT8+FHcR0ZZtX
         dB4bLQ+7jOZsK8XUoFz6f9NKBK0C23aOZmUI8sJG6AWL23wCW/w90HiAhfhcWPviQeGq
         yKbVCCH0NpnAnR2mtXY2tzVwdIKrX1JoRR8c25kSneihE7G0lbjHl+3Q0U1EZuODwdC+
         gWag==
X-Gm-Message-State: ACrzQf2WdVUMRSTFMz4uGAVc2yV+HlWn45dYEQ/b8PguTYZcZvkpM168
        pppDbh+kInAZi2yGpBvfW+yChkoPp/A=
X-Google-Smtp-Source: AMsMyM63y+ZAyDVuiNe57GaYzJpX0zfKOHIMdAmdRcLvqUT30aH7rhdhTFkoPlNGah14pDgMX8U/OQ==
X-Received: by 2002:a17:90a:13c8:b0:200:17ca:f183 with SMTP id s8-20020a17090a13c800b0020017caf183mr4329771pjf.104.1663156392497;
        Wed, 14 Sep 2022 04:53:12 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce3:4f78:48c4:2ac5:ccad:657d])
        by smtp.gmail.com with ESMTPSA id f189-20020a6238c6000000b00540e3cbf6c1sm9809854pfa.180.2022.09.14.04.53.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2022 04:53:12 -0700 (PDT)
Date:   Wed, 14 Sep 2022 17:23:07 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v3] ARM: dts: aspeed: yosemit V2: Disable the EEPROM driver
Message-ID: <20220914115307.GA339@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed NIC EEPROM driver IPMB-12 channel and enabled it as
generic i2c EEPROM.

---
--- v3- Updated the title and commit
--- v2- Updated the title
--- v1- Initial draft
---

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..2293f10e94d6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -207,12 +207,6 @@
 
 &i2c12 {
 	status = "okay";
-	//MEZZ_FRU
-	eeprom@51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
 };
 
 &pwm_tacho {
-- 
2.17.1

