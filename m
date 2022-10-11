Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFB5FBFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJLDvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJLDtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:49:31 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD9ABD56
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:48:23 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221012034821epoutp02c9365f95c3a1a101282db3bcd3e25537~dNbfoLu3L1949919499epoutp021
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:48:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221012034821epoutp02c9365f95c3a1a101282db3bcd3e25537~dNbfoLu3L1949919499epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546501;
        bh=VU96B+4AmTLSo76S7TlPprnB1dXScdmwt5AHyPX25pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgDVCQcrhCqYV8q9zVhEGSRDdtaD0emcNODozZ2TyzCGOURDy9YQgvRGl3tjf09g/
         EG63YaVp6MwiOX50m9+FQStG7cddnDuIY7Q3lye3FlTgw5GkaCM4TdjviKUgIb91Xk
         UnynSfnENITcmHRDe/odpTpknF9buoblia4MjKu4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221012034820epcas5p4ea59d009f3ff9cd18237e0aa9c54ba01~dNbe04Dug0309103091epcas5p47;
        Wed, 12 Oct 2022 03:48:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnJXK6443z4x9Pt; Wed, 12 Oct
        2022 03:48:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.1C.39477.10936436; Wed, 12 Oct 2022 12:48:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125222epcas5p1599424c2b8fe888dd9f9d04c76909c07~dBNNAVtNn1056110561epcas5p1F;
        Tue, 11 Oct 2022 12:52:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125222epsmtrp165015956329610abae2d84a3f82bde22~dBNM-AA5-2654526545epsmtrp1O;
        Tue, 11 Oct 2022 12:52:22 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-dd-63463901eba4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.1D.14392.60765436; Tue, 11 Oct 2022 21:52:22 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125219epsmtip1fd42a1817ee88692a7c8dc315b836089~dBNJ8oHtt2178621786epsmtip1u;
        Tue, 11 Oct 2022 12:52:19 +0000 (GMT)
From:   aakarsh jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v3 13/15] media: s5p-mfc: Load firmware for each run in
 MFCv12.
