Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A42680032
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjA2QTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2QTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:19:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3D10ABA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675009184; bh=pYVUL+f8IjvlIH/FtKAfdcFiq3ilxIHTf8IZGsNA3S8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eojxfkb2r255SXeMovThjnueMtWzaCox6LCyBZM6gbylS4Ssr+HmKoxYFiveN7Tar
         TND1zhmdI4TL5GggrKaG2ovaBeXNFNWbfRf9o1fsqbK4X4MBEpg6qmQQ6Q6Elyqy63
         mpwCK230AIsEhHKHbJ12cq7XaX2Gijc39jT0TYiSI3fpkJ6ZmMjd9TOis+sUIO9WKi
         49Zwz/OrC657svZyJWFQ2CiT7uVrLg/ZD0UIyhY8BVZ5g99cVG//ahiXTH2z0daF5r
         rNxLI5clmHUHSYvyA69a42eHq4V1cWyHnB71I9zWyvdf9D7Sd3lb5UoN5eeguVcvkO
         Rk3XlyKch2DSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1p6HRd48Py-00KOZw; Sun, 29
 Jan 2023 17:19:44 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers: misc: ti-st: Fix a typo ("unknow")
Date:   Sun, 29 Jan 2023 17:19:41 +0100
Message-Id: <20230129161942.1627267-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YfGXvwm9tBKsIrK+LrhWXlGsGVCgt/Tt0ToafBtwhWDZw/D6I1T
 8f+Y6IIJet/C2IZWSr+Cgc+XAWboPttMIFtgAwJsL8hBt8bRHj/PfCrFLxrBAGj6yu67Ggb
 uKLOlKwB3kMSBPTrP+QFr0+j54rGVQBaxgeRhFQxw1O+qMJe3n/d9WnwHSg/oUr6qgi1IgG
 H3tRiv6JUObftRKFFPcpA==
UI-OutboundReport: notjunk:1;M01:P0:5xgEXLgTq/0=;6EP3KMcQOAh12OUk309f9X/OlnN
 LQB93DCGa+8fG16Sd4/5qz7UJTSwPwicllZ2feqwdhiI/oeCFkLWKOXBX5FQQPjsE0Bv9SY2q
 uw0xav/b7H+nSiJQICIDRgyjZ8YYm+8OJSh0EheiuOqsJkMjaCBR3cEHG2Z7QZVHLt5VYaM1x
 V80Rk4BBVfR2zcyohUSDfsHmGWkdNoYiybQtbVRwkKMoK8HjxuA6HlFwvVfuh/WQChtjbVTdY
 qol3m29J6K1Qfb8OZpKRt7lPMor912ZhvTEiLd+Z2vBkOJWa8012rVd/ZDdkpd+EjQ3o/bnDj
 DMnkTIIXcw8FV0Ccqqc1LR+rB7cRrNk+iFDsuxq+3yiLjBa47R3FDmwdCSgBjVrf4z884r/80
 yyTPiNujau5XsK+OS3rvBgyI5vXtd/ppgI2O6JCXFnwI2WYjkScuOdH3L7lwIuFHVp7Hj3oyi
 xjzVGv5SyRykYHeImIzz60LqYMB12K/je0GfuVh9Yxk+73wMGAQ91WcSD6GimWR7ygZ1ekkc8
 TBje53x0xfxwvrUixUj3QU0oh938aXiufarhOZ7NibB8oKPRW88DHck1LH4htHty4ULjTwSi/
 12xo+AepjOt+10ejVM2Yb5AaDR6Cr+1afzUM5TaonNTlH+vDI76coggeg/ywLMdx0ucUBiM1g
 KKCUqFYPBckEhf3Pq4r1ikRblvyd9GtMbQxIaZGJMN/mGQ5wsJDfqTFdAza8l4mhU0W/P5qnl
 exhg3eX2swnhtPrIRAg/nQnis89wqTUiB80+vb3pZD/kCl0u+s6dMuH3jn9JXie6fJ78G9JSs
 ff+IsGS32YU5sj8l2QLVZceIfr4+qNf4+WqKV5fPfoZ8nTNROzz17dMXBFcCXrEa7K1+PwdYv
 vMtAfiTPAif0jWGRe9rtRTyquajdZZtITkFJQWNp7PJPa6fQ1825vCWP8iNB8eB0CYPzqUzD8
 7YXchgKw+21BP0jpDAPktptcTL0=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spell it as "unknown".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/misc/ti-st/st_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 7f6976a9f508b..01d2257deea46 100644
=2D-- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -338,7 +338,7 @@ void st_int_recv(void *disc_data,
 			ptr++;
 			count--;
 			continue;
-			/* Unknow packet? */
+			/* Unknown packet? */
 		default:
 			type =3D *ptr;

=2D-
2.39.0

