Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF8614FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKAQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:50:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D733E18B26
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667321448; bh=nTlvppyOmodE8fLVzrwGNsbUIK/z7n8vmm57+76/Ti4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IwSFBOzUBiLAVstkY5vC9Tq1u3iXzgPA0HgryVH2UdKy6YhBwdX9QvE+wTY0YaQwO
         fQ0iYFY0r6iojXK0ByEMDapS2LyGW8LP7l7ySZ0g/2vhJUKCYJP2+7LLqtromRd7rl
         JNLy58M/z95t9sdpJY8a/6681vj/trwsCQt6fcw/EM72YbstJHKvLHhPbpYP2yuQOx
         EKKzdfWFQtJoQk8fLB0a5uVStaj6bGki7bdn3zmJjCcRbhhuI+iIfpu0rfbdOXTlb7
         FJWvoktH4xsGLUDFQvOXtZ8o/tx/ELlUs77axWH8rOsdJrfap48DXIn0z8ubhC00fH
         p91ovaMwD0bkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1p0SKs0uKk-011PI6; Tue, 01
 Nov 2022 17:50:48 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH] mfd: mc13xxx-spi: Fix typo ("transfert")
Date:   Tue,  1 Nov 2022 17:50:45 +0100
Message-Id: <20221101165045.1017822-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yi8sIP3oPXtIGltBLSh1zopFnJOAmV74FEYSxyU3j9ZFbwIKadE
 sJur6TbL5Di4ciTmtyaQwHTZpn2Fid0N4tn6DTj75lqXq/1Q9xV4syqBkqn345410vtBkkn
 1DFs+hF53BM+P7q1u4zkHbfUUNit8u+UplJBhEsA34mKC37ky/AJU8W3R/soyJRdwh6qbZH
 X5jxlIJbLpKOiVjHooweg==
UI-OutboundReport: notjunk:1;M01:P0:6/rdIGWKsRc=;rbfsGy6YoQmUtLaKgfl4Q23FIaw
 p8SI5gg8lS6TzeAylFMUweU40P0Vd7hCLz7scMzetAma7nJ/XSOrmh0Tku/h7Wefg3R1ndVBn
 /JgyEfZ/qvfL6UcsEz3lOgzvJOSbDXKWrtWJxzBJ6R3vc8LW1MHQOtVWX9XOmdxO+CjG1b+9X
 AsL0ZZX7YKipTv4GpK4jTfCD99kD6vWNXM9289prgto5nLiI6aAygiyzh4kWdyiJgq2SpP1YN
 pVc/gyY0pEVvT8rpXtrz4x1I9aF6XwW1ujtGfN4UoXM/WJmGCvdpFHOJtgYr7AUiI3PY6jq76
 nJINA97Wdz6N6brkCD9W3JFwYdBgzDukM6eawKV0YZW8WZAYmrJ3i43IaNv5JNpGbYXQdW6B/
 aP+4HoWoAcGy0ezAsKk8jR/tE6YSCYhoRHKmjeI43yZt/DKo41j4gVmxVnYiME+9QqTW6pAcJ
 LbJJiGP0tE1cWsb8Qq4/8FOA7/Q2asiF3i+OrIv480BvGjWq+qvEoVqVpdFavmjRnunhPChTN
 tFnfFcQ32yHM31ZoKif7CySdB3HmRevTx0EtpOwdexDgwNbj4JUF8yUgD3/wcooBhJAs+nInW
 Vzs+WoYJYUKC0vwaigT61XxN+YJz4K+skuX5l/FsythwfEBVP10vQepIliPcO0z5KPHhdRIgw
 ncUesdz/EelUmdKZYwYt4DF3r8nkfNget8pawiOcO444+poQ2ZMYGe8RU/TGHuawKTSaAJ7xI
 8VxTMd/7IIn60UhrORNddRhpA10P/RN82LJv7CeeOtvDQ6IPK/1GxDNeHwjY7YYOHufmYm2D+
 cvHrlXBA7QBa3OZcPWYX3ZDz8Mksze5Cchy9lAdDQq+Xen5tPkUCVy6nykxadastUO6NIz0hY
 U68h7ZRVkWTgmSE+oEVPUIywOBPbzu2P2MfX0FCkEvnm5yHtqJTze6hRFxBqys+XzlGmUfq/D
 jTXm/oMtm60pwOPCFb5ehraH4ss=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That spelling is only correct in French :-)

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mfd/mc13xxx-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index f803527e58194..84ea45ef0280d 100644
=2D-- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -115,7 +115,7 @@ static int mc13xxx_spi_write(void *context, const void=
 *data, size_t count)
  * result, the SS will negate before all of the data has been
  * transferred to/from the peripheral."
  * We workaround this by accessing the SPI controller with a
- * single transfert.
+ * single transfer.
  */

 static struct regmap_bus regmap_mc13xxx_bus =3D {
=2D-
2.35.1

