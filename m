Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3BC619442
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiKDKOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDKOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:14:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537629CA4;
        Fri,  4 Nov 2022 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667556831; bh=wuVEHgnetky37buxuvscMpawn4JSxbveYI5QzUX3XiY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YLEByf+S/V8bLPbCeV0USWzjSbA07grNOp7HnkNMdtTkL5ikhJQtenx2lI7AkUT59
         ZtyZwhTLWJklkEHkqyZ3N7bbBjDS+9yzOKHbXC7wvU464EYuFzPhyNj1/vAhaHl0gp
         kbc/1uElA2cU7fFGE12RGrk4E+I2cPuwnHAJoCeSCVFGXXv+r9yIlD15pSGEOHYj/M
         ZyT5amNdnVCpPZtcgvovb9uWuOelW8hrQ0qpsloLK7RBYurxP8XIs6BiACeEFtqgil
         MqaxM4oNIC1GWPRxXhxd7m5jLSPtUZu0Zc7up2KSYEO0bpW8IE+9C89sf0kuUygx9p
         8GzU9sT5PcDRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1oeTM42Tf1-00Mrjw; Fri, 04
 Nov 2022 11:13:51 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-media@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: davinci/vpbe: Fix a typo ("defualt_mode")
Date:   Fri,  4 Nov 2022 11:13:49 +0100
Message-Id: <20221104101349.2172578-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ACEodQbYWxuE87pR22apqCBfpHeLpukqkiEgVdcMcQAU3U2VNmV
 9Pbz187Yq1EKrcbuBzxWLSnu10gLsTyjkna4Y+vskvP0pf3s+jQL9dL/Y1CCQpXj0afXlt4
 h/o8unfsqgtkwnrXEySgodkKCJ7zFxc/AprYK7+DuscmeP4tAwc9RAiWkLCFZBKJ//vWIvI
 Ww7Zza1VLp0WKEd/wY0wQ==
UI-OutboundReport: notjunk:1;M01:P0:Xin6IN6aHwg=;WCz6Sm5ACuAxchdpRtCXdD74/sr
 Y3zl3pySX0nlRW5/NL79ImZi40IAkhWONHzms4DXc5GHugVtmiH/G0g8l1SbVdzg6HPJkw4EL
 fbCDvC/Y9IWRLQGXmiRlsZTTroUvFDufNSbXIwqXUdwLUTi6QYwZtaQklJLftfGts6RnH53da
 yNqKc87UPXki8nR396ZNrIC9yBS/T0ElUtofDMOtDSafFRbOTY/ibtkxLSp14r3qFZt9lkWVF
 5LhiVyXKJyL0R/+6HgnoO2NzQ5MJAaxcDOSNLfEN/NWdOmlg7ZsO8BztJ+2vgKF5NKyx6tQ0Y
 dl1WhqHc83CTe88+tsQ/T5fcXJrBYwDvPF2nqOqmhX+NT6Z9P0tjQbddeofr2qoxdx77UUavp
 bVDX1B0yxtHQ5OVsUwN5Ypi+30Ac7G1S+f3ft+puqdV0irSYnOI0Hsc4UIj+ZjWPTHVkE4PJi
 a2gByYTsuRkUoZ6+Y5GCjtvNGOLb/spfeEZY5lp/CyYcv2OUKhqxOo0f6JkTjDZzHCG6giZvM
 gMy/rRur5aJl8M/HEIL9dKBAaMLbzeIW0V/B8EvpLadcZftHDKlBSabz0VMCKsApdEeKZtAKe
 wWTth+Q/Mn2hfI3ui+ONmt1BLpcHS6MWyVdkK+ITUNvhRhc9h1lPURv/mvcqswqCrtrDBIWe0
 84njPL3u0uxNVlECqs14io0b7EbSVl+lgAetWrO2O+6qKbvRTSsBOQUhDLejbMvhQD9Esoqr0
 FQJ5j2wN3siatrRRs3PNQa0heMkHVvbWLTXPDpqmIGJtAeNgzqIra9oZeVB+N3YVvcoIJy4rm
 p/fgOf5IIZ3Jpw6dwUbhh6zTaUL6+g5nmCDzeJNp7D/opPFlKvCqy8f6PSyqp3w82WSDt5ipS
 rIwlTGNMpjAaYISdByClVFdRVM8o8eQaHLogtX+vMwmfZELq74B6wc+WwjBTXqwwB3WKLQReq
 Yy6JUXb9hUuwWg8EyVBLWS3uPbg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's spell the variable name correctly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/media/davinci/vpbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/davinci/vpbe.h b/include/media/davinci/vpbe.h
index e74a93475d21f..646c4b48b29d1 100644
=2D-- a/include/media/davinci/vpbe.h
+++ b/include/media/davinci/vpbe.h
@@ -28,7 +28,7 @@ struct vpbe_output {
 	 */
 	char *subdev_name;
 	/*
-	 * defualt_mode identifies the default timings set at the venc or
+	 * default_mode identifies the default timings set at the venc or
 	 * external encoder.
 	 */
 	char *default_mode;
=2D-
2.35.1

