Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573CF67C85E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbjAZKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbjAZKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:19:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50CD7EC1;
        Thu, 26 Jan 2023 02:18:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2681B81D51;
        Thu, 26 Jan 2023 10:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7796DC433EF;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674728284;
        bh=SEA+SZj/8CwLwSOICO5ZSda/48TRihR4WgSENpJnHlE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=dKXBx/z7CUYQWYkkmIgOzX28kWhIutpOaJXbSKLxy1EAcSXybiMeuMpjdaYfHKxFk
         M2m9E4bGDSKaXNzX+opJN0+pg/zl4D4vGv9LIplYBs93JzrUUpFuM6aPuw6G3fJLX9
         lMhgJDQQd/N3QqCpXflcuXzKqNHazPFQrkooxvPPmyflDWeghKVUk78RVCT0HpuPOd
         UrHpMOsLUeYFHnWu+kiajluAvoOZrXxFD8qDGNks0zpZ0cnJ1z9SWOxlnmzxSC6UHH
         Zs1BwsbAgmQFCfUe+p58Y5D1/NmUzJxalk+lgOcgty5SqlSnw9efnTc/X90fEDErdj
         5/OL1ZUo/KApQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 5F57CC54E94;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
From:   Niall Leonard via B4 Submission Endpoint 
        <devnull+nl250060.ncr.com@kernel.org>
Date:   Thu, 26 Jan 2023 10:17:22 +0000
Subject: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
In-Reply-To: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niall Leonard <nl250060@ncr.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=nl250060@ncr.com;
 h=from:subject:message-id; bh=TZqj8LOqd2ElAWFa5TLfeyGZqTZ8bzLHl7An5WBxTgA=; 
 =?utf-8?q?b=3DowEBbQKS/ZANAwAKAVGiIrYFD2P/AcsmYgBj0lNa8K940tPfSmc2r9nNjxeac?=
 =?utf-8?q?sEcqV+EBYR7dCIh_eoyWvsuJAjMEAAEKAB0WIQSha1EPjh6hUqdtwZNRoiK2BQ9j/?=
 =?utf-8?q?wUCY9JTWgAKCRBRoiK2BQ9j/3RpD/_4jj77vSlXxpbuPYKFdn0vEZhfXOLPaXlCCs?=
 =?utf-8?q?+CkYcU39mGs9v4OjplKJUVPuuCVERaCmKgdhPtS1D9X_wexpEBPbTOiuECj2lFIWp?=
 =?utf-8?q?6Cv9C3jYDNCaBCsRIZ2mZ70FJiHXJgoSeZ7QK6NJD+ygLtbPGNKjVh9dV_N4kkmiB?=
 =?utf-8?q?naSEuTjXHJ+cfMapEnVNmElK20rRcoxJp+Hldqw+bDCYUrGatqrCxCWwD22XkWSCI?=
 =?utf-8?q?l4pmLp_bwVZvgxTpuvBeC2gE63lwTBNH18cOAYgZ0Bl4kZRmLbEbiYFWEaWI5+tnU?=
 =?utf-8?q?1aPd2dn52rnuKZtcVihJ_P3adT7IxtLs+cDFZC/sIL76sYewxV8T6dwJ7fgo2Eslz?=
 =?utf-8?q?vAksfvo0cHTA+ZzuZRyXgiH7gDH9UozTLs_Ql7nmtvS97ojMeM6lrEY4FUU6V0qGH?=
 =?utf-8?q?yPvFbuzSGJeK/YzMM+Qv5LywW0gWeZLkLBpRulik2xhtkAfc_U/7st71QO4Lp6PU+?=
 =?utf-8?q?Mewz1a2XlZHpTBxnT4q7z2c4BCXbROfy4wCOspiWzy5NmMU5YGIZHaZmUtIJkY_iC?=
 =?utf-8?q?D4NQnRTXvaCgMuscLbRgADLRexTfRekrSnazsftSYN/fiQZOSWLpnqYYzPYiD7BHR?=
 =?utf-8?q?QansuPMq6A4?=
 4UZCrn2KSFMw0awdyMxc81ntXCmZkmp3lVo9h83HdO8JWZyvfHcxL1R0Madw==
X-Developer-Key: i=nl250060@ncr.com; a=openpgp;
 fpr=A16B510F8E1EA152A76DC19351A222B6050F63FF
X-Endpoint-Received: by B4 Submission Endpoint for nl250060@ncr.com/default with auth_id=26
X-Original-From: Niall Leonard <nl250060@ncr.com>
Reply-To: <nl250060@ncr.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niall Leonard <nl250060@ncr.com>

Added optional "no-input" property

Signed-off-by: Niall Leonard <nl250060@ncr.com>
---
 Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
index 038c3a6a1f4d..9405f9dad522 100644
--- a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
@@ -18,6 +18,7 @@ Required properties:
 
 Optional properties:
 	- no-output: GPIOs are read-only.
+	- no-input: GPIOs are write-only. Read is via a shadow register.
 
 Examples:
 	gpio0: gpio0@e0000000 {

-- 
2.34.1

