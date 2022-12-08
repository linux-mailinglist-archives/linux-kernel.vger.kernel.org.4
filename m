Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267B9647169
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLHOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:14:58 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82A81DA8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:14:54 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221208141449epoutp025c61f8da0f8e72934f1519f106fe69bd~u1vwRMQB00053400534epoutp02W
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:14:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221208141449epoutp025c61f8da0f8e72934f1519f106fe69bd~u1vwRMQB00053400534epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670508889;
        bh=y9qUn4mXBv4NSRx5v9NuWhOMRw9GaeQfdHzFhonAdg0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=IIDgzWcfGhPXW+e9yVbjuCqiGs0ytBI1g4dStBAaq/v9isdUsGUKEaGzJteWTE25F
         6cIjwIeqVa2EEpNld2ihsmXh2Xw0IPGj9HWNifh/+2UlxUmAYxgij0lo39UDiR88Su
         MxqVmIpWWeRiWWvx40W/rAE+QjtvihPgEFYhqliw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221208141449epcas5p45d35d6ca14aef2e0d906c9ee87d4d958~u1vvyyt340520505205epcas5p4P;
        Thu,  8 Dec 2022 14:14:49 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NSbkv5Vbrz4x9Pp; Thu,  8 Dec
        2022 14:14:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.29.39477.751F1936; Thu,  8 Dec 2022 23:14:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221208141447epcas5p44220ff166d8b4c594274cff4011b339e~u1vt-NmN_0520505205epcas5p4N;
        Thu,  8 Dec 2022 14:14:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221208141447epsmtrp24fa15b13372427ab8710cafb51f29bbd~u1vt9Sv_m2935429354epsmtrp2H;
        Thu,  8 Dec 2022 14:14:47 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-16-6391f1575356
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.83.14392.751F1936; Thu,  8 Dec 2022 23:14:47 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221208141445epsmtip2a75fc708e4e957c0b9dd1ca49ad5b82a~u1vsmR-rM1136411364epsmtip2Q;
        Thu,  8 Dec 2022 14:14:45 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Colin Ian King'" <colin.i.king@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Mauro Carvalho Chehab'" <mchehab@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20221208115847.2433777-1-colin.i.king@gmail.com>
Subject: RE: [PATCH] media: platform: exynos4-is: Fix spelling mistake
 "palne" -> "plane"
Date:   Thu, 8 Dec 2022 19:44:44 +0530
Message-ID: <000801d90b0f$6d621620$48264260$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI0vk9RW1iZ4BXMTfsejTy1hxIu1gDaeiQgraXOGYA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmhm74x4nJBv8maVpMav/CarH1lrTF
        3tdb2S02Pb7GanF51xw2i54NW1ktZpzfx2SxbNMfJovDb9pZHTg9ds66y+6xaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWl
        eel6eaklVoYGBkamQIUJ2RkfpvYxF+wVqbhwaC9zA+N/wS5GTg4JAROJU8+esHcxcnEICexm
        lLh++DsLhPOJUWLVlZtQmW+MEiu3fQFyOMBaHk11BOkWEtjLKPH2TTJEzUtGidPzVrKAJNgE
        dCV2LG5jA0mICOxjkvg/fQMjSIJZwFXizpl7rCA2p4CdRN/eV0wgtrBAtMTRP4+ZQWwWARWJ
        Dzfmgg3iFbCUaHp5jRnCFpQ4OfMJC8QcbYllC18zQ/ygIPHz6TKwmSICVhLb1y5hgqgRl3h5
        9AjYBxICazkkpt7fwA7R4CKxvauDEcIWlnh1fAtUXEri87u9bBBfekgs+iMFEc6QeLt8PVS5
        vcSBK3NYQEqYBTQl1u/Sh1jFJ9H7+wkTRCevREebEES1qkTzu6ssELa0xMTublYI20Nix7Mf
        rBMYFWcheWwWksdmIXlgFsKyBYwsqxglUwuKc9NTi00LjPJSy+HRnZyfu4kRnGC1vHYwPnzw
        Qe8QIxMH4yFGCQ5mJRHeZcsmJgvxpiRWVqUW5ccXleakFh9iNAWG9kRmKdHkfGCKzyuJNzSx
        NDAxMzMzsTQ2M1QS5106pSNZSCA9sSQ1OzW1ILUIpo+Jg1OqganG+OTytqWspfz5Wb03Fvxb
        Z31wTUnCnYiA2y+u+gZErY0J/F7XsnZWsG5qjJ3Z9M8mGl9EHVMrktO3XPbnnTT56jGZaQ9e
        LpotGP+/q3+xUP2l4xUr5q9b3hFhITL5lIqZl8l6O26Fcysm3Pj8PMvidZixQ9afQ5uTOY8t
        nJ01z0OWzS9+wjmdhEu6get8Wb51aZY6xKavVa2OZXXc+OrGx08as+59r2A66Lapr377pQ23
        Vx35Gaqw0bD+SBXzu/ncPgXpDuy5re0s4SkTk1OctN99+miukPw52EJiclm40faHz+LMjV7x
        MLQtvx7pKNdWaZRg8TXLpLxpq27vLe9pf08+Zou9bTBf6ODJciWW4oxEQy3mouJEAMOIhWk5
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvG74x4nJBnv/CVlMav/CarH1lrTF
        3tdb2S02Pb7GanF51xw2i54NW1ktZpzfx2SxbNMfJovDb9pZHTg9ds66y+6xaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujKXHdrIVvBauuNm8mK2Bca1gFyMHh4SA
        icSjqY5djFwcQgK7GSV23/7P2MXICRSXlri+cQI7hC0ssfLfc3aIoueMEg8272EBSbAJ6Ers
        WNzGBpIQETjEJDF52x0mkASzgLvEtKadjBAd/YwST5tnsYIkOAXsJPr2vgIrEhaIlLh3YREz
        iM0ioCLx4cZcsKm8ApYSTS+vMUPYghInZz5hgRiqLdH7sJURxl628DUzxHkKEj+fLgObLyJg
        JbF97RKoI8QlXh49wj6BUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YW
        l+al6yXn525iBMealuYOxu2rPugdYmTiYDzEKMHBrCTCu2zZxGQh3pTEyqrUovz4otKc1OJD
        jNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamLYlJFq/Tpp0arWTrLrA3EusIa1bNky+
        07xpT3Zy70Qn8y1haz5zCR9uCvE9r80Swj9bzWHd2Qim6Deziiv4/u77OVPp8Clx7ef1ohbd
        OUfUkk7kLaxOV+g5OV+Bcd6rFT92TU1z+HLy8fvD8yr2KO090XBtQk+Rps0vnqZn01jbVsXO
        ai/Q9+K84ij4L2x/us7O+ycaY9ZqBP7ujOlp2vNCr7bq7dXmwHkL0j/mia39ZX4skcX4v1Rk
        vObTToPH/P/E53nMUlSrddT2Ppw82XyX582ZN5+YJUwUPPQmwvaCCHvICWm5BbM3bao/eFV2
        d4Od0KK2w3/fbJNjaFhhyb5DRozpz5Fd/A8SD3WG7FViKc5INNRiLipOBAAesAeWJAMAAA==
