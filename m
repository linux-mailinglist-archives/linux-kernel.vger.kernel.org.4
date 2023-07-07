Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8374A854
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGGBEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:04:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACB1BDB;
        Thu,  6 Jul 2023 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688691817; x=1689296617; i=w_armin@gmx.de;
 bh=BFg18R7D45PvYc6tAEeEiB0FiEf132/g39rWra8TwlU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mkQNklDGH6F2popgGYUoFPxvSZ2IULRaRqXxTjHOCUh0/BO5HNkYGwYpPwqxjTnULh1nb1j
 FV/4pXIatPb54ADUajwE4edleCcrpMvLLR1uhiuLu+AG1a1RjkBekZnwuv16sce8srLdPThHm
 o48/s2DSffvU7L+Jjor0FS86ySOc9I060jaI3aqcJNzD5x159k6j0hkImV/Tjq1rDDwYl/c5B
 uhmF6vY2mXRQqvULFKmIMYPbsg+Ty69Ub3PLBwP1BUCeFhGBXfmEMCXQgBisQCpOBGk/+ui4R
 Eye5sszYn+yDEsvp++XGOY2EIDt0FGE9p5MeuBhVbWXbQV0Z0cSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBUmD-1q91h009CZ-00D1d9; Fri, 07 Jul 2023 03:03:37 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: dell-ddv: Fix mangled list in documentation
Date:   Fri,  7 Jul 2023 03:03:33 +0200
Message-Id: <20230707010333.12954-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230707010333.12954-1-W_Armin@gmx.de>
References: <20230707010333.12954-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/hwyvylgjPU5ny4zvohfMB15j+aPvNxemuiuUhCVLAZtR66j54
 utYKRqCP6rDJWr4jUreYVprQoEYj/2Fk2i70VBJdx5Xw4tvdsN8vQvhxdPGz3GARzq17Lld
 6IQPFLS7oomS+UMul6adBCWRBqveJywec1aJa9BAozpokdwTACxxzsPs4YuxpcaiUDNF1ns
 wG7CL0d6qoBNuQHYkLINA==
UI-OutboundReport: notjunk:1;M01:P0:xxTHVl92eGc=;H9VKj/VguUyld8eVQPxfNuuDeBh
 ahF76TU2ShRNRK2qsTbvCxRc5Ci8zihCgibyGj6Ch5XGlT86+yh0SZFdxk3QOk8KtLncWp3fN
 gJH30VxP4Rh7lzlWeyjJ3mNA/tya4L745prxwo0O04BMk4CiXXS19SEWfzKRghgVs0/AcNmdl
 DcVTFzhI/L80DnBYTbm6lPiiFz4v1XSl17ftSSydBVGq7koI6QR1/l8CPl5XJ8gsCRi7vLvEb
 EtMcLTX3nuJSL0qsoohu+Cjp44Dl2dyzKxcmRxO5MRXLeu7Im/vdIfIxV7UJn10SCoXvm6EtV
 U0NhVVErSv9knVokUglvd8l7R7mFmNJu6ZojbPxxEXpeSrdZEinWGvfiFhmtfoTK6rSG5nHKF
 KBRxYBM9ySK3Mym2ohKpc0h0bR7E0rikSefhCM1/NghCXEpwnLUN4LkBlrwX8pJ0fXXOS44Gq
 1Pe8DCwDsmdkeGAWMEBIHspd9DV4wh81CqKt6uAjMa6o9Rzobh7jW5c5j5vrwF8Id2cNLScjQ
 bl1ENCEF4gyPHgxGfEvn9jX4FdJvpeYnZdE+hbVs/hv4KbMQuPRfxX02131pS2dDlr6K4fysZ
 duduy//TxnS5Des0OHitG08aTsOWS7Nzs8euhV/vbqsx5s8FICZzKMMzjt+MRqgAP5jb5M3r2
 SS2lfaV+LgtYUWAG6HwLXqYAAe+uwN4R2R1qvsZPuxDcX15W3yiwZBTY6n9+yWcQEi39I93tZ
 pa9F3/UwsP9OkYH1ypCwG2qPYPxE9Rh1IqPHbJDl1WK6RzmzTTN5ebh9HWwtE7uLnSQcAEors
 bZzXKqcoERWWfUcHIEEa1rIBfWojic9vz9FqvOT2nV47LMwFwllXVdyKj3SWvsCQ6dgucKZHL
 3/PSz+fikk5oeoRiMm8xLhXF3xnYDyKbBjyfPwMTtyYe3ZrFDCUmDrXcIwJqABGtJSJ2nk5ak
 VZql1pRfAgtIzc14MMLW0yQJ124=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing empty line necessary for sphinx to recognize
the list. Also reword the first entry a little bit.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/devices/dell-wmi-ddv.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wm=
i/devices/dell-wmi-ddv.rst
index d8aa64e9c827..bf963d91dd55 100644
=2D-- a/Documentation/wmi/devices/dell-wmi-ddv.rst
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -187,7 +187,8 @@ WMI method BatteryeRawAnalytics()

 Returns a buffer usually containg 12 blocks of analytics data.
 Those blocks contain:
=2D- block number starting with 0 (u8)
+
+- a block number starting with 0 (u8)
 - 31 bytes of unknown data

 .. note::
=2D-
2.30.2