Date:   Tue, 11 Oct 2022 17:55:14 +0530
Message-Id: <20221011122516.32135-14-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHc+5tbwuu5FrRHYgiKxsqGdhiCwcGuqDWOyUTYpzRbcGmvQFC
        X+ktzPkH62AwxkRkuImMAaEUE95vkEfAijMD58QRSJwtApO3TnkNwcFKW7b/Pr/v7/c7v8c5
        h4vzRwhPbrxaT+vUMqWAcGU139631x+ESOXC4ZZd6GnrdTZ6UthMIOPyBIaGjfMsZG5o4qDG
        gR9xdONuNxsV9dxno5ZboyxUN2nz9l+3sNBEUTVAU/lWAtWPDbLRyPQZ9HtbAYEu1TaxUVWP
        hYNMQ/0YKqt/jaGSpgUOSuvs4SBLRzNAX6X3YO9DqrKwElCtllJADZXO4dTNfAuHMnZMYVR9
        +TcE9Xiwg6AaSr+g0u6ssKjLjeWAWkv5iUNl9gwR1Hy9F9W7OM+JcjuXEBZHyxS0zptWyzWK
        eHVsuODEqZjDMZIgochfFIKCBd5qmYoOFxyJjPKXxittaxB4J8mUiTYpSsYwgv0Hw3SaRD3t
        Hadh9OECWqtQasXaAEamYhLVsQFqWh8qEgoDJbbA8wlx6/+YMK2Re8FUl80xAAMnE7hwISmG
        ZaODxAbzyXYAp6uwTOBq4zkA2/N/JRzGEoDp833EZkZvUS7b4egEsOXyJdxhpGGw6o8UsBFF
        kP6wy9Rtz3AnvwRwLEO/EYSTqSxoubdqL76NjIYTD4vxDWaR78BfCsvtOo88CGcfvcAd5XbD
        itpuO7vY9Jemn+09QXKdC4cNr509HYFXclOdvA1O3210TucJp7LTnSyHYyVTzkOVsKbjKsvB
        h2D3QIGNubbu9sGatv0OeRf8vrca22CcdINZq39iDp0HWws32RcWPF5mO3gnvF1hAg6m4LWi
        dueKcgCsMDwDV4BX/v8ligEoBx60llHF0oxEG6imP/vv2uQaVT2wv3W/461g5MmLADPAuMAM
        IBcXuPNAUYScz1PIPr9I6zQxukQlzZiBxLbAHNxzu1xj+yxqfYxIHCIUBwUFiUMOBIkEb/KM
        eX5yPhkr09MJNK2ldZt5GNfF04BV56vdqlaPnbk2WTG+Mh9p8HZ/IB2qnD2W538vwycV40iv
        Ng3tGW+OhaI3VnzWQ59aPti9g/H9zSM0KbsvInnmw94dyWXJeS9PWueWR63o5iuwZWtJTtLb
        r9JOqwYUC5/OZEqSO6MXUnjo1lFV7pY7WIbrzprlb0f2jvv9db7voY7hpXYZjj6P0GofnDw3
        uS49cPa0aWC2jlhL128nrXuKT7jrrYuqHy4cEvDOcqvy7i+ZUe1x6NHCD37P593vrJK15qyt
        4oHDtV5/G5eynp/y9fhI6ccPC//kRobi2dfYojovcFw6EdxQp+oKjXxrZfiR+WKlsKMfZ2G+
        M6q26I+VlIDFxMlEfriOkf0La9gOzHQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe8/OzcXsOBedNCxOmKQ4szTfbpJCcQi6EJhUlC47WLnNsZOV
        QaSZoSa1TKOpbeI2ZetCzry2aNnR0A9iF1wX10UxL7kytZJYWrP69nue35/n/+EhRVI9GkQe
        VR/ntGqFksHFaONjJiQST9+StsrwNhgONusx+N7QiEPT9BAC35kmUdhW30DAey8qRLD2iROD
        RqEbg02P+lFYN/zHPtW7UThkvAPgSPlbHNoHejH4YTQZPm+txGHx3QYM3hbcBLS4niKwxu5F
        YHXDFAHzHwgEdDsaATx/QUA20+wtwy3ANrvNgHWZJ0RsS7mbYE2OEYS12wpxtq/XgbP15rNs
        fvtPlL10zwbYmXM3CLZIcOHspD2E7fo2Sezy3yfeeJhTHj3BaaPiU8VHZn9ZEI2JPGWpu0zk
        gByiCPiRNBVDdxmvYkVATEqp+4D+8Wnqn1hCz17o+MeBtHVmiPgbykPoqsFruE/gVCT90OLE
        fUJG5QPaZS1EfIOIqkDp6RIn5ksFUjvp0pka1McoFUp3GmxzZyVUPD32elz0t2IpffOuc479
        /uy/WjrmGqTUJjr3SxmiA/5VYJ4NLOY0vCpdxUdrotXcSTmvUPFZ6nR5WqbKDua+F76yGTTZ
        xuVtACFBG6BJESOTAGNimlRyWJF9mtNmpmizlBzfBoJJlFkk6SnqTJFS6YrjXAbHaTjtf4uQ
        fkE5SHdxZ31i6XSL9X7ABpI5s9cSp+/rOVewq8xtsm8M027XrR2OiHtvrtpRMFRZXrYvKubK
        mEfaHyANYGK3t7Zcq1UTy56t0QU6heev9qLrNgRQ75Tfl2Cr5d5VGvPBvoGMCe1yV09W/8tE
        dWqe91m1Gg1LVS74ltx5CcvNXG5kk3TJDO+sGIgdr7k+O1Ls9QQdijxQ4LB+lvu9Mcewo1b9
        Zc/CPevrVCtLyhNCqiuro+IF2eaL28QGIZuJnTKLmrszPRFds/tLxZLS3fEa7FdoD+NKeKG7
        mm2d/7HJJswcq+h26Be0wwc6WWN2YbuXb09wbl2R1DHoscp0OxkG5Y8oosNFWl7xG1d+CPws
        AwAA
X-CMS-MailID: 20221011125222epcas5p1599424c2b8fe888dd9f9d04c76909c07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125222epcas5p1599424c2b8fe888dd9f9d04c76909c07
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125222epcas5p1599424c2b8fe888dd9f9d04c76909c07@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

In MFCv12, some section of firmware gets updated at each MFC run.
Hence we need to reload original firmware for each run at the start.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index 877e5bceb75b..a70283d4c519 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -51,8 +51,9 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 	 * into kernel. */
 	mfc_debug_enter();
 
-	if (dev->fw_get_done)
-		return 0;
+	if (!IS_MFCV12(dev))
+		if (dev->fw_get_done)
+			return 0;
 
 	for (i = MFC_FW_MAX_VERSIONS - 1; i >= 0; i--) {
 		if (!dev->variant->fw_name[i])
-- 
2.17.1

