Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AAA67FF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjA2Mz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2MzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:55:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021461C5B9;
        Sun, 29 Jan 2023 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674996918; bh=ODXbyUT2wHd3CmhiQMj501ChYR57hALSmWu/oQs/2xI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=nFp6wsQM59FXN1T4qXA8A16mYe18mBlNyPxBJ9U2aqPl/4MuX1r87gpHkFaMie6uS
         +BZ6NLLdWJcRiXXYLI7sFwS4lRlAuGfOL2nwz6+9f6ZWVihZyDQfC4iw94Xt77dDOZ
         vneHEfEL3s0X4qsKMMxfaKbUz2m6w4iLlXEZWe0kawnUU4qwTrUhRsY2rqAeTgZiBE
         e4wHAwgr8qGdJYJ4mnZx+rvR8dt+UoMMy+Kt8EPZY/U9ZEAlwi1xf9kbJu8TISHZlm
         KmA0MBXcuTzdypSc9RPrkVTXNgfzzRyegYeJa8Fy5cYkdfJpizldfTM8mve9/K0NKz
         ZiLkDdQL4AY/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1oXJ530uap-00tzfs; Sun, 29
 Jan 2023 13:55:18 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-omap@vger.kernel.org
Subject: [PATCH] mfd: tps65910: Fix a typo ("regualator")
Date:   Sun, 29 Jan 2023 13:55:14 +0100
Message-Id: <20230129125515.1313991-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X9A94t2JCgdikhaasPDyPFhH52e7mdVIE/aEMhQ4E8lnzW10gMZ
 Q+G8jwxNS+40m80mOyZbZjWZDHm4u++5VmLfQoVAJWQVmyIcQfmRl37XHCKLOY8j6xA+as3
 11nKePoo8kFK5wNkrVXbPfCv6FQS1DchHBOoCqcRexPhBv8yzzYC3jZXStUmzGGk1IylLtH
 jbSjdUAcj9o9wDIHZ7qQg==
UI-OutboundReport: notjunk:1;M01:P0:V3Hg6UxqEFM=;rppNV11pFIobTGkP2D3XT3ZFwHz
 GnHhuTp+gdEUfIkvJvWbIT7xdXckfabF2SwpElxY28vp3nCu0iGUgAriZ/xqk4YfUVxIi9JWL
 agAwEySrKiCLf2Is2AfIqJUDd1ElhRkbgntq07pLKRq/TjHZk2NBD9svOT0OaeRF0ef2oiYEC
 6CWOyst7T7xO2PeyS3RBCzmhSrM68UxQh1Vq1qdufptwcdEU1NJu5iVF6w9vEbIncU11rDQWs
 SB2eIT6qwH25yQyIeMhOrbLEIt1+JtTyJlAINdSf2ulAaHh1d4RQ9ahlcvSmO1qpPyF4n0HIR
 4OcMs7mB/VANDveuxaFDYd5FKrcvz7yJCaBru9pmcn7FxIQ8u7DFmyGrlZsw9aPs7Q+oDXzjo
 oiOxjDx7V6Ya34mmp1CsBKZqv2jgLczFsmoBiKFah87bDdJQbMFialnaGuWCM82Dn9Zlo77JD
 77FMTHjaLBK+V7ShtYBoL9+eAlKo8WqcWmCItQK22PLcS8IKIP3gFUXehMTVHZccAtWJy6Gh1
 Ew24udsflqrIYP7p57Vq5dh+wr04M2Lq039v8tSqhyWZXOFNrzbugNasvuTigKt4u3pDDuPeC
 UneFLy676/JFKifdEOAVrOPXdDUIDmqaMIKcO/3Bt0wWqQlwo+UVooc2u60uXFOZnwPQfK67A
 YiVRbvw6b9iLJaHjs2YiP/uswCdJYjfXlrG8aZCliW0wIUsWDwKal22YCS12SiwNDXycnToKI
 maa+7aSz93CUSKAZ08SrJiR18yCje0eVm7AEfe5yS7WZfZ6/iMYlIaLYBFNU4vrzG6KIjptlh
 9cKdtUFSDDHaZAG6/VdTym0+aRCpn+4g87RmoMt5VggAO7y1rVE4iH8N37v8qd+AnJpwxLFni
 KPYtiKGGfc7cp5WUzLChprRsRj6jQbJx7TPXUW2trKaApIHTAvJn+q5zDZzRArsOgQkFbI7AK
 +62XXrHydhD+gNc9XxcdQbiHyio=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spell it as "regulator".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mfd/tps65910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 821c0277a2edc..6a892826cd9c2 100644
=2D-- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -262,7 +262,7 @@ static bool is_volatile_reg(struct device *dev, unsign=
ed int reg)

 	/*
 	 * Caching all regulator registers.
-	 * All regualator register address range is same for
+	 * All regulator register address range is same for
 	 * TPS65910 and TPS65911
 	 */
 	if ((reg >=3D TPS65910_VIO) && (reg <=3D TPS65910_VDAC)) {
=2D-
2.39.0

