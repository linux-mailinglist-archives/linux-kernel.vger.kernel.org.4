Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325CD680030
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjA2QQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2QQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:16:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3F1E2B6;
        Sun, 29 Jan 2023 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675008982; bh=urxmFyOj59HOKLixvBBRQqIlv7zJ5t7JlEJfrmi2bUM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ipygiERTJfX/xiEYJoybYiPCCSnkksblihYnjBdew2yvHLCLLFP0xxbOQcnfkqOIS
         dHJqoKB5tbravgHAF2deuHJ393XyAUs4jByQdJjBrouMcezw+4YYL4GVtTtO+nyo62
         XFmgyggco619zdZ9MCuOUGBCEw41dI0xUDTqKWCXYSDVh8ALzOEL0m/lzjYS+8WH9h
         R2q5ZJKIC6M72rOAlwxVPfwxdEOjkIFS3tR8jP31Oi+mxmFnpHsojS6h7FAvNlPys4
         014FcKQplExRo7f+UDQAQMLWU0UkJF6/gNFNR1loy42FO8mKOCeYq2HRbzbmRADkJ1
         WlV+i3VpDPvRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1pQ1yR3RzO-00Dq1m; Sun, 29
 Jan 2023 17:16:21 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-media@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: Fix a typo ("Unknow sleep mode")
Date:   Sun, 29 Jan 2023 17:16:18 +0100
Message-Id: <20230129161619.1621869-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:97XDzuNMG3RkYiarUOisY/cT9NekfsIE18aZDknDljmPbrGoWcZ
 G6MD3V/Ae03DxBnvt+2Ad6sz6V+bXPA/7kuvyQSWlFIVV69aR60t62MzFKzs190mPeqYu6S
 iY9MgMBD9tYVTAHGC3ZIwPywYerHfSeCnyTSsRAxIBhOhiJEJyde9ZvopxHQMtbHbO6N2q8
 SntAcMlhuivlUmWmvA0gw==
UI-OutboundReport: notjunk:1;M01:P0:oUTbO46JV6M=;3CzPWs8NHjbJrclgsZsb5rEL4tG
 ScpyAGhTOLNGGTt2X39SxKGibj7DFr9UJNmNBx7yL+9hr2KKOjKGTXLlHLoFZ0YhgUhH7+VHC
 Ru88AhrqbnvmI3i4UQyH3quBjwVzVnm1MwHbE0mL/IpfEP1qaXp5vBk5ldG3NvS5PRb17fuht
 UKjhfOON6dZNyQFW7kwjt574oieCaLl5fyKb3r16IKU6tXBDgZUuV5leDhiSadQgBlItzTD1e
 vBl4v0pIjz+Y1t6mxiajekHqP4zLMgtartsjnkikwyxGVfEPXmBaZQAg6cmgMXRml581NPHTU
 itegBKZD3wlMIkwQDRo7W5Gj3bdd55Gp9vWsfq/ADF5MCBH2AICobmpFJmPhyC4yb9WFXNrw+
 Vsb8y7EgH6/7n3YnXXL2m507WaiXplEZt1wb71tZAcHSp68BqtsBlH1tHxi2ht2CNcoi6hNJe
 RI65aTIlLBwi8PEgEwR6IwQVxvQsil0kjaGIU+dhsSNKuc84bNPwjx9BtgJ6lCoB535KjUwWR
 8uec9v065AFKyjZeOgISD8t1BXYS3faoRaLsUmVmLFZeuOlR4utIdjQWXlQynPlw7EF59ebR3
 G/AsYssPMEQ/l+B/PbtCijzXSqybb9FNPXoMT4rUNQug2V6ZKvH+8KsDiiVFuWuqHVRDJL2K0
 0RXtSffuW3Ah4AOgREsnuVMryJ9VuGFXjlGl1+UrZhOchTvYYMalAtIkdtrPTSVJACOh345K3
 VhLeFKhBac+fCzMC0TfXPzfLLski7+pOg4vFoVgbFE8+LL6ab2aNzESUWNGlIJ5gymb3DxyhU
 Q3PijoTXQS5E7UewyMEFSakU3UI4d5jJE22ecqNj4Jj3W9xr7DqtNeGTZbnQM6Fu6EqUfdbkQ
 BK+pHS4UFMebmLrb/FEfEKUdzXf/gOlcHcsH9dRvx11F8ay5OGt2OVte9bjBn6RNaNNaDvcR0
 Uhp6n0nKQWlIlf+C1LPlxjDZ6KY=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spell "unknown" correctly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 2 +-
 drivers/media/dvb-frontends/drxk_hard.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/d=
vb-frontends/drx39xyj/drxj.c
index 1dff59ca21a17..637e428e71ee5 100644
=2D-- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -11068,7 +11068,7 @@ ctrl_power_mode(struct drx_demod_instance *demod, =
enum drx_power_mode *mode)
 		sio_cc_pwd_mode =3D SIO_CC_PWD_MODE_LEVEL_OSC;
 		break;
 	default:
-		/* Unknow sleep mode */
+		/* Unknown sleep mode */
 		return -EINVAL;
 	}

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-f=
rontends/drxk_hard.c
index 9807f54119965..3301ef75d4417 100644
=2D-- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -1585,7 +1585,7 @@ static int ctrl_power_mode(struct drxk_state *state,=
 enum drx_power_mode *mode)
 		sio_cc_pwd_mode =3D SIO_CC_PWD_MODE_LEVEL_OSC;
 		break;
 	default:
-		/* Unknow sleep mode */
+		/* Unknown sleep mode */
 		return -EINVAL;
 	}

=2D-
2.39.0

