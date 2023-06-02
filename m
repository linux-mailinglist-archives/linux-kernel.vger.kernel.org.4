Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6857202CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjFBNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjFBNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:11:59 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BBE4E;
        Fri,  2 Jun 2023 06:11:24 -0700 (PDT)
Date:   Fri, 02 Jun 2023 13:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685711482; x=1685970682;
        bh=JFatXUbuyrOmuslFYZorSsbJ/niD1OMN+SFRZ93mUp0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=SH2BA/+A+42W4kJQFxS4tgCCZ16HzRLDYV+Gn65qMZ5lSBJwH0ZBbzoRrI/sKWzV2
         me7EimoUVqhORcCyP8Mnl3l71zUriW+b4Bj/Fkcwi8llJUuG+LGIiXW8lSJdaLVlJf
         8gznqqxvky5acOLfbXQIFv2BmroRCrn8z+f113fU8b5vy93aHcwVOAZbER7lcqBio6
         bmBe9b/WVdm7CTNxrjvvYWFpeUhzOog26C9fTLbK3BUcTFuWBWXwuigKulyEE3S9c8
         icA8MVjujuAmkogb/w3pR7nvvRSretMbgnWleCBBFu1FVkCFmo7OK2kIZJw1OP33b8
         aBCitq5OUeE1w==
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
Subject: [PATCH 2/2] leds: sgm3140: Add richtek,rt5033-led compatible
Message-ID: <20230602131024.260297-1-raymondhackley@protonmail.com>
In-Reply-To: <20230602130644.259933-1-raymondhackley@protonmail.com>
References: <20230602130644.259933-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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


