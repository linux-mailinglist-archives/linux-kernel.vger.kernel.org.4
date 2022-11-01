Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD826150C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKAReR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKARdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:33:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F291CB17;
        Tue,  1 Nov 2022 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667323981; bh=JoeQUnpY7vK3GkymqK9ssQPbhH1w8wzKrNuORFh5uvo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lhHB6/ow9dBOfW+qE0PkuFHFxii7q4VyI5xrTuRBSVP6FowNwIH7ac3noQMLi1Y0H
         xI3hfk3K4VN4VIL55SpNOVdlvBPgdKtiGBJ+bVNQVwSr6YB2cSplGJ3ddFK+Rv9QvE
         p3qLLs6yMfHTIWslsxgifI5N86T1pk7UBTitoL4w7FuFN80EEc6qs4Lh6XmkUux1KD
         TNcOCjyzJf0YLFEd2rCUts4BrtNBVCGUSeRc1U4TjzBKIbmpcUZnvTQhPd0aybbCea
         4splR5lncGBko7qEIagfw8oUW7hszmW/O91PLsl//bqyxN/kQ9I57WmKvS0stnlLLr
         dkcuA6dwQkJ/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1orq0S3SZt-002bNE; Tue, 01
 Nov 2022 18:33:01 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-api: spi: Update reference to struct spi_controller
Date:   Tue,  1 Nov 2022 18:32:51 +0100
Message-Id: <20221101173252.1069294-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YFOSNjlwG99mLOnLjkWj5S9jhCLukjysYhysmXDQVL6yCd2JyZB
 /4HnzfHpIkBGhmgZdJBuBjh7BbGpvhUjb7yHkG18GikWhJt5k193WUxVMbDsPB/7hWxPeGJ
 pk7T0NcdRqHJoqpZclt0edwk5SeeufGh9clfTL6JSwwOPnM7wyfN80Fm0wOC5IhVG2Cr9ok
 hPVQGCyDJmqaomG3rGmZw==
UI-OutboundReport: notjunk:1;M01:P0:83ArS7ffRCs=;OC+MltJ5NWPR9fGkT3NU6LxcDxg
 ArrrdBnvVg1MIrzxKoL/4E5qxNcous+R7qANXjbJQE11fGVxyEXgQzC8u6SzatRl3Tt+7bu/d
 W3fZcXKaXlXguk+yuZByPflYHoV4a8ooeN+Aw0So+y6GltW8xtAt0jY9AmCqCEJM9nWC4zAnN
 LebCU5wjR3IsL8gSJ9cUfNKQZLOkY+PsacY4GCEgMI3oNhVWQBcRLyCVJzRmDW+oSwZUICNAk
 mdDBsQSzHGcc6TuMGLuAWzidBDdbiuT9C2NclpNk4JE8o3tEkVu51Q5unO75g3ewy+xqNCTm4
 uyFtBtf5FWHfzrvj+kZFFQiF3lSv1z3CrcnssX1r2XRV83vaAhvx+2RCskcr7DKynMD4TGynT
 JsYtEVSC4YxNjkxPHdY/j42YNJYAS0ckDaqy8EyTkFmciDhi208rtCa0IfE6WASYsn2r4/2TD
 v08Wiigk/Hi61iqAPaH0XCVTTuNy4VTq4KUcY7i8ASLJ4BCmIz6kyyM/gjkHhQmtn8u4g7yQj
 egmyRXThcFWfoYkoT0F5g5oJ77Q1oUIycW8+yrvM4jxSp5PMrmbD+guGGICkU71xeUyLmXBWz
 mA0FM4byKWepiajKyvdsgcHwJfXgjGBVpmZl+rfEGaktMKPOnsx/KwLVwTO11Sa1bVhs1/9/Y
 d0swdLp4dbN79V45EDLD2TSSubW07eYhattlDxWzsa9M769kP6c3W9Ef+lwg+TmwD3XxJz0Ge
 NATlyHipbZKYVpdc0gRyk/S1MSW7tQ9Luetht9xE138EmidwTIuN4TFtWema8s0MGILiZW5sK
 QONcb55hxkrmtZaKHA3U28iW+n7A2/JUBJRlfHnv33nLRq2YS0s13l4vtNafOaG7dabi9FqqB
 QTkZeMk9G9TV/0Tm0G0bqS2+2BHpEm5Z4fwj6qmIQCri8mHCfixwOmLo3pPhtF1dx+lBxhlsH
 WuTmgCKdLfo4h/SuV4Po6/vQWfs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct spi_master has been renamed to struct spi_controller. Update the
reference in spi.rst to make it clickable again.

Fixes: 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/spi.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/spi.rst b/Documentation/driver-api/s=
pi.rst
index f64cb666498aa..f28887045049d 100644
=2D-- a/Documentation/driver-api/spi.rst
+++ b/Documentation/driver-api/spi.rst
@@ -25,8 +25,8 @@ hardware, which may be as simple as a set of GPIO pins o=
r as complex as
 a pair of FIFOs connected to dual DMA engines on the other side of the
 SPI shift register (maximizing throughput). Such drivers bridge between
 whatever bus they sit on (often the platform bus) and SPI, and expose
-the SPI side of their device as a :c:type:`struct spi_master
-<spi_master>`. SPI devices are children of that master,
+the SPI side of their device as a :c:type:`struct spi_controller
+<spi_controller>`. SPI devices are children of that master,
 represented as a :c:type:`struct spi_device <spi_device>` and
 manufactured from :c:type:`struct spi_board_info
 <spi_board_info>` descriptors which are usually provided by
=2D-
2.35.1

