Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE60961948A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKDKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiKDKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:37:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398632A276;
        Fri,  4 Nov 2022 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667558242; bh=HHObUMqxyzm1pOX3j1YUDl912OP6TjeEK87qob5XEvI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=iH8kwCkg/nplgQGH2SaUH4Ole0QBH2YU9fUpOe+jxs/u2fr1jsbcWm3Z+fLwx+rox
         3CtWl9gDGd7Ip+30FVTNWRlsWH/t2ntQ+o4uo7AAHABMwS46WkUNPS1qTW2x1YDPhs
         Fia9HFhSIMVG2RTt9se1YIund6qRPY8/9DX0XCdgrAPiD3qCRIiyguKLFTe6P6b8mx
         mO9P6VS8s0QukSWhoRZpijWcWF1jx+N7I/OTGX4/aZHihg5QecfqApP/BDMSdDIDSb
         YkpzX4jnHooqevhIbGKULq29r1F0GKOtl+26hziUqKQtu6PdTWgZ4xTmZ4TvkIjdm4
         0ZZjacCvJrShQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1oSaoz3RTE-00SizJ; Fri, 04
 Nov 2022 11:37:21 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: Fix a typo ("ignorning")
Date:   Fri,  4 Nov 2022 11:37:19 +0100
Message-Id: <20221104103719.2234098-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:otl6u0ZQ35bKG7n+pC1q1iP1p25Az/OuifD0UevnC6sKvY2prte
 wQSHkOQEjp5e9PBxsOMsxzdov/8EJT3vSDYHNrVPcRD7j9F/fCGjQB80N9FmGguirmqSNm9
 SBAdgBegNTXIcDK42bryMEXGEWlMjcoJtq63qq9rOZamBK8r1P2jRErkf1iHICMxZiwZXkp
 gQHf4id5kgdVko5bigSsw==
UI-OutboundReport: notjunk:1;M01:P0:FSci/EGaBjQ=;xwJPKEQHdoIWHKtOK//YN59N/X2
 U7X+M9HORDae4rSIK+I90VU7bVlz2u/ncv2vyC95k5regeYuAvyIY2uLINtqBO163eYBlofFa
 4OY+Lw6GogZCnZjH/Lc+wJCU4zG/AHnoQpfrVUIvMOitnl2KwXQZC/78hrMq1yLpGhzYKTPpN
 zt9M+AV6yx1Awo3juvjvS5K4danSqpINixJhplKGN216LGQGjyE+DkkstRWRGg0Lgi4lU0Bg9
 fZF4Os+NcGLguE1+54uFx8E7+QLHpMFAVyIxW7y/OeFfP/c4tTUrYTRDVq7emrPDVBzW9Rc/N
 rqACvIi0tWReJ+G036av23ZJIeaMEq6yorBKTHBfASKQLsMJyOoitkc650MZVU+mYSJ8XWhbo
 D4Yuq5sg9fnwv+jh47LNerEqch7du9Il4u89W02tjpmhAf/Kx5vELWhlkCT6fvthBcScZTjrk
 FIIIsbVQtA5bFfA+PnjQ4RSSK29opmF8Crld30hYI60TQHNmWW4F4jYQ8N7MjE0icYGHXCqZo
 NZg9UnSC88eL/6KWD741sFtmq/GMVPJ/S4s2yHGEJFdADvyNJ1nrSGXj+NDfweTh5YY4Hgk0f
 /n2YjKMb+Faak+DVgOFcTmsI0Yhq0Odpv8a006pjd/HSmLFcFsuqvZH5QL5xbW3WkyX0BNjlV
 xEbUNqRyjlCqmFpAEqS4BlVLaiAGK7Oc3WutWhEDpMtK4qHKxaXmnWGvmcF7gMgJ+nO/52/TH
 bNKT22X306MSjdAaMW0vEr99nuPlxtxK8aL2k0S9Ysc6DyCx/WDCn1lT0hJFrxWWknHp9ubu4
 njWbBFmeOj688NEgcS6UN+0JrKDVgiR0tYSlTu9/+rVJxT+PvtWcvQy9rI17RhwQiRIayphzk
 JPhby2PDkgXkFBg9aDIO4T9BfuhzMCmfGfV4+3uMbQG10NM3s9zgxWStXZLsXn7cwJobNPrnj
 rdaRXNUrj2SieagadD6KxZSmrEw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the two instances of this typo present in the MSM and VT8500 serial
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/tty/serial/msm_serial.c    | 2 +-
 drivers/tty/serial/vt8500_serial.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_seri=
al.c
index 7dd19a2815794..d9a3aa941427c 100644
=2D-- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -819,7 +819,7 @@ static void msm_handle_rx(struct uart_port *port)
 			port->icount.rx++;
 		}

-		/* Mask conditions we're ignorning. */
+		/* Mask conditions we're ignoring. */
 		sr &=3D port->read_status_mask;

 		if (sr & MSM_UART_SR_RX_BREAK)
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt850=
0_serial.c
index 10fbdb09965f3..37c8a55b48eda 100644
=2D-- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -168,7 +168,7 @@ static void handle_rx(struct uart_port *port)

 		c =3D readw(port->membase + VT8500_RXFIFO) & 0x3ff;

-		/* Mask conditions we're ignorning. */
+		/* Mask conditions we're ignoring. */
 		c &=3D ~port->read_status_mask;

 		if (c & FER) {
=2D-
2.35.1

