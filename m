Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2276367FF56
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjA2NUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2NUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:20:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B58166ED;
        Sun, 29 Jan 2023 05:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674998430; bh=tW0vCGvFhtR9wx8OFa891HzIun4rM0WHTOEfZftZPZo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=oCJeL/LRtX2HtICxBsjKE62oQi+bfug/6SNxke/P+2Ajsz6jxGGAejDNggh94/31a
         +tRsGRo4M1EbAbDXX/fen+HVEK/F9P7KU9niy0nx/h0hWz4QVqw+zXehmrLXhEoBCx
         E4FyysEPLl/VyeFpLkYX14eL0OD96Sbu1x3aEDX0zaJ3htP1bUjfC687mPLfh2TIDV
         nm/DrwtmDf+GpeF5Z0Lry7hFnGrBHikw+5rt41mMacWhgeGygGdXaMclr60vM5m09P
         LSKe0pfZ0OlHNOkjF9vDZrQz4Z0du8jpOjFkc4WBwScecFPoEQXaYlyQb6AhRcMwBW
         asIIAP7VtPN2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1oXsV51mCf-00tPOj; Sun, 29
 Jan 2023 14:20:30 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: chemical: sps030: Reformat comment in a more readable way
Date:   Sun, 29 Jan 2023 14:20:20 +0100
Message-Id: <20230129132020.1352368-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aafJvaAiz1MwGQ1PENhwxikwho5iwei2TDN4G1s4A4LQ2cJITYj
 BxX0e9tapuS+dEaC8jkYnfgkDsP/5hqmEBv4XUp1FrpGhtEearpgBGpHaFjcdTbawylrlMF
 9SszZVdPwhA+GdEAyyRAb3Tgjq/IUj5HuNZbTmk2ATSQTgeVVH+s7RFQqFeQmb+4ppEFbVL
 liQsT+R7cA2u89w4CKCHA==
UI-OutboundReport: notjunk:1;M01:P0:wBvTdjarNOA=;TRRLp1yH1eLt1P2mqfKk9mL24Li
 e81lXJ3amYY5dKCc5XxRSj2vyCFg7iBndKZgjhTV+f+ts3PEZ0q9pTLf2DTQtx6+K9VaD1HoF
 rjbtAPz7WM/h4xKqD20Cd4OjsU3liGVb1jpNuC/fCkmDdZiBWv2f2E7TRRWOPXPmEiYzI/u03
 Sa4YNDFM1S+aDy11+xH2hNNSEhv5aeNICZi+OphHU3P081i9FzyVJiOSIsRpcRcBpQk0JwjKU
 Z7FUQlNIWPigzuMmKPvQh5CglrVGeBr3tNIjVEPtMY22EbHqebcVI9Y3wrzK97cbfHooSbkwd
 AdkRXc7+XBIp+Pu+CCdHHqpzypiZuEvrPNrNNGdC1pD+2QipNRgHH6CD5V3Qy2m8ocN6t/K5y
 Wwe7StmoEVqa0baKUSS5ypG2FQTj+ca1fFaqAVL0XhY3/iDkZqTfBpA2iUw8ntyBmCr2wrsQ1
 +Lrx70a9gWragCO1AjVcR3UVJnpxyi3Rzjy2ndtHLPq/VpTKuybXkyx1b9DAslp2hXYN+YYVF
 w4i37LfZe2oudha4UY4GKRwf8jGq3y17CxuKlacmCNZOUY7B1jrpS5OksMjqM1kLlBaUybZhs
 NKAKSFKInj83rPk9hqmgRzl6DbIg6RVLbS/UVYeTyfBEbsv8zGTciyXWbfUQ3FuGGwMxOd3ua
 WDOTOIPtuL/MW898bf7fhIubX7Ubj4/8/ax40ObAEskx9vhUk7dnbeC8khueQg4P4cBHvFpPP
 NEIUwtGQT6w8jy7BMPwsj2wv2oLHqlVRjCVNbbrm01psVi3gWBHUq4F9Olep+mel8mRxMb7MV
 Pt1q3h5V4hdTO8WZdTOGJGP/uxeHGZWkcYEgZNW+CzjIHGr/v/P5GanpNE1SBR1KhwX/+J+ZO
 SybikPcgn0vmnsq1zP7DY8TS5uylKQxycizjWyn62z4rIJcSGfaI+ewLD5K1ZRzgndNDIQIjA
 +Eq9VkiYyqyTAf0loTczxIq3S3o=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easier to see the (lack of) difference between the lines when they
are visually aligned.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/iio/chemical/sps30_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30=
_i2c.c
index 2aed483a2fdec..0cb5d9b65d625 100644
=2D-- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -68,10 +68,10 @@ static int sps30_i2c_command(struct sps30_state *state=
, u16 cmd, void *arg, size
 	/*
 	 * Internally sensor stores measurements in a following manner:
 	 *
-	 * PM1: upper two bytes, crc8, lower two bytes, crc8
+	 * PM1:   upper two bytes, crc8, lower two bytes, crc8
 	 * PM2P5: upper two bytes, crc8, lower two bytes, crc8
-	 * PM4: upper two bytes, crc8, lower two bytes, crc8
-	 * PM10: upper two bytes, crc8, lower two bytes, crc8
+	 * PM4:   upper two bytes, crc8, lower two bytes, crc8
+	 * PM10:  upper two bytes, crc8, lower two bytes, crc8
 	 *
 	 * What follows next are number concentration measurements and
 	 * typical particle size measurement which we omit.
=2D-
2.39.0

