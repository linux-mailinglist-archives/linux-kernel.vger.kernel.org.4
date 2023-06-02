Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BCA720381
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjFBNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjFBNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:38:20 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94FD136;
        Fri,  2 Jun 2023 06:38:18 -0700 (PDT)
Date:   Fri, 02 Jun 2023 13:38:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685713095; x=1685972295;
        bh=JFatXUbuyrOmuslFYZorSsbJ/niD1OMN+SFRZ93mUp0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=P9w9TClBgI+Je7GgWb9dXSFJ7zYBMTvmerw9q0r7kVJi1d6Tyg4s66/YeQKWLcDyY
         2DeXa+L8HFJrQHSlOoYpsEOajOLRYOLPgu39wxZ8Ul0GceuNcFwTt4fpnKfNrkP2Ue
         8/Yu3llp6tMKc8TOzLEDhLtJlqNkDZl/AcMdj4VztklFjd9d3wiubaWkRM0VSgghZJ
         s2yS3fJaYL+G2ZCFAaLTqFI/le2RenOBz5hQ5MIO1Q1+Di+ZRUPKAvxONdbgUACCAM
         Hxe6Dbwui/HhHSRfM83yHFip4KxSHhr3riO07pwKQMKqbLvINjFZdkB1ZVGQ8NQfuj
         0hYOt4NiJoD5g==
To:     open list <linux-kernel@vger.kernel.org>
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list : LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list : OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, ~postmarketos/upstreaming@lists.sr.ht
Subject: [RESEND PATCH 2/2] leds: sgm3140: Add richtek,rt5033-led compatible
Message-ID: <20230602133726.260610-1-raymondhackley@protonmail.com>
In-Reply-To: <20230602133533.260502-1-raymondhackley@protonmail.com>
References: <20230602133533.260502-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richtek's rt5033-led has pin configurations similar to sgm3140.
Add it to the compatible list.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 drivers/leds/flash/leds-sgm3140.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sg=
m3140.c
index d3a30ad94ac4..d3f50dca5136 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -291,6 +291,7 @@ static int sgm3140_remove(struct platform_device *pdev)
=20
 static const struct of_device_id sgm3140_dt_match[] =3D {
 =09{ .compatible =3D "ocs,ocp8110" },
+=09{ .compatible =3D "richtek,rt5033-led" },
 =09{ .compatible =3D "sgmicro,sgm3140" },
 =09{ /* sentinel */ }
 };
--=20
2.30.2