X-CMS-MailID: 20221208141447epcas5p44220ff166d8b4c594274cff4011b339e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221208115852epcas5p476b048a9661b4ac6d11971475968c73e
References: <CGME20221208115852epcas5p476b048a9661b4ac6d11971475968c73e@epcas5p4.samsung.com>
        <20221208115847.2433777-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Colin Ian King =5Bmailto:colin.i.king=40gmail.com=5D
>Sent: Thursday, December 8, 2022 5:29 PM
>To: Sylwester Nawrocki <s.nawrocki=40samsung.com>; Mauro Carvalho
>Chehab <mchehab=40kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski=40linaro.org>; Alim Akhtar <alim.akhtar=40samsung.com=
>;
>linux-media=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
>samsung-soc=40vger.kernel.org
>Cc: kernel-janitors=40vger.kernel.org; linux-kernel=40vger.kernel.org
>Subject: =5BPATCH=5D media: platform: exynos4-is: Fix spelling mistake =22=
palne=22 ->
>=22plane=22
>
>There are spelling mistakes in a literal string and a comment. Fix them.
>
>Signed-off-by: Colin Ian King <colin.i.king=40gmail.com>
>---

Thanks=21

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>


> drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c =7C 2 +-
>drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h =7C 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
>b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
>index 5d9f4c1cdc5e..7a48fad1df16 100644
>--- a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
>+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
>=40=40 -54,7 +54,7 =40=40 const char *fimc_is_param_strerr(unsigned int er=
ror)
> 	case ERROR_DMA_INPUT_ORDER:
> 		return =22ERROR_DMA_INPUT_ORDER: Invalid order(DRC:
>YYCbCr,YCbYCr,FD:NO,YYCbCr,YCbYCr,CbCr,CrCb)=22;
> 	case ERROR_DMA_INPUT_PLANE:
>-		return =22ERROR_DMA_INPUT_PLANE: Invalid palne (DRC: 3,
>FD: 1, 2, 3)=22;
>+		return =22ERROR_DMA_INPUT_PLANE: Invalid plane (DRC: 3,
>FD: 1, 2, 3)=22;
> 	case ERROR_OTF_OUTPUT_WIDTH:
> 		return =22ERROR_OTF_OUTPUT_WIDTH: Invalid width (DRC:
>128=7E8192)=22;
> 	case ERROR_OTF_OUTPUT_HEIGHT:
>diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
>b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
>index 9dcbb9853ac0..809e117331c0 100644
>--- a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
>+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
>=40=40 -156,7 +156,7 =40=40 enum fimc_is_error =7B
> 	ERROR_DMA_INPUT_BIT_WIDTH	=3D 34,
> 	/* invalid order(DRC: YYCbCrorYCbYCr,
>FD:NO,YYCbCr,YCbYCr,CbCr,CrCb) */
> 	ERROR_DMA_INPUT_ORDER		=3D 35,
>-	/* invalid palne (DRC: 3, FD: 1, 2, 3) */
>+	/* invalid plane (DRC: 3, FD: 1, 2, 3) */
> 	ERROR_DMA_INPUT_PLANE		=3D 36,
>
> 	ERROR_OTF_OUTPUT_NONE		=3D ERROR_COMMON_NONE,
>--
>2.38.1


